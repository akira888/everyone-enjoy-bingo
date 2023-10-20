module ApplicationHelper
  def body_class
    "#{controller_path.gsub('/', '-')} #{action_name}"
  end
end
