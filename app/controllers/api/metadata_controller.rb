module Api
  class MetadataController < ApplicationController
    def index
      @genres = Genre.all
      @languages = Language.pluck(:name)
    end
  end
end
