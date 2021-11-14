<!-- Page header -->
<section class="content-header">
    <h1>{{$title}}</h1>
    <a href="{{route('users.create')}}" class="btn btn-success">{{ __('Create') }}</a>

</section>
<!-- /page header -->

<!-- Content area -->
<div class="content">
    <!-- Hover rows -->

        <form action="{{route('users.index')}}">
            <div class="form-group row">
                <div class="col-lg-2">
                    <div class="input-group">
                        <input type="text" name="search"  class="form-control"
                               value="{{$search ?? old('firstname')}}"
                               placeholder="{{__('User name')}}">
                    </div>
                </div>

                @if($roles)
                    <div class="col-lg-2">
                        <div class="input-group">
                            <select name="role" class="form-control multiselect"  data-fouc>
                                <option  value="">{{__('User role')}}</option>
                                @foreach($roles as $key => $role)
                                    <option
                                            @if(isset($roleId) && $roleId == $role->id)
                                            selected
                                            @endif
                                            value="{{ $role->id }}">{{$role->title}}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                @endif

                <div class="col-lg-2">
                    <div class="input-group">
                        <button type="submit"
                                class="btn bg-transparent border-teal text-teal border-2 btn-icon mr-3">{{__('Filter')}}</button>
                        <a href="{{route('users.index')}}" id="users_page_search_clear"
                                class="btn">{{__('Clear')}}</a>
                    </div>
                </div>
            </div>
        </form>



    <div class="card">
        <div class="table-responsive">
            @if($items)
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>{{ __('ID') }}</th>
                        <th>{{ __('Fullname') }}</th>
                        <th>{{ __('email') }}</th>
                        <th>{{ __('status') }}</th>
                        <th>{{ __('Actions') }}</th>

                    </tr>
                    </thead>
                    <tbody>
                    @foreach($items as $item)
                        <tr>
                            <td>{{$item->id}}</td>
                            <td>{{$item->fullname}}</td>
                            <td>{{$item->email}}</td>
                            <td>{{$item->status}}</td>
                            <td>
                                <div class="row">
                                    <a href="{{route('users.edit',['user'=>$item->id])}}"
                                       class="btn btn-primary btn-labeled">{{ __('Edit') }}
                                    </a>
                                    &nbsp;
                                    <form method="post"  action="{{route('users.delete',['user'=>$item->id])}}">
                                        @csrf
                                        @method('DELETE')
                                        <button  type="submit" class="btn btn-danger">{{ __('Delete') }}
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @endforeach

                    <div style="display:none">
                        <form method="post" id="contact-applications-delete" action="">
                            @csrf
                            @method('DELETE')
                        </form>
                    </div>

                    </tbody>
                </table>
            @endif
        </div>
    </div>
    <!-- /hover rows -->

</div>
<!-- /content area -->
