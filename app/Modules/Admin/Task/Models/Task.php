<?php

namespace App\Modules\Admin\Task\Models;

use App\Modules\Admin\Sources\Models\Source;
use App\Modules\Admin\Status\Models\Status;
use App\Modules\Admin\TaskComment\Models\TaskComment;
use App\Modules\Admin\Unit\Models\Unit;
use App\Modules\Admin\User\Models\User;
use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    //
    protected $fillable = [
        'link',
        'phone',
        'source_id',
        'unit_id',
        'user_id',
        'responsible_id',
    ];

    /**
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function getTasks(User $user)
    {
        $builder = $this
            ->with(
                [
                    'source',
                    'unit',
                    'status'
                ]
            )
            ->where(function ($query) {
                $query->whereBetween('status_id', [1,2])
                    ->orWhere([
                        ['status_id', 3],
                        ['updated_at', '>', \DB::raw('DATE_SUB(NOW(), INTERVAL 24 HOUR)')],
                    ]);
            });

            if($user->hasRole('manager')) {
                $builder->where(function ($query) use ($user) {
                    $query
                        ->where('user_id', $user->id)
                        ->orWhere('responsible_id', $user->id);
                });
            }

            return $builder
                    ->orderBy('created_at')
                    ->get();
    }

    /**
     * @param User $user
     * @return \Illuminate\Contracts\Pagination\LengthAwarePaginator
     */
    public function getArchives(User $user)
    {
        $builder = $this
            ->with(
                [
                    'status',
                    'source',
                    'unit'
                ]
            )
            ->where(function ($query) {
                $query
                    ->where('updated_at', '<', \DB::raw('DATE_SUB(NOW(), INTERVAL 24 HOUR)'))
                    ->where('status_id', 3);
            });

            if($user->hasRole('manager')) {
                $builder->where(function ($query) use ($user) {
                    $query
                        ->where('user_id', $user->id)
                        ->orWhere('responsible_id', $user->id);
                });
            }

            return $builder
                        ->orderBy('updated_at','DESC')
                        ->paginate(config('settings.pagination'));
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function statuses()
    {
        return $this->belongsToMany(Status::class,'task_status');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function status()
    {
        return $this->belongsTo(Status::class);
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function source()
    {
        return $this->belongsTo(Source::class);
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function responsibleUser()
    {
        return $this->belongsTo(User::class,'responsible_id','id');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function unit()
    {
        return $this->belongsTo(Unit::class);
    }


    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function comments()
    {
        return $this->hasMany(TaskComment::class);
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function lastComment()
    {
        return $this->comments()->where('comment_value', '!=', NULL)->orderBy('id','desc')->first();
    }

    public function renderData($load = true) {

        if($load) {
            $this->load(['source','unit','status']);
        }
        return [
            'id' => $this->id,
            'phone' => $this->phone,
            'link' => $this->link,
            'source_id' => $this->source_id,
            'unit_id' => $this->unit_id,
            'status_id' => $this->status_id,
            'created_at' => $this->created_at->toDateTimeString(),
            'lastComment' =>  isset($this->lastComment()->comment_value) ? $this->lastComment()->comment_value : ($this->comments->first()->text ?? ""),
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
            'author' => $this->user->firstname,
            'responsible' => $this->responsibleUser->firstname,
            'responsible_id' => $this->responsible_id,
            'user_id' => $this->user_id,
        ];
    }
}
