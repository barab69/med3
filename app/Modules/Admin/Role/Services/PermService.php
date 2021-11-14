<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 13.12.2020
 * Time: 14:39
 */

namespace App\Modules\Admin\Role\Services;


use App\Modules\Admin\Role\Models\Role;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class PermService
{
    public function save(Request $request) {

        $data = $request->except('_token');

        $roles = Role::all();

        foreach ($roles as $role) {

            if(isset($data[$role->id])) {
                ////
                $role->savePermissions($data[$role->id]);
            }
            else {
                //
                $role->savePermissions([]);
            }
        }

        return true;
    }
}