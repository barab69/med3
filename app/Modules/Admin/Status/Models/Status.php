<?php

namespace App\Modules\Admin\Status\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Status extends Model
{
    use HasFactory;

    public function leads() {
        return $this->belongsTo(Status::class);
    }
}
