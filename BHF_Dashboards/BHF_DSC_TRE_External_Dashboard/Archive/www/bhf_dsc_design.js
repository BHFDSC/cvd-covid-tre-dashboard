$(function() {
  $('[data-toggle="tooltip"]').tooltip()
})


$ ( document ).ready(function() {
$.ajax({
    type: 'GET',
    url: 'models/summary.php',
    mimeType: 'json',
    success: function(data) {
        $.each(data, function(i, data) {
            var body = "<tr>";
            body    += "<td>" + data.name + "</td>";
            body    += "<td>" + data.address + "</td>";
            body    += "<td>" + data.phone_no + "</td>";
            body    += "<td>" + data.birthday + "</td>";
            body    += "<td>" + data.color + "</td>";
            body    += "<td>" + data.car + "</td>";
            body    += "<td>" + data.hobbies + "</td>";
            body    += "<td>" + data.relatives + "</td>";
            body    += "</tr>";
            $( "#summary-table tbody" ).append(body);
        });
        /*DataTables instantiation.*/
        $( "#summary-table" ).DataTable();
    },
    error: function() {
        alert('Fail!');
    }
});
});