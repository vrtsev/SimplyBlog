After do |scenario|
  if scenario.failed?
    save_page
  end
end