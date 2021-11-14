<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 28.01.2021
 * Time: 23:08
 */

namespace App\Modules\Admin\Analitics\Services;


use DateService;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class AnaliticDataService
{

    public function getAnalitic($request)
    {
        $dateStart = Carbon::now();
        if($request->dateStart && DateService::isValid($request->dateStart, "d.m.Y")) {
            $dateStart = Carbon::parse($request->dateStart);
        }

        $dateEnd = Carbon::now();
        if($request->dateEnd && DateService::isValid($request->dateEnd, "d.m.Y")) {
            $dateEnd = Carbon::parse($request->dateEnd);
        }

        $leadsData = DB::select(
            'CALL countLeads("'.$dateStart->format('Y-m-d') . '","'.$dateEnd->format('Y-m-d') . '")'
        );

        return $leadsData;
    }
}