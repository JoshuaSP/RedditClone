module Findable
  extend ActiveSupport::Concern

  included do
    before_action :find_by_id, only: [:edit, :update, :show, :destroy]
  end

  def find_by_id
    object = controller_name.classify
    instance_variable_set("@#{object.downcase}".to_sym, object.constantize.find(params[:id]))
  end
end
