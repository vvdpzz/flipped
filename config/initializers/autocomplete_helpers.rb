module Rails3JQueryAutocomplete

  # Contains utility methods used by autocomplete
  module Helpers

    #
    # Returns a three keys hash actually used by the Autocomplete jQuery-ui
    # Can be overriden to show whatever you like
    #
    def json_for_autocomplete(items, method)
      items.collect do |item|
        if item.respond_to?("abbr")
          id = item.abbr
        else
          id = item.id
        end
        {"id" => id, "label" => item.send(method), "value" => item.send(method)}
      end
    end

    # Returns parameter model_sym as a constant
    #
    #   get_object(:actor)
    #   # returns a Actor constant supposing it is already defined
    #
    def get_object(model_sym)
      object = model_sym.to_s.camelize.constantize
    end

    def get_parent(parent_class_name)
      if parent_id = params[:id]
        parent_class_name = parent_class_name || params[:controller].singularize
        begin
          parent_model = get_object(parent_class_name)
        rescue
          raise "Couldn't find any ActiveRecord model with name: #{parent_class_name}. Please indicate a valid model name via the :parent_class_name option."
        end
        parent_model.find_by_abbr(parent_id)
      end
    end

    # Returns a symbol representing what implementation should be used to query
    # the database and raises *NotImplementedError* if ORM implementor can not be found
    def get_implementation(object) 
      ancestors_ary = object.ancestors.collect(&:to_s)
      if ancestors_ary.include?('ActiveRecord::Base')
        :activerecord
      elsif ancestors_ary.include?('Mongoid::Document')
        :mongoid
      else
        raise NotImplementedError
      end
    end

    #DEPRECATED
    def get_order(implementation, method, options)
      warn 'Rails3JQueryAutocomplete#get_order is has been DEPRECATED, please use #get_autocomplete_order instead'
      get_autocomplete_order(implementation, method, options)
    end

    # Returns the order parameter to be used in the query created by get_items
    def get_autocomplete_order(implementation, method, options)
      order = options[:order]

      case implementation
        when :mongoid then
          if order 
            order.split(',').collect do |fields|
              sfields = fields.split
              [sfields[0].downcase.to_sym, sfields[1].downcase.to_sym]
            end
          else
            [[method.to_sym, :asc]]
          end
        when :activerecord then 
          order || "#{method} ASC"
      end
    end

    # DEPRECATED
    def get_limit(options)
      warn 'Rails3JQueryAutocomplete#get_limit is has been DEPRECATED, please use #get_autocomplete_limit instead'
      get_autocomplete_limit(options)
    end

    # Returns a limit that will be used on the query
    def get_autocomplete_limit(options)
      options[:limit] ||= 10
    end

    # DEPRECATED
    def get_items(parameters)
      warn 'Rails3JQueryAutocomplete#get_items is has been DEPRECATED, you should use #get_autocomplete_items instead'
      get_autocomplete_items(parameters)
    end

    #
    # Can be overriden to return or filter however you like
    # the objects to be shown by autocomplete
    #
    #   items = get_autocomplete_items(:model => get_object(object), :options => options, :term => term, :method => method) 
    #
    def get_autocomplete_items(parameters)
      model = parameters[:model]
      method = parameters[:method]
      options = parameters[:options]
      term = parameters[:term]
      parent = parameters[:parent]
      is_full_search = options[:full]

      limit = get_autocomplete_limit(options)
      implementation = get_implementation(model)
      order = get_autocomplete_order(implementation, method, options)

      case implementation
      when :mongoid
        order_method = "order_by"
        search = (is_full_search ? '.*' : '^') + term + '.*'
        where_clause = {method.to_sym => /#{search}/i}
      when :activerecord
        order_method = "order"
        where_clause = ["LOWER(#{method}) LIKE ?", "#{(is_full_search ? '%' : '')}#{term.downcase}%"]
      end
      if parent
        relation_name = options[:relation_name] || model.name.underscore.pluralize
        items = parent.send(relation_name).where(where_clause).limit(limit).send(order_method, order)
      else
        items = model.where(where_clause).limit(limit).send(order_method, order)
      end
    end

  end
end