class ApplicationController < ActionController::Base
  before_action :check_for_restorable

  def check_for_restorable
    return unless session[:restorable_id].present?
    @restorable ||= PaperTrail::Version.where(id: session[:restorable_id]).first
    session[:restorable_id] = nil
    @restorable
  end
end
