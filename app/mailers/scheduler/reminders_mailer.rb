class Scheduler::RemindersMailer < ActionMailer::Base
  default from: "DAT Scheduling <scheduling@arcbadat.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.scheduler.reminders_mailer.email_invite.subject
  #
  def email_invite(assignment)
    @assignment = assignment

    mail to: assignment.person.email, subject: "#{assignment.shift.name} on #{assignment.date.strftime("%b %d")}" do |format|
      format.text
      format.ics
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.scheduler.reminders_mailer.email_reminder.subject
  #
  def email_reminder(assignment)
    @assignment = assignment

    mail to: assignment.person.email, subject: "#{assignment.shift.name} on #{assignment.date.strftime("%b %d")}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.scheduler.reminders_mailer.sms_reminder.subject
  #
  def sms_reminder(assignment)
    @assignment = assignment

    mail to: assignment.person.sms_addresses, subject: ""
  end

  def daily_email_reminder(setting)
    now = DateTime.now.in_time_zone
    prepare_reminders(setting)

    mail to: setting.person.email, subject: "DAT Shifts for #{now.strftime("%b %d")}"
  end

  def daily_sms_reminder(setting)
    now = DateTime.now.in_time_zone
    prepare_reminders(setting)

    mail to: setting.person.sms_addresses, subject: ""
  end

  private
  def prepare_reminders(setting)
    @setting = setting
    @groups = Scheduler::ShiftGroup.current_groups_for_chapter(setting.person.chapter)
    @groups = Scheduler::ShiftGroup.next_groups(setting.person.chapter)

    counties = setting.person.counties.to_a.first

    @groups = @groups.uniq.reduce({}) do |hash, grphash|
      hash.tap{|h|
        h[grphash] = grphash[:group].shifts.where(county_id: counties).order(:ordinal).to_a
      }
    end
  end
  def item
    @assignment
  end
  def shift_lead
    @shift_lead ||= Scheduler::ShiftAssignment.includes(:shift).where(date: item.date, scheduler_shifts: {shift_group_id: item.shift.shift_group, county_id: item.shift.county}).first
  end
  def other_assignments
    Scheduler::ShiftAssignment.includes(:shift).where(date: item.date, scheduler_shifts: {shift_group_id: item.shift.shift_group, county_id: item.shift.county}).references(:shift).order('scheduler_shifts.ordinal')
  end
  def assignments_for_date_shift(the_date, shift)
    Scheduler::ShiftAssignment.where{shift_id.in(shift.id) & (date == the_date)}
  end

  def format_person(person, count=2)
    numbers = person.phone_order.first(count).map{|ph| "#{ph[:number]} (#{ph[:label][0]})"}.join(" ")
    "#{person.full_name} #{numbers}"
  end


  helper_method :item, :shift_lead, :other_assignments, :assignments_for_date_shift, :format_person
end