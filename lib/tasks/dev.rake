namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development? 
    show_spinner('Apagando BD...') { %x(rails db:drop) }
    show_spinner('Criando BD...') { %x(rails db:create) }
    show_spinner('Migrando...') { %x(rails db:migrate) }
    %x(rails dev:add_mining_types)  
    %x(rails dev:add_coins)
  else
      puts "Você não está em ambiente de desenvolvimento!"
  end
end

  desc "Cadastra as Moedas"
  task add_coins: :environment do
    show_spinner('Cadastrando moedas...') do
      coins =  [ 
        { 
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://banner2.kisspng.com/20180729/plb/kisspng-bitcoin-cash-cryptocurrency-bitcoin-unlimited-logo-bitcoin-white-5b5e786fc44317.2481451315329178718039.jpg",
          mining_type: MiningType.find_by(acronym: 'PoW')
        },

        { 
          description: "Ethereum",
          acronym: "ETH",
          url_image: "https://www.ethereum.org/images/logos/ETHEREUM-ICON_Black_small.png",
          mining_type: MiningType.all.sample
        },

        { 
          description: "Dash",
          acronym: "DASH",
        url_image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwJi0dDkeKUsNiLHESywT2Dw7Z2Cmswig1YHowP9DoYo63JpUO",
        mining_type: MiningType.all.sample
        },
        
        {
          description: "Iota",
          acronym: "IOT",
          url_image: "https://criptohub.com.br/assets/svg/svg008.svg",
          mining_type: MiningType.all.sample
        },
  
        {
          description: "ZCash",
         acronym: "ZEC",
          url_image: "https://pbs.twimg.com/profile_images/1047215410574217218/bvVEvteL_400x400.jpg",
          mining_type: MiningType.all.sample

          }
      ]
    coins.each do |coin|
      Coin.find_or_create_by!(coin)
    end
  end
end

desc "Cadastra Tipos de mineração"
task add_mining_types: :environment do
  show_spinner('Cadastrando tipos de mineração...') do
    mining_types = [
      {description: "Proof of Work", acronym: "PoW"},
      {description: "Proof of Stake", acronym: "PoS"},
      {description: "Proof of Capacity", acronym: "PoC"}
    ]
    mining_types.each do |mining_type|
      MiningType.find_or_create_by!(mining_type)
    end
  end
end


  private

  def show_spinner(msg_start, msg_end = "Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}") 
    spinner.auto_spin
  yield
    spinner.success("(#{msg_end})")
  end
end
