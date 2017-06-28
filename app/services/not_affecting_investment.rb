class NotAffectingInvestment
  NOT_AFFECTING_INVESTMENT = {
    'f[]' => 'issue.cf_20',
    'op[issue.cf_20]' => '!',
    'v[issue.cf_20][]' => 0
  }.freeze

  def array_queries
    NOT_AFFECTING_INVESTMENT.map { |key, value| [key, value] }
  end

  def hash_queries
    NOT_AFFECTING_INVESTMENT
  end
end
