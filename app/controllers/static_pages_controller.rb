class StaticPagesController < ApplicationController
  def team
  end
  def contact
  end
  def welcome
    @user = current_user
  end
  def index
    @gossips = Gossip.all
    @tags = Tag.all
  end
end
