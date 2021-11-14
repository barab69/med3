<?php

namespace App\Modules\Admin\LeadComment\Models;

use App\Modules\Admin\Lead\Models\Lead;
use App\Modules\Admin\Status\Models\Status;
use App\Modules\Admin\User\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LeadComment extends Model
{
    use HasFactory;

    protected $fillable = [
        'text',
        'comment_value',
    ];

    public function lead() {
        return $this->belongsTo(Lead::class);
    }
    public function user() {
        return $this->belongsTo(User::class);
    }
    public function status() {
        return $this->belongsTo(Status::class);
    }
}
