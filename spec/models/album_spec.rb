require "rails_helper"

RSpec.describe Album, type: :model do
  let(:artist) {FactoryBot.create :artist}
  subject {FactoryBot.create :album, artist: artist}

  context "database" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:year).of_type :string}
  end

  context "validates" do
    describe ".create" do
      it {is_expected.to be_valid}
    end

    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of :name}
    end

    describe "#year" do
      it {is_expected.to validate_presence_of :year}
      it {is_expected.to validate_numericality_of(:year).only_integer
        .is_greater_than 0}
    end
  end

  context "associations" do
    it {is_expected.to belong_to :artist}
    it {is_expected.to have_many :category_albums}
    it {is_expected.to have_many :album_tracks}
    it {is_expected.to have_many :favourites}
    it {is_expected.to have_many(:categories).through :category_albums}
    it {is_expected.to have_many(:tracks).through :album_tracks}
  end
end
