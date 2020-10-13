class VersionsController < ApplicationController
  def restore
    PaperTrail::Version.find(params[:id]).reify.save
    redirect_to request.referer
  end
end
