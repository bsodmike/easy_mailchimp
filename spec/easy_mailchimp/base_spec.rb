require 'spec_helper'

RSpec.shared_examples 'an exception on lists' do
  it 'logs and raises the exception' do
    expect(EasyMailchimp).to receive(:config).and_return config
    expect_any_instance_of(::Gibbon::Request).to \
      receive(:lists).and_raise(::Gibbon::MailChimpError, error)

    expect_any_instance_of(::EasyMailchimp::Logger).to receive(:info)

    expect { subject.create_member(list_id) }.to raise_error(::Gibbon::MailChimpError)
  end
end

describe EasyMailchimp::Base do
  subject { described_class.new }
  let(:config) do
    double('config', {
      logger: nil,
      api_key: '123-us11',
      api_endpoint: 'https://{{dc}}.fakeapi.com'
    })
  end
  let(:list_id) { 'id-123' }

  describe '#create_member' do
    let(:members) { double('members') }

    it 'uses the Gibbon API to create a member, with the list ID passed' do
      expect(EasyMailchimp).to receive(:config).and_return config
      expect(EasyMailchimp::Logger).to receive(:new).and_return nil

      expect_any_instance_of(::Gibbon::Request).to receive(:lists).with(list_id).and_return members
      expect(members).to receive_message_chain(:members, :create)

      subject.create_member(list_id)
    end

    context 'if an exception occurs' do
      let(:error) { 'Ran out of gas!' }

      it_behaves_like 'an exception on lists'
    end
  end

  describe '#get_list_name' do
    let(:list_name) { 'Example list' }
    let(:lists) do
      double('lists', {
        retrieve: {
          'lists' => [{'id' => list_id, 'name' => list_name}]
        }
      })
    end

    it 'uses the Gibbon API to fetch list name using the list ID passed' do
      expect(EasyMailchimp).to receive(:config).and_return config
      expect(EasyMailchimp::Logger).to receive(:new).and_return nil

      expect_any_instance_of(::Gibbon::Request).to receive(:lists).and_return lists

      expect(subject.get_list_name(list_id)).to eq list_name
    end

    context 'if an exception occurs' do
      let(:error) { 'Ran out of gas!' }

      it_behaves_like 'an exception on lists'
    end
  end
end
