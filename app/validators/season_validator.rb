class SeasonValidator < ActiveModel::Validator
  def validate(record)
    st1 = Content.find_by(id: record.content_id) #get the content to which this season belongs
    st2 = Title.find_by(id: st1.title_id) #get the title to which that content belongs
    if verifykind(st2) == true then record.errors.add(:season, 'A season cannot belong to a movie') end
  end

  def verifykind(title)
    if title.kind == 'movie' then return true end
  end
end
