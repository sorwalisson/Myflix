class ContentValidator < ActiveModel::Validator
  def validate(record)
    dtester = Title.find_by(id: record.title_id) #get the Title to which the content belongs to
    if dtester.kind == 'movie'
      if url_movie(record) == true then record.errors.add(:content, "Invalid content, movies must have a video_url") end
    end
    if dtester.kind == 'show'
      if url_show(record) == true then record.errors.add(:content, "invalid content, shows or documentaries must not have a video_url") end
    end
    if dtester.kind == 'documentary'
      if url_show(record) == true then record.errors.add(:content, "invalid content, shows or documentaries must not have a video_url") end
    end
  end

  def url_movie(record)
    if record.video_url == nil #check if the video_url is absent
      return true 
    end
  end
  def url_show(record)
    if record.video_url != nil #check if the video_url is present
      return true 
    end
  end
end