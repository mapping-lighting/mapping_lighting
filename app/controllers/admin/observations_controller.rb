class Admin::ObservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_observation, only: [:show, :edit, :update, :destroy]

  def index
    @observations = Observation.all
    @grid = ObservationsGrid.new(params[:observations_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  # DELETE /observations/1
  # DELETE /observations/1.json
  def destroy
    @observation.destroy
    respond_to do |format|
      format.html { redirect_to admin_observations_url, notice: 'Observation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private def set_observation
    @observation = Observation.find(params[:id])
  end
end
