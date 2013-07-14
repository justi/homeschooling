def get_credentials(my_provider)
  credentials = {:provider => my_provider,
             :uuid     => "1234567890",
             :facebook => {
                            :email => "foobar@example.com",
                            :first_name => "foo",
                            :last_name => "bar",
                            :username => "foo.bar",
                          },
              :twitter => {
                            :name => "foo bar",
                            :screen_name => "foo_bar",
                          },
              :github => {
                            :login => "foo_bar",
                          }
            }
end

def get_omniauth_email(my_provider)
  credentials = get_credentials(my_provider)
  provider = credentials[:provider]
  user_hash = credentials[provider]
  user_hash[:email]
end

def set_omniauth(my_provider)

  credentials = get_credentials(my_provider)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
    uid: credentials[:uuid],
    provider: provider.to_s,
    info: user_hash,
    extra: {
      raw_info: user_hash
      }
    })
end