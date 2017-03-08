require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      head :ok
    end
  end

  describe '#index' do
    context 'unkown user' do
      before { get :index }

      it 'responds with 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'do not assigns current_user' do
        expect(assigns(:current_user)).to eq(nil)
      end

      it 'redirects to messages' do
        expect(response).to redirect_to root_path
      end
    end

    context 'existing user' do
      let!(:user) { create :user }

      before do
        sign_in user
        get :index
      end

      it 'responds with success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns current_user' do
        expect(assigns(:current_user)).to eq(user)
      end
    end
  end
end
