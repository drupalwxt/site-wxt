Composer Project template for Drupal WxT
========================================

[![Build Status][githubci-badge]][githubci]

[Drupal WxT][wxt] codebase for `site-wxt`.

> **Note**: You may find the [README.md][wxt] file in the WxT repository more beneficial then this composer project template.

## Requirements

* [Composer][composer]
* [Node][node]

## Setup

Normally you can simply run a `composer install` but at the moment you might need to run the following:

```sh
export COMPOSER_MEMORY_LIMIT=-1 && composer install
```

## Dependencies

The `composer.json` file calls the following dependencies:

* [Lightning][lightning]
* [WxT][wxt]

> Note: The [docker-scaffold][docker-scaffold] has now been moved to its own repository though symlinks are still present. Should you wish to use the docker workflow you simple need to run the following command in this repositories working directory.

```sh
git clone https://github.com/drupalwxt/docker-scaffold.git docker
```

### Lightning

The intent of [Lightning][lightning] is to enable developers to create great authoring experiences and empower editorial teams. This is done by providing a lightweight framework, documentation and best practice examples for building working solutions in Drupal.

### WxT

The [Drupal WxT][wxt] distribution is a web content management system which assists in building and maintaining innovative Web sites that are accessible, usable, and interoperable. This distribution is open source software and free for use by departments and external Web communities. This distribution extends on Lightning and integrates extensively with the WET-BOEW jQuery Framework for improved accessible markup.

## Project

For production releases you should only ever use a stable tag.

### New Project (stable tag)

```sh
composer create-project drupalwxt/site-wxt:4.0.0 site-name
```

### New Project (dev)

```sh
composer create-project drupalwxt/site-wxt:4.0.x-dev site-name
```

## Maintenance

List of common commands are as follows:

| Task                                            | Composer                                               |
|-------------------------------------------------|--------------------------------------------------------|
| Latest version of a contributed project         | ```composer require drupal/PROJECT_NAME:1.*```         |
| Specific version of a contributed project       | ```composer require drupal/PROJECT_NAME:1.0-beta5``` |
| Updating all projects including Drupal Core     | ```composer update```                                  |
| Updating a single contributed project           | ```composer update drupal/PROJECT_NAME```              |
| Updating Drupal Core exclusively                | ```composer update drupal/core```                      |

## Acknowledgements

Extended with code and lessons learned by the [Acquia Team](https://acquia.com) over at [Lightning](https://github.com/acquia/lightning) and [BLT](https://github.com/acquia/blt).

<!-- Links Referenced -->

[composer]:                     https://getcomposer.org
[docker-scaffold]:              https://github.com/drupalwxt/docker-scaffold.git
[githubci]:                     https://github.com/drupalwxt/site-wxt/actions
[githubci-badge]:               https://github.com/drupalwxt/site-wxt/workflows/build/badge.svg
[node]:                         https://nodejs.org
[lightning]:                    https://github.com/acquia/lightning
[wxt]:                          https://github.com/drupalwxt/wxt
