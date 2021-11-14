<?php

Route::group(['prefix' => 'analitics', 'middleware' => []], function () {
    Route::post('/', 'Api\AnaliticsController@index')->name('api.analitics.store');
});