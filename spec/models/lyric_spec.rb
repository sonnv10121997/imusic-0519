require "rails_helper"

RSpec.describe Lyric, type: :model do
  let(:user) {FactoryBot.create :user}
  let(:category) {FactoryBot.create :category}
  let(:artist) {FactoryBot.create :artist}
  let(:album) {FactoryBot.create :album, artist_id: artist.id, category_ids: category.id}
  let(:track) {FactoryBot.create :track, album_id: album.id, artist_id: artist.id}
  subject {FactoryBot.create :lyric, track_id: track.id, user_id: user.id}

  context "database" do
    it {is_expected.to have_db_column(:content).of_type :text}
    it {is_expected.to have_db_column(:approved).of_type :boolean}
  end

  context "validates" do
    describe ".create" do
      it {is_expected.to be_valid}
    end

    describe "#content" do
      it {is_expected.to validate_presence_of :content}
    end

    describe "#approved" do
      it {is_expected.to validate_uniqueness_of(:approved).scoped_to :track_id}
    end
  end

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :track}
  end
end
