class Admin::ObservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @observations = Observation.all
  end
end
