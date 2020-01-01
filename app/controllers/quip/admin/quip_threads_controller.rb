class Quip::Admin::QuipThreadsController < Quip::Admin::BaseController
  before_action :set_quip_app
  before_action :set_quip_thread, only: [:show, :edit, :update, :destroy]

  def index
    @quip_threads = QuipThread.page(params[:page])
  end

  def new
    @quip_thread = QuipThread.new
  end

  def create
    @quip_thread = QuipThread.new(quip_thread_params)

    unless @quip_thread.save
      render :new, locals: { model: @quip_thread }, status: :unprocessable_entity
    end
  end
  
  def sync
    @quip_app.private_threads
    render 'index'
  end

  def show
  end

  def edit
  end

  def update
    @quip_thread.assign_attributes(quip_thread_params)

    unless @quip_thread.save
      render :edit, locals: { model: @quip_thread }, status: :unprocessable_entity
    end
  end

  def destroy
    @quip_thread.destroy
  end

  private
  def set_quip_app
    @quip_app = QuipApp.find params[:quip_app_id]
  end
  
  def set_quip_thread
    @quip_thread = QuipThread.find(params[:id])
  end

  def quip_thread_params
    params.fetch(:quip_thread, {}).permit(
      :type,
      :title,
      :html,
      :content
    )
  end

end
