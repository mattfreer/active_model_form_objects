require 'active_model'

<% module_namespacing do -%>
class <%= klass_name %><% if has_parent_class? %> < <%= parent_class_name %><% end %>
  include ActiveModel::FormObject

  private

  def persist!
    #TODO
  end
end
<% end -%>
