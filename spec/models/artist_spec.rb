require "rails_helper"

RSpec.describe Artist, type: :model do
  subject {FactoryBot.create :artist}

  context "database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:description).of_type :text}
    it {is_expected.to have_db_column(:dob).of_type :date}
    it {is_expected.to have_db_column(:country).of_type :string}
  end

  context "validates" do
    describe ".create" do
      it {is_expected.to be_valid}
    end

    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of :name}
    end

    describe "#country" do
      it {is_expected.to validate_presence_of :country}
      it {is_expected.to validate_length_of :country}
    end

    describe "#dob" do
      it {is_expected.to validate_presence_of :dob}
    end
  end

  context "associations" do
    it {is_expected.to have_many :albums}
    it {is_expected.to have_many :tracks}
  end
end
