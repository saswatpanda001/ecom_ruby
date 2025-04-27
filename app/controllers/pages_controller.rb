


class PagesController < ApplicationController
  



  def show
    @page = Page.find_by!(name: params[:name])
  end
  

  def edit
    @pages = Page.all
  end

  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      redirect_to edit_pages_path, notice: "#{@page.name.capitalize} page updated successfully."
    else
      render :edit
    end
  end

  private

  def page_params
    params.require(:page).permit(
      :content,
      :about_us, :our_story, :mission, :values,
      :phone, :email, :instagram, :address
    )
  end


end