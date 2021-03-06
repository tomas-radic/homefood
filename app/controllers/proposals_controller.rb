class ProposalsController < ApplicationController

  before_action :authenticate_user!


  def index
    @proposals = current_user.proposals.includes(:food)
  end


  def new
    @proposal = current_user.proposals.new
  end


  def create
    @proposal = current_user.proposals.new(whitelisted_params)

    if @proposal.save
      # @proposal.update_photo params[:proposal][:photo] if params[:proposal][:photo]
      flash[:success] = "Návrh bol zaevidovaný."

      redirect_to foods_path
    else
      flash.now[:danger] = "Návrh sa nepodarilo uložiť. Možno chýbajú *požadované informácie."
      render :new
    end
  end


  def edit
    @proposal = current_user.proposals.find(params[:id])
  end


  def update
    @proposal = current_user.proposals.find(params[:id])

    if @proposal.update(whitelisted_params)

      # if params[:proposal][:photo]
      #   @proposal.update_photo params[:proposal][:photo]
      # elsif params[:remove_photo] == '1'
      #   @proposal.remove_photo
      # end

      flash[:success] = "Návrh bol upravený."
      redirect_to foods_path
    else
      flash.now[:danger] = "Návrh sa nepodarilo uložiť. Možno chýbajú *požadované informácie."
      render :edit
    end
  end


  def destroy
    @proposal = current_user.proposals.find(params[:id])
    # @proposal.remove_photo if @proposal.photo_public_id
    @proposal.destroy
    flash[:success] = "Návrh bol vymazaný."
    redirect_to foods_path
  end


  private

  def whitelisted_params
    params.require(:proposal).permit(:name, :category, :ingredients, :description,
                                     :owner_private) #, :photo)
  end

end
