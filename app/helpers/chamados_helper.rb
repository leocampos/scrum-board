module ChamadosHelper
  def show_team_projects(team)
    if team.projects.blank?
      concat t('messages.chamados.nenhum')
    else
      team.projects.each do |project|
        concat raw("<ul><li>#{project.name} [<a href='/projects/#{project.id}>/chamados/new'>auto</a> | <a href='/projects/#{project.id}/chamados/manual'>manual</a>]</li></ul>")
      end
    end
  end
end