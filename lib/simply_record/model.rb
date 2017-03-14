class SimplyRecord::Model
  def update(record)
    self.class.update(self.id, record)
  end

  def destroy
    self.class.destroy(self.id)
  end

  class << self
    def new
      @new_object = super
      db_fields.each do |f|
        @new_object.class.send(:attr_accessor, f)
        @new_object.instance_variable_set(:"@#{f}", nil)
      end
      return @new_object
    end

    def all
      get_data(:collection, "SELECT * FROM #{table_name};")
    end

    def first
      get_data(:single, "SELECT * FROM #{table_name} ORDER BY id ASC LIMIT 1;")
    end

    def last
      get_data(:single, "SELECT * FROM #{table_name} ORDER BY id DESC LIMIT 1;")
    end

    def find(id)
      get_data(:single, "SELECT * FROM #{table_name} WHERE id = #{id} LIMIT 1;")
    end

    def where(q)
      get_data(:collection, "SELECT * FROM #{table_name} WHERE #{q};")
    end

    def create(data)
      current_time = Time.now.to_s
      timestamps = {created_at: current_time, updated_at: current_time}
      keys = (data.keys + timestamps.keys).join(', ')
      values = (data.values + timestamps.values).map {|w| "\'#{w}\'"}.join(', ')

      get_data("INSERT INTO #{table_name} (#{keys}) VALUES (#{values}) RETURNING id;") do |result|
        id = result.first['id']
        return find(id)
      end
    end

    def update(id, data)
      user_data = data.merge(updated_at: Time.now.to_s)
      user_data = user_data.map {|o| "#{o.first}='#{o.last}'" }.join(', ')

      get_data("UPDATE #{table_name} SET #{user_data} WHERE id=#{id} RETURNING id") do |result|
        id = result.first['id']
        return find(id)
      end
    end

    def destroy(id)
      # TODO : Make sure that .destroy should return deleted object instance
      get_data("DELETE FROM #{table_name} WHERE id=#{id}") do |result|
        return puts "Record ##{id} has been successfully destroyed" if result.result_status
      end
    end

    private

    def get_data(response=:handle_response, query, &block)
      data = send_request(query)
      return yield wrap_data(response, data) if block_given?
      wrap_data(response, data)
    end

    def send_request(query)
      SimplyRecord::DatabaseConnection.new.get_data(query)
    end

    def wrap_data(response, data)
      case response
      when :collection
        SimplyRecord::DataWrapper.new(self).collection(data)
      when :single
        SimplyRecord::DataWrapper.new(self).single_object(data)
      when :handle_response
        return data
      end
    end

    def table_name
      self.to_s.underscore.pluralize
    end

    def db_fields
      get_data("SELECT * FROM #{table_name} WHERE false;").fields
    end
  end
end