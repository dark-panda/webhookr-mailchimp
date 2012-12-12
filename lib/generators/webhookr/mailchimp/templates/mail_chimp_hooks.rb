class MailChimpHooks

  # All 'on_' handlers are optional. Omit any you do not require.

  def on_subscribe(incoming)
    payload = incoming.payload
    puts payload.fired_at
    puts payload.data.id
    puts payload.data.list_id
    puts payload.data.email
    puts payload.data.email_type
    puts payload.data.merges.EMAIL
    puts payload.data.merges.FNAME
    puts payload.data.merges.LNAME
    puts payload.data.merges.INTERESTS
    puts payload.data.ip_opt
    puts payload.data.ip_signup
  end

  def on_unsubscribe(incoming)
    payload = incoming.payload
    puts payload.fired_at
    puts payload.data.action
    puts payload.data.reason
    puts payload.data.id
    puts payload.data.list_id
    puts payload.data.email
    puts payload.data.email_type
    puts payload.data.merges.EMAIL
    puts payload.data.merges.FNAME
    puts payload.data.merges.LNAME
    puts payload.data.merges.INTERESTS
    puts payload.data.ip_opt
    puts payload.data.campaign_id
    puts payload.data.reason
  end

  def on_profile(incoming)
    payload = incoming.payload
    puts payload.fired_at
    puts payload.data.id
    puts payload.data.list_id
    puts payload.data.email
    puts payload.data.email_type
    puts payload.data.merges.EMAIL
    puts payload.data.merges.FNAME
    puts payload.data.merges.LNAME
    puts payload.data.merges.INTERESTS
    puts payload.data.ip_opt
  end

  def on_upemail(incoming)
    payload = incoming.payload
    puts payload.fired_at
    puts payload.data.list_id
    puts payload.data.new_id
    puts payload.data.new_email
    puts payload.data.old_email
  end

  def on_cleaned(incoming)
    payload = incoming.payload
    puts payload.fired_at
    puts payload.data.list_id
    puts payload.data.campaign_id
    puts payload.data.reason
    puts payload.data.email
  end

  def on_campaign(incoming)
    payload = incoming.payload
    puts payload.fired_at
    puts payload.data.id
    puts payload.data.subject
    puts payload.data.status
    puts payload.data.reason
    puts payload.data.list_id
  end

end