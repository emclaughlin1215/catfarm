class TreatmentsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @treatments = Treatment.paginate(page: params[:page])
  end

  private

    def treatment_params
      params.require(:treatment).permit()
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
