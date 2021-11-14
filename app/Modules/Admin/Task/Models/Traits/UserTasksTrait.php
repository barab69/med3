<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 30.01.2021
 * Time: 23:11
 */

namespace App\Modules\Admin\Task\Models\Traits;


use App\Modules\Admin\Task\Models\Task;

trait UserTasksTrait
{
    public function tasks() {
        return $this->hasMany(Task::class);
    }
    public function responsibleTasks() {
        return $this->hasMany(Task::class,'responsible_id','id');
    }
}