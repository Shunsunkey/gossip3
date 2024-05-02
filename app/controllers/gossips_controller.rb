class GossipsController < ApplicationController
  before_action :set_gossip, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def show
    @gossip = Gossip.find(params[:id])
    @comment = Comment.new
  end

  def new
    @gossip = current_user.gossips.build
    @tags = Tag.all
  end

  def create
    @gossip = current_user.gossips.build(gossip_params)
    @gossip.tag_ids = params[:tag_ids]
    if @gossip.save
      redirect_to @gossip, flash: { success: "Le super potin a été créé avec succès !" }
    else
      flash.now[:danger] = "Erreur : veuillez compléter tous les champs."
      render :new
    end
  end

  def index
    @gossips = Gossip.includes(:comments)
    # Je suppose que vous voulez que la redirection ne se fasse que si l'utilisateur n'est pas connecté
    redirect_to static_pages_index_path unless current_user.nil?
  end
  
  def edit
    @tags = Tag.all
    redirect_to @gossip, alert: "Vous n'êtes pas autorisé à effectuer cette action." unless current_user == @gossip.user
  end
  
  def update
    @gossip.tag_ids = params[:tag_ids]
    if @gossip.update(gossip_params)
      redirect_to @gossip, notice: "Le potin a bien été mis à jour !"
    else
      render :edit
    end
  end
  def destroy
    if current_user == @gossip.user
      @gossip.destroy
      redirect_to gossips_path, notice: "Le potin a été supprimé avec succès !"
    else
      redirect_to @gossip, alert: "Vous n'êtes pas autorisé à effectuer cette action."
    end
  end
  

  private

  def set_gossip
    @gossip = Gossip.find(params[:id])
  end

  def gossip_params
    params.require(:gossip).permit(:title, :description)
  end

  def require_login
    unless current_user
      flash[:alert] = "Vous devez être connecté pour accéder à cette page."
      redirect_to new_session_path
    end
  end
end
