# frozen_string_literal: true

class ItemGroupsController < ApplicationController
  before_action :set_and_authorize_project
  before_action :set_item_group, only: %i(show edit update destroy)

  # GET /item_groups
  # GET /item_groups.json
  def index
    @item_groups = @project.item_groups
  end

  # GET /item_groups/1
  # GET /item_groups/1.json
  def show; end

  # GET /item_groups/new
  def new
    @item_group = @project.item_groups.build
  end

  # GET /item_groups/1/edit
  def edit; end

  # POST /item_groups
  # POST /item_groups.json
  def create
    @item_group = @project.item_groups.build(item_group_params)
    authorize @item_group, policy_class: ProjectEntityPolicy

    respond_to do |format|
      if @item_group.save
        format.html { redirect_to @project, notice: 'Item group was successfully created.' }
        format.json { render :show, status: :created, location: @item_group }
      else
        format.html { render :new }
        format.json { render json: @item_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_groups/1
  # PATCH/PUT /item_groups/1.json
  def update
    respond_to do |format|
      if @item_group.update(item_group_params)
        format.html do
          redirect_to project_path(@project, shownItemGroup: @item_group.id), notice: 'Item group was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @item_group }
      else
        format.html { render :edit }
        format.json { render json: @item_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_groups/1
  # DELETE /item_groups/1.json
  def destroy
    @item_group.destroy
    session[:restorable_id] = @item_group.versions.last.id
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Item group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_and_authorize_project
    @project = Project.find(params[:project_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_item_group
    @item_group = ItemGroup.find(params[:id])
    authorize @item_group, policy_class: ProjectEntityPolicy
  end

  # Only allow a list of trusted parameters through.
  def item_group_params
    params.require(:item_group).permit(:project_id, :name, :budget, :note)
  end
end
