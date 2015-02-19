module HammerCLIGutterball
  class ContentReportsCommand < Command
    resource :content_reports
    module ReportPrintable
      def adapter
        :csv
      end

      def execute
        if option_async?
          super
        else
          request = send_request
          task_id = request.is_a?(Hash) ? request['id'] : request
          task_progress(request)
          data = load_task(task_id)['output']['report_data']
          print_data(data) unless data.empty?
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
        field :name, 'Hostname'
        field :status, 'Status'
        field :date, "Date"
      end

      build_options
    end

    class ContentHostTrend < InfoCommand
      include HammerCLIForemanTasks::Async
      include ReportPrintable

      action :system_trend
      command_name 'content-host-trend'

      output do
        field :date, 'Date'
        field :status_status, 'Status'
      end

      build_options
    end

    class StatusTrend < InfoCommand
      include HammerCLIForemanTasks::Async
      include ReportPrintable

      action :status_trend
      command_name 'status-trend'

      output do
        field :timestamp, 'Timestamp'
        field :valid, 'valid'
        field :invalid, 'invalid'
      end

      build_options
    end

    autoload_subcommands
  end
end
