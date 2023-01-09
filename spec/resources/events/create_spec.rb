RSpec.describe Events::Create do
  let(:valid_params) do
    {
      issue: {
        number: 1
      },
      event: {
        action: "create"
      },
      sender: {
        login: "LeandroGelain",
        id: 50625871,
        node_id: "MDQ6VXNlcjUwNjI1ODcx",
        avatar_url: "https://avatars.githubusercontent.com/u/50625871?v=4",
        gravatar_id: "",
        url: "https://api.github.com/users/LeandroGelain",
        html_url: "https://github.com/LeandroGelain",
        followers_url: "https://api.github.com/users/LeandroGelain/followers",
        following_url: "https://api.github.com/users/LeandroGelain/following{/other_user}",
        gists_url: "https://api.github.com/users/LeandroGelain/gists{/gist_id}",
        starred_url: "https://api.github.com/users/LeandroGelain/starred{/owner}{/repo}",
        subscriptions_url: "https://api.github.com/users/LeandroGelain/subscriptions",
        organizations_url: "https://api.github.com/users/LeandroGelain/orgs",
        repos_url: "https://api.github.com/users/LeandroGelain/repos",
        events_url: "https://api.github.com/users/LeandroGelain/events{/privacy}",
        received_events_url: "https://api.github.com/users/LeandroGelain/received_events",
        type: "User",
        site_admin: false
      }
    } 
  end

  describe '#initialize' do
    before do
      @instance = described_class.new(valid_params)
    end

    it 'instantiate the params correctly' do
      expect(@instance.params).to eq(valid_params)
    end
  end

  describe '#execute' do
    before do
      @instance = described_class.new(valid_params)
    end

    it 'returns created event' do
      expect(@instance.send(:register_event!)).to be_instance_of(Event)
    end
  end

  describe '#register_event!' do
    context 'when params is correctly sended' do
      before do
        @instance = described_class.new(valid_params)
      end
  
      it 'returns created event' do
        expect(@instance.send(:register_event!)).to be_instance_of(Event)
      end
    end

    context 'when params wrong is sended' do
      before do
        @instance = described_class.new({invalid_params: 'valid_params'})
      end
  
      it 'raise a custom exception' do
        expect { @instance.send(:register_event!) }.to raise_error(Errors::CustomException)
      end
    end
  end

  describe '#format_params' do
    let(:keys) { %i[issue_id action author] }

    before do
      @instance = described_class.new(valid_params)
    end

    it 'returns formated params' do
      expect(@instance.send(:format_params).keys).to contain_exactly(*keys)
    end
  end
end
