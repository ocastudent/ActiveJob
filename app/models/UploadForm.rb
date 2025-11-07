class UploadForm
  include ActiveModel::Model

  attr_accessor :file

  validates :file, presence: true

  FILE_DIR = "#{Rails.root}/tmp"

  def import
    return false unless save
    CSV.read(filename).each do |row|
      User.create(name: row[0], email: row[1])
    end
    true
  end

  private

  def filename
    "#{FILE_DIR}/#{file.original_filename}"
  end

  def save
    return false unless valid?
    open(filename, "wb") do |f|
      f.write file.read.encode('UTF-8', 'ASCII-8BIT', invalid: :replace, undef: :replace, replace: '')
    end
    true
  end
end