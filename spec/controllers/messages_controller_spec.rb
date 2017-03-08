require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
 describe '#index' do
    context 'new user' do
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
      let!(:message) { create :message }

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

      it 'assigns messages' do
        expect(assigns(:messages)).to eq(Message.all.includes(:user))
      end

      it 'renders index template' do
        expect(response).to render_template(:index)
      end
    end
  end
end
