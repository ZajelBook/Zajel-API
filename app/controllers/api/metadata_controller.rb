module Api
  class MetadataController < ApplicationController
    def index
      @genres = Genre.all.order(name: :asc)
      @languages = Language.order(name: :asc).pluck(:name)
      @confirmed = current_user && current_user.confirmed_at.present?
    end
  end
end
