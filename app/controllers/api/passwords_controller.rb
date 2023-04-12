# frozen_string_literal: true

module Api
  class PasswordsController < DeviseTokenAuth::PasswordsController
    def edit
      # if a user is not found, return nil
      @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])

      if @resource&.reset_password_period_valid?
        token = @resource.create_token unless require_client_password_reset_token?

        # ensure that user is confirmed
        @resource.skip_confirmation! if confirmable_enabled? && !@resource.confirmed_at
        # allow user to change password once without current_password
        @resource.allow_password_change = true if recoverable_enabled?

        @resource.save!

        yield @resource if block_given?

        if require_client_password_reset_token?
          redirect_to DeviseTokenAuth::Url.generate(@redirect_url,
                                                    reset_password_token: resource_params[:reset_password_token])
        else
          redirect_header_options = { reset_password: true }
          redirect_headers = build_redirect_headers(token.token,
                                                    token.client,
                                                    redirect_header_options)
          render json: { url: @resource.build_auth_url(@redirect_url, redirect_headers) }
        end
      else
        render_edit_error
      end
    end
  end
end
