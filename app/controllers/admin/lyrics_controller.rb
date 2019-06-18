class Admin::LyricsController < AdminController
  before_action :find_admin_lyric, only: %i(edit update destroy)

  def index
    @admin_lyrics = Lyric.page(params[:page])
      .per Settings.lyric.featured_list
  end

  def new
    @admin_lyric = Lyric.new
  end

  def edit; end

  def create
    @admin_lyric = Lyric.new admin_lyric_params

    if admin_lyric.save
      redirect_to admin_lyrics_path, notice: t(".created")
    else
      render :new
    end
  end

  def update
    if admin_lyric.update admin_lyric_params
      redirect_to admin_lyrics_path, notice: t(".updated")
    else
      render :edit
    end
  end

  def destroy
    if admin_lyric.destroy
      redirect_to admin_lyrics_path, notice: t(".destroyed")
    else
      redirect_to admin_lyrics_path, alert: t(".faild_to_destroyed")
    end
  end

  private

  attr_reader :admin_lyric

  def find_admin_lyric
    @admin_lyric = Lyric.find_by id: params[:id]

    return if admin_lyric
    redirect_to admin_lyrics_path, alert: t("admin.resource.not_found")
  end

  def admin_lyric_params
    params.require(:admin_lyric).permit Lyric::LYRIC_PARAMS
  end
end
