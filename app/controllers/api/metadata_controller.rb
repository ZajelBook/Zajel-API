module Api
  class MetadataController < ApplicationController
    def index
      @genres = Genre.all.order(name: :asc)
      @languages = Language.order(name: :asc).pluck(:name)
    end
  end
end
