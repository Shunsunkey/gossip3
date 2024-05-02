class CommentsController < ApplicationController
  before_action :find_gossip, only: [:create, :edit, :update, :destroy]
  before_action :require_login, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @gossip.comments.build(comment_params)
    @comment.user = current_user
    @comment.created_at = Time.current # Ajouter cette ligne pour définir la date de création
    if @comment.save
      redirect_to @gossip, notice: "Commentaire ajouté avec succès !"
    else
      render 'gossips/show'
    end
  end
  

  def edit
    @comment = @gossip.comments.find(params[:id])
    redirect_to @gossip, alert: "Vous n'êtes pas autorisé à effectuer cette action." unless current_user == @comment.user
  end

  def update
    @comment = @gossip.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @gossip, notice: "Commentaire modifié avec succès !"
    else
      render :edit
    end
  end

  def destroy
    if current_user == @comment.user
      @comment.destroy
      redirect_to @gossip, notice: "Commentaire supprimé avec succès."
    else
      redirect_to @gossip, alert: "Vous n'êtes pas autorisé à supprimer ce commentaire."
    end
  end
  
  private

  def find_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :content)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def require_login
    unless current_user
      flash[:alert] = "Vous devez être connecté pour accéder à cette page."
      redirect_to new_session_path
    end
  end
end
