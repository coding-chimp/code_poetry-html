//= require_directory ./libraries/
//= require_directory ./plugins/
//= require_self

$(document).ready(function() {
  $.fn.dataTableExt.oStdClasses.sStripeOdd = 'pure-table-odd';
  $('.file_list').dataTable({
    "aaSorting": [[ 0, "asc" ]],
    "bPaginate": false
  });

  $("a.src_link").click(function() {
    var source_table = $($(this).attr('href'));

    if (!source_table.hasClass('highlighted')) {
      source_table.find('pre code').each(function(i, e) {hljs.highlightBlock(e)});
      source_table.addClass('highlighted');
    };
  });

  $(document).ready(function() {
    $(".src_link").fancybox({
      minWidth: 700,
      helpers: {
        title:  null
      }
    });
  });

  $("abbr.timeago").timeago();
});
