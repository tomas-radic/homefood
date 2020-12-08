namespace :data do

  # "rake data:users"
  desc "Creates users if not existing"
  task :users => :environment do
    emails = [
        "tomas.radic@gmail.com"
    ]

    puts "\nAdding users..."
    emails.each do |email|
      User.where(email: email).first_or_create!(
          name: email.split('@')[0],
          password: email.gsub('@', '##') # to be changed by user themself
      )
    end

    puts "Done.\n"
  end


  # "rake data:raws"
  desc "Creates raws if not existing"
  task :raws => :environment do
    raws = {
        "Bylinky" => [
            "bazalka",
            "koriander",
            "petržlenová vňať"
        ],
        "Koreniny" => [
            "čierne korenie",
            "rasca",
            "zelené korenie"
        ],
        "Mäsové výrobky" => [
            "anglická slanina",
            "bravčová panenka",
            "kuracie prsia",
            "morčacie prsia",
            "oravská slanina",
            "pancetta"
        ],
        "Mliečne výrobky" => [
            "maslo",
            "parmezán",
            "pecorino"
        ],
        "Nápoje" => [
            "pivo",
            "sladké biele víno",
            "suché biele víno",
            "whisky"
        ],
        "Omáčky" => [
            "rybacia omáčka",
            "sojová omáčka",
            "worcesterová omáčka"
        ],
        "Pečivo" => [
            "pečivo"
        ],
        "Zelenina" => [
            "baklažán",
            "bambusové výhonky",
            "batáty",
            "biela reďkovka",
            "cesnak",
            "cibuľa",
            "cherry paradajky",
            "chilli papričky",
            "cuketa",
            "červená reďkovka",
            "hrubá sladká paprika",
            "listový šalát",
            "rukola",
            "šalotka",
            "šampióny",
            "zázvor",
            "zeleninová paprika",
            "zemiaky"
        ],
        nil => [
            "arašidy",
            "citrónová šťava",
            "citrónová tráva",
            "cukor",
            "červená kari pasta",
            "kokosové mlieko",
            "kukuričky v konzerve",
            "kurací vývar",
            "med",
            "olej",
            "olivový olej",
            "paradajkový pretlak",
            "ryža",
            "sezam",
            "soľ",
            "sušený cesnak",
            "škrobová múčka",
            "špagety",
            "trstinový cukor",
            "vajcia"
        ]
    }

    puts "\nAdding raws..."
    ActiveRecord::Base.transaction do
      raws.each do |category_name, raw_names|
        category = if category_name
                     RawCategory.where(name: category_name).first_or_create!
                   end

        raw_names.each do |raw_name|
          raw = Raw.where(name: raw_name).first_or_create!
          category.raws << raw if category
        end
      end
    end

    puts "Done.\n"
  end
end
