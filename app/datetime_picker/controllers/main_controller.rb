module DatetimePicker
  class MainController < Volt::ModelController
    reactive_accessor :show

    def date_f
      if attrs.value.nil?
        ''
      else
        attrs.value.strftime(attrs.date_format)
      end
    end

    def date_f=(value)

    end

    def select_day
      d = attrs.data[:date]
      t = get_date
      d = Time.new d.year, d.month, d.day, t.hour, t.min
      attrs.value = d
      attrs.hide_calendar
    end

    def hide_calendar
      self.show = false
    end

    def get_date
      if attrs.value.nil?
        if attrs.time
          Time.now
        else
          d = Time.now
          Time.new d.year, d.month, d.day
        end
      else
        attrs.value
      end
    end

    def minusMonth
      d = get_date
      attrs.value = Time.new(d.year, d.month - 1, d.day, d.hour, d.min)
    end

    def plusMonth
      d = get_date
      attrs.value = Time.new(d.year, d.month + 1, d.day, d.hour, d.min)
    end

    def minusYear
      d = get_date
      attrs.value = Time.new(d.year-1, d.month, d.day, d.hour, d.min)
    end

    def plusYear
      d = get_date
      attrs.value = Time.new(d.year+1, d.month, d.day, d.hour, d.min)
    end

    def minusHour
      d = get_date
      attrs.value = Time.new(d.year, d.month, d.day, d.hour - 1, d.min)
    end

    def plusHour
      d = get_date
      attrs.value = Time.new(d.year, d.month, d.day, d.hour + 1, d.min)
    end

    def minusMinute
      d = get_date
      attrs.value = Time.new(d.year, d.month, d.day, d.hour, d.min - 1)
    end

    def plusMinute
      d = get_date
      attrs.value = Time.new(d.year, d.month, d.day, d.hour, d.min + 1)
    end

    def days(week, date)
      if date.nil?
        date = Time.now
      end
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

    def time_display
      if attrs.value.nil?
        Time.now.strftime('%H:%M')
      else
        attrs.value.strftime('%H:%M')
      end
    end

    def month_display
      if attrs.value.nil?
        Time.now.strftime('%m')
      else
        attrs.value.strftime('%m')
      end
    end

    def year_display
      if attrs.value.nil?
        Time.now.strftime('%Y')
      else
        attrs.value.strftime('%Y')
      end
    end
  end
end
