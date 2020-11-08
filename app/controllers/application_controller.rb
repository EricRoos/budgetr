# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, unless: -> { devise_controller? }

  before_action :authenticate_user!
  before_action :check_for_restorable

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def route_not_found
    render 'error_pages/404', status: :not_found
  end

  def user_not_authorized
    redirect_to(request.referrer || root_path)
  end

  private
    def check_for_restorable
      return if session[:restorable_id].blank?

      @restorable ||= PaperTrail::Version.where(id: session[:restorable_id]).first
      session[:restorable_id] = nil
      @restorable
    end
end
