class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  validates :name, presence: true

  def add_fav(title_id)
    movie = Title.find_by(id: title_id)
    favg = movie.genre
    if self.favorites == nil then favnil(favg, movie) end
    pfav = JSON.parse(self.favorites)
    if pfav.has_key?("#{favg}")
      pfav["#{favg}"] << (movie.id) unless pfav["#{favg}"].include?(movie.id)
      self.favorites = JSON.generate(pfav)
      self.save!
      return true
    else
      ids = Array.new
      ids << movie.id
      newkey = {"#{favg}": ids}
      pfav.merge!(newkey)
      self.favorites = JSON.generate(pfav)
      self.save!
      return true
    end
  end

  def favnil(favg, movie) #this will take place when the favorite is a nil
    ids = Array.new #each section will hold n ids so it must be an array
    ids << movie.id
    newk = {"#{favg}": ids}
    self.favorites = JSON.generate(newk)
    self.save!
  end

  def removefav(title_id)
    movie = Title.find_by(id: title_id)
    favg = movie.genre
    flist = JSON.parse(self.favorites)
    if flist["#{favg}"].include?(title_id)
      flist["#{favg}"].delete(title_id)
      self.favorites = JSON.generate(flist)
      self.save!
      return true
    end
  end

  def startpayment #store payment information
    if self.personal_information.nil?
      firstpayment()
      return
    end
    getinfo = JSON.parse(self.personal_information)
    info = getinfo["last_payment"]
    if info.nil? #this case when the user has never made a payment before
      firstpayment()
    else
      newpayment() #this case when the user is renewing the payment
    end
  end

  def firstpayment()
    datepay = Date.today
    newpayment = {"last_payment": datepay}
    savepay = JSON.generate(newpayment)
    if self.personal_information == nil 
      self.personal_information = savepay 
      self.save!
    else self.personal_information != nil 
      prev = JSON.parse(self.personal_information)
      prev.merge!(newpayment)
      self.personal_information = JSON.generate(prev)
      self.save!
    end
  end

  def newpayment
    getoldpay = JSON.parse(self.personal_information)
    savepayment = getoldpay["last_payment"]
    savelast(savepayment) #send the old date to the payment history
    getoldpay = JSON.parse(self.personal_information)
    getoldpay["last_payment"] = Date.today
    newpay = JSON.generate(getoldpay)
    self.personal_information = newpay
    self.save!
  end

  def savelast(savepayment)
    getinfo = JSON.parse(self.personal_information)
    if getinfo.has_key?("payment_history") #this case if it is not the first history entry
      getinfo["payment_history"] << savepayment
      newhistory = JSON.generate(getinfo)
      self.personal_information = newhistory
      self.save!
    else #this case if it is the first entry
      payments = Array.new
      payments << savepayment
      newhistory = {"payment_history": payments}
      savehistory = getinfo.merge!(newhistory)
      self.personal_information = JSON.generate(savehistory)
      self.save!
    end
  end

  def checkactive
    if self.personal_information.nil?
      self.active = false
      self.save!
      return
    end
    getinfo = JSON.parse(self.personal_information)
    if getinfo["last_payment"].nil?
      self.active = false
      self.save!
    else
      timer = (Time.current.to_date - getinfo["last_payment"].to_date).to_i
      if timer > 30 then self.active = false end
      if timer <= 30 then self.active = true end
      self.save!
    end
  end
end



