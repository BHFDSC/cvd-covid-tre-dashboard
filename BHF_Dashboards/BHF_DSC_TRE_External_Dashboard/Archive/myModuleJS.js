//code to run at the beginning of each module that may use JS to align namespaces
function myModuleJS(ns) {
    $('#' + ns + 'clickableElement').click(function() {
        $('#' + ns + 'highlightableElement').css('background', 'yellow');
    });
}