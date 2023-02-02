class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  validates :name, presence: true

  def add_favorite(title_id)
    #Get information about the title to be added
    movie = Title.find_by(id: title_id)
    favg = movie.genre
    
    #Check if it is the first of the user adding a favorite, if true then LINE 35
    if self.favorites == nil then favorite_nil(favg, movie) end
    
    #Get User favorites json object
    pfav = JSON.parse(self.favorites)
    
    #this if the user already has this GENRE of title as KEY on the JSON
    if pfav.has_key?("#{favg}")
      pfav["#{favg}"] << (movie.id) unless pfav["#{favg}"].include?(movie.id)
      self.favorites = JSON.generate(pfav)
      self.save!
      return true
    
    #This if the key needs to be created
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

  def favorite_nil(favg, movie) #when it's the user first time adding a favorite
    ids = Array.new #each section will hold n ids so it must be an array
    ids << movie.id
    newk = {"#{favg}": ids}
    self.favorites = JSON.generate(newk)
    self.save!
  end

  def remove_favorite(title_id)
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

  # PAYMENTS METHODS 
  
  def start_payment
    if self.personal_information.nil? #Check if it is the first time of ther user making a payment, LINE 72
      first_payment()
      return
    end
    getinfo = JSON.parse(self.personal_information)
    info = getinfo["last_payment"]
    if info.nil? #this case when the user has never made a payment before
      first_payment()
    else
      new_payment() #this case when the user is renewing the payment
    end
  end

  def first_payment()
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

  def new_payment
    getoldpay = JSON.parse(self.personal_information)
    savepayment = getoldpay["last_payment"]
    save_last_payment(savepayment) #send the old date to the payment history
    getoldpay = JSON.parse(self.personal_information)
    getoldpay["last_payment"] = Date.today
    newpay = JSON.generate(getoldpay)
    self.personal_information = newpay
    self.save!
  end

  #Method to save the old Last_Payment, to the Payments history.
  def save_last_payment(savepayment)
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

  #CHECK IF THE USER IS ACTIVE OR INACTIVE

  def check_active
    # IF the user has never made a payment before nor has any kind of information on his personal_information
    if self.personal_information.nil?
      self.active = false
      self.save!
      return
    end
    
    getinfo = JSON.parse(self.personal_information) #GET the JSON variable to check the "last_payment"
    
    #This case if the user has info on his personal_information but last_payment is absent
    if getinfo["last_payment"].nil?
      self.active = false
      self.save!
    
    #This case if the last_payment info is present
    else
      timer = (Time.current.to_date - getinfo["last_payment"].to_date).to_i
      if timer > 30 then self.active = false end
      if timer <= 30 then self.active = true end
      self.save!
    end
  end
end



