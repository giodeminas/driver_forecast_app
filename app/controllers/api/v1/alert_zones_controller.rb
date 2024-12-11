class Api::V1::AlertZonesController < ApplicationController
  before_action :set_alert_zone, only: %i[ show update destroy ]

  # GET /alert_zones
  def index
    @alert_zones = AlertZone.all

    render json: @alert_zones
  end

  # GET /alert_zones/1
  def show
    render json: @alert_zone
  end

  # POST /alert_zones
  def create
    @alert_zone = AlertZone.new(alert_zone_params)

    if @alert_zone.save
      render json: @alert_zone, status: :created, location: @alert_zone
    else
      render json: @alert_zone.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /alert_zones/1
  def update
    if @alert_zone.update(alert_zone_params)
      render json: @alert_zone
    else
      render json: @alert_zone.errors, status: :unprocessable_entity
    end
  end

  # DELETE /alert_zones/1
  def destroy
    @alert_zone.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert_zone
      @alert_zone = AlertZone.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alert_zone_params
      params.require(:alert_zone).permit(:alert_id, :name, :geometry)
    end
end
