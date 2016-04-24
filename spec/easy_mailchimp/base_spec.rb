require 'spec_helper'

describe EasyMailchimp::Base do
  subject { described_class.new }

  describe '#create_member' do
    let(:config) do
      double('config', {
        logger: nil,
        api_key: '123-us11',
        api_endpoint: 'https://{{dc}}.fakeapi.com'
      })
    end
    let(:list_id) { "id-123" }
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

      it 'logs and raises the exception' do
        expect(EasyMailchimp).to receive(:config).and_return config
        expect_any_instance_of(::Gibbon::Request).to \
          receive(:lists).and_raise(::Gibbon::MailChimpError, error)

        expect_any_instance_of(::EasyMailchimp::Logger).to receive(:info)

        expect { subject.create_member(list_id) }.to raise_error(::Gibbon::MailChimpError)
      end
    end
  end
end
