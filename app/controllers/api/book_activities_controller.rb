module Api
  class BookActivitiesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_book_activity, only: [:update, :destroy]

    def index
      book_activities = if params[:type].eql?('sent')
                           current_user.borrow_requests
                         elsif params[:type].eql?('received')
                           current_user.lend_requests
                         end.includes(:borrower, :lender, book: [:genre, image_attachment: :blob]).order(created_at: :desc)

      @pagy, @book_activities = pagy(book_activities, items: params[:per_page])
    end

    def create
      book_activity = current_user.borrow_requests.new(book_activity_params)
      if book_activity.save
        render json: {status: 'request sent successfully'}
      else
        @error_message = book_activity.errors
        render 'shared/errors', status: :unprocessable_entity
      end
    end

    def update
      if params[:type].eql?('accept')
        @book_activity.accepted!
        render json: { status: 'request accepted' }
      elsif params[:type].eql?('reject')
        @book_activity.rejected!
        render json: { status: 'request rejected' }
      end
    end

    def destroy
      if @book_activity.destroy
        render json: { status: 'requests cancelled successfully' }
      else
        @error_message = @book_activity.errors
        render 'shared/errors', status: :unprocessable_entity
      end
    end

    private
    def book_activity_params
      params.permit(:book_id)
    end

    def find_book_activity
      @book_activity = current_user.borrow_requests.find(params[:id])
    end
  end
end