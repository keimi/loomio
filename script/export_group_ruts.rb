require 'csv'

CSV.open("data.csv", "w") do |csv|
  csv << ['rut','asistencias', 'grupo']
  aux = Array.new
  Group.all.each do |g|
    if g.parent and g.created_at.year == 2019
      members_rut = g.members.collect {|m| m.rut}
      if members_rut
        members_rut.each do |ru|
          aux << {rut: ru, asistencias: 1, grupo: g.parent.name}
        end
      end
    end
  end
  all_parents = aux.collect{|d| d[:grupo]}.uniq
  all_parents.each { |parent|
    ruts_gr = aux.select{|d| d[:grupo] == parent}
    all_ruts = ruts_gr .collect{|r| r[:rut]}.uniq
    all_ruts.each { |r|
      asis = ruts_gr.select{|d2| d2[:rut] == r}.collect{|d2| d2[:asistencias]}.reduce(:+)
      # if asis > 3
      csv << [r, asis, parent]
      # end
    }
  }
end





