class InvestmentProjects
  def initialize
    @renuo_investments = 138
    @investments_elf = 129
    @redmine_communicator = 141
    @redmine_estimator = 130
    @investments_griffin = 139
    @investments_inters = 140
  end

  def all_investment_projects_id
    [@renuo_investments, @investments_elf, @redmine_communicator,
     @redmine_estimator, @investments_griffin, @investments_inters]
  end
end
