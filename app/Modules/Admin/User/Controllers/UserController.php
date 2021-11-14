<?php

namespace App\Modules\Admin\User\Controllers;

use App\Modules\Admin\Dashboard\Classes\Base;
use App\Modules\Admin\Role\Models\Role;
use App\Modules\Admin\User\Models\Filters\UserSearch;
use App\Modules\Admin\User\Models\User;
use App\Modules\Admin\User\Requests\UserRequest;
use App\Modules\Admin\User\Requests\UserRequestWeb;
use App\Modules\Admin\User\Services\UserService;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class UserController extends Base
{

    /**
     * RoleController constructor.
     */
    public function __construct(UserService $userService)
    {
        parent::__construct();
        $this->service = $userService;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request,UserSearch $userSearch)
    {
        //$users = User::paginate(config('settings.pagination'))->appends(request()->input());

        $search = $request->input('search');
        $roleId = $request->input('role');


        $users = $userSearch->apply($request)->paginate(config('settings.pagination'))->appends(request()->input());

        /** @var String $title */
        $this->title = __("Users page");

        /** @var String $content */
        $this->content = view('Admin::User.index')
            ->with([
                'items' => $users,
                'title' => $this->title,
                'roles' => Role::all(),
                'search' => $search,
                'roleId' => $roleId,
            ])->render();

        //render output
        return $this->renderOutput();

    }

    /**
     * Create of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        /** @var String $title */
        $this->title = __("User Create");

        /** @var Role $roles */
        $roles = Role::all();

        /** @var String $content */
        $this->content = view('Admin::User.create')
            ->with([
                'title' => $this->title,
                'roles' => $roles
            ])->render();

        //render output
        return $this->renderOutput();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(UserRequestWeb $request)
    {
        $this->service->saveWeb($request, new User());
        return  \Redirect::route('users.index')->with([
            'message' => __('Success')
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Modules\Admin\User\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function show(User $user)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Modules\Admin\User\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function edit(User $user)
    {
        $this->authorize('edit', $user);

        $this->title = "User Edit";

        $this->content = view('Admin::User.edit')->
        with([
            'title' => $this->title,
            'item' => $user,
            'roles' => Role::all()
        ])->
        render();

        return $this->renderOutput();
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Modules\Admin\User\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function update(UserRequestWeb $request, User $user)
    {
        $this->service->saveWeb($request, $user);
        return  \Redirect::route('users.index')->with([
            'message' => __('Success')
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Modules\Admin\User\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function destroy(User $user)
    {
        $user->status = '0';
        $user->update();

        return  \Redirect::route('users.index')->with([
            'message' => __('Success')
        ]);
    }
}
