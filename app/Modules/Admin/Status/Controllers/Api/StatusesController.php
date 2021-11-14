<?php

namespace App\Modules\Admin\Status\Controllers\Api;

use App\Modules\Admin\Status\Models\Status;
use App\Services\Response\ResponseServise;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class StatusesController extends Controller
{

    public function index()
    {

        $statuses = Status::all();

        //send responce
        return ResponseServise::sendJsonResponse(true, 200, [], [
            'items' => $statuses->toArray()
        ]);
    }

}