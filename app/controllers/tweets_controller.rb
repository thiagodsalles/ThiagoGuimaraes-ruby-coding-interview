class TweetsController < ApplicationController
  def index
    tweets = Paginator.new(
      query: Tweet.all.by_newest_first,
      per_page: permited_params[:per_page]
    ).call

    render json: tweets
  end

  def permited_params
    params.permit(:per_page)
  end
end
