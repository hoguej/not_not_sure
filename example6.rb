class Object
  def method_missing(name, *args, &block)
    super unless name.to_s.match(/^not_(.*)/)
    super unless name.to_s.match(/^not_(.*)\?$/)

    orig_method = name.to_s.sub(/^not_/, '')
    ! self.send(orig_method.to_sym, *args, &block)
  end

  def methods
    add_not_methods(super)
  end

  def public_methods
    add_not_methods(super)
  end

  def respond_to?(method_name, include_private = false)
    return true if super
    return false unless method_name.to_s.start_with?('not_')

    original_method = method_name.to_s.sub(/^not_/, '')
    return true if respond_to?(original_method.to_sym, include_private)
    return false
  end

  private

  def add_not_methods(methods)
    methods + methods.grep(/\?$/).map{ |orig_method|
      "not_#{orig_method.to_s}".to_sym
    }
  end
end

require 'byebug'

thing = "cheese"
byebug
thing.not_nil?
