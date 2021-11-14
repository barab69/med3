<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 25.01.2021
 * Time: 23:22
 */

namespace App\Modules\Admin\LeadComment\Services;


use App\Modules\Admin\Lead\Models\Lead;
use App\Modules\Admin\LeadComment\Models\LeadComment;
use App\Modules\Admin\Status\Models\Status;
use App\Modules\Admin\User\Models\User;

class LeadCommentService
{
    public static function saveComment(string $text, Lead $lead, User $user, Status $status, string  $commentValue = null, bool $is_event = false) {

        $comment = new LeadComment([
            'text' => $text,
            'comment_value' => $commentValue,
        ]);
        $comment->is_event = $is_event;

        $comment->
                lead()->
                associate($lead)->
                user()->
                associate($user)->
                status()->
                associate($status)->
                save();

        return $comment;

    }

    public function store($request, $user)
    {
        $lead = Lead::findOrFail($request->lead_id);
        $status = Status::findOrFail($request->status_id);

        if($status->id != $lead->status_id) {
            $lead->status()->associate($status)->update();

            $is_event = true;
            $tmpText = "Пользователь <strong>".$user->fullname.'</strong> изменил статус лида '.$status->title_ru;
            LeadCommentService::saveComment($tmpText, $lead, $user, $status, null, $is_event);

            $lead->statuses()->attach($status->id);
        }

        if($request->user_id && $request->user_id != $lead->user_id) {
            $newUser = User::findOrFail($request->user_id);
            $lead->user()->associate($newUser)->update();

            $is_event = true;
            $tmpText = "Пользователь <strong>".$user->fullname.'</strong> изменил автора лида на '.$newUser->fullname;
            LeadCommentService::saveComment($tmpText, $lead, $user, $status, null, $is_event);
        }

        if($request->text) {
            $tmpText = "Пользователь <strong>".$user->fullname.'</strong> оставил комментарий '.$request->text;
            LeadCommentService::saveComment($tmpText, $lead, $user, $status, $request->text);
        }

        return $lead;
    }
}