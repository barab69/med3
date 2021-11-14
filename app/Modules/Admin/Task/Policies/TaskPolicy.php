<?php

namespace App\Modules\Admin\Task\Policies;
use App\Modules\Admin\User\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class TaskPolicy
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
    /**
     * @param User $user
     * @return bool
     */
    public function view(User $user)
    {
        return $user->canDo(['SUPER_ADMINISTRATOR','TASKS_VIEW']);
    }

    /**
     * @param User $user
     * @return bool
     */
    public function save(User $user)
    {

        return $user->canDo(['SUPER_ADMINISTRATOR','TASKS_CREATE']);
    }

    /**
     * @param User $user
     * @return bool
     */
    public function edit(User $user)
    {
        return $user->canDo(['SUPER_ADMINISTRATOR','TASKS_EDIT']);
    }

    /**
     * @param User $user
     * @return bool
     */
    public function delete(User $user)
    {
        return $user->canDo(['SUPER_ADMINISTRATOR','TASKS_EDIT']);
    }
}
