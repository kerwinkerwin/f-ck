$(document).ready(function(){
  // $(".artist-img").mouseover(function(e){
  //   imageHover(e)
  // });
  $(".artist-img").hover(
    function() {
      $( this ).addClass( "img_hover" );
    }, function() {
      $( this ).removeClass( "img_hover" );
    }
  );


});

function imageHover(e){

}
