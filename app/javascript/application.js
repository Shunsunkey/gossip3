// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"
//= require jquery3
//= require popper
//= require bootstrap
//= require_tree .
//= require rails-ujs

$(document).ready(function() {
    $('.like-btn').on('click', function() {
      var gossipId = $(this).data('gossip-id');
      var likeUrl = '<%= like_gossip_path(gossip) %>';
  
      $.post(likeUrl, function(response) {
        // Handle the response from the server if needed
        console.log(response);
      });
    });
  });
  