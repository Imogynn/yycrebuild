class NeedsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  def index
    @needs = Need.all
  end

  def show
    @need = Need.find(params[:id])
  end

  def new
    @need = Need.new
  end

  def create
    @need = current_user.needs.create(params[:need])
    current_user.tag(@need, :with => params[:need_tags], :on => :tags)
    if @need.save
       redirect_to needs_path, notice: 'Need was successfully created.'
    else
       render action: "new"
    end
  end
end
