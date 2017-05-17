class PagesController < ApplicationController
  def show
    if valid_page?
      if logged_in?
        @feed_items = current_user.feed
        @random_books = Book.order('RANDOM()').limit(3)
      end

      render template: "pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
  end
end
