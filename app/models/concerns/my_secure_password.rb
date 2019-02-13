module MySecurePassword
  extend ActiveModel::SecurePassword
  extend ActiveSupport::Concern

   module ClassMethods
     def has_secure_password(attribute = :password, validations: true)
        begin
          require "bcrypt"
        rescue LoadError
          $stderr.puts "You don't have bcrypt installed in your application. Please add it to your Gemfile and run bundle install"
          raise
        end

        attr_reader attribute

        define_method("#{attribute}=") do |unencrypted_password|
          if unencrypted_password.nil?
            self.send("#{attribute}_digest=", nil)
          elsif !unencrypted_password.empty?
            instance_variable_set("@#{attribute}", unencrypted_password)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            self.send("#{attribute}_digest=", BCrypt::Password.create(unencrypted_password, cost: cost))
          end
        end

        define_method("#{attribute}_confirmation=") do |unencrypted_password|
          instance_variable_set("@#{attribute}_confirmation", unencrypted_password)
        end

        define_method("authenticate_#{attribute}") do |unencrypted_password|
          attribute_digest = send("#{attribute}_digest")
          BCrypt::Password.new(attribute_digest).is_password?(unencrypted_password) && self
        end


        alias_method :authenticate, :authenticate_password if attribute == :password

        if validations
          include ActiveModel::Validations

          validate do |record|
            record.errors.add(attribute, :blank) unless record.send("#{attribute}_digest").present?
          end

          validates_length_of attribute, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
          validates_confirmation_of attribute, allow_blank: true
        end

     end

   end

end