class Users::RawsController < Users::BaseController

  def index
    @raws = Pundit.policy_scope!(current_user, Raw).distinct.order(:name)
    @ownerships = current_user.ownerships.to_a
  end

  def switch_ownership
    @raw = Pundit.policy_scope!(current_user, Raw).find(params[:raw_id])
    @ownership = current_user.ownerships.find_by(raw: @raw)

    super

    @ownerships = @ownerships.to_a
    @raws = Pundit.policy_scope!(current_user, Raw).distinct.order(:name)

    respond_to do |format|
      format.js
    end
  end

end
