desc "Remove if already exists"
task :destroy do
  rm_rf File.join(ENV['HOME'], ".vimrc")
  rm_rf File.join(ENV['HOME'], ".gvimrc")
  rm_rf File.join(ENV['HOME'], ".vim")
end

desc "Symlink .vimrc and .gvimrc files"
task :rc_files do
  %w[vimrc gvimrc].each do |script|
    dotfile = File.join(ENV['HOME'], ".#{script}")
    if File.exist?(dotfile) || File.symlink?(dotfile)
      warn "#{dotfile} already exists!"
    else
      ln_s File.join("#{ENV['HOME']}/.dotfiles/dotvim/vim", script), dotfile
      puts "vim/#{script} symlinked to #{dotfile}"
    end
  end
end

desc "Symlink .vim directory"
task :config_dir do
  config_dir = File.join(ENV['HOME'], ".vim")
  if Dir.exist? config_dir
    puts "#{config_dir} already exists!"
  else
    ln_s File.join("#{ENV['HOME']}/.dotfiles/dotvim", 'vim'), config_dir
    puts "vim symlinked to #{config_dir}"
  end
end

desc "Create ~/.vim-tmp/bckp,swap,undo dirs"
task :tmp_dirs do
  mkdir_p File.join(ENV['HOME'], '.vim-tmp', 'bckp')
  mkdir_p File.join(ENV['HOME'], '.vim-tmp', 'swap')
  mkdir_p File.join(ENV['HOME'], '.vim-tmp', 'undo')
end

desc "the setup"
task :setup => [:rc_files, :config_dir, :tmp_dirs]

task default: :setup
