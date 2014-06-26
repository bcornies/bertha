Facter.add("home") do
  setcode do
     File.expand_path('~')
  end
end