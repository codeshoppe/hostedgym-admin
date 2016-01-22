module ApplicationHelper
  def application_title
    ENV['APPLICATION_TITLE'] || 'HostedGym'
  end

  def bootstrap_class_for(flash_type)
    { success: 'success', error: 'danger', alert: 'warning', notice: 'info' }[flash_type.to_sym] || flash_type.to_s
  end
end
