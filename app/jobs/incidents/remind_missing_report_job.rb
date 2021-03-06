class Incidents::RemindMissingReportJob

  def self.enqueue
    new.perform
  end

  def perform
    threshold = 12.hours.ago
    now = 5.minutes.ago
    Incidents::Incident.valid.joins{[dat_incident.outer, dispatch_log]}.where{(dat_incident.id == nil) & (created_at < threshold) & 
        ((last_no_incident_warning == nil) | (last_no_incident_warning < threshold))}.readonly(false).each do |inc|
      inc.update_attribute :last_no_incident_warning, now
      Incidents::Notifications::Notification.create_for_event inc, 'incident_missing_report'
    end
  end

end