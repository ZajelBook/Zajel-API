# frozen_string_literal: true

module Api
  class StatusController < ApplicationController
    def show
      head :ok
    end
  end
end
