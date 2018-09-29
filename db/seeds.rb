require_relative("../models/merchant")
require("pry-byebug")

Merchant.delete_all()

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

binding.pry
nil
