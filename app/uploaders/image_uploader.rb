class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]

  version :size do
    process resize_to_fill: [100, 150]
  end

  version :thumb do
    process resize_to_fill: [200, 275]
  end

  version :book_size do
    process resize_to_limit: [300, 400]
  end

  version :favourite_book do
    process resize_to_fill: [80, 100]
  end

  version :review_book do
    process resize_to_fill: [140, 190]
  end

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
