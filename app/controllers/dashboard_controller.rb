class DashboardController < ApplicationController
    before_action :authenticate_user
    skip_before_action :verify_authenticity_token, only: [:index]
    def index
      @companies = Company.where(user_id: current_user.id)
    end
  end