App.progress = App.cable.subscriptions.create("ProgressChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    this.install();
    this.follow();
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('received called. data = ' + data.percent);
    $('tr#' + data.set + ' > td.' + data.action + ' > a').text('Fetching...');
    $('td.fetch > a, td.fetch_image > a').addClass('disabled');
    $('div#progress-div').show();
    $('div.progress-percentage').text(data.set + ' fetching ' + data.percent + "%");
    $('div.progress-bar').attr('aria-valuenow', data.percent).css('width', data.percent + '%');
    if (data.percent >= 100) {
      $('div#progress-div').hide();
      $('div.progress-percentage').text("0%");
      $('div.progress-bar').attr('aria-valuenow', 0).css('width', "0%");
      $('td.fetch > a.not_fetched, td.fetch_image > a.not_fetched').removeClass('disabled');
    }
  },

  follow: function() {
    this.perform('follow', { progress_id: 1 })
  },

  install: function() {
    $(document).on('page:change', function() { App.progress.follow() })
  }

});
