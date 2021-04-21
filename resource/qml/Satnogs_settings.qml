import QtQuick 2.15

Satnogs_settingsForm {

    accept.onPressed: {
        var id = norad_id.text
        var start = start_date_year.text + "-" + start_date_month.text + "-" + start_date_day.text +
                "T"
                + start_time_hour.text + ":" + start_time_min.text + ":" + start_time_sec.text

        var end = end_date_year.text + "-" + end_date_month.text + "-" + end_date_day.text +
                "T"
                + end_time_hour.text + ":" + end_time_min.text + ":" + end_time_sec.text
        var stat = status.currentText

        var delete_old_data = checkBox_keep_data.checked
        Controller.setSatnogs(id , start, end, stat, delete_old_data);

    }


    end_time_hour.onTextChanged: if (end_time_hour.length > 2) end_time_hour.remove(2, end_time_hour.length);
    end_time_min.onTextChanged: if (end_time_min.length > 2) end_time_min.remove(2, end_date_year.length);
    end_time_sec.onTextChanged: if (end_time_sec.length > 2) end_time_sec.remove(2, end_date_year.length);
    end_date_day.onTextChanged: if (end_date_day.length > 2) end_date_day.remove(2, end_date_day.length);
    end_date_month.onTextChanged: if (end_date_month.length > 2) end_date_month.remove(2, end_date_month.length);
    end_date_year.onTextChanged: if (end_date_year.length > 4) start_date_year.remove(4, end_date_year.length);

    start_time_hour.onTextChanged: if (start_time_hour.length > 2) start_time_hour.remove(2, start_time_hour.length);
    start_time_min.onTextChanged: if (start_time_min.length > 2) start_time_min.remove(2, start_time_min.length);
    start_time_sec.onTextChanged: if (start_time_sec.length > 2) start_time_sec.remove(2, start_time_sec.length);
    start_date_day.onTextChanged: if (start_date_day.length > 2) start_date_day.remove(2, start_date_day.length);
    start_date_month.onTextChanged: if (start_date_month.length > 2) start_date_month.remove(2, start_date_month.length);
    start_date_year.onTextChanged: if (end_date_year.length > 4) start_date_year.remove(4, end_date_year.length);

    end_date_year.text: {
        var now = new Date;
        return now.getUTCFullYear()
    }


    end_date_month.text: {
        var now = new Date;
        return now.getMonth() +1
    }


    end_date_day.text: {
        var now = new Date;
        return now.getUTCDate()
    }


    end_time_hour.text: {
        var now = new Date;
        return now.getUTCHours()
    }

    end_time_min.text: {
        var now = new Date;
        return now.getUTCMinutes()
    }

    end_time_sec.text: {
        var now = new Date;
        return now.getUTCSeconds()
    }
}
