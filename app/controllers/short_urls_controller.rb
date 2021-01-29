class ShortUrlsController < ApplicationController

  def show
    @short_url = ShortUrl.find_by(short_id: params[:short_id])

    if @short_url && !@short_url.expired?
      @short_url.visit
      redirect_to @short_url.origin_url
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def new
  end

  def create
    @short_url = ShortUrl.new(short_url_params)

    if @short_url.save
      render partial: 'short_url', locals: { short_url: @short_url }, status: :ok
    else
      render partial: 'error', locals: { short_url: @short_url }, status: :bad_request
    end
  end

  private
  def short_url_params
    params.require(:short_url).permit(:origin_url)
  end
end
