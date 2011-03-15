class Notifier < ActionMailer::Base
  default :from => "心动了"
  
  def welcome_mail(user)
    @user = user
    mail(:to => user.email,
         :subject => "欢迎加入心动了 － 匿名告白")
  end
end
