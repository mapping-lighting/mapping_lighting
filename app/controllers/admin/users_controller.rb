class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end


  def index
    @users = User.all

    @users_grid = UsersGrid.new(params[:users_grid])
    respond_to do |f|
      f.html do
        @users_grid.scope {|scope| scope.page(params[:page]) }
      end
      f.csv do
        send_data @users_grid.to_csv,
          type: "text/csv",
          disposition: 'inline',
          filename: "users_grid-#{Time.now.to_s(:file_name_timestamp)}.csv"
      end
    end
  end


  # DELETE /observations/1
  # DELETE /observations/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
