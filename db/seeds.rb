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
gori = teams[5]

projects = Project.create([
   {:name => 'SiteTools', :confluence_parent_page => 'chamados-site-tools', :pilot => false, :team => maio, :repository => 'git@codebasehq.com:abril/site-tools/site-tools.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Site%20Tools%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://sitetools.alexandria.abril.com.br/version'},
   {:name => 'Console', :confluence_parent_page => 'chamados-console', :pilot => false, :team => maio, :repository => 'git@codebasehq.com:abril/console/console.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Console%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://alexandria.abril.com.br/version'},
   {:name => 'Editorial', :confluence_parent_page => 'chamados-editorial', :pilot => true, :team => esparta, :repository => 'git@codebasehq.com:abril/editorial/editorial-data-entry.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Editorial%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://editorial.alexandria.abril.com.br/version'},
   {:name => 'Midia', :confluence_parent_page => 'chamados-midia', :pilot => true, :team => esparta, :repository => 'git@codebasehq.com:abril/midia/midia-data-entry.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Midia%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://midia.alexandria.abril.com.br/version'},
   {:name => 'Concurso Cultural - API', :confluence_parent_page => 'concurso-api', :pilot => true, :team => esparta, :repository => 'git@codebasehq.com:abril/dominios/concursos.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Concurso%20Cultural%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://concursos.api.abril.com.br/version'},
   {:name => 'Concurso Cultural - Data Entry', :confluence_parent_page => 'concurso-de', :pilot => true, :team => esparta, :repository => 'git@codebasehq.com:abril/dominios/concursos-dataentry.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Concurso%20Cultural%20DataEntry%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://concursos.alexandria.abril.com.br/version'},
   {:name => 'AbrilId', :confluence_parent_page => 'chamados-abril-id', :pilot => true, :team => dst, :repository => 'git@codebasehq.com:abril/aapg/abril-id.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Abril%20ID-QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://id.abril.com.br/version'},
   {:name => 'ICE', :confluence_parent_page => 'chamados-ice', :pilot => true, :team => gori, :repository => 'git@codebasehq.com:abril/aapg/abril-id.git', :qa_approved_url => '', :production_version_url => ''},
   {:name => 'MCP', :confluence_parent_page => 'chamados-mcp', :pilot => true, :team => gori, :repository => 'git@codebasehq.com:abril/aapg/abril-id.git', :qa_approved_url => '', :production_version_url => ''},
   {:name => 'Anotações Data Entry', :confluence_parent_page => 'chamados-anotacoes', :pilot => false, :team => maio, :repository => 'git@codebasehq.com:abril/anotacoes/anotacoes-data-entry.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Anotacoes%20Data%20Entry%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://anotacoes.alexandria.abril.com.br/version'},
   {:name => 'Anotações Domain', :confluence_parent_page => 'chamados-anotacoes', :pilot => false, :team => maio, :repository => 'git@codebasehq.com:abril/anotacoes/anotacoes.git', :qa_approved_url => 'http://172.16.1.243/hudson/job/Anotacoes%20-%20QA%20APPROVED/lastSuccessfulBuild/artifact/LAST_VERSION', :production_version_url => 'http://anotacoes.api.abril.com.br/version'}
])