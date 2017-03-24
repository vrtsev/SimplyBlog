describe SimplyRecord::DatabaseConnection do
  let(:database_connection) { instance_double('PG::Connection', query: database_obj) }
  let(:database_obj) { instance_double('PG::Result') }
  let(:host)         { 'localhost' }
  let(:user)         { 'example' }
  let(:password)     { 'testpass' }
  let(:dbname)       { 'blog_development' }
  let(:query)        { 'test query' }

  before do
    allow_any_instance_of(described_class).to receive(:client).and_return(database_connection)
  end

  describe '#get_data' do
    context 'when custom db configuration passed to class' do
      subject { described_class.new(database_connection, host, user, password, dbname) }

      it 'returns corrrect db instance object' do
        expect(subject.get_data(query)).to be(database_obj)
      end
    end

    context 'when class uses default db configuration' do
      subject { described_class.new }

      it 'returns correct db instance object' do
        expect(subject.get_data(query)).to be(database_obj)
      end
    end
  end
end
