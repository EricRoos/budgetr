# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/item_groups', type: :request do
  let(:current_user) do
    project_owner
  end
  let(:project_owner) do
    email = 'foo@test.com'
    password = 'test123456'
    User.create(email: email, password: password)
  end
  let(:contributing_user) do
    u = User.create(email: 'contrib@1.com', password: 'test123456')
    Contributor.create(user: u, project: project)
    u
  end
  # ItemGroup. As you add validations to ItemGroup, be sure to
  # adjust the attributes here as well.

  let(:project) do
    project = Project.new(name: 'foo', budget: 1000)
    project_owner.add_project(project)
    project
  end

  let(:valid_attributes) do
    {
      name: 'name',
      budget: 1000,
      project_id: project.id,
    }
  end

  let(:invalid_attributes) do
    {
      budget: -1000,
    }
  end

  before do
    sign_in current_user
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_project_item_group_url(project)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      item_group = ItemGroup.create! valid_attributes
      get edit_project_item_group_url(project, item_group)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new ItemGroup' do
        expect do
          post project_item_groups_url(project), params: { item_group: valid_attributes }
        end.to change(ItemGroup, :count).by(1)
      end
      context 'when logged in as a contributing user' do
        let(:current_user) { contributing_user }

        it 'creates a new ItemGroup' do
          expect do
            post project_item_groups_url(project), params: { item_group: valid_attributes }
          end.to change(ItemGroup, :count).by(1)
        end
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new ItemGroup' do
        expect do
          post project_item_groups_url(project), params: { format: 'turbo_stream', item_group: invalid_attributes }
        end.to change(ItemGroup, :count).by(0)
      end
    end

    context 'when not logged in as project owner' do
      let(:current_user) { User.create(email: 'other@test.com', password: 'test1234556') }

      it 'does not create a new ItemGroup' do
        expect do
          post project_item_groups_url(project), params: { item_group: valid_attributes }
        end.to change(ItemGroup, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    let(:new_attributes) do
      {
        name: 'updated',
      }
    end

    context 'with valid parameters' do
      it 'updates the requested item_group' do
        item_group = ItemGroup.create! valid_attributes
        patch project_item_group_url(project, item_group), params: { item_group: new_attributes }
        item_group.reload
        expect(item_group.name).to eq('updated')
      end
      context 'when logged in as a contributing user' do
        let(:current_user) { contributing_user }

        it 'updates the requested item_group' do
          item_group = ItemGroup.create! valid_attributes
          patch project_item_group_url(project, item_group), params: { item_group: new_attributes }
          item_group.reload
          expect(item_group.name).to eq('updated')
        end
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        item_group = ItemGroup.create! valid_attributes
        patch project_item_group_url(project, item_group), params: { format: 'turbo_stream',  item_group: invalid_attributes }
        expect(response).to be_successful
      end
    end

    context 'when not logged in as project owner' do
      let(:current_user) { User.create(email: 'other@test.com', password: 'test1234556') }

      it 'does not update the requested item_group' do
        item_group = ItemGroup.create! valid_attributes
        expect do
          patch project_item_group_url(project, item_group), params: { item_group: new_attributes }
        end.not_to change { item_group.reload.as_json }
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested item_group' do
      item_group = ItemGroup.create! valid_attributes
      expect do
        delete project_item_group_url(project, item_group)
      end.to change(ItemGroup, :count).by(-1)
    end
    context 'when logged in as a contributing user' do
      let(:current_user) { contributing_user }

      it 'destroys the requested item_group' do
        item_group = ItemGroup.create! valid_attributes
        expect do
          delete project_item_group_url(project, item_group)
        end.to change(ItemGroup, :count).by(-1)
      end
    end

    context 'when not logged in as project owner' do
      let(:current_user) { User.create(email: 'other@test.com', password: 'test1234556') }

      it 'does not destroy the requested item_group' do
        item_group = ItemGroup.create! valid_attributes
        expect do
          delete project_item_group_url(project, item_group)
        end.to change(ItemGroup, :count).by(0)
      end
    end
  end
end
