require "rails_helper"

RSpec.describe Track, type: :model do
  let(:category) {FactoryBot.create :category}
  let(:artist) {FactoryBot.create :artist}
  let(:album) {FactoryBot.create :album, artist: artist, category_ids: category.id}
  subject {FactoryBot.create :track, album: album, artist: artist}

  context "database" do
    it {is_expected.to have_db_column(:title).of_type :string}
    it {is_expected.to have_db_column(:year).of_type :string}
  end

  context "validates" do
    describe ".create" do
      it {is_expected.to be_valid}
    end

    describe "#title" do
      it {is_expected.to validate_presence_of :title}
      it {is_expected.to validate_length_of(:title)
        .is_at_most Settings.track.title.max_length}
    end

    describe "#year" do
      it {is_expected.to validate_presence_of :year}
      it {is_expected.to validate_numericality_of(:year).only_integer
        .is_greater_than 0}
    end
  end

  context "associations" do
    it {is_expected.to belong_to :album}
    it {is_expected.to belong_to :artist}
    it {is_expected.to have_many :track_lyrics}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :favourites}
    it {is_expected.to have_many(:lyrics).through :track_lyrics}
  end
end
