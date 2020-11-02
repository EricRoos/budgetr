# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_and_authorize_project, only: %i(edit update destroy)

  # GET /projects
  # GET /projects.json
  def index
    @projects = policy_scope(Project.all)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.includes(item_groups: [:items]).find(params[:id])
    authorize @project
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if current_user.add_project(@project)
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_and_authorize_project
    @project = Project.find(params[:id])
    authorize @project
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :budget)
  end
end
