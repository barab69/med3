<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 28.11.2020
 * Time: 8:16
 */

namespace App\Services\Localization;


use Illuminate\Support\Facades\Facade;

class LocalizationService extends Facade
{
    protected static  function getFacadeAccessor()
    {
        return 'Localization';
    }
}