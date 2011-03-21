module ApplicationHelper

  def show_flash_messages(flash)
    s = ''
    flash.each do |type, message|
      s << content_tag(:div, "<p>#{message}</p>".html_safe, :class => "flash #{type}")
    end

    s.html_safe
  end

end
