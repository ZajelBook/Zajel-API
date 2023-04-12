# frozen_string_literal: true

module Web
  class BorrowRequestsController < BookActivitiesController
    def index
      borrow_requests = current_user.borrow_requests
                                    .includes(:conversation, :borrower, :lender, book: [:book_activities, :genre, {
                                                image_attachment: :blob
                                              }])
                                    .order(updated_at: :desc)

      @pagy, @borrow_requests = pagy(borrow_requests, items: params[:per_page])
    end
  end
end
