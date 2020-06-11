class RevenueSerializer
  def initialize(revenue, date)
    @revenue = revenue
    @date = date
  end

  def to_hash
    { data: {
        attributes: {
          total_revenue: sprintf("%.2f", @revenue)
        }
      }
    }
  end
end