# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Provence::Application.initialize!

#gives Paperclip access to imagemagick
Paperclip.options[:command_path] = "/usr/local/bin/"