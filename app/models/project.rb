class Project < ActiveRecord::Base
  belongs_to :team
  
  def retrieve_repository
    return if repository.blank?
    
    dir_name = retrive_dir_name
    
    if File.exists?(dir_name)
      Dir.chdir retrive_dir_name
      `git pull`
    else
      Dir.chdir repositories_dir
      
      `git clone #{repository}`
    end
  end
  
  def retrieve_production_version
    return if production_version_url.blank?
    
    data = `curl '#{production_version_url}'`
    data.gsub("\n",'')
    
    return data unless data.match /^\{.*?\}$/
    
    return ActiveSupport::JSON.decode(data)['version']
  end
  
  def retrieve_qa_approved_version
    return if qa_approved_url.blank?
    
    version = `curl '#{qa_approved_url}'`
    version.gsub("\n",'')
  end
  
  def stepup_diff(data, sections=[])
    data ||= {}
    command = 'stepup notes --fetch'
    
    data.each_pair do |chave, valor|
      command += " --#{chave}=#{valor}"
    end
    
    unless sections.blank?
      command += " --sections=#{sections.join(' ')}"
    end
    
    set_current_dir
    clean_stepup_notes `#{command}`
  end
  
  def sha1(version)
    text = `git log --pretty=oneline --no-color -n1 #{version}`
    text[0,40]
  end
  
  private
  def repositories_dir
    return @rep_dir_name unless @rep_dir_name.blank?
    @rep_dir_name = File.join(Rails.root, 'repositories')
    @rep_dir_name
  end
  
  def retrive_dir_name
    return @dir_name unless @dir_name.blank?
    
    @dir_name = File.join(repositories_dir, repository.match(/([^\/]+)\.git/)[1])
    @dir_name
  end
  
  def set_current_dir
    Dir.chdir retrive_dir_name
  end
  
  def clean_stepup_notes(text)
    text.gsub(/\A.*?---\r?\n?$/m, '')
  end
end
