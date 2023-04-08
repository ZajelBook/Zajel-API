class Admins::ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_admin!
end