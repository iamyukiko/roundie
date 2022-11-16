class Apply < ApplicationRecord

  belongs_to :user
  belongs_to :event

  enum apply_status: {
    applying: 1, #申請中
    approved: 2, #承認
    rejected: 3 #却下
  }

end
