<?php

namespace App\Modules\Admin\User\Policies;

use App\Modules\Admin\User\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class UserPolicy
{
    use HandlesAuthorization;

    /**
     * Create a new policy instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public function view(User $user) {
        return $user->canDo(['SUPER_ADMINISTRATOR','USER_ACCESS']);
    }

    public function create(User $user) {
        return $user->canDo(['SUPER_ADMINISTRATOR','USER_ACCESS']);
    }

    public function edit(User $user) {
        return $user->canDo(['SUPER_ADMINISTRATOR','USER_ACCESS']);
    }

    public function delete(User $user) {
        return $user->canDo(['SUPER_ADMINISTRATOR','USER_ACCESS']);
    }
}
