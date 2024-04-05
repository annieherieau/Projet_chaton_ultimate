class StaticPagesController < ApplicationController
  def contact
  end

  def send_contact
    UserMailer.visitor_contact_email(params[:static_pages]).deliver_now
    if UserMailer.admin_contact_email(params[:static_pages]).deliver_now
      flash[:success] = "Votre message a bien été envoyé."
    else
      flash[:alert] = "Erreur lors de l'envoi. Veuillez recommencer."
    end
    redirect_to :contact
  end


end
