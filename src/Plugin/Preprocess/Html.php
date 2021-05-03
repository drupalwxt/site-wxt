<?php

namespace Drupal\wxt_bootstrap\Plugin\Preprocess;

use Drupal\bootstrap\Plugin\Preprocess\PreprocessBase;

/**
 * Pre-processes variables for the "page" theme hook.
 *
 * @ingroup plugins_preprocess
 *
 * @BootstrapPreprocess("html")
 */
class Html extends PreprocessBase {

  /**
   * {@inheritdoc}
   */
  public function preprocess(array &$variables, $hook, array $info) {
    // Language Handling.
    $language = \Drupal::languageManager()->getCurrentLanguage()->getId();
    $language_prefix = \Drupal::config('language.negotiation')->get('url.prefixes');
    $variables['language'] = $language;
    $variables['language_prefix'] = $language_prefix[$language];

    // Theme variables.
    $variables['wxt_theme'] = \Drupal::config('wxt_library.settings')->get('wxt.theme');

    // Assign skip link variables.
    $variables['wxt_skip_link_primary'] = $this->theme->getSetting('wxt_skip_link_primary');
    if (empty($this->theme->getSetting('wxt_skip_link_primary_text'))) {
      // We cannot pass an empty string into the $this->t() function.
      $variables['wxt_skip_link_primary_text'] = '';
    }
    else {
      $variables['wxt_skip_link_primary_text'] = t($this->theme->getSetting('wxt_skip_link_primary_text'));
    }
    $variables['wxt_skip_link_secondary'] = $this->theme->getSetting('wxt_skip_link_secondary');
    if (empty($this->theme->getSetting('wxt_skip_link_secondary_text'))) {
      // We cannot pass an empty string into the $this->t() function.
      $variables['wxt_skip_link_secondary_text'] = '';
    }
    else {
      $variables['wxt_skip_link_secondary_text'] = t($this->theme->getSetting('wxt_skip_link_secondary_text'));
    }

    parent::preprocess($variables, $hook, $info);
  }

}
