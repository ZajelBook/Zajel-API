module Web
  class LendRequestsController < BookActivitiesController
    def index
      lend_requests = current_user.lend_requests
                                  .active
                                  .includes(:conversation, :borrower, :lender, book: [:book_activities, :genre, image_attachment: :blob])
                                  .order(updated_at: :desc)

      @pagy, @lend_requests = pagy(lend_requests, items: params[:per_page])
    end
  end
end