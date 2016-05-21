$(document).ready(function() {   
    $('div.boxes li').draggable(
        { revert : 'invalid'},
        { cursor : 'move'},
        { helper : 'clone'},
        { opacity : 0.5 }
    );
    $('div.boxes').droppable({ 
        drop : function(event, ui) {
            $(this).append(ui.draggable);
        }
    });
});