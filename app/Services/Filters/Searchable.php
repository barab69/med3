<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 01.02.2021
 * Time: 22:41
 */

namespace App\Services\Filters;


use Illuminate\Http\Request;

interface Searchable
{
    public function apply(Request $filters);
}