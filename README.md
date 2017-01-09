Composer Project for Drupal WxT
===============================

[![Build Status][travisci-badge]][travisci]

[![Docker Hub Status](http://dockeri.co/image/drupalwxt/site-wxt)](https://hub.docker.com/r/drupalwxt/site-wxt/)

The baseline development codebase for the [Drupal WxT][drupalwxt] distribution.

## Install

### Docker Toolbox

1. Install [Docker Toolbox][docker_toolbox] which is comprised of the following tools:

    * [Docker Engine][docker_engine]
    * [Docker Compose][docker_compose]
    * [Docker Machine][docker_machine]
    * [Kitematic][kitematic]

### Composer

1. Clone this repo to the directory of your choice `~/sites/wxt`.

2. Enter the directory in which you cloned this repo and via [Composer][composer]:

    ```sh
    composer install
    ```

3. This will create a `html` + `vendor` directory with the `WxT` distribution with associated Drupal dependencies.

## Build

### Docker Containers

1. To override the default machine created upon first run of `docker-compose` an example below is given:

    ```sh
    docker-machine create -d virtualbox \
      --engine-label disktype=ssd \
      --engine-storage-driver overlay2 \
      --virtualbox-cpu-count "4" \
      --virtualbox-memory "8048" \
      default
    ```

    > Note: Overlay2 is only supported in OS's with Linux Kernel 4.0+

2. Build + start the required infrastructure via Docker containers through `docker-compose`:

    ```sh
    docker-compose up -d
    ```

2. Add `wxt.dev` to your `/etc/hosts` file associated to the ip found with docker machine `docker-machine ls`.

## Drupal WxT

1. With all of the pre-requisites installed + built you can now simply install [Drupal WxT][drupalwxt] via the following:

    ```sh
    docker exec wxt_web bash /root/scripts/wxt/main.sh wxt-first-run
    ```

    or by leveraging our Makefile:

    ```sh
    make drupal_install
    ```

## Acknowledgements

Where possible we try to follow the best practices laid out by the top-tier distributions:

* [Lightning][lightning] distribution created by [Acquia][acquia]
* [Open Social][open_social] distribution created by [Goal Gorilla][goalgorilla]
* [Panopoly][panopoly] distribution created by [Pantheon][pantheon]

You are heavily encouraged to check these distributions out!

[acquia]:             https://acquia.com
[composer]:           https://getcomposer.org
[docker_compose]:     https://www.docker.com/products/docker-compose
[docker_engine]:      https://www.docker.com/products/docker-engine
[docker_machine]:     https://www.docker.com/products/docker-machine
[docker_toolbox]:     https://www.docker.com/products/docker-toolbox
[drupalwxt]:          https://github.com/wet-boew/wet-boew-drupal8
[node]:               https://nodejs.org
[goalgorilla]:        https://www.goalgorilla.com/en
[kitematic]:          https://www.docker.com/products/docker-kitematic
[lightning]:          https://github.com/acquia/lightning
[open_social]:        https://www.drupal.org/project/social
[panopoly]:           https://github.com/panopoly/panopoly
[pantheon]:           https://pantheon.io
[travisci]:           https://travis-ci.org/drupalwxt/site-wxt
[travisci-badge]:     https://travis-ci.org/drupalwxt/site-wxt.svg?branch=master
