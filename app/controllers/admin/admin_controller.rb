class Admin::AdminController < ApplicationController
  before_action :authorize_admin

  def something
    
  end

  private

  def authorize_admin
    unless current_user.has_role?('admin')
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end