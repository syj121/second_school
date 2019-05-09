# -*- encoding : utf-8 -*-

class ImageUploader < AvatarUploader

  #include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg gif png swf)
  end

end


