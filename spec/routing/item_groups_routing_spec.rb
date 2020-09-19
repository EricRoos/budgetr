require "rails_helper"

RSpec.describe ItemGroupsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/item_groups").to route_to("item_groups#index")
    end

    it "routes to #new" do
      expect(get: "/item_groups/new").to route_to("item_groups#new")
    end

    it "routes to #show" do
      expect(get: "/item_groups/1").to route_to("item_groups#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/item_groups/1/edit").to route_to("item_groups#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/item_groups").to route_to("item_groups#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/item_groups/1").to route_to("item_groups#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/item_groups/1").to route_to("item_groups#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/item_groups/1").to route_to("item_groups#destroy", id: "1")
    end
  end
end
