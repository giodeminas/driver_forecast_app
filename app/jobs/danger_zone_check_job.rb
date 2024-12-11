require 'sidekiq/cron/job'

class DangerZoneCheckJob
  include Sidekiq::Job
  
  def perform
    DangerZoneCheckService.new().call
  end
end