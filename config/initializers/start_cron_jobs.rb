Rails.application.config.after_initialize do
  Rails.logger.info "Starting cron jobs"
  CronJobService.new().call
end