class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  def scale_and_crop(width, height)
    manipulate! do |image|
      image.tap(&:auto_orient)
      image.combine_options do |c|
        c.gravity 'Center'
        c.resize "#{width}x#{height}" # ^op secilen tarafın olcusune @ op da var denenmedi
        #c.scale 'x100'
        #c.scale '100'
        c.crop "#{width}x#{height}+0+0"
        #c.pointsize '10'
        #c.annotate('+0+0', "Machinist" )
        #c.fill 'grey'
        c.background 'white' #transparent, none
        c.extent "#{width}x#{height}"
        #c.frame '3x3+1+1'
        #c.raise  '2' # edges  - or +

      end
      image
    end
  end
  def auto_orient
    manipulate! do |image|
      image.tap(&:auto_orient)
    end
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process scale_and_crop: [100, 100]
  end

  version :logo do
    process scale_and_crop: [120, 40]
  end

  version :medium do
    process scale_and_crop: [250, 250]
  end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png tiff gif svg)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
