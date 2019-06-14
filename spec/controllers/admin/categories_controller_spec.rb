require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:category) {FactoryBot.create :category}
  let(:valid_attributes) {FactoryBot.attributes_for :category}
  let(:invalid_attributes) {FactoryBot.attributes_for :category, name: ""}

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
        get :edit, params: {id: category}
        expect(response).to render_template "edit"
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it do
          expect {
            post :create, params: {admin_category: valid_attributes}
          }.to change(Category, :count).by 1
        end

        it do
          post :create, params: {admin_category: valid_attributes}
          expect(response).to redirect_to admin_categories_path
        end
      end

      context "with invalid params" do
        it do
          post :create, params: {admin_category: invalid_attributes}
          expect(response).to render_template "new"
        end
      end
    end

    describe "PATCH #update" do
      context "with valid params" do
        let(:new_attributes) {
          FactoryBot.attributes_for :category, name: "name changed"
        }

        it do
          category = Category.create! valid_attributes
          patch :update, params: {id: category, admin_category: new_attributes}
          category.reload
          expect(category.name).to eq new_attributes[:name]
        end

        it do
          category = Category.create! valid_attributes
          patch :update, params: {id: category, admin_category: new_attributes}
          expect(response).to redirect_to admin_categories_path
        end
      end

      context "with invalid params" do
        it do
          category = Category.create! valid_attributes
          patch :update, params: {id: category, admin_category: invalid_attributes}
          expect(response).to render_template "edit"
        end
      end
    end

    describe "DELETE #destroy" do
      it do
        category = Category.create! valid_attributes
        expect {
          delete :destroy, params: {id: category}
        }.to change(Category, :count).by -1
      end

      it do
        category = Category.create! valid_attributes
        delete :destroy, params: {id: category}
        expect(response).to redirect_to admin_categories_path
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
        get :edit, params: {id: category}
        expect(response).to redirect_to root_path
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
          FactoryBot.attributes_for :category, name: "name changed"
        }

        it do
          category = Category.create! valid_attributes
          patch :update, params: {id: category, admin_category: new_attributes}
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params" do
        it do
          category = Category.create! valid_attributes
          patch :update, params: {id: category, admin_category: invalid_attributes}
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "DELETE #destroy" do
      it do
        category = Category.create! valid_attributes
        delete :destroy, params: {id: category}
        expect(response).to redirect_to root_path
      end
    end
  end
end
