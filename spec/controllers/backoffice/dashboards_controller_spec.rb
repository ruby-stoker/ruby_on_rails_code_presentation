require 'rails_helper'

RSpec.describe Backoffice::DashboardsController, type: :controller do
  include AuthHelper

  let(:club) { create :club }
  let(:user) { create :user, role: 'admin', club_id: nil }

  describe 'GET #show' do
    context 'when authenticated' do
      it 'should render page' do
        login_user
        get :show, params: { use_route: :backoffice }
        expect(response).to have_http_status 200
      end
    end

    context 'when not authenticated' do
      it 'should authenticate user' do
        get :show, params: { use_route: :backoffice }
        expect_redirect_to_sign_in
      end
    end
  end
end
