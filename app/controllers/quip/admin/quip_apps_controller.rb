class Quip::Admin::QuipAppsController < Quip::Admin::BaseController
  before_action :set_quip_app, only: [:show, :edit, :update, :destroy]

  def index
    @quip_apps = QuipApp.page(params[:page])
  end

  def new
    @quip_app = QuipApp.new
  end

  def create
    @quip_app = QuipApp.new(quip_app_params)

    unless @quip_app.save
      render :new, locals: { model: @quip_app }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @quip_app.assign_attributes(quip_app_params)

    unless @quip_app.save
      render :edit, locals: { model: @quip_app }, status: :unprocessable_entity
    end
  end

  def destroy
    @quip_app.destroy
  end

  private
  def set_quip_app
    @quip_app = QuipApp.find(params[:id])
  end

  def quip_app_params
    params.fetch(:quip_app, {}).permit(
      :name,
      :access_token,
      :profile_picture_url,
      :private_folder_id
    )
  end

end
