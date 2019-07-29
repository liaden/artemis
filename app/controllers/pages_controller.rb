class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :enforce_tenancy, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.owned_by(current_tenant).all
  end

  def show
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to @page, notice: 'Page was successfully created.'
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      redirect_to @page, notice: 'Page was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_url, notice: 'Page was successfully destroyed.'
  end

  private

  def submit_button
    I18n.t('helpers.submit.page').invert[params['commit']]
  end

  def publication_status
    if submit_button.in? [:unpublish, :create]
      PublicationStatus['draft']
    elsif submit_button == :publish
      PublicationStatus['published']
    else
      @page.try(:publication_status) || PublicationStatus['draft']
    end
  end

  def enforce_tenancy
    return head :unauthorized unless @page.tenant ==  current_tenant
  end

  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params
      .require(:page)
      .permit(:publication_status_id, :content, :name)
      .tap { |p| p.delete(:publication_status_id) }
      .merge!(publication_status: publication_status, tenant: current_tenant)
  end
end
