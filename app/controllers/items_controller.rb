# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_and_authorize_project
  before_action :set_item_group
  before_action :set_item, only: %i(show edit update destroy)

  # GET /items
  # GET /items.json
  # def index
  #  @items = Item.all
  # end

  # GET /items/1
  # GET /items/1.json
  # def show; end

  # GET /items/new
  def new
    @item = @item_group.items.build
    authorize @item
    respond_to do |format|
      format.html
    end
  end

  # GET /items/1/edit
  def edit
    @item.lock_for_editing(current_user)
    respond_to do |format|
      format.html
    end
  end

  # POST /items
  # POST /items.json
  def create
    @item = @item_group.items.build(item_params)
    authorize @item

    respond_to do |format|
      if @item.save
        format.turbo_stream do
          flash.now[:notice] = 'Item created'
          render turbo_stream: [
            turbo_stream.update(
              :new_item,
              partial: 'items/modal_form',
              locals: {
                item: @item_group.items.build
              }
            )
          ]
        end
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        flash.now[:notice] = 'Item updated'
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              @item,
              partial: 'items/item',
              locals: {
                item: @item
              }
            ),
            turbo_stream.update(
              :edit_item,
              partial: 'items/modal_form',
              locals: {
                item: @item
              }
            )
          ]
        end
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    session[:restorable_id] = @item.versions.last.id
    respond_to do |format|
      format.html do
        redirect_to project_item_group_path(@project, @item_group), notice: 'Item was successfully destroyed.'
      end
      format.js
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_and_authorize_project
    @project = Project.find(params[:project_id])
    head :not_found if @project.blank?
    @project
  end

  def set_item_group
    @item_group = @project.item_groups.where(id: params[:item_group_id]).first
  end

  def set_item
    @item = Item.find(params[:id])
    authorize @item
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:item_group_id, :name, :quantity, :purchase_price, :note, :purchased)
  end
end
