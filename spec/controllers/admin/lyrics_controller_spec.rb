require "rails_helper"

RSpec.describe Admin::LyricsController, type: :controller do
  let(:user) {FactoryBot.create :user}
  let(:category) {FactoryBot.create :category}
  let(:artist) {FactoryBot.create :artist}
  let(:album) {FactoryBot.create :album, artist_id: artist.id,
    category_ids: category.id}
  let(:track) {FactoryBot.create :track, album_id: album.id, artist_id: artist.id}
  let(:lyric) {FactoryBot.create :lyric, track_id: track.id, user_id: user.id}
  let(:valid_attributes) {FactoryBot.attributes_for :lyric, track_id: track.id,
    user_id: user.id}
  let(:invalid_attributes) {FactoryBot.attributes_for :lyric, track_id: track.id,
    user_id: user.id, content: ""}

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
        get :edit, params: {id: lyric}
        expect(response).to render_template "edit"
      end

      context "resource not found" do
        it do
          get :edit, params: {id: 0}
          expect(response).to redirect_to admin_lyrics_path
        end
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it do
          expect {
            post :create, params: {admin_lyric: valid_attributes}
          }.to change(Lyric, :count).by 1
        end

        it do
          post :create, params: {admin_lyric: valid_attributes}
          expect(response).to redirect_to admin_lyrics_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {admin_lyric: invalid_attributes}
          expect(response).to render_template "new"
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        let(:new_attributes) do
          FactoryBot.attributes_for :lyric, track_id: track.id,
            user_id: user.id, content: "content changed"
        end

        it do
          patch :update, params: {id: lyric, admin_lyric: new_attributes}
          lyric.reload
          expect(lyric.content).to eq new_attributes[:content]
        end

        it do
          patch :update, params: {id: lyric, admin_lyric: new_attributes}
          expect(response).to redirect_to admin_lyrics_path
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: lyric, admin_lyric: invalid_attributes}
          expect(response).to render_template "edit"
        end
      end

      context "resource not found" do
        it do
          patch :update, params: {id: 0}
          expect(response).to redirect_to admin_lyrics_path
        end
      end
    end

    describe "DELETE #destroy" do
      it do
        lyric = Lyric.create! valid_attributes
        expect {
          delete :destroy, params: {id: lyric}
        }.to change(Lyric, :count).by -1
      end

      it do
        lyric = Lyric.create! valid_attributes
        delete :destroy, params: {id: lyric}
        expect(response).to redirect_to admin_lyrics_path
      end

      context "resource not found" do
        it do
          delete :destroy, params: {id: 0}
          expect(response).to redirect_to admin_lyrics_path
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
        get :edit, params: {id: lyric}
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
          post :create, params: {admin_lyric: valid_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {admin_lyric: invalid_attributes}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        let(:new_attributes) do
          FactoryBot.attributes_for :lyric, album_id: album.id, artist_id: artist.id,
            title: "title changed"
        end

        it do
          patch :update, params: {id: lyric, admin_lyric: new_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          patch :update, params: {id: lyric, admin_lyric: invalid_attributes}
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
        lyric = Lyric.create! valid_attributes
        delete :destroy, params: {id: lyric}
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
