class TweetsController < ApplicationController
  def index
    tweets = Paginator.new(
      query: tweets_query,
      per_page: permited_params[:per_page]
    ).call

    render json: tweets
  end

  private

  def tweets_query
    Tweet.all.by_username(permited_params[:username]).by_newest_first
  end

  def permited_params
    params.permit(:per_page, :username)
  end
end
