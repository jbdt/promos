Trestle.admin(:dashboard, model: false) do
  menu do
    item :dashboard, icon: "fa fa-dashboard", label: "Dashboard", priority: :first
  end

  controller do
    def index
      @today = Date.today
      @daily_view = DailyView.find_by(day: @today)

      missing_days = []
      (1..7).each do |i|
        day = @today + i.days
        missing_days << day.strftime("%A, %B %d, %Y") unless DailyView.exists?(day: day)
      end
  
      if missing_days.any?
        flash.now[:danger] = "<b>No daily view assigned for the following days:</b> \n" + missing_days.join("\n")
      end
    end
  end
end
