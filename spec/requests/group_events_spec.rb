require 'rails_helper'

RSpec.describe 'Group Events API', type: :request do
  let!(:group_event) { FactoryBot.create :group_event }
  let!(:group_event_2) { FactoryBot.create :group_event, name: 'Another test group event' }

  describe 'GET /api/v1/group_events' do
    before do
      get '/api/v1/group_events', xhr: true
    end

    it 'returns group events' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end
  end

  describe 'GET /api/v1/group_events/:id' do
    before do
      get "/api/v1/group_events/#{group_event.id}", xhr: true
    end

    it 'returns the group event' do
      expect(json).not_to be_empty
      expect(json['name']).to eq(group_event.name)
    end
  end

  describe 'POST /api/v1/group_events' do
    let(:group_event_for_create) { FactoryBot.build :group_event, name: 'Group event to create' }

    before do
      post '/api/v1/group_events', params: group_event_for_create.attributes, xhr: true
    end

    it 'returns the created group event' do
      expect(json).not_to be_empty
      expect(json['name']).to eq(group_event_for_create.name)
    end
  end

  describe 'PATCH /api/v1/group_events/:id' do
    before do
      patch "/api/v1/group_events/#{group_event.id}", params: { name: 'Changed name' }, xhr: true
    end

    it 'returns the updated group event' do
      expect(json).not_to be_empty
      expect(json['name']).to eq('Changed name')
    end
  end

  describe 'DELETE /api/v1/group_events/:id' do
    it 'deletes the group event' do
      expect { delete "/api/v1/group_events/#{group_event.id}", xhr: true }.
        to change { GroupEvent.count }.from(2).to(1)
    end
  end
end
