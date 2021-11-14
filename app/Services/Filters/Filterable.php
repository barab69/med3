<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 01.02.2021
 * Time: 22:44
 */

namespace App\Services\Filters;


use Illuminate\Database\Eloquent\Builder;

interface Filterable
{
    public static function apply(Builder $builder, $value);
}