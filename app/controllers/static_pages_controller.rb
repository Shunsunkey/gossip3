class StaticPagesController < ApplicationController
  def team
  end
  def contact
  end
  def welcome
    @first_name = params[:first_name] || "Hortense"
  end
  def accueil
    @gossips = Gossip.all
  end
end
