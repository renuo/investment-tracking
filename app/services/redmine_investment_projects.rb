class RedmineInvestmentProjects
  INVESTMENT_PROJECTS = {
    renuo_investments: 138,
    dashboard: 155,
    gifcoin: 152,
    investments_elf: 129,
    redmine_communicator: 141,
    redmine_estimator: 130,
    investments_griffin: 139,
    investments_interns: 140
  }.freeze

  def ids
    INVESTMENT_PROJECTS.values
  end
end
