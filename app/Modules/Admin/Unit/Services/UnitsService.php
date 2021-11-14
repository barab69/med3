<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 26.12.2020
 * Time: 17:55
 */

namespace App\Modules\Admin\Unit\Services;

use App\Modules\Admin\Unit\Models\Unit;

class UnitsService
{

    public function getUnits()
    {
        return Unit::all();
    }

}