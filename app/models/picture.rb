class Picture < ApplicationRecord
  belongs_to :machine
  mount_uploader :image, ImageUploader
  after_destroy :remove_file_directory

  def remove_file_directory
    path = File.expand_path(image.store_path, image.root)
    FileUtils.remove_dir(path, force: false)
  end
end
