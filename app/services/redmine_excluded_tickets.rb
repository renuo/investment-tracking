class RedmineExcludedTickets
  EXCLUDED_TICKETS = {
    kranksein: 2949,
    abwesenheit_absenzen: 6199
  }.freeze

  def ticket_nrs
    EXCLUDED_TICKETS.values
  end
end
