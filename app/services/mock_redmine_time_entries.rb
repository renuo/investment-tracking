class MockRedmineTimeEntries
  def static_time_entries
    [{ 'id': 42_800, 'project': { 'id': 7, 'name': 'Renuo Internal' }, 'issue': { 'id': 1592 },
       'user': { 'id': 74, 'name': 'Alicia Rueegg' }, 'activity': { 'id': 45, 'name': 'Auto' }, 'hours': 1.14,
       'comments': '530160757: Clean office : : 2017-02-07T08:28:40+00: 00', 'spent_on': '2017-02-07', '
       created_on': '2017-02-07T08:30:32Z', 'updated_on': '2017-02-07T08:35:07Z' },
     { 'id': 42_800, 'project': { 'id': 7, 'name': 'Renuo Internal' }, 'issue': { 'id': 1592 }, 'user':
       { 'id': 74, 'name': 'Alicia Rueegg' }, 'activity': { 'id': 45, 'name': 'Auto' }, 'hours': 0.14,
       'comments': '530160757: Clean office : : 2017-02-07T08:28:40+00: 00', 'spent_on': '2017-02-07',
       'created_on': '2017-02-07T08:30:32Z', 'updated_on': '2017-02-07T08:35:07Z' }]
  end
end
