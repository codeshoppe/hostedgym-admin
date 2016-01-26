require "rails_helper"

RSpec.describe ClinicsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/clinics").to route_to("clinics#index")
    end

    it "routes to #new" do
      expect(:get => "/clinics/new").to route_to("clinics#new")
    end

    it "routes to #show" do
      expect(:get => "/clinics/1").to route_to("clinics#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/clinics/1/edit").to route_to("clinics#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/clinics").to route_to("clinics#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/clinics/1").to route_to("clinics#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/clinics/1").to route_to("clinics#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/clinics/1").to route_to("clinics#destroy", :id => "1")
    end

  end
end
