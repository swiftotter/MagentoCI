<?php
/** Credits to: https://gist.github.com/colinmollenhour/2715268 */

/**
 * Set global/skip_process_modules_updates to '1' in app/etc/local.xml and
 * then use this script to apply updates and refresh the config cache without
 * causing a stampede on the config cache.
 *
 * @author Colin Mollenhour
 */
if(strtolower(php_sapi_name()) != 'cli'){
    exit;
}

umask(0);
ini_set('memory_limit','512M');
set_time_limit(0);

set_include_path(
    get_include_path() . PATH_SEPARATOR .
    dirname(dirname(__FILE__))
);

require_once(__DIR__ . '/../../public/app/Mage.php');
try {

// Init without cache so we get a fresh version
    Mage::app('admin', 'store', array('global_ban_use_cache' => TRUE));

    echo "Applying updates...\n";
    Mage_Core_Model_Resource_Setup::applyAllUpdates();
    Mage_Core_Model_Resource_Setup::applyAllDataUpdates();
    echo "Done.\n";

// Now enable caching and save
    Mage::getConfig()->getOptions()->setData('global_ban_use_cache', FALSE);
    Mage::app()->baseInit(array()); // Re-init cache
    Mage::getConfig()->loadModules()->loadDb()->saveCache();
    echo "Saved config cache.\n";
} catch (Exception $ex) {
    $stdError = fopen('php://stderr', 'w+');
    fwrite($stdError, $ex->getMessage());
}
