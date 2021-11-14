<?php

Route::group(['prefix' => 'analitics', 'middleware' => []], function () {
    Route::get('/export/{user}/{dateStart}/{dateEnd}', 'AnaliticsController@export')->name('analitics.export');
});