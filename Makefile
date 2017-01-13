NAME := drupalwxt/site-wxt
VERSION := $(or $(VERSION),$(VERSION),'latest')
PLATFORM := $(shell uname -s)

all: wxt

build: all

behat:
	./docker/bin/behat -c behat.common.yml --colors

clean:
	rm -rf {html,vendor}
	rm -f composer.lock
	composer clear-cache

clean_docker:
	docker rm $$(docker ps --all -q -f status=exited)

drupal_cs:
	cp docker/conf/phpcs.xml html/core/phpcs.xml
	cp docker/conf/phpunit.xml html/core/phpunit.xml

wxt:
	docker build -f docker/Dockerfile \
               -t $(NAME):$(VERSION) \
               --no-cache \
               --build-arg http_proxy=$$HTTP_PROXY \
               --build-arg HTTP_PROXY=$$HTTP_PROXY \
               --build-arg https_proxy=$$HTTP_PROXY \
               --build-arg HTTPS_PROXY=$$HTTP_PROXY .

drupal_install:
	docker exec wxt_web bash /var/www/scripts/wxt/main.sh wxt-first-run wxt

drupal_migrate:
	docker exec wxt_web bash /var/www/scripts/wxt/main.sh wxt-migrate

drush_archive:
	./docker/bin/drush archive-dump --destination="/var/www/files_private/wxt$$(date +%Y%m%d_%H%M%S).tgz" \
                                  --generator="Drupal WxT"

env:
	eval $$(docker-machine env default)

lint:
	./docker/bin/lint

# http://stackoverflow.com/questions/4219255/how-do-you-get-the-list-of-targets-in-a-makefile
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

phpcs: drupal_cs
	./docker/bin/phpcs --config-set installed_paths /var/www/vendor/drupal/coder/coder_sniffer

	./docker/bin/phpcs --standard=/var/www/html/core/phpcs.xml \
              --extensions=php,module,inc,install,test,profile,theme \
              --report=summary \
              --colors \
              --ignore=/var/www/html/profiles/wxt/modules/custom/wxt_test \
              /var/www/html/modules/custom \
              /var/www/html/profiles/wxt/modules/custom \
              /var/www/html/themes/custom \

	./docker/bin/phpcs --standard=/var/www/html/core/phpcs.xml \
              --extensions=php,module,inc,install,test,profile,theme \
              --report=summary \
              --colors \
              -l \
              /var/www/html/profiles/wxt

phpunit:
	./docker/bin/phpunit --colors=always \
                --testsuite=kernel \
                --group wxt

	./docker/bin/phpunit --colors=always \
                --testsuite=unit \
                --group wxt

test: lint phpcs phpunit behat

up:
	docker-machine start default
	eval $$(docker-machine env default)
	docker-compose up -d

update: wxt
	git pull origin 8.x
	composer update
	docker-compose build --no-cache
	docker-compose up -d

release: tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

.PHONY: \
	all \
	behat \
	build \
	clean \
	drupal_cs \
	drupal_install \
	drupal_migrate \
	drush_archive \
	env \
	lint \
	list \
	phpcs \
	phpunit \
	release \
	tag_latest \
	test \
	up \
	update \
	wxt
