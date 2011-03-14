# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
fruits = "莲雾,芭蕉,茄苳,杨桃,木瓜,柑桔,柚子,葡萄柚,柠檬,橘子,金桔,山楂,西瓜,梨,菠萝,苹果,香蕉,芒果,猕猴桃,西柚,火龙果,香蕉,芒果,哈密瓜,草莓,橙子,葡萄,柿子,荔枝,龙眼,甘蔗,桃子,椰子,番石榴,山竹,榴莲,奇异果,樱桃,红龙,红毛丹,无花果,李子,梅子,酪梨,荸荠,核桃,杨梅,橄榄,沙枣,香瓜,黑樱桃,枇杷,金桔,水蜜桃,山楂,榛子,哈密瓜,青梅,银杏,公爵樱桃,砀山梨,山核桃,板栗,黑莓,海棠果,槟榔子,蓝莓,蛇皮果,莲蓬"
list = fruits.split(',')
list.each do |item|
  puts item
  Fruit.find_or_create_by_name(item)
end
provinces = "北京,天津,河北,山西,内蒙古,辽宁,吉林,黑龙江,上海,江苏,浙江,安徽,福建,江西,山东,河南,湖北,湖南,广东,广西,海南,重庆,四川,贵州,云南,西藏,陕西,甘肃,青海,宁夏,新疆,香港,澳门,台湾"
list = provinces.split(',')
list.each do |item|
  puts item
  Province.find_or_create_by_name(item)
end
