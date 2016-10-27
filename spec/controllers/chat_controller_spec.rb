require 'rails_helper'

RSpec.describe ChatController, type: :controller do
  describe "#index" do
    it "renders successfully" do
      get :index
      expect(response).to be_successful
    end
  end
end
