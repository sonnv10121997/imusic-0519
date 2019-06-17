require "rails_helper"

RSpec.describe Admin::TracksController, type: :controller do
  let(:category) {FactoryBot.create :category}
  let(:artist) {FactoryBot.create :artist}
  let(:album) {FactoryBot.create :album, artist_id: artist.id, category_ids: category.id}
  let(:track) {FactoryBot.create :track, album_id: album.id, artist_id: artist.id}
  let(:valid_attributes) do
    FactoryBot.attributes_for :track, album_id: album.id, artist_id: artist.id
  end
  let(:invalid_attributes) do
    FactoryBot.attributes_for :track, album_id: album.id, artist_id: artist.id, title: ""
  end

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
        get :edit, params: {id: track}
        expect(response).to render_template "edit"
      end

      context "resource not found" do
        it do
          get :edit, params: {id: 0}
          expect(response).to redirect_to admin_tracks_path
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it do
          expect {
            post :create, params: {admin_track: valid_attributes}
          }.to change(Track, :count).by 1
        end

        it do
          post :create, params: {admin_track: valid_attributes}
          expect(response).to redirect_to admin_tracks_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {admin_track: invalid_attributes}
          expect(response).to render_template "new"
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        let(:new_attributes) do
          FactoryBot.attributes_for :track, album_id: album.id, artist_id: artist.id,
            title: "title changed"
        end

        it do
          patch :update, params: {id: track, admin_track: new_attributes}
          track.reload
          expect(track.title).to eq new_attributes[:title]
        end

        it do
          patch :update, params: {id: track, admin_track: new_attributes}
          expect(response).to redirect_to admin_tracks_path
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: track, admin_track: invalid_attributes}
          expect(response).to render_template "edit"
        end
      end

      context "resource not found" do
        it do
          patch :update, params: {id: 0}
          expect(response).to redirect_to admin_tracks_path
        end
      end
    end

    describe "DELETE #destroy" do
      it do
        track = Track.create! valid_attributes
        expect {
          delete :destroy, params: {id: track}
        }.to change(Track, :count).by -1
      end

      it do
        track = Track.create! valid_attributes
        delete :destroy, params: {id: track}
        expect(response).to redirect_to admin_tracks_path
      end

      context "resource not found" do
        it do
          delete :destroy, params: {id: 0}
          expect(response).to redirect_to admin_tracks_path
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
        get :edit, params: {id: track}
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
          post :create, params: {admin_track: valid_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {admin_track: invalid_attributes}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        let(:new_attributes) do
          FactoryBot.attributes_for :track, album_id: album.id, artist_id: artist.id,
            title: "title changed"
        end

        it do
          patch :update, params: {id: track, admin_track: new_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: track, admin_track: invalid_attributes}
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
        track = Track.create! valid_attributes
        delete :destroy, params: {id: track}
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
