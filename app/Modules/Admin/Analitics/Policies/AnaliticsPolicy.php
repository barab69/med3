<?php

namespace App\Modules\Admin\Analitics\Policies;

use App\Modules\Admin\User\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

trait AnaliticsPolicy
{

    public function viewAnalitic(User $user) {
        return $user->canDo(['SUPER_ADMINISTRATOR','ANALITICS_ACCESS']);
    }
}
