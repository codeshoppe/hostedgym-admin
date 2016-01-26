module Payment
  class PlanDecorator < ::Draper::Decorator
    delegate_all

    def collection_label_method
      id = object.id
      price = h.number_to_currency object.price
      billing_frequency = h.pluralize(object.billing_frequency, 'month')
      "#{id} - #{price} every #{billing_frequency}"
    end

    def collection_value_method
      object.id
    end
  end
end
