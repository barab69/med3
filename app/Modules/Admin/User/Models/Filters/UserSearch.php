<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 01.02.2021
 * Time: 22:47
 */

namespace App\Modules\Admin\User\Models\Filters;


use App\Modules\Admin\User\Models\User;
use App\Services\Filters\BaseSearch;
use App\Services\Filters\Searchable;

class UserSearch implements Searchable
{
    const MODEL = User::class;
    use BaseSearch;
}