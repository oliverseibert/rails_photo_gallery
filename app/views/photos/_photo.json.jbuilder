json.extract! photo, :id, :description, :file_url, :file_size, :file_type, :album_id, :created_at, :updated_at, :album_id
json.url photo_url(photo, format: :json)
