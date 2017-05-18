class PagesController < ApplicationController
  def show
    if valid_page?
      if logged_in?
        @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
        @random_books = Book.order("RANDOM()").limit(5)
      end

      render template: "pages/#{params[:title]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:title]}.html.erb"))
  end
end
