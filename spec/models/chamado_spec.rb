# encoding: utf-8
require_relative '../spec_helper'

describe Chamado do
  context 'instance' do
    before :each do
      @chamado = Chamado.new(:content => 'THIS IS THE TEXT', :project => Project.new(:name => 'Teste ABC', :confluence_parent_page => 'PARENT-PAGE'))
      
      @client = ScrumBoard::ConfluenceClient.new
      ScrumBoard::ConfluenceClient.stubs(:new).returns(@client)
    end
    
    context 'should respond to' do
      it 'create_page' do
        @chamado.should respond_to(:create_page)
      end
      
      it 'update_deploy_list' do
        @chamado.should respond_to(:update_deploy_list)
      end
      
      it 'generate' do
        @chamado.should respond_to(:generate)
      end
    end
    
    context 'on receiving a call to generate' do
      it 'should call update_deploy_list and create_page' do
        @chamado.expects(:update_deploy_list).with('v9.9.1').once
        @chamado.expects(:create_page).with('v9.9.1', 'CONTENT').once
        
        @chamado.generate 'v9.9.1', 'CONTENT'
      end
    end
    
    context 'should delegate to ScrumBoard::ConfluenceClient' do
      it 'when create_page called' do
        @client.expects(:add_page).with('teste abc - v0.5.2', 'Conteudo', :parent => 'PARENT-PAGE').once
        @chamado.create_page('v0.5.2', 'Conteudo')
      end
      
      it 'when update_deploy_list called' do
        topo = %q{h1. Deploys dos sistemas Alexandria:


|| Sistema || Versão || Chamado || Dt. Abertura || Dt. Execução || Status || Tipo || Motivo deploy emergencial || Problemas do deploy/Validação ||
}
        former_content = %Q{#{topo}CONTINUACAO
}
        linha = "| Teste ABC | v0.5.2 | [IM-000000|plataforma:teste abc - v0.5.2] | 12/03/2012 | | Aberto | Piloto | | |\n"
        
        @client.expects(:page_source).with('Chamados+de+deploy').once.returns(former_content)
        @client.expects(:store_page).with('Chamados de deploy', %Q{#{topo}#{linha}CONTINUACAO
}).once
        @chamado.update_deploy_list('v0.5.2')
      end
    end
  end
end