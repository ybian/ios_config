require 'spec_helper'

describe IOSConfig::Payload::VPN do
  
  subject(:vpn) do
    IOSConfig::Payload::VPN.new connection_name:     "My VPN",
                                authentication_type: :password,
                                connection_type:     :pptp,
                                encryption_level:    :auto,
                                proxy_type:          :none,
                                send_all_traffic:    true,
                                server:              "example.org",
                                username:            "macdemarco",
                                password:            "viceroy"
  end

  it 'builds a payload hash' do 
    expect(vpn.build).to be_a_kind_of(Hash)
  end

end