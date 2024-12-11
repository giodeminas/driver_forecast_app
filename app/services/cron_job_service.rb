class CronJobService
    def call
      # Fetch updated parameter values for CRON jobs
      alert_download_period = Parameter.find_by(key: 'AlertDownloadPeriod')&.value
      danger_zone_check_period = Parameter.find_by(key: 'DangerZoneCheckPeriod')&.value

      # Update CRON schedules if parameters are present
      if alert_download_period.present?
        job = Sidekiq::Cron::Job.find('AlertDownloadJob')
  
        job.destroy if job

        Sidekiq::Cron::Job.create(
          name: 'AlertDownloadJob',
          cron: "*/#{alert_download_period} * * * *",
          class: 'AlertDownloadJob'
        )
      end

      if danger_zone_check_period.present?
        job = Sidekiq::Cron::Job.find('DangerZoneCheckJob')
  
        job.destroy if job

        Sidekiq::Cron::Job.create(
          name: 'DangerZoneCheckJob',
          cron: "*/#{danger_zone_check_period} * * * *",
          class: 'DangerZoneCheckJob'
        )
      end
    end
end