require 'rails_helper'

RSpec.describe Event, type: :model do
  attr_accessor :event_one, :event_two

  before(:all) do
    @event_one = FactoryBot.create(:event)
    @event_two = FactoryBot.create(:event)
  end

  describe 'EventQuery' do
    context 'when search by id' do
      subject do
        described_class.search_by(id: event_one.id)
      end

      it 'response to be match with search params' do
        subject.map do |event|
          expect(event.id).to eq(event_one.id)
        end
      end
    end

    context 'when search by issue_id' do
      subject do
        described_class.search_by(issue_id: event_one.issue_id)
      end

      it 'response to be match with search params' do
        subject.map do |event|
          expect(event.issue_id).to eq(event_one.issue_id)
        end
      end
    end

    context 'when search by action' do
      subject do
        described_class.search_by(action: event_one.action)
      end

      it 'response to be match with search params' do
        subject.map do |event|
          expect(event.action).to eq(event_one.action)
        end
      end
    end
  end
end 
