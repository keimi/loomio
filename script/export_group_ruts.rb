require 'csv'

CSV.open("data.csv", "w") do |csv|
  csv << ['grupo_padre','reunion', 'asistentes']

  Group.all.each do |g|
    if g.parent
      
      members_rut = g.members.collect {|m| m.rut}.join(':')
      data = [g.parent.name, g.name, members_rut]
      p data
      csv << data
    end
  end
end