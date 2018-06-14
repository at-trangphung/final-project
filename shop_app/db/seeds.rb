# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create!(name: "Coffee sua", parent_id: 0, sort_order:0)
Category.create!(name: "Cream", parent_id: 0, sort_order:0)
Category.create!(name: "Coffee late", parent_id: 0, sort_order:0)
Category.create!(name: "Coffee matcha", parent_id: 0, sort_order:0)
Category.create!(name: "Coffee cabuchino", parent_id: 0, sort_order:0)
Category.create!(name: "Coffee den", parent_id: 0, sort_order:0)
Category.create!(name: "Coffee sua da", parent_id: 1, sort_order:0)
Category.create!(name: "Coffee sua da sai gon", parent_id: 1, sort_order:0)
Category.create!(name: "Cream Dau", parent_id: 1, sort_order:0)
Category.create!(name: "Cream Socola", parent_id: 1, sort_order:0)
Category.create!(name: "Cream Dua", parent_id: 1, sort_order:0)



(1..9).each do |i|
  name = 'Article'  + "#{i}"
  Article.create!(title: name, content: "Đi cà phê từ lâu không đơn thuần chỉ là uống một tách cà phê mà còn là dịp gặp mặt và trò chuyện cùng bạn bè. Tại The Coffee House, chúng tôi trân trọng và đề cao giá trị kết nối giữa con người và trải nghiệm của khách hàng.

  Chúng tôi được truyền cảm hứng từ những tách cà phê và thức uống mình tạo ra. Chúng tôi tin tưởng mạnh mẽ rằng thức uống với chất lượng tốt nhất được phục vụ trong không gian thân thiện.", create_at: Time.now, updated_id: Time.now, image_link:"Screenshot_from_2018-05-21_09_01_36.png")

end

Size.create!(name: "S")
Size.create!(name: "M")
Size.create!(name: "L")

Type.create!(name: "Hot")
Type.create!(name: "Cold")



