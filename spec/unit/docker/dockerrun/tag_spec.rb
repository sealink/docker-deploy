require 'docker/dockerrun/tag'

describe Docker::Dockerrun::Tag do
  subject { Docker::Dockerrun::Tag.new tag }
  let(:tag) { :the_new_tag }
  let(:file) { double( read: file_content, rewind: nil, write: nil, close: nil) }
  let(:file_content) { '{"Image":{"Name":"the name:the_old_tag"}}' }

  before do
    stub_const 'Docker::Dockerrun::FILE_NAME', 'the file name'
    allow(File).to receive(:open).and_return(file)
  end

  context 'In the happy path' do
    it 'executes uneventfully' do
      expect { subject.call }.not_to raise_error
      expect(file).to have_received(:rewind)
      expect(file).to have_received(:write).with(
        "{\n  \"Image\": {\n    \"Name\": \"the name:the_new_tag\"\n  }\n}"
      )
    end
  end
end
