(function($) {
  $(function() {
    $('#regions-panes .pane').not(':first').hide();
    $('#regions-tabs li:first').addClass('active');
    $('#regions-tabs a').click(function(evt) {
      evt.preventDefault();
      var $this = $(this);
      $this.parent().addClass('active').siblings().removeClass('active');
      var pane_id = $this.attr('href');
      $(pane_id).show().siblings('.pane').hide();
    });
    
    var disableWhenDefault = function() { $(this).next().attr('disabled', $(this).val() == ''); }
    $('#state-county').relatedSelects({
  		onChangeLoad: '/regions/counties',
  		dataType: 'html',
  		loadingMessage: 'Please Wait...',
  		disableIfEmpty: true,
  		selects: ['state_fips', 'county_fips'],
  		onChange: disableWhenDefault,
  		onLoadingEnd: disableWhenDefault
  	});
  	
  	var $pinnedItemTemplate = $('#templates .pinned-item').detach().removeClass('template');
  	$('#regions .selector form').submit(function(evt) {
  	  evt.preventDefault();
  	  var $this = $(this);
  	  var $bucket = $this.closest('.pane').find('.pinned ul');
  	  
  	  $.ajax({
  	    url: '/regions/pin',
  	    type: 'post',
  	    data: $this.serialize(),
  	    dataType: 'json',
  	    error: function(xhr, status) {
  	      $('#messages .error').text('Could not add region to selections: '+status).show();
  	    },
  	    success: function(data, status) {
  	      var $item = $pinnedItemTemplate.clone();
  	      $item.find('.name').text(data.name);
  	      $item.find('input[name=fips]').val(data.fips)
  	      $item.appendTo($bucket).show('highlight');
  	    }
  	  });
  	});
  	
  	$('#regions .pinned-item form').live('submit', function(evt) {
	    evt.preventDefault();
	    var $this = $(this);
	    var $item = $this.closest('.pinned-item');
	    $item.remove();
      $.ajax({
        url: 'regions/unpin',
        type: 'post',
        data: $this.serialize(),
        error: function(xhr, status) {
          $('#messages .error').text('Could not remove region from selections: '+status).show();
        },
        success: function(data, status) {
          $item.remove();
        }
      });
	  });
  });
})(jQuery);