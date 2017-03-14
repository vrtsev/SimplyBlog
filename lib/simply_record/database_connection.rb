class SimplyRecord::DatabaseConnection
  # TODO : Use database.yml file for db configuration

  def initialize(database=nil, host=nil, user=nil, password=nil, dbname=nil)
    db_config = Rails.configuration.database_configuration[Rails.env]
    @database = database || PG::Connection
    @host     = host || db_config["host"]
    @user     = user || db_config["username"]
    @password = password || db_config["password"]
    @dbname   = dbname || db_config["database"]
    @client   = client
  end

  def get_data(q)
    @client.query(q)
  end

  private

  def client
    @database.new(host: @host, user: @user, password: @password, dbname: @dbname)
  end

  def database_configuration
    path = File.expand_path('../config/database.yml', __FILE__)
    yaml = Pathname.new(path) if path

    config = if yaml && yaml.exist?
      require "yaml"
      require "erb"
      YAML.load(ERB.new(yaml.read).result) || {}
    else
      raise "Could not load database configuration. Please, check config/database.yml for existance"
    end
  end
end
