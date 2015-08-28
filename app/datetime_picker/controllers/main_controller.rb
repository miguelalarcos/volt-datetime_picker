module DatetimePicker
  class MainController < Volt::ModelController
    reactive_accessor :show

    def date_f
      attrs.value.strftime(attrs.date_format)
    end

    def date_f=(value)

    end

    def select_day
      d = attrs.data[:date]
      t = attrs.value
      d = Time.new d.year, d.month, d.day, t.hour, t.min
      attrs.value = d
      attrs.hide_calendar
    end

    def hide_calendar
      self.show = false
    end

    def minusMonth
      d = attrs.value
      attrs.value = Time.new(d.year, d.month - 1, d.day, d.hour, d.min)
    end

    def plusMonth
      d = attrs.value
      attrs.value = Time.new(d.year, d.month + 1, d.day, d.hour, d.min)
    end

    def minusYear
      d = attrs.value
      attrs.value = Time.new(d.year-1, d.month, d.day, d.hour, d.min)
    end

    def plusYear
      d = attrs.value
      attrs.value = Time.new(d.year+1, d.month, d.day, d.hour, d.min)
    end

    def minusHour
      attrs.value = Time.new(attrs.value.year, attrs.value.month, attrs.value.day, attrs.value.hour - 1, attrs.value.min)
    end

    def plusHour
      attrs.value = Time.new(attrs.value.year, attrs.value.month, attrs.value.day, attrs.value.hour + 1, attrs.value.min)
    end

    def minusMinute
      attrs.value = Time.new(attrs.value.year, attrs.value.month, attrs.value.day, attrs.value.hour, attrs.value.min - 1)
    end

    def plusMinute
      attrs.value = Time.new(attrs.value.year, attrs.value.month, attrs.value.day, attrs.value.hour, attrs.value.min + 1)
    end

    def days(week, date)
      ret = []
      ini_month = Time.new(date.year,date.month)
      ini_day = ini_month - 60*60*24*(ini_month.wday-1)
      ini_day = ini_day + 60*60*24*7*week
      dt = Time.new(ini_month.year, ini_month.month + 1)
      if ini_day >= dt
        return []
      end
      end_day = ini_day + 60*60*24*6
      while ini_day <= end_day
        if ini_month.month == ini_day.month
          now = Time.new
          now = Time.new now.year, now.month, now.day
          if ini_day == now
            decoration = 'xbold xunderline xtoday xdatetime-day'
          else
            decoration = 'xbold xdatetime-day'
          end
        else
          decoration = 'xcursive xdatetime-day'
        end
        ret << {:value => ini_day.day.to_s.rjust(2, '0'), :date => ini_day, :decoration => decoration}
        ini_day = ini_day + 60*60*24*1
      end
      ret
    end

    def weeks
      (0..5).to_a
    end
  end
end
