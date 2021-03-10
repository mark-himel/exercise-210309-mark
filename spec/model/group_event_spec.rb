require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  let(:group_event) { FactoryBot.build(:group_event, name: 'Test Event') }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }

  describe 'validate uniqueness of name' do
    context 'when name is unique' do
      it 'allows to save the event' do
        expect(group_event.valid?).to eq(true)
      end
    end

    context 'when name is not unique' do
      let(:invalid_group_event) { FactoryBot.build(:group_event, name: 'Test Event') }

      before do
        group_event.save!
      end

      it 'does not allow to save the event' do
        expect(invalid_group_event.valid?).to eq(false)
      end
    end
  end

  describe 'validate dates' do
    context 'when start and end date is valid' do
      it 'allows to save the event' do
        expect(group_event.valid?).to eq(true)
      end
    end

    context 'when start and end date ranges are invalid' do
      let(:invalid_group_event) { FactoryBot.build(:group_event, name: 'Test Event', end_date: DateTime.now - 7) }

      before do
        group_event.save!
      end

      it 'does not allow to save the event' do
        expect(invalid_group_event.valid?).to eq(false)
      end
    end
  end

  describe 'validate before publishing' do
    before do
      group_event.save
    end

    context 'when some attributes are missing' do
      it 'does not allow the event to be published' do
        group_event.update(published_at: DateTime.now + 2)
        expect(group_event.errors.full_messages).to eq(['Publish is only possible when all attributes are present'])
      end
    end

    context 'when all attributes are present' do
      before do
        group_event.update(description: 'A description', location: 'Dhaka')
      end
      it 'allows the event to be published' do
        expect {group_event.update(published_at: DateTime.now + 2) }.to change { group_event.published_at }
      end
    end
  end

  describe 'callbacks' do
    describe '#calculate_duration' do
      it 'sets the duration before saving the event' do
        expect { group_event.save }.to change { group_event.duration }.from(nil).to(7)
      end
    end
  end
end
