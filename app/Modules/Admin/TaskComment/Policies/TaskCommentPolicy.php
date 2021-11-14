<?php

namespace App\Modules\Admin\TaskComment\Policies;

use App\Modules\Admin\User\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class TaskCommentPolicy
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
        return $user->canDo(['SUPER_ADMINISTRATOR','TASKS_COMMENT_VIEW']);
    }

    /**
     * @param User $user
     * @return bool
     */
    public function save(User $user)
    {
        return $user->canDo(['SUPER_ADMINISTRATOR','TASKS_COMMENT_CREATE']);
    }

    /**
     * @param User $user
     * @return bool
     */
    public function edit(User $user)
    {
        return $user->canDo(['SUPER_ADMINISTRATOR','TASKS_COMMENT_EDIT']);
    }

    /**
     * @param User $user
     * @return bool
     */
    public function delete(User $user)
    {
        return $user->canDo(['SUPER_ADMINISTRATOR','TASKS_COMMENT_EDIT']);
    }
}
