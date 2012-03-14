# encoding: utf-8

teams = Team.create([
  {:name => 'Wan-do', :scrum_master => 'Eric Adrien Fer', :product_owner => 'Daniel Calmazini'},
  {:name => 'Maio', :scrum_master => 'Anselmo Martelini', :product_owner => 'Francisco Madureira'},
  {:name => 'Esparta', :scrum_master => 'Anselmo Martelini', :product_owner => 'Francisco Madureira'},
  {:name => 'Devil Sheep Team', :scrum_master => 'Eric Adrien Fer', :product_owner => 'Daniel Calmazini'},
  {:name => 'Hokage', :scrum_master => 'Eric Adrien Fer', :product_owner => 'Luis Felipe Cipriani'},
  {:name => 'Góri', :scrum_master => 'Anselmo Martelini', :product_owner => 'Luis Felipe Cipriani/Luiz Rocha'}
])

maio = teams[1]
esparta = teams[2]
dst = teams[3]

projects = Project.create([
   {:name => 'SiteTools', :pilot => false, :team => maio, :repository => 'git@codebasehq.com:abril/site-tools/site-tools.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Site%20Tools%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://sitetools.alexandria.abril.com.br/version'},
   {:name => 'Console', :pilot => false, :team => maio, :repository => 'git@codebasehq.com:abril/console/console.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Console%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://alexandria.abril.com.br/version'},
   {:name => 'Editorial', :pilot => true, :team => esparta, :repository => 'git@codebasehq.com:abril/editorial/editorial-data-entry.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Editorial%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://editorial.alexandria.abril.com.br/version'},
   {:name => 'Midia', :pilot => true, :team => esparta, :repository => 'git@codebasehq.com:abril/midia/midia-data-entry.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Midia%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://midia.alexandria.abril.com.br/version'},
   {:name => 'Concurso Cultural - API', :pilot => true, :team => esparta, :repository => 'git@codebasehq.com:abril/dominios/concursos.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Concurso%20Cultural%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://concursos.api.abril.com.br/version'},
   {:name => 'Concurso Cultural - Data Entry', :pilot => true, :team => esparta, :repository => 'git@codebasehq.com:abril/dominios/concursos-dataentry.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Concurso%20Cultural%20DataEntry%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://concursos.alexandria.abril.com.br/version'},
   {:name => 'AbrilId', :pilot => true, :team => dst, :repository => 'git@codebasehq.com:abril/aapg/abril-id.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Abril%20ID-QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://id.abril.com.br/version'}
])
