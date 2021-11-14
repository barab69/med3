<?php

namespace App\Modules\Admin\Sources\Controllers\Api;

use App\Modules\Admin\Sources\Models\Source;
use App\Modules\Admin\Sources\Requests\SourcesRequest;
use App\Modules\Admin\Sources\Services\SourcesService;
use App\Services\Response\ResponseServise;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class SourcesController extends Controller
{

    private $service;

    /**
     * RoleController constructor.
     */
    public function __construct(SourcesService $sourcesService)
    {
        $this->service = $sourcesService;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $this->authorize('view', new Source());

        return ResponseServise::sendJsonResponse(true, 200,[],[
            'items' =>  $this->service->getSources()
        ]);
    }

    /**
     * Create of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(SourcesRequest $request)
    {
        //
        $item = $this->service->save($request, new Source());
        return ResponseServise::sendJsonResponse(true, 200,[],[
            'item' =>  $item->toArray()
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Modules\Admin\Sources\Models\Source  $source
     * @return \Illuminate\Http\Response
     */
    public function show(Source $source)
    {
        return ResponseServise::sendJsonResponse(true, 200,[],[
            'item' =>  $source
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Modules\Admin\Sources\Models\Source  $source
     * @return \Illuminate\Http\Response
     */
    public function edit(Source $source)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Modules\Admin\Sources\Models\Source  $source
     * @return \Illuminate\Http\Response
     */
    public function update(SourcesRequest $request, Source $source)
    {
        //

        $item = $this->service->save($request, $source);
        return ResponseServise::sendJsonResponse(true, 200,[],[
            'item' =>  $item->toArray()
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Modules\Admin\Sources\Models\Source  $source
     * @return \Illuminate\Http\Response
     */
    public function destroy(Source $source)
    {
        //
        $source->delete();
        return ResponseServise::sendJsonResponse(true, 200,[],[
            'item' =>  $source
        ]);
    }
}
