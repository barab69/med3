<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 28.11.2020
 * Time: 8:19
 */

namespace App\Services\Localization;


use Illuminate\Support\Facades\App;

class Localization
{
    public function locale() {
        $locale = request()->segment(1);
        if($locale && in_array($locale, config('app.locales'))) {
            App::setLocale($locale);
            return $locale;
        }

        return '';
    }
}