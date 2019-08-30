module ApplicationHelper
  def auth_token
    "<input type=\"hidden\"
            name=\"authenticity_token\"
            value=\"#{h(form_authenticity_token)}\">".html_safe
  end

  def submit_button(value)
    "<input type=\"submit\"
            value=\"#{h(value)}\">".html_safe
  end
end
