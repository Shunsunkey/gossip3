class LikesController < ApplicationController
  before_action :find_gossip

  def create
    @like = current_user.likes.build(gossip: @gossip)
    if @like.save
      flash[:success] = "Gossip liked!"
    else
      flash[:error] = "Unable to like gossip."
    end
    redirect_to @gossip
  end

  def destroy
    @like = current_user.likes.find_by(gossip: @gossip)
    if @like
      @like.destroy
      flash[:success] = "Like removed."
    else
      flash[:error] = "Unable to remove like."
    end
    redirect_to @gossip
  end

  private

  def find_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end
end
