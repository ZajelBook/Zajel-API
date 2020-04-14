module Api
  class MetadataController < ApplicationController
    skip_before_action :check_user_confirmation_status, only: [:index]

    def index
      @genres = Genre.all.order(name: :asc)
      @languages = Language.order(name: :asc).pluck(:name)
      @confirmed = current_user && current_user.confirmed_at.present?
    end
  end
end
