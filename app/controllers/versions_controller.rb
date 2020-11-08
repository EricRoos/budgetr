# frozen_string_literal: true

class VersionsController < ApplicationController
  def restore
    test = PaperTrail::Version.find(params[:id]).reify(has_many: true, has_one: true, belongs_to: true)
    test.save(validate: false)
    redirect_to request.referer
  end
end
