<?php

function adminer_object()
{
    // Required to run any plugin.
    include_once "./plugins/plugin.php";

    // Plugins auto-loader.
    foreach (glob("plugins/*.php") as $filename) {
        include_once "./$filename";
    }

    if (!empty(getenv('ADMINER_DESIGN'))) {
        # compatibility with previous custom version
        $pematon_theme = getenv('ADMINER_DESIGN');
    } else {
        $pematon_theme = match (getenv('APP_ENV')) {
            'local' => 'default-green',
            'dev', 'test', 'stage', 'staging' => 'default-blue',
            'prod', 'production' => 'default-orange',
            default => 'default-orange',
        };
    }

    // Specify enabled plugins here.
    $plugins = [
        // AdminerTheme has to be the last one!
        new AdminerTheme($pematon_theme),
    ];

    return new AdminerPlugin($plugins);
}

// Include original Adminer or Adminer Editor.
include "./adminer.php";
