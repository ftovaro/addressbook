# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_user = User.create name: 'Felipe', email: 'felipe@email.com', password: 'password1'
admin_user.add_role :admin
regular_user = User.create name: 'Santi', email: 'santi@email.com', password: 'password1'
regular_user.add_role :regular
org = Organization.create name: "MyCompany"
org.users.push admin_user, regular_user
org.save
contact = {
  full_name: "Felipe Tovar",
  address: "531 E 3rd St, Brooklyn",
  phone: "+573117233109",
  city: 'New York',
  email: 'myemail@correo.com'
}
Contact.create_contact contact, org.id

# Default Cards
card = Card.create category: :christmas, welcome_message: 'Merry Christmas!',
                  message: 'I hope you have a sweet christmas!'
card = Card.create category: :motherday, welcome_message: 'Hello Mom!',
                  message: 'You are the best mom!'
