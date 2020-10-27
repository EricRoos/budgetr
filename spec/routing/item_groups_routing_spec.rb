# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemGroupsController, type: :routing do
  let(:base_route_expect) do
    {
      controller: 'item_groups',
      project_id: '1'
    }
  end
  let(:base_route) { '/projects/1/item_groups' }
  let(:path) { '' }
  let(:full_path) { "#{base_route}#{path}" }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: base_route).to route_to(base_route_expect.merge(action: 'index'))
    end

    it 'routes to #new' do
      expect(get: "#{base_route}/new").to route_to(base_route_expect.merge(action: 'new'))
    end

    it 'routes to #show' do
      expect(get: base_route + '/1').to route_to(base_route_expect.merge(action: 'show', id: '1'))
    end

    it 'routes to #edit' do
      expect(get: base_route + '/1/edit').to route_to(base_route_expect.merge(action: 'edit', id: '1'))
    end

    it 'routes to #create' do
      expect(post: base_route).to route_to(base_route_expect.merge(action: 'create'))
    end

    it 'routes to #update via PUT' do
      expect(put: base_route + '/1').to route_to(base_route_expect.merge(action: 'update', id: '1'))
    end

    it 'routes to #update via PATCH' do
      expect(patch: base_route + '/1').to route_to(base_route_expect.merge(action: 'update', id: '1'))
    end

    it 'routes to #destroy' do
      expect(delete: base_route + '/1').to route_to(base_route_expect.merge(action: 'destroy', id: '1'))
    end
  end
end
