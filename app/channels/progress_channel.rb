class ProgressChannel < ApplicationCable::Channel
  def subscribed
    stream_from "progress:message"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def follow(data)
    stream_from("progress:#{data['progress_id'].to_i}")
  end

  def unfollow
    stop_all_streams
  end

  def status
  end
end
