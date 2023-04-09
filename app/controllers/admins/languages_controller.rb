module Admins
  class LanguagesController < ApplicationController
    def index
      @languages = Language.all.order(name: :asc)
      @pagy, @languages = pagy(@languages, items: params[:per_page])
    end

    def new
      @language = Language.new
    end

    def create
      language = Language.new(language_params)
      if language.save
        redirect_to admins_languages_path
      else
        render :new
      end
    end

    def edit
      @language = Language.find(params[:id])
    end

    def update
      language = Language.find(params[:id])
      if language.update(language_params)
        redirect_to admins_languages_path
      else
        render :edit
      end
    end

    private
    def language_params
      params.require(:language).permit(:name, translations_attributes: [
        :id, :_destroy,
        :locale,
        :name,
      ])
    end
  end
end
