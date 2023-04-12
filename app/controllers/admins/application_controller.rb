# frozen_string_literal: true

module Admins
  class ApplicationController < ActionController::Base
    include Pagy::Backend

    before_action :authenticate_admin!
  end
end
