require 'tilt/rdiscount'

class Welcome < Base
  get('/') do
    markdown IO.read settings.root + '/../README.md'
  end
end
