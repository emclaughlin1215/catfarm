class CatsController < ApplicationController
  skip_authorization_check  # TODO: Remove
  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def create
    @cat = Cat.new(cat_new_params)

    if @cat.save
      flash[:success] = "#{@cat.name} (#{@cat.rescue_id}) successfully created"
      redirect_to edit_cat_path(@cat.id)
    else
      render 'new'
    end
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_edit_params)
      flash[:success] = "#{@cat.id_string} successfully updated"
      redirect_to edit_cat_path(@cat.id)
    else
      render 'edit'
    end
  end

  def destroy
    @cat = Cat.find(params[:id])

    if @cat.destroy
      flash[:success] = "#{@cat.name} (#{@cat.rescue_id}) successfully deleted"
      redirect_to cats_path
    else
      render 'index'
    end
  end

  def upload
    uploaded_io = params[:cat][:image]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  private
    def cat_new_params
      params.require(:cat).permit(:name, :image, :sex, :curr_foster, :contact,
        :availability, :date_fostered, :birthdate, :date_adopted, :paper_location,
        :notes, :rescue_id)
    end

    def cat_edit_params
      params.require(:cat).permit(:name, :image, :sex, :curr_foster, :contact,
        :availability, :date_fostered, :birthdate, :date_adopted, :paper_location,
        :notes)
    end
end
