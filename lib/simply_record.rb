module SimplyRecord
  path = Pathname.new(File.expand_path('../' ,__FILE__))
  components = path.join('simply_record', '*.rb')
  Dir[components].each { |file| require file }
end
