<?php

Route::group(['prefix' => 'tasks_comments', 'middleware' => ['auth:api']], function () {
    Route::get('/', 'Api\TasksCommentsController@index')->name('api.tasks_comments.index');

    Route::post('/', 'Api\TasksCommentsController@store')->name('api.tasks_comments.store');

    Route::get('/{tasks_comments}', 'Api\TasksCommentsController@show')->name('api.tasks_comments.read');
    Route::put('/{tasks_comments}', 'Api\TasksCommentsController@update')->name('api.tasks_comments.update');
    Route::delete('/{tasks_comments}', 'Api\TasksCommentsController@destroy')->name('api.tasks_comments.delete');

});