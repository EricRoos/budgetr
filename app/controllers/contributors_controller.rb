class ContributorsController < ApplicationController
  before_action :set_and_authorize_project
  before_action :set_contributor, only: [:show, :edit, :update, :destroy]


  # GET /contributors/new
  def new
    @contributor = @project.contributors.build
    authorize @contributor
  end

  # POST /contributors
  # POST /contributors.json
  def create
    @contributor = @project.contributors.build({user: User.where(email: params[:contributor][:user][:email]).first})
    authorize @contributor

    respond_to do |format|
      if @contributor.save
        format.html { redirect_to edit_project_path(@project), notice: 'Contributor was successfully created.' }
        format.json { render :show, status: :created, location: @contributor }
      else
        format.html { render :new }
        format.json { render json: @contributor.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /contributors/1
  # DELETE /contributors/1.json
  def destroy
    @contributor.destroy
    respond_to do |format|
      format.html { redirect_to edit_project_path(@project), notice: 'Contributor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_and_authorize_project
      @project = Project.where(id: params[:project_id]).first
      head :not_found unless @project.present?
      @project
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_contributor
      @contributor = Contributor.find(params[:id])
      authorize @contributor
    end

    # Only allow a list of trusted parameters through.
    def contributor_params
      params.require(:contributor).permit(:user_id, :project_id)
    end
end
