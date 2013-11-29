class UploadsController < ApplicationController

  def index
    @uploads= Upload.all
  end

  def new
    @upload= Upload.new
  end

  def create
    if save_file
      @upload= Upload.new
      @upload.filepath = "/uploaded/#{upload_params[:file].original_filename}"
      redirect_to uploads_path, notice: 'Upload was successfully created.' if @upload.save
    else
      redirect_to new_upload_path
    end
  end

  private

  def save_file
    File.open(Rails.root.join('public', 'uploaded',upload_params[:file].original_filename), 'wb') do |file|
      file.write(upload_params[:file].read)
    end
    true
  end
  
  def upload_params
    params.require(:upload).permit(:file)
  end
end
