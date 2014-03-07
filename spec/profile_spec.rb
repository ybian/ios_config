require 'spec_helper'

describe IOSConfig::Profile do

  subject(:profile) do
    IOSConfig::Profile.new type:            "Configuration",
                           display_name:    "A Profile Name",
                           identifier:      "org.example.examplemdmservice.exampleprofile",
                           organization:    "A Company Name",
                           uuid:            SecureRandom.uuid,
                           allow_removal:   false,
                           client_certs:    [],
                           payloads:        ['dummy payload content']
  end

  it 'creates an unsigned profile' do
    unsigned = profile.unsigned

    expect(unsigned).to be_a_kind_of(String)
    expect(unsigned).to have_at_least(100).characters
  end

end
