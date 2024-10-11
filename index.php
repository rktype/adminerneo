<?php

namespace docker {
    function adminer_object()
    {
        require_once('plugins/plugin.php');

        class Adminer extends \AdminerPlugin
        {
            function _callParent($function, $args)
            {
                if ($function === 'loginForm') {
                    ob_start();
                    $return = \Adminer::loginForm();
                    $form = ob_get_clean();

                    // Set default server
                    $form = str_replace('name="auth[server]" value="" title="hostname[:port]"', 'name="auth[server]" value="' . getenv('ADMINER_DEFAULT_SERVER') . '" title="hostname[:port]"', $form);

                    // Set default drive
                    $driver = getenv('ADMINER_DEFAULT_DRIVER') ?? 'server';
                    $driver = $driver === 'mysql' ? 'server' : $driver;

                    $form = str_replace(' selected>', '>', $form);
                    $form = str_replace('value="' . $driver . '">', 'value="' . $driver . '" selected>', $form);

                    echo $form;

                    return $return;
                }

                return parent::_callParent($function, $args);
            }
        }

        $plugins = [];

        if (!empty(getenv('ADMINER_DESIGN'))) {
            # compatibility with previous custom version
            $pematon_theme = getenv('ADMINER_DESIGN');
        } else {
            $pematon_theme = match (getenv('ADMINER_ENV')) {
                'local' => 'default-green',
                'dev', 'test', 'stage', 'staging' => 'default-blue',
                'prod', 'production' => 'default-orange',
                default => 'default-orange',
            };
        }

        require_once('plugins/AdminerTheme.php');
        $plugins[] = new \AdminerTheme($pematon_theme);

        foreach (glob('plugins/*.php') as $plugin) {
            if (in_array(basename($plugin), ['AdminerTheme.php', 'plugin.php'])) {
                continue;
            }
            $plugins[] = require($plugin);
        }

        return new Adminer($plugins);
    }
}

namespace {
    if (basename($_SERVER['DOCUMENT_URI'] ?? $_SERVER['REQUEST_URI']) === 'adminer.css' && is_readable('adminer.css')) {
        header('Content-Type: text/css');
        readfile('adminer.css');
        exit;
    }

    function adminer_object()
    {
        return \docker\adminer_object();
    }

    require('adminer.php');
}
