module ApplicationHelper
  def menu_item(item, name, path=:default)
    case item
    when 'root'
      path = send("root_path")
    else
      path = path == :default ? send("#{item.pluralize}_path") : path
    end
    
    
    "<li#{active_menu_item?(path) ? ' class="active"' : ''}><a href=\"#{path}\">#{name}</a></li>"
  end
  
  def active_menu_item?(path)
    request.fullpath == path
  end
end
