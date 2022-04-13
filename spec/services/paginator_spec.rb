require 'rails_helper'

RSpec.describe Paginator do
  let!(:tweets) { create_list(:tweet, 3) }
  let(:tweet_query) { Tweet.all }

  describe '#call' do
    context 'when query parameter is nil' do
      it 'raise a standard error' do
        expect { described_class.new(query: nil).call }.to raise_error(StandardError)
      end
    end

    context 'when query parameter passed with a query' do
      context 'and per_page paramenter is nil' do
        let!(:instance) { described_class.new(query: tweet_query).call }

        it 'return paginated query with one page' do
          expect(instance[:pages].first[:data]).to eq(tweet_query)
          expect(instance[:total_pages]).to eq(1)
          expect(instance[:pages].last[:page]).to eq(1)
        end
      end

      context 'and per_page is passed' do
        let!(:instance) { described_class.new(query: tweet_query, per_page: 1).call }

        it 'return paginated query with pages based on per page size' do
          expect(instance[:pages].first[:data].first).to eq(tweet_query.first)
          expect(instance[:total_pages]).to eq(3)
          expect(instance[:pages].last[:page]).to eq(3)
        end
      end
    end
  end
end

