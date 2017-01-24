<?php

namespace Deployer;

require 'recipe/drupal8.php';
require 'vendor/deployer/recipes/slack.php';

set('repository', 'http://github.com/drupalwxt/site-wxt.git');
set('env_vars', "HTTP_PROXY=".getenv('HTTP_PROXY'));
set('keep_releases', '15');

# Override native deployer composer task for proxy support
# TODO: Determine why isn't detected natively by Deployer.
set('bin/composer', function () {
    if (commandExist('composer')) {
        $composer = run('which composer')->toString();
    }
    if (empty($composer)) {
        run("source ~/.profile && cd {{release_path}} && curl -sS https://getcomposer.org/installer | {{bin/php}}");
        $composer = "source ~/.profile && {{bin/php}} {{release_path}}/composer.phar";
    }
    return $composer;
});

//Drupal 8 shared dirs
set('shared_dirs', [
    'html/sites/{{drupal_site}}/files',
]);
//Drupal 8 shared files
set('shared_files', [
    'html/sites/{{drupal_site}}/settings.php',
    'html/sites/{{drupal_site}}/services.yml',
]);
//Drupal 8 Writable dirs
set('writable_dirs', [
    'html/sites/{{drupal_site}}/files',
]);

// Server
server(getenv('PROJECT_NAME'), getenv('SSH_HOST'))
    ->user(getenv('SSH_USER'))
    ->identityFile()
    ->forwardAgent()
    ->set('deploy_path', getenv('SSH_PATH'))
    ->stage('develop');

after('deploy','deploy:vendors');

// Slack
set('slack', [
    'channel'  => getenv('SLACK_CHANNEL'),
    'token' => getenv('SLACK_TOKEN'),
    'username' => 'GitLab',
    'team'  => getenv('SLACK_TEAM_NAME'),
    'app'   => getenv('PROJECT_NAME'),
    'icon' => ':whale:',
    'message' => "`{{app_name}}` deployment to `{{host}}` on *{{stage}}* was successful\n(`{{release_path}}`)",
    'proxy' => [
      'user' => getenv('PROXY_USER'),
      'pass' => getenv('PROXY_PASS'),
      'url' => getenv('PROXY_URL'),
    ],
]);

after('deploy','deploy:slack');
