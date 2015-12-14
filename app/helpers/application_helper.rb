module ApplicationHelper
  def flash_class flash_type
    {
      :success => 'alert-success',
      :notice => 'alert-success',
      :error => 'alert-danger',
      :alert => 'alert-danger',
    }[flash_type.to_sym] || flash_type.to_s
  end
end
