# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :routing do
  let(:base_route_expect) do
    {
      controller: 'items',
      project_id: '1',
      item_group_id: '1',
    }
  end

  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'projects/1/item_groups/1/items').to route_to(base_route_expect.merge(action: 'index'))
    end

    it 'routes to #new' do
      expect(get: 'projects/1/item_groups/1/items/new').to route_to(base_route_expect.merge(action: 'new'))
    end

    it 'routes to #show' do
      expect(get: 'projects/1/item_groups/1/items/1').to route_to(base_route_expect.merge(action: 'show', id: '1'))
    end

    it 'routes to #edit' do
      expect(get: 'projects/1/item_groups/1/items/1/edit').to route_to(base_route_expect.merge(action: 'edit', id: '1'))
    end

    it 'routes to #create' do
      expect(post: 'projects/1/item_groups/1/items').to route_to(base_route_expect.merge(action: 'create'))
    end

    it 'routes to #update via PUT' do
      expect(put: 'projects/1/item_groups/1/items/1').to route_to(base_route_expect.merge(action: 'update', id: '1'))
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'projects/1/item_groups/1/items/1').to route_to(base_route_expect.merge(action: 'update', id: '1'))
    end

    it 'routes to #destroy' do
      expect(delete: 'projects/1/item_groups/1/items/1').to route_to(base_route_expect.merge(action: 'destroy', id: '1'))
    end
  end
end
