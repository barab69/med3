<?php

namespace App\Modules\Pub\Analitics\Controllers;

use App\Modules\Admin\Analitics\Export\LeadsExport;
use App\Modules\Admin\User\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Excel;

class AnaliticsController extends Controller
{
    public function export(User $user, $dateStart, $dateEnd) {
        $export = new LeadsExport($user, $dateStart, $dateEnd);
        return Excel::download($export,'leads.xlsx');
    }
}
