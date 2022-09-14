module BeforeFilter

  def before_filter name
    puts 'before filter' + name.to_s
    @@filter = name
  end

  def method_added(method)
    puts "#{method}  #{self}"
    return if method ==@@filter
    return if @filtering


    @filtering = true
    alias_method :"original_#{method}", method  # alias given_name first_name

   define_method method do |*args|
     self.send @@filter
     self.send "original_#{method}"
   end
    @filtering = false
  end
end

class User
  extend BeforeFilter

  before_filter :prepare_logs

  def ashwini
    puts 'ashwin'
  end

  def another_ashwin
    puts 'another ashwin'
  end

  def prepare_logs
    puts "prepare logs"
  end

end