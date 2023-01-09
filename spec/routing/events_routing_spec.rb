RSpec.describe EventsController, type: :routing do
  let(:url) { 'http://localhost:3000' }

  it 'routes to #index via GET' do
    expect(get: "#{url}/issues/1/events").to route_to(
      controller: 'events',
      action: 'index',
      id: '1'
    )
  end

  it 'routes to #create via POST' do
    expect(post: "#{url}/events").to route_to(
      controller: 'events',
      action: 'create'
    )
  end
end