<?php
/**
 * Created by PhpStorm.
 * User: Meits
 * Date: 25-Mar-19
 * Time: 14:20
 */

namespace App\Modules\Admin\TaskComment\Services;

use App\Modules\Admin\Status\Models\Status;
use App\Modules\Admin\Task\Models\Task;
use App\Modules\Admin\TaskComment\Models\TaskComment;
use App\Modules\Admin\User\Models\User;

class TaskCommentService
{
    /**
     * Save lead comment
     *
     * @param string $text
     * @param Lead $lead
     * @param User $user
     * @param Status $status
     * @return LeadComment
     */
    public static function saveComment(string $text, Task $task, User $user, Status $status, string $commentValue = null, $is_event = false) {

        /** @var LeadComment $comment */
        $comment = new TaskComment();

        $comment->text = $text;
        $comment->comment_value = $commentValue;
        $comment->is_event = $is_event;
        $comment
            ->task()
            ->associate($task)
            ->user()
            ->associate($user)
            ->status()
            ->associate($status)
            ->save();

        return $comment;
    }

    public function store($request, $user)
    {
        /** @var Task $task */
        $task = Task::findOrFail($request->task_id);
        if($task) {

            /** @var Status $status */
            $status = Status::findOrFail($request->status_id);

            $task->responsible_id = $request->responsible_id;


            if($request->status_id != $task->status_id) {
                $task->status()->associate($status);
                $task->statuses()->attach($status->id);

                $tmpText = "Пользователь <strong>" . $user->fullname . '</strong> изменил <strong>статус</strong> на '. $status->title_ru;
                TaskCommentService::saveComment($tmpText, $task, $user, $status, null, true);

            }

            $task->save();

            if(isset($request->text) && $request->text != "") {
                $tmpText = "Пользователь <strong>" . $user->fullname . '</strong> оставил <strong>комментарий</strong> '. $request->text;
                TaskCommentService::saveComment($tmpText, $task, $user, $status, $request->text);
            }

        }

        return $task;
    }
}