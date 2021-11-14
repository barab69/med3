<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 27.12.2020
 * Time: 11:48
 */

namespace App\Modules\Admin\Lead\Services;


use App\Modules\Admin\Lead\Models\Lead;
use App\Modules\Admin\LeadComment\Services\LeadCommentService;
use App\Modules\Admin\Status\Models\Status;
use App\Modules\Admin\User\Models\User;
use Illuminate\Support\Facades\Auth;

class LeadService
{

    public function getLeads()
    {
        $leads = (new Lead())->getLeads();
        $statuses = Status::all();

        $resultLeads = [];

        $statuses->each(function($item, $key) use(&$resultLeads,$leads) {
            $collection = $leads->where('status_id', $item->id);
            $resultLeads[$item->title] = array_values($collection->map(function($elem) {
                return $elem->renderData();
            })->toArray());

        });

        return $resultLeads;
    }

    public function store($request, User $user)
    {
        $lead = new Lead();
        $lead->fill($request->only($lead->getFillable()));

        $status = Status::where('title','new')->first();

        $lead->status()->associate($status);

        $user->leads()->save($lead);

        ///add comments
        $this->addStoreComments($lead, $request, $user, $status);

        $lead->statuses()->attach($status->id);

        return $lead;
    }

    private function addStoreComments($lead, $request, $user, $status)
    {
        $is_event = true;
        $tmpText = "Автор ".$user->fullname.' создал лид со статусом '.$status->title_ru;
        LeadCommentService::saveComment($tmpText, $lead, $user, $status, null, $is_event);

        if($request->text) {
            $is_event = false;
            $tmpText = "Пользователь ".$user->fullname.' оставил комментарий '.$request->text;
            LeadCommentService::saveComment($tmpText, $lead, $user, $status, $request->text, $is_event);
        }

    }

    public function update($request, $user, $lead)
    {
        $tmp = clone $lead;

        $lead->count_create++;

        $status = Status::where('title','new')->first();
        $lead->fill($request->only($lead->getFillable()));
        $lead->status()->associate($status);
        $lead->save();

        ///add comments
        $this->addUpdateComments($lead, $request, $user, $status, $tmp);


        return $lead;

    }

    private function addUpdateComments($lead, $request, $user, $status, $tmp)
    {

        if ($request->text) {
            $tmpText = "Пользователь " . $user->fullname . ' оставил комментарий ' .  $request->text ;
            LeadCommentService::saveComment($tmpText, $lead, $user, $status, $request->text);
        }
        
        if ($tmp->source_id != $lead->source_id) {
            $is_event = true;
            $tmpText = "Пользователь " . $user->fullname . ' изменил источник на ' . $lead->source->title;
            LeadCommentService::saveComment($tmpText, $lead, $user, $status,null,$is_event);
        }

        if ($tmp->unit_id != $lead->unit_id) {
            $is_event = true;
            $tmpText = "Пользователь " . $user->fullname . ' изменил подразделение на ' . $lead->unit->title;
            LeadCommentService::saveComment($tmpText, $lead, $user, $status,null,$is_event);
        }

        if ($tmp->status_id != $lead->status_id) {
            $is_event = true;
            $tmpText = "Пользователь " . $user->fullname . ' изменил статус на ' . $lead->status->title_ru;
            LeadCommentService::saveComment($tmpText, $lead, $user, $status,null,$is_event);
        }

        $is_event = true;
        /**Автор лида* создал лид *дата и время создания* со статусом *статус**/
        $tmpText = "Автор " . $user->fullname . ' создал лид  со статусом ' . $status->title_ru;
        LeadCommentService::saveComment($tmpText, $lead, $user, $status, $request->text, $is_event);

        $lead->statuses()->attach($status->id);
    }

    public function archive()
    {
        $leads = (new Lead())->getArchive();

        return (collect($leads->items())->transform(function($item) {
            return $item->renderData(false);
        }));
    }

    public function checkExist($request)
    {
        $queryBuilder = Lead::select('*');

        if($request->link) {
            $queryBuilder->where('link',$request->link);
        }
        elseif ($request->phone) {
            $queryBuilder->where('phone',$request->phone);
        }

        $queryBuilder->where('status_id','!=', Lead::DONE_STATUS);

        return $queryBuilder->first();

    }

    public function updateQuality($request, $lead)
    {
        $lead->isQualityLead = true;
        $lead->save();

        return $lead;
    }

    public function getAddSaleCount()
    {
        // @var int $count */
        $count = 0;
        // @var User $user */
        $user = Auth::user();

        $count = $user->
        leads()->
        where('is_add_sale', '1')->
        where('isQualityLead', '1')->
        where(\DB::raw('DATE_FORMAT(created_at,"%Y-%m-%d")'), '>', \DB::raw('DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH)'))->
        count();

        return $count;
    }
}