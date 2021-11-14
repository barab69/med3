<!-- Page header -->
<section class="content-header">
    <h1>{{$title}}</h1>
</section>
<!-- /page header -->


<!-- Content area -->
<div class="content">

    <!-- Input group addons -->
    <div class="box card">
        <form role="form" enctype="multipart/form-data" method="post" action="{{ route('users.update',['user'=>$item->id]) }}">

            @csrf
            @method('PUT')

            <div class="card-body">

                @if ($errors->any())
                    <div class="alert alert-danger">
                        <ul>
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif

                <fieldset class="mb-3">
                    <legend class="">{{__('Common info')}}</legend>

                    <div class="form-group row">
                        <label class="col-form-label col-lg-2">{{__('Firstname')}}<span
                                    class="text-danger">*</span></label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="text" name="firstname" required class="form-control"
                                       value="{{$item->firstname ?? old('firstname')}}"
                                       placeholder="{{__('firstname')}}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-form-label col-lg-2">{{__('Lastname')}}<span
                                    class="text-danger">*</span></label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="text" name="lastname" required class="form-control"
                                       value="{{$item->lastname ?? old('lastname')}}"
                                       placeholder="{{__('lastname')}}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-form-label col-lg-2">{{__('Email')}}<span
                                    class="text-danger">*</span></label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="text" name="email" required class="form-control"
                                       value="{{$item->email ?? old('email')}}"
                                       placeholder="{{__('email')}}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-form-label col-lg-2">{{__('Phone')}}<span
                                    class="text-danger">*</span></label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="text" name="phone" required class="form-control"
                                       value="{{$item->phone ?? old('phone')}}"
                                       placeholder="{{__('phone')}}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-form-label col-lg-2">{{__('Password')}}<span
                                    class="text-danger">*</span></label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <input type="password" name="password" class="form-control"
                                       value=""
                                       placeholder="{{__('password')}}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-form-label col-lg-2">{{__('Role')}}<span
                                    class="text-danger">*</span></label>
                        <div class="col-lg-10">
                            <div class="input-group">
                                <select name="role_id" class="form-control">

                                    @foreach($roles as $role)
                                        <option @if(!$item->roles->where('id',$role->id)->isEmpty()) selected @endif value="{{$role->id}}">{{$role->title}}</option>
                                    @endforeach

                                </select>
                            </div>
                        </div>
                    </div>


                </fieldset>
                <button type="submit" class="btn btn-success">{{__('Submit')}}</button>


            </div>
        </form>
    </div>
    <!-- /input group addons -->

</div>

<!-- /content area -->
