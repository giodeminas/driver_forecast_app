class Api::V1::ParametersController < ApplicationController
    # GET /parameters
    def index
      parameters = Parameter.where(key: ['AlertDownloadPeriod', 'DangerZoneCheckPeriod'])
      render json: { parameters: parameters }
    end
  
    # POST /parameters
    def create
      parameters = [
        { key: 'AlertDownloadPeriod', value: params[:alert_download_period] },
        { key: 'DangerZoneCheckPeriod', value: params[:danger_zone_check_period] }
      ]
  
      # Update or create parameters
      updated_parameters = parameters.map do |param|
        next if param[:value].blank? # Skip if value is not provided

        param_record = Parameter.find_or_initialize_by(key: param[:key])
        param_record.update(value: param[:value])
        param_record
      end

      CronJobService.new().call
  
      if updated_parameters.all?(&:persisted?) || updated_parameters.all? { |p| p.errors.empty? }
        render json: { message: "Parameters updated successfully", parameters: updated_parameters }, status: :ok
      else
        render json: { errors: updated_parameters.map { |p| p.errors.full_messages } }, status: :unprocessable_entity
      end
    end

  end
  