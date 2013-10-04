module ApplicationHelper
  def percent_color(percent)
    if percent<10
      "#d00000"
    elsif percent < 20
      "#c11111"
    elsif percent < 30
      "#8c1a1a"
    elsif percent < 40
      "#3a0a0a"
    elsif percent < 60
      "#000"
    elsif percent < 70
      "#0a3a0a"
    elsif percent < 80
      "#1a8c1a"
    elsif percent < 90
      "#11c111"
    else
      "#00d000"
    end
  end
end
