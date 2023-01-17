class TitlesQuery
  def initialize(params, title = Title.all) # get the parameters from controller and from databasee
    @params = params
    @title = title
  end

  def call
    query_list = @title
    query_list = by_genre(query_list) if checkgenre() == true
    query_list = by_kind(query_list) if checkkind() == true
    return query_list #send it back
  end

  def by_genre(query_list)
    query_list.where(genre: @params[:params], available: true)
  end

  def by_kind(query_list)
    query_list.where(kind: @params[:params], available: true)
  end

  def checkgenre()
    Title.genres.each do |check|
      if check.include?(@params[:params]) then return true end 
    end
  end

  def checkkind()
    Title.kinds.each do |check|
      if check.include?(@params[:params]) then return true end
    end
  end

end