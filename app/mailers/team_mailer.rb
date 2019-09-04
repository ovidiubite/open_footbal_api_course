# frozen_string_literal: true

class TeamMailer < ApplicationMailer
  def send_report
    @teams = Team.all

    mail(
      to: 'some_email_address@gmail.com',
      bcc: '',
      subject: 'Teams'
    )
  end

  def send_email_with_records(count)
    @created = count

    mail(
        to: 'some_email_address@gmail.com',
        bcc: '',
        subject: 'Teams/Managers'
    )
  end
end
