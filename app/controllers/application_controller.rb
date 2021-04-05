# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, unless: -> { devise_controller? }

  before_action :authenticate_user!
  before_action :check_for_restorable
  before_action :clear_edit_locks
  after_action :clear_flash_messages, if: -> { turbo_frame_request? }

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def route_not_found
    render 'error_pages/404', status: :not_found
  end

  def user_not_authorized
    redirect_to(request.referrer || root_path)
  end

  def clear_locks
    authorize current_user
    head :no_content
  end
  private

  def check_for_restorable
    return if session[:restorable_id].blank?

    @restorable ||= PaperTrail::Version.where(id: session[:restorable_id]).first
    session[:restorable_id] = nil
    @restorable
  end

  def clear_edit_locks
    return nil unless current_user.present?
    current_user.edit_locks.destroy_all
  end

  def clear_flash_messages
    flash.discard
  end
end
