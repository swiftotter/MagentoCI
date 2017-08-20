<?php
return array (
  'backend' => 
  array (
    'frontName' => 'admin_dev',
  ),
  'crypt' => 
  array (
    'key' => '--crypt-key--',
  ),
  'db' => 
  array (
    'table_prefix' => '--table-prefix--',
    'connection' => 
    array (
      'default' => 
      array (
        'host' => 'localhost',
        'dbname' => '--database--',
        'username' => '--username--',
        'password' => '--password--',
        'model' => 'mysql4',
        'engine' => 'innodb',
        'initStatements' => 'SET NAMES utf8;',
        'active' => '1',
      ),
    ),
  ),
  'resource' => 
  array (
    'default_setup' => 
    array (
      'connection' => 'default',
    ),
  ),
  'x-frame-options' => 'SAMEORIGIN',
  'MAGE_MODE' => 'developer',
  'cache_types' => 
  array (
    'config' => 1,
    'layout' => 1,
    'block_html' => 1,
    'collections' => 1,
    'reflection' => 1,
    'db_ddl' => 1,
    'eav' => 1,
    'customer_notification' => 1,
    'full_page' => 1,
    'config_integration' => 1,
    'config_integration_api' => 1,
    'translate' => 1,
    'config_webservice' => 1,
    'compiled_config' => 1,
  ),
  'install' => 
  array (
    'date' => 'Mon, 14 Nov 2016 17:33:30 +0000',
  ),
);
