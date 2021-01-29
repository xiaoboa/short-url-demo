class Admin::ShortUrlsController < ApplicationController
  before_action :set_short_url
  def show
  end

  def update
    if @short_url.update(short_url_params)
      redirect_to admin_short_url_path(admin_id: @short_url.admin_id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_short_url
    @short_url = ShortUrl.find_by(admin_id: params[:admin_id])
  end

  def short_url_params
    params.require(:short_url).permit(:expires_at)
  end
end
