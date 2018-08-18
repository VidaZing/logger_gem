require 'rainbow/refinement'
using Rainbow

GEM_NAME = 'vidazing_logger'

desc "Remove #{GEM_NAME} && Gemfile.lock"
task :clean do
  puts "Remove #{GEM_NAME} && Gemfile.lock".blue
  system "rm -f *.gem Gemfile.lock"
end

desc "Build #{GEM_NAME}"
task :build => :clean do
  puts "Building #{GEM_NAME}".blue
  system "gem build #{GEM_NAME}.gemspec"
end

desc "Installs #{GEM_NAME}"
task :install => :build do
  puts "Installing #{GEM_NAME}".blue
  system "gem install #{GEM_NAME}"
end

desc "Uninstalls #{GEM_NAME}"
task :uninstall do
  puts "UNINSTALLING #{GEM_NAME}".inverse.blue
  system "gem uninstall -xq #{GEM_NAME}"
end

desc "Rebuilds on file changes"
task :"auto-install" do
  puts "Rebuilding on file changes. Ignores .git/ and gems created. Watches every 1 seconds".bright.magenta
  system "fswatch -0 -e .git/ -e *.gem -l 1 . | xargs -0 -I {} sh -c \"echo '{}' && rake uninstall install\""
end
