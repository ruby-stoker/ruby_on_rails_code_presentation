require 'rails_helper'

RSpec.describe Backoffice::UsersController, type: :controller do
  include AuthHelper

  let(:club) { create :club }
  let(:admin) { create :user, role: 'admin', club_id: nil }

  before do
    request.host = 'backoffice.test.host'
    login_user(admin)
  end

  describe 'clubs check' do
    context 'GET #index' do
      it 'return users array' do
        get :index, params: { use_route: :backoffice }
        expect(assigns(:users)).to eq([admin])
      end
    end

    context 'GET #show' do
      it 'assign requested club' do
        get :show, params: { use_route: :backoffice,
                             id: admin.id }
        expect(assigns(:user)).to eq(admin)
      end
    end

    context 'GET #new' do
      it 'should render template' do
        get :new, params: { use_route: :backoffice }
        expect(response).to render_template(:new)
      end
    end

    context 'GET #edit' do
      it 'should render template' do
        get :edit, params: { use_route: :backoffice, id: admin.id }
        expect(response).to render_template(:edit)
      end
    end
  end
end
