<?php

namespace App\Modules\Admin\LeadComment\Requests;

use Illuminate\Foundation\Http\FormRequest;

class LeadCommentRequest extends FormRequest
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
            'lead_id' => 'required|integer',
            'status_id' => 'required|integer',
            'text' => 'string|nullable',
        ];
    }
}
