<?php

namespace BlendHtml\Pages;

class Router
{
    public static function process(
        string $uri
    ): ?string
    {
        return match ($uri) {
//            '/' => '/homepage',
            default => $uri,
        };
    }
}