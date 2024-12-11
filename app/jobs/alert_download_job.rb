require 'sidekiq/cron/job'

class AlertDownloadJob
  include Sidekiq::Job
  
  def perform
    AlertDownloadService.new().call
  end
end