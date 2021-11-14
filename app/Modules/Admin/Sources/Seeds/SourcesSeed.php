<?php
/**
 * Created by PhpStorm.
 * User: note
 * Date: 26.12.2020
 * Time: 18:05
 */

namespace App\Modules\Admin\Sources\Seeds;


use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SourcesSeed extends Seeder
{
    public function run() {
        DB::table('sources')->insert([
            [
                'title'=>'Instagram',
            ],
            [
                'title'=>'Viber',
            ],
            [
                'title'=>'Site',
            ],
            [
                'title'=>'Phone',
            ],
        ]);
    }
}