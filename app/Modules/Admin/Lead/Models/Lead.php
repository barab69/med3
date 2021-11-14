<?php

namespace App\Modules\Admin\Lead\Models;

use App\Modules\Admin\LeadComment\Models\LeadComment;
use App\Modules\Admin\Sources\Models\Source;
use App\Modules\Admin\Status\Models\Status;
use App\Modules\Admin\Unit\Models\Unit;
use App\Modules\Admin\User\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lead extends Model
{
    use HasFactory;

    const DONE_STATUS = 3;

    protected $fillable = [
        'link',
        'phone',
        'source_id',
        'unit_id',
        'is_processed',
        'is_express_delivery',
        'is_add_sale',
    ];

    public function source() {
        return $this->belongsTo(Source::class);
    }

    public function user() {
        return $this->belongsTo(User::class);
    }

    public function unit() {
        return $this->belongsTo(Unit::class);
    }
    public function status() {
        return $this->belongsTo(Status::class);
    }

    public function comments() {
        return $this->hasmany(LeadComment::class);
    }

    public function lastComment() {
        return $this->comments()->where('comment_value', '!=', NULL)->orderBy('id','desc')->first();
    }

    public function getLeads()
    {

        return $this->
                    with(['source','unit','status'])->
            whereBetween('status_id',[1,2])->
            orWhere([
                ['status_id', 3],
                ['updated_at', '>' ,\DB::raw('DATE_SUB(NOW(), INTERVAL 24 HOUR)')]
            ])->
            orderBy('created_at')->
            get()
            ;
    }

    public function statuses() {
        return $this->belongsToMany(Status::class);
    }

    public function getArchive()
    {
        return $this->
                with(['statuses','source','unit'])->
                where('status_id', self::DONE_STATUS)->
                where('updated_at','<',\DB::raw('DATE_SUB(NOW(), INTERVAL 24 HOUR)'))->
                orderBy('updated_at','DESC')->
                paginate(config('settings.pagination'));
    }

    public function renderData($load = true) {

        if($load) {
            $this->load(['source','unit','status']);
        }
        return [
            'id' => $this->id,
            'phone' => $this->phone,
            'link' => $this->link,
            'count_create' => $this->count_create,
            'is_processed' => (bool)$this->is_processed,
            'isQualityLead' => (bool)$this->isQualityLead,
            'is_express_delivery' => (bool)$this->is_express_delivery,
            'is_add_sale' =>(bool) $this->is_add_sale,
            'source_id' => $this->source_id,
            'unit_id' => $this->unit_id,
            'status_id' => $this->status_id,
            'created_at' => $this->created_at->toDateTimeString(),
            'lastComment' =>  isset($this->lastComment()->comment_value) ? $this->lastComment()->comment_value : "",
            'created_at_time' => $this->created_at->timestamp,
            'source' => [
                'id' => $this->source->id,
                'title' => $this->source->title,
            ],
            'unit' => [
                'id' => $this->unit->id,
                'title' => $this->unit->title,
            ],
            'status' => [
                'id' => $this->status->id,
                'title' => $this->status->title_ru,
            ],
            'author' => $this->user->firstname
        ];
    }

}
