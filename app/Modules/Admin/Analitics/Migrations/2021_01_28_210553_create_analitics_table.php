<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAnaliticsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $str = <<<EOD
CREATE PROCEDURE countLeads(IN p1 DATE, IN p2 DATE)
BEGIN
SELECT
	users.id,
    users.firstname,
    users.lastname,
    COUNT(*) AS CountLeads,
    COUNT(IF(leads.isQualityLead='1', 1, null)) as CountQualityLeads,
    COUNT(IF(leads.isQualityLead='1' AND leads.is_add_sale='1', 1, null)) as CountQualityAssSaleLeads,
    COUNT(IF(leads.isQualityLead='0', 1, null)) as CountNotQualityLeads,
    COUNT(IF(leads.isQualityLead='0' AND leads.is_add_sale='1', 1, null)) as CountNotQualityAssSaleLeads
FROM
    leads
LEFT JOIN users ON(users.id = leads.user_id)
WHERE leads.created_at >= p1 AND leads.created_at <= p2  AND leads.status_id = '3'
GROUP BY users.id, users.firstname, users.lastname;
END

EOD;

        \Illuminate\Support\Facades\DB::unprepared($str);

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('analitics');
    }
}
