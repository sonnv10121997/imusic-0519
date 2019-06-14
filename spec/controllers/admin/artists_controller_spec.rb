require "rails_helper"

RSpec.describe Admin::ArtistsController, type: :controller do
  let(:artist) {FactoryBot.create :artist}
  let(:valid_attributes) {FactoryBot.attributes_for :artist}
  let(:invalid_attributes) {FactoryBot.attributes_for :artist, name: ""}

  context "user is administrator" do
    before do
      admin = FactoryBot.create :user, :admin
      @current_user = admin
      sign_in admin
    end

    describe "GET #index" do
      it do
        get :index
        expect(response).to render_template "index"
      end
    end

    describe "GET #new" do
      it do
        get :new
        expect(response).to render_template "new"
      end
    end

    describe "GET #edit" do
      it do
        get :edit, params: {id: artist}
        expect(response).to render_template "edit"
      end

      context "resource not found" do
        it do
          get :edit, params: {id: 0}
          expect(response).to redirect_to admin_artists_path
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it do
          expect {
            post :create, params: {admin_artist: valid_attributes}
          }.to change(Artist, :count).by 1
        end

        it do
          post :create, params: {admin_artist: valid_attributes}
          expect(response).to redirect_to admin_artists_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {admin_artist: invalid_attributes}
          expect(response).to render_template "new"
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        let(:new_attributes) {
          FactoryBot.attributes_for :artist, name: "name changed"
        }

        it do
          patch :update, params: {id: artist, admin_artist: new_attributes}
          artist.reload
          expect(artist.name).to eq new_attributes[:name]
        end

        it do
          patch :update, params: {id: artist, admin_artist: new_attributes}
          expect(response).to redirect_to admin_artists_path
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: artist, admin_artist: invalid_attributes}
          expect(response).to render_template "edit"
        end
      end

      context "resource not found" do
        it do
          patch :update, params: {id: 0}
          expect(response).to redirect_to admin_artists_path
        end
      end
    end

    describe "DELETE #destroy" do
      it do
        artist = Artist.create! valid_attributes
        expect {
          delete :destroy, params: {id: artist}
        }.to change(Artist, :count).by -1
      end

      it do
        artist = Artist.create! valid_attributes
        delete :destroy, params: {id: artist}
        expect(response).to redirect_to admin_artists_path
      end

      context "resource not found" do
        it do
          delete :destroy, params: {id: 0}
          expect(response).to redirect_to admin_artists_path
        end
      end
    end
  end

  context "user is not administrator" do
    before do
      user = FactoryBot.create :user
      @current_user = user
      sign_in user
    end

    describe "GET #index" do
      it do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #new" do
      it do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #edit" do
      it do
        get :edit, params: {id: artist}
        expect(response).to redirect_to root_path
      end

      context "resource not found" do
        it do
          get :edit, params: {id: 0}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it do
          post :create, params: {admin_category: valid_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {admin_category: invalid_attributes}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        let(:new_attributes) {
          FactoryBot.attributes_for :artist, name: "name changed"
        }

        it do
          patch :update, params: {id: artist, admin_artist: new_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: artist, admin_artist: invalid_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "resource not found" do
        it do
          patch :update, params: {id: 0}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE #destroy" do
      it do
        artist = Artist.create! valid_attributes
        delete :destroy, params: {id: artist}
        expect(response).to redirect_to root_path
      end

      context "resource not found" do
        it do
          delete :destroy, params: {id: 0}
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
