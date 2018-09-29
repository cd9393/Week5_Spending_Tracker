require_relative("../models/merchant")
require_relative("../models/tag")
require("pry-byebug")

Merchant.delete_all()
Tag.delete_all()

merchant1 = Merchant.new({
  "name" => "Amazon"
  })
  merchant1.save()

  merchant2 = Merchant.new({
    "name" => "Tesco"
    })
    merchant2.save()

    merchant3 = Merchant.new({
      "name" => "Spa Town Coffee"
      })
      merchant3.save()
tag1 = Tag.new({
  "category" => "Shopping"
  })

  tag2 = Tag.new({
    "category" => "Groceries"
    })

    tag3 = Tag.new({
      "category" => "Eating Out"
      })

  tag1.save()
  tag2.save()
  tag3.save()
binding.pry
nil
