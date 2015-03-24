require 'rails_helper'

RSpec.describe TagMapController, type: :controller do

  let(:valid_attributes) { { tag_map: { url: 'google.com' } } }
  let(:invalid_attributes) { { tag_map: { url: '' } } }

  describe 'POST inspect' do

    context "with valid attributes" do
      subject { post :inspect, valid_attributes }

      it {
        VCR.use_cassette('get_source', record: :new_episodes, match_requests_on: [:uri]) do 
          should have_http_status(:success) 
        end
      }
    end

    context "with invalid attributes" do
      subject { post :inspect, invalid_attributes }
      it { should have_http_status(:unprocessable_entity) }
    end

  end

end
