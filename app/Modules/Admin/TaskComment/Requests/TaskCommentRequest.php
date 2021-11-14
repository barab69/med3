<?php

namespace App\Modules\Admin\TaskComment\Requests;

use Illuminate\Foundation\Http\FormRequest;

class TaskCommentRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            //
            'task_id' => 'required|integer',
            'status_id' => 'required|integer',
            'text' => 'string|nullable',
        ];
    }
}
