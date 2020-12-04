class Users::BaseController < ApplicationController

  before_action :authenticate_user!

  def switch_ownership
    if @ownership
      @ownership.update!(need_buy: !@ownership.need_buy)
    else
      current_user.ownerships.create!(raw: @raw, need_buy: false)
    end

    @ownerships = current_user.ownerships
  end
end
