class Paginator
  def initialize(query:, per_page: nil)
    @query = query
    @per_page = per_page
  end

  def call
    raise StandardError.new('query can not be nil') if query.nil?
    return paginated_query(1, pages_with_data) if per_page.nil?

    paginated_query(total_pages, pages_with_data)
  end

  private

  attr_reader :query, :per_page

  def paginated_query(total_pages, pages)
    { total_pages: total_pages, pages: pages }
  end

  def total_pages
    pages_with_data.size
  end

  def pages_with_data
    sliced_query.each_with_index.map do |data, index|
      { data: data, page: index + 1 }
    end
  end

  def sliced_query
    return [query.all] if per_page.nil?

    query.all.each_slice(per_page.to_i).to_a
  end
end
