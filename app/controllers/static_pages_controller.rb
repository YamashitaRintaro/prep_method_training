class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: [:top]
  skip_before_action :require_category_id, only: [:top]

  def top; end
end
