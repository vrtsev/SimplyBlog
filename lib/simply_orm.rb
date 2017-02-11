class SimplyORM
  def initialize(host='localhost', user='blog', password='vadimblog', dbname='blog_development')
    @host     = host
    @user     = user
    @password = password
    @dbname   = dbname
    @@client  = set_connection
    generate_classes!
  end

  def set_connection
    PG::Connection.new(host: @host, user: @user, password: @password, dbname: @dbname)
  end

  def db_tables
    @@client.query(
      "SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema'"
    ).map { |e| e['tablename'] }
  end

  def generate_classes!
    db_tables.each do |table|
      class_obj = set_constant(table)
      @fields = get_columns(table)
      create_accessors(class_obj, @fields)
      build_standart_methods(class_obj, table)
    end
  end

  private

  def set_constant(table)
    class_name = table.split('_').map { |w| w.capitalize }.join
    return Object.const_set(class_name, Class.new())
  end

  def get_columns(table)
    @@client.query("SELECT column_name FROM information_schema.columns WHERE table_name = '#{table}';").map { |el| el['column_name'] }
  end

  def create_accessors(class_obj, fields)
    class_obj.class_eval do
      fields.each { |field| class_obj.send :attr_accessor, field }
    end
  end

  def build_standart_methods(class_obj, table)
    define_method_all(class_obj, table)
    define_method_find(class_obj, table)
    define_method_where(class_obj, table)
    define_single_object_methods(class_obj, :first, "SELECT * FROM #{table} ORDER BY id ASC LIMIT 1;")
    define_single_object_methods(class_obj, :last, "SELECT * FROM #{table} ORDER BY id DESC LIMIT 1;")
  end

  def define_single_object_methods(class_obj, name, query)
    class_obj.define_singleton_method(name) do
      @@client.query(query).to_a.each do |o|
        new_obj = self.new
        o.each { |k, v| new_obj.instance_variable_set(:"@#{k}", v) }
        return new_obj
      end
    end
  end

  def define_method_all(class_obj, table_name)
    class_obj.define_singleton_method(:all) do
      @@client.query("SELECT * FROM #{table_name};").to_a.inject([]) do |arr, o|
        new_obj = self.new
        o.each { |k, v| new_obj.instance_variable_set(:"@#{k}", v) }
        arr << new_obj
      end
    end
  end

  def define_method_find(class_obj, table_name)
    class_obj.define_singleton_method(:find) do |id|
      @@client.query("SELECT * FROM #{table_name} WHERE id = #{id} LIMIT 1;").to_a.each do |o|
        new_obj = self.new
        o.each { |k, v| new_obj.instance_variable_set(:"@#{k}", v) }
        return new_obj
      end
    end
  end

  def define_method_where(class_obj, table_name)
    class_obj.define_singleton_method(:where) do |q|
      @@client.query("SELECT * FROM #{table_name} WHERE #{q};").to_a.inject([]) do |arr, o|
        new_obj = self.new
        o.each { |k, v| new_obj.instance_variable_set(:"@#{k}", v) }
        arr << new_obj
      end
    end
  end
end
