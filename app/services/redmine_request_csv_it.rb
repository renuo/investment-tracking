class RedmineRequestCsvIt < RedmineRequestCsv
  def addition_params
    [['f[]', 'project_id'],
     ['op[project_id]', '='],
     ['v[project_id][]', 129],
     ['v[project_id][]', 130],
     ['v[project_id][]', 138],
     ['v[project_id][]', 139],
     ['v[project_id][]', 140],
     ['v[project_id][]', 141]]
  end
end
