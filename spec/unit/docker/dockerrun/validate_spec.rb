require 'docker/dockerrun/validate'

describe Docker::Dockerrun::Validate do
  subject { Docker::Dockerrun::Validate.instance }
  let(:system_exit) { 'the system exit error' }
  let(:file_exist?) { true }
  let(:file_content) { '{"a key":"a value"}' }
  
  before do
    stub_const 'Docker::Dockerrun::FILE_NAME', 'the file name'
    allow(File).to receive(:exist?).and_return(file_exist?)
    allow(File).to receive(:read).and_return(file_content)
    allow(subject).to receive(:abort).and_raise(system_exit)
    allow(subject).to receive(:parsability).and_call_original
  end

  context 'In the happy path' do
    it 'executes unevenfully' do
      expect { subject.call }.not_to raise_error
    end
  end

  context "when the file doesn't exist" do
    let(:file_exist?) { false }

    it 'aborts with the error message' do
      expect { subject.call }.to raise_error(system_exit)
      expect(subject).to have_received(:abort).with('./the file name not found!')
      expect(subject).not_to have_received(:parsability)
    end
  end

  context "when the file isn't parsable" do
    let(:file_content) { '{"incomplete json"' }

    it 'aborts with the error message' do
      expect { subject.call }.to raise_error(system_exit)
      expect(subject).to have_received(:abort).with(
        "the file name is not parsable: 776: unexpected token at '#{file_content}'"
      )
    end
  end
end
