module HammerCLIGutterball
  class ContentReportsCommand < Command
    resource :content_reports
    module ReportPrintable
      def execute
        if option_async?
          super
        else
          request= send_request
          task_id = request.is_a?(Hash) ? request['id'] : request
          task_progress(request)
          taskoutput = load_task(task_id)
          if taskoutput['output'] && taskoutput['output']['report_data']
            print_data(taskoutput['output']['report_data'])
          end
          HammerCLI::EX_OK
        end
      end
    end

    class ContentHostStatus < InfoCommand
      include HammerCLIForemanTasks::Async
      include ReportPrintable

      action :system_status
      command_name 'content-host-status'


      output do
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
        end
        field :date,  "Date"
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
      end

      build_options
    end

    class ContentHostTrend < InfoCommand
      include HammerCLIForemanTasks::Async
      include ReportPrintable

      action :system_trend
      command_name 'content-host-trend'

      output do
        field :date ,"Date"
        collection :entitlements ,"Entitlements" do
                field :account_number ,"Account Number"
                field :attributes ,"Attributes" do
                    field :arch ,"Arch"
                    field :requires_system_type ,"Requires System Type"
                    field :support_level ,"Support Level"
                    field :support_type ,"Support Type"
                    field :type ,"Type"
                    field :virt_limit ,"Virt Limit"
                end
                field :contract_number ,"Contract Number"
                field :derived_product_attributes ,"Derived Product Attributes"
                field :derived_product_id ,"Derived Product Id"
                field :derived_product_name ,"Derived Product Name"
                field :derived_provided_products ,"Derived Provided Products"
                field :end_date ,"End Date"
                field :order_number ,"Order Number"
                field :product_id ,"Product Id"
                field :product_name ,"Product Name"
                field :quantity ,"Quantity"
                field :restricted_to_username ,"Restricted To Username"
                field :start_date ,"Start Date"
        end
        field :status ,"Status" do
            list :compliant_products ,"Compliant Products" 
            field :date ,"Date"
            list :non_compliant_products ,"Non Compliant Products"
            list :partial_stacks ,"Partial Stacks"
            list :partially_compliant_products ,"Partially Compliant Products"
            collection :reasons ,"Reasons" do
                    field :attributes ,"Attributes" do
                        field :name ,"Name"
                        field :product_id ,"Product Id"
                    end
                    field :key ,"Key"
                    field :message ,"Message"
            end
            field :status ,"Status"
        end
        field :system ,"System" do
            field :entitlement_count ,"Entitlement Count"
            field :entitlement_status ,"Entitlement Status"
            field :environment ,"Environment"
            field :facts ,"Facts" do
                field :cpu.cpu_socket(s) ,"Cpu.Cpu Socket(S)"
                field :uname.machine ,"Uname.Machine"
            end
            list :guest_ids ,"Guest Ids"
            field :hypervisor_id ,"Hypervisor Id"
            collection :installed_products ,"Installed Products" do
                    field :arch ,"Arch"
                    field :end_date ,"End Date"
                    field :product_id ,"Product Id"
                    field :product_name ,"Product Name"
                    field :start_date ,"Start Date"
                    field :status ,"Status"
                    field :version ,"Version"
                end
            field :last_checkin ,"Last Checkin"
            field :name ,"Name"
            field :release_ver ,"Release Ver"
            field :service_level ,"Service Level"
            field :system ,"System" do 
                field :display_name ,"Display Name"
                field :key ,"Key"
            end
            field :system_state ,"System State" do 
                field :created ,"Created"
                field :system ,"System"
                field :uuid ,"Uuid"
            end
            field :type ,"Type" do
                field :label ,"Label"
                field :manifest ,"Manifest"
            end
            field :username ,"Username"
            field :uuid ,"Uuid"
        end
      end

      build_options
    end

    class StatusTrend < InfoCommand
      include HammerCLIForemanTasks::Async

      action :status_trend
      command_name 'status-trend'

      output do
        # TODO
        field :timestamp, 'Timestamp'
        field :valid, 'valid'
        field :invalid, 'invalid'
      end

      build_options
    end

    autoload_subcommands
  end
end
