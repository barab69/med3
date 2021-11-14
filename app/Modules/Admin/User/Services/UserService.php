<?php


namespace App\Modules\Admin\User\Services;


use App\Modules\Admin\Role\Models\Role;
use App\Modules\Admin\User\Models\User;
use App\Modules\Admin\User\Requests\UserRequest;
use App\Modules\Admin\User\Requests\UserRequestWeb;
use Illuminate\Support\Facades\Hash;

class UserService
{

    public function getUsers($status = false)
    {

        $usersBulder = User::with('roles');

        if($status) {
            $usersBulder->where('status',(string)$status);
        }

        $users = $usersBulder->get();
        $users->transform(function($item) {
            $item->rolename = '';
            if(isset($item->roles)) {
                $item->rolename = isset($item->roles->first()->title) ? $item->roles->first()->title : "";
            }

            return $item;
        });

        return $users;
    }

    public function save(UserRequest $request, User $user)
    {
        $user->fill($request->only($user->getFillable()));

        if($request->password){
            $user->password = Hash::make($request->password);
        }

        $user->status = 1;

        $user->save();

        $role = Role::findOrFail($request->role_id);
        $user->roles()->sync($role->id);

        $user->rolename = $role->title;

        return $user;
    }

    public function saveWeb(UserRequestWeb $request, User $user)
    {
        $user->fill($request->only($user->getFillable()));

        if($request->password){
            $user->password = Hash::make($request->password);
        }

        $user->status = '1';

        $user->save();

        $role = Role::findOrFail($request->role_id);
        $user->roles()->sync($role->id);

        $user->rolename = $role->title;

        return $user;
    }
}
