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
    
    `curl #{production_version_url}`
  end
  
  def retrieve_qa_approved_version
    return if qa_approved_url.blank?
    
    `curl #{qa_approved_url}`
  end
  
  private
  def repositories_dir
    File.join(Rails.root, 'repositories')
  end
  
  def retrive_dir_name
    File.join(repositories_dir, repository.match(/([^\/]+)\.git/)[1])
  end
end
