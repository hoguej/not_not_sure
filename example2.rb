class Object
  def method_missing(name, *args, &block)
    super unless name.to_s.match(/^not_(.*)/)

    orig_method = name.to_s.sub(/^not_/, '')
    ! self.send(orig_method.to_sym, *args, &block)
  end

  def methods
    methods = super
    methods + methods.grep(/\?$/).map{ |orig_method|
      "not_#{orig_method.to_s}".to_sym
    }
  end
end

thing = "cheese"
puts "methods: " + thing.methods.map(&:to_s).grep(/^not_/).join(", ")
