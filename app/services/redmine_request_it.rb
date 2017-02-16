class RedmineRequestIt < RedmineRequest

  def addition_params
    [['f[]', 'project_id'],
      ['op[project_id]', '='],
      ['v[project_id][]', 129],
      ['v[project_id][]', 130],
      ['v[project_id][]', 139],
      ['v[project_id][]', 140]]
  end
end
