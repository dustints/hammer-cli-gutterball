module HammerCLIGutterball
  class ContentReportsCommand < Command
    resource :content_reports

    class ContentHostStatus < InfoCommand
      include HammerCLIForemanTasks::Async

      action :system_status
      command_name 'content-host-status'

      def execute
        if option_async?
          super
        else
          request= send_request
          task_id = request.is_a?(Hash) ? request['id'] : request
          task_progress(request)
          require 'debugger'
          debugger
          print_data(load_task(task_id))
          HammerCLI::EX_OK
        end
      end

      output do
        field :system, "System" do
          field :uuid, "Uuid"
          field :system_state, "System State" do
            field :uuid, "Uuid"
            field :system, "System"
            field :created, "Created"
          end
          field :name, "Name"
          field :username, "Username"
          field :entitlement_status, "Entitlement Status"
          field :service_level, "Service Level"
          field :release_ver, "Release Ver"
          field :type, "Type"
          field :system, "System"
          field :entitlement_count, "Entitlement Count"
          field :last_checkin, "Last Checkin"
          field :facts, "Facts"
          collection :installed_products, "Installed Products" do
            field :product_id, "Product Id"
            field :product_name, "Product Name"
            field :version, "Version"
            field :arch, "Arch"
            field :status, "Status"
            field :start_date, "Start Date"
            field :end_date, "End Date"
          end
          field :guest_ids, "Guest Ids"
          field :hypervisor_id, "Hypervisor Id"
          field :environment, "Environment"
          field :status, "Status" do
            field :status, "Status"
            collection :reasons, "Reasons" do
              field :key, "Key"
              field :message, "Message"
              field :attributes, "Attributes"
            end
            list :non_compliant_products, "Non Compliant Products"
            field :compliant_products, "Compliant Products"
            field :partially_compliant_products, "Partially Compliant Products"
            field :partial_stacks, "Partial Stacks"
            field :date, "Date"
          end
          collection :entitlements, "Entitlements" do
            field :quantity, "Quantity"
            field :start_date, "Start Date"
            field :end_date, "End Date"
            field :product_id, "Product Id"
            field :derived_product_id, "Derived Product Id"
            field :product_name, "Product Name"
            field :derived_product_name, "Derived Product Name"
            field :restricted_to_username, "Restricted To Username"
            field :contract_number, "Contract Number"
            field :account_number, "Account Number"
            field :order_number, "Order Number"
            field :attributes, "Attributes" do
              field :requires_system_type, "Requires System Type"
              field :support_type, "Support Type"
              field :arch, "Arch"
              field :support_level, "Support Level"
              field :virt_limit, "Virt Limit"
              field :type, "Type"
            end
          end
          field :date,  "Date"
        end
      end

      build_options
    end

    class ContentHostTrend < InfoCommand
      include HammerCLIForemanTasks::Async

      action :system_trend
      command_name 'content-host-trend'

      output do
        # TODO
      end

      build_options
    end

    class StatusTrend < InfoCommand
      include HammerCLIForemanTasks::Async

      action :status_trend
      command_name 'status-trend'

      output do
        # TODO
      end

      build_options
    end

    autoload_subcommands
  end
end
