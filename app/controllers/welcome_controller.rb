class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Ruby on Rails - Luis [COOKIE]"
    session[:curso] = "Ruby on Rails - Luis [SESSION]"
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
