require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  attr_accessor :event_one, :event_two

  before(:all) do
    @event_one = FactoryBot.create(:event)
    @event_two = FactoryBot.create(:event)
  end

  describe 'POST #create' do
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

    context 'when event is create with valid params' do
      before do
        allow_any_instance_of(described_class).to receive(:authenticate_webhook!).and_return(true)
        post :create, params: valid_params
      end

      it 'returns status code ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when event is create with valid params but not authenticated' do
      before do
        post :create, params: valid_params
      end

      it 'returns status code unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when event is create without valid params' do
      before do
        allow_any_instance_of(described_class).to receive(:authenticate_webhook!).and_return(true)
        post :create, params: { invalid_params: 'invalid_params'}
      end

      it 'returns status code ok' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        request.headers['HTTP_USER_NAME'] = 'user_name_example'
        request.headers['HTTP_PASSWORD'] = 'password_example'
      end

      context 'and valid params is sended' do
        let!(:valid_params) { { id: event_one.issue_id } }

        before do
          get :index, params: valid_params
        end
  
        it 'returns an array with all interactions in issue found' do
          expect(response).to have_http_status(:ok)

          JSON.parse(response.body)['events'].map do |event|
            expect(event['issue_id']).to eq(event_one.issue_id)
          end
        end
      end

      context 'and invalid params is sended' do
        let!(:invalid_params) { { id: 'invalid_id' } }

        before do
          get :index, params: invalid_params
        end
  
        it 'returns an array with all interactions in issue found' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context "when user isn't authenticated" do
      let!(:valid_params) { { id: event_one.issue_id } }

      
      before do
        request.headers['HTTP_USER_NAME'] = 'invalid_user_name'
        request.headers['HTTP_PASSWORD'] = 'invalid_password'

        get :index, params: valid_params
      end

      it 'returns status code unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
