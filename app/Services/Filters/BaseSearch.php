<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 01.02.2021
 * Time: 22:43
 */

namespace App\Services\Filters;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Str;



trait BaseSearch
{
    /**
     * @return mixed
     */
    protected function getObject() {
        $className = self::MODEL;
        return new $className;
    }

    /**
     * @return string
     */
    protected function getNameSpace() {
        return (new \ReflectionObject($this))->getNamespaceName();
    }

    /**
     * @param Request $filters
     * @return Builder
     */
    public  function apply(Request $filters)
    {
        $query = static::applyDecoratorsFromRequest($filters, $this->getObject()->newQuery());
        return static::getResults($query);
    }

    /**
     * @param Request $request
     * @param Builder $query
     * @return Builder
     */
    private  function applyDecoratorsFromRequest(Request $request, Builder $query)
    {
        foreach ($request->all() as $filterName => $value) {
            if(!$value) {
                continue;
            }
            $decorator = $this->createFilterDecorator($filterName);

            if (static::isValidDecorator($decorator)) {
                $query = $decorator::apply($query, $value);
            }
        }
        return $query;
    }

    /**
     * @param $name
     * @return string
     */
    protected  function createFilterDecorator($name)
    {
        return $this->getNameSpace() . "\\" . Str::studly($name);
    }

    /**
     * @param $decorator
     * @return bool
     */
    protected  function isValidDecorator($decorator)
    {
        return class_exists($decorator);
    }

    /**
     * @param Builder $query
     * @return Builder
     */
    protected  function getResults(Builder $query)
    {
        return $query;
    }
}