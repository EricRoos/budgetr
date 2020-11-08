require "rails_helper"

RSpec.describe ContributorsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/projects/1/contributors/new").to route_to("contributors#new", project_id: "1")
    end

    it "routes to #create" do
      expect(post: "/projects/1/contributors").to route_to("contributors#create", project_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/projects/1/contributors/1").to route_to("contributors#destroy", project_id: "1", id: "1")
    end
  end
end
