asamblea = Group.find_by(name: 'Asamblea General')
if asamblea

  User.all.each do |u|
    if u.email_verified
      if not asamblea.members.find_by(id: u.id)
        asamblea.add_member! u
        p 'member added:' + u.email
      end
    end
  end
end