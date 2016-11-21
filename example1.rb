class Object
  def method_missing(name, *args, &block)
    super unless name.to_s.match(/^not_(.*)/)

    orig_method = name.to_s.sub(/^not_/, '')
    ! self.send(orig_method.to_sym, *args, &block)
  end
end

thing = nil
puts "Thing is Nil:"
puts "\tthing.nil? # #{thing.nil?}"
puts "\tnot_nil?:  # #{thing.not_nil?}"
puts ""

thing = "cheese"
puts "Thing is 'Cheese':"
puts "\tthing.nil? # #{thing.nil?}"
puts "\tnot_nil?:  # #{thing.not_nil?}"

puts thing.class
puts thing.methods.grep(/\?$/)
