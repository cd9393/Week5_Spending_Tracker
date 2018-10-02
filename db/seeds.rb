require_relative("../models/merchant")
require_relative("../models/tag")
require_relative("../models/transaction")
require("pry-byebug")

Merchant.delete_all()
Tag.delete_all()
Transaction.delete_all()

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
  "category" => "Shopping",
  "budget" => 300
  })

  tag2 = Tag.new({
    "category" => "Groceries",
    "budget" => 200
    })

    tag3 = Tag.new({
      "category" => "Eating Out",
      "budget" => 200
      })

  tag1.save()
  tag2.save()
  tag3.save()

  transaction1 = Transaction.new({
    "amount" => 23.50,
    "merchant_id" => merchant1.id,
    "tag_id" => tag1.id,
    "transaction_date" => "12/09/2018"
    })

    transaction2 = Transaction.new({
      "amount" => 37.32,
      "merchant_id" => merchant2.id,
      "tag_id" => tag2.id,
      "transaction_date" => "11-09-2018"
      })

      transaction3 = Transaction.new({
        "amount" => 2.75,
        "merchant_id" => merchant3.id,
        "tag_id" => tag3.id,
        "transaction_date" => "01-08-2018"
        })

        transaction4 = Transaction.new({
          "amount" => 2.75,
          "merchant_id" => merchant3.id,
          "tag_id" => tag3.id,
          "transaction_date" => "01-10-2018"
          })

  transaction1.save()
  transaction2.save()
  transaction3.save()
  transaction4.save()
binding.pry
nil
