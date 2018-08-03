# frozen_string_literal: true

module GraphQL
  class Schema
    # Represents a list type in the schema.
    # Wraps a {Schema::Member} as a list type.
    # @see {Schema::Member::TypeSystemHelpers#to_list_type}
    class List < GraphQL::Schema::Wrapper
      def to_graphql
        @of_type.graphql_definition.to_list_type
      end

      # @return [GraphQL::TypeKinds::LIST]
      def kind
        GraphQL::TypeKinds::LIST
      end

      # @return [true]
      def list?
        true
      end

      def to_type_signature
        "[#{@of_type.to_type_signature}]"
      end

      def evaluate_selections(object:, selections:, interpreter:)
        object.map do |inner_obj|
          @of_type.evaluate_selections(object: inner_obj, selections: selections, interpreter: interpreter)
        end
      end
    end
  end
end
