# app/controllers/likes_controller.rb
class LikesController < ApplicationController
    before_action :find_gossip
  
    def create
      @like = current_user.likes.new(gossip: @gossip)
      if @like.save
        redirect_to @redirect_path, notice: 'Gossip liked!'
      else
        redirect_to @redirect_path, alert: 'Error liking gossip!'
      end
    end
  
    def destroy
      @like = current_user.likes.find_by(gossip: @gossip)
      if @like.destroy
        redirect_to @redirect_path, notice: 'Gossip unliked!'
      else
        redirect_to @redirect_path, alert: 'Error unliking gossip!'
      end
    end
  
    private
  
    def find_gossip
      @gossip = Gossip.find(params[:gossip_id])
    end

    def set_redirect_path
      @redirect_path = request.referer || root_path
  end
  