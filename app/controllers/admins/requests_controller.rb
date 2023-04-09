module Admins
  class RequestsController < ApplicationController
    def index
      @requests = Request.all.order(created_at: :desc)
      @pagy, @requests = pagy(@requests, items: params[:per_page])
    end
  end
end
