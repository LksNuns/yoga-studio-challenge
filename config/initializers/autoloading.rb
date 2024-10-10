module Commands; end

Rails.autoloaders.main.push_dir("#{Rails.root}/app/commands", namespace: Commands)
