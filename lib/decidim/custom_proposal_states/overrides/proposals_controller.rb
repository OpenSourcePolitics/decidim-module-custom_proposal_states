# frozen_string_literal: true

module Decidim
  module CustomProposalStates
    module Overrides
      module ProposalsController
        def self.prepended(base)
          base.class_eval do
            def default_filter_params
              {
                search_text_cont: "",
                with_any_state: default_states,
                with_any_origin: default_filter_origin_params,
                activity: "all",
                with_any_category: default_filter_category_params,
                with_any_scope: default_filter_scope_params,
                related_to: "",
                type: "all"
              }
            end

            def default_states
              [
                Decidim::CustomProposalStates::ProposalState.not_system.where(component: current_component).pluck(:token).map(&:to_s),
                %w(accepted evaluating state_not_published)
              ].flatten
            end
          end
        end
      end
    end
  end
end
