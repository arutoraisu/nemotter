class Message < ActiveRecord::Base
  belongs_to :team
  belongs_to :user


   def self.search(search)
      if search
        Message.where(['name LIKE ?', "%#{search}%"])
      else
        Message.all
      end
    end
end
