class Like < ApplicationRecord

  after_save :updatepostcounter

  private

  def updatepostcounter
   
  end
end
