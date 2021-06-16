module Api
  module Admin
    class RequestsController < ApplicationController
      before_action :authenticate_admin!

      def index
        @requests = Request.all
        @pagy, @requests = pagy(@requests, items: params[:per_page])
      end
    end
  end
end
