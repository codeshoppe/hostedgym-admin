module ApplicationHelper
  def application_title
    ENV['APPLICATION_TITLE'] || 'HostedGym'
  end
end
