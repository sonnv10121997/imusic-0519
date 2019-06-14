require "rails_helper"

RSpec.describe Category, type: :model do
  context "validates" do
    subject {FactoryBot.create :category}

    context "columns" do
      it {is_expected.to respond_to :name}
    end

    describe ".create" do
      it {is_expected.to be_valid}
    end

    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of :name}
      it {is_expected.to validate_uniqueness_of(:name).case_insensitive}
    end
  end

  context "associations" do
    it {is_expected.to have_many :category_albums}
    it {is_expected.to have_many(:albums).through :category_albums}
  end
end
