<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 30.01.2021
 * Time: 23:19
 */

namespace App\Modules\Admin\Task\Services;


use App\Modules\Admin\Status\Models\Status;
use App\Modules\Admin\Task\Models\Task;
use App\Modules\Admin\TaskComment\Services\TaskCommentService;
use Illuminate\Support\Facades\Auth;

class TaskService
{

    public function geTasks()
    {
        /** @var Collection $tasks */
        $tasks = new Task();
        $tasks = $tasks->getTasks(Auth::user());


        /** @var Collection $statuses */
        $statuses = Status::all();

        /** @var Array $resultTasks */
        $resultTasks = [];
        $statuses->each(function ($item, $key) use (&$resultTasks, $tasks) {
            $collection = $tasks->where('status_id', $item->id);

            $resultTasks[$item->title] = array_values($collection->map(function($elem) {
                return $elem->renderData();
            })->toArray());
        });

        //send response
        return $resultTasks;
    }

    public function store($request, $user)
    {
        /** @var Lead $task */
        $task = new Task();

        /** @var Status $status */
        $status = Status::where('title', 'new')->firstOrFail();

        //lead save
        $user
            ->tasks()
            ->save($task->fill($request->except('comment'))->status()->associate($status));

        $task->statuses()->attach($status->id);

        $this->addTasksComments($task, $user, $status, $request);

        return $task->renderData();
    }

    public function archive()
    {
        /** @var Collection $tasks */
        $tasks = (new Task())->getArchives(Auth::user());
        return (collect($tasks->items())->transform(function($item) {
            return $item->renderData(false);
        }));
    }

    private function addTasksComments($task, $user, $status, $request)
    {
        $is_event = true;
        $tmpText = "Автор ".$user->fullname.' создал адачу со статусом '.$status->title_ru;
        TaskCommentService::saveComment($tmpText, $task, $user, $status, null, $is_event);

        if (isset($request->text) && $request->text != "") {
            $tmpText = "Пользователь <strong>" . $user->fullname . '</strong> оставил <strong>комментарий</strong> ' . $request->text;
            TaskCommentService::saveComment($tmpText, $task, $user, $status, $request->text);
        }
    }
}