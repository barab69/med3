<?php

namespace App\Modules\Admin\Analitics\Export;

use App\Modules\Admin\Lead\Models\Lead;
use App\Modules\Admin\User\Models\User;
use DateService;
use Carbon\Carbon;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class LeadsExport implements FromCollection, WithHeadings
{

    private $user;
    private $dateStart;
    private $dateEnd;

    /**
     * LeadsExport constructor.
     * @param $user
     * @param $dateStart
     * @param $dateEnd
     */
    public function __construct(User $user, $dateStart, $dateEnd)
    {
        $this->user = $user;

        $this->dateStart = new Carbon('first day of this month');
        if($dateStart && DateService::isValid($dateStart, "d.m.Y")) {
            $this->dateStart = Carbon::parse($dateStart);
        }

        $this->dateEnd = new Carbon('last day of this month');
        if($dateEnd  && DateService::isValid($dateEnd, "d.m.Y")) {
            $this->dateEnd = Carbon::parse($dateEnd);
        }
    }

    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        //
        $leads = $this->getLeads();

        return $leads->map(function($item) {
            return [
                $item->created_at->format('d.m.Y'),
                $item->user->fullname,
                $item->link,
                $item->phone,
                $item->source ? $item->source->title : '',
                $item->unit ? $item->unit->title : '',
                $item->status->title_ru ?? "",
                $item->isQualityLead ? 'Да' : 'Нет',
                $item->is_add_sale ? 'Да' : 'Нет',
            ];
        });

    }

    /**
     * @return array
     */
    public function headings(): array
    {
        return [
            'Дата',
            'Менеджер',
            'Ссылка',
            'Телефон',
            'Источник',
            'Подразделение',
            'Статус',
            'Успешный?',
            'Доп. продажа'
        ];
    }

    private function getLeads()
    {
        return $this->
                    user->
                    leads()->
                    where('status_id', Lead::DONE_STATUS)->
                    whereDate('leads.created_at','>=', $this->dateStart)->
                    whereDate('leads.created_at','<=', $this->dateEnd)->
                    with('source','unit','user')->
                    get();
    }
}
