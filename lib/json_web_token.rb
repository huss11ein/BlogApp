class JsonWebToken

      class << self #defining it as static
            def encode_token(payload, exp = 2.hours.from_now)
            begin
                payload[:exp] = exp.to_i
            JWT.encode(payload, Rails.application.credentials.secret_key_base)
            rescue JWT::ExpiredSignature, JWT::VerificationError => e
          raise ExceptionHandler::ExpiredSignature, e.message
            rescue JWT::DecodeError, JWT::VerificationError => e
              raise ExceptionHandler::DecodeError, e.message
            end

            end

            def decode_token(token)
                    begin
                        body = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
                        HashWithIndifferentAccess.new body
                    rescue JWT::ExpiredSignature, JWT::VerificationError => e
                      raise ExceptionHandler::ExpiredSignature, e.message
                    rescue JWT::DecodeError, JWT::VerificationError => e
                      raise ExceptionHandler::DecodeError, e.message
                    end

            end
      end
  end