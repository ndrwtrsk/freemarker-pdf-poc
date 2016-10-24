<html>
<head>
    <title>Welcome!</title>
</head>
<body>
<table class="columns">
    <tr>
        <td>
            <div id="pie_div"></div>
        </td>
        <td>
            <div id="bar_div"></div>
        </td>
    </tr>
    <tr>
        <td>
            <div id="pie2_div"></div>
        </td>
        <td>
            <div id="bar2_div"></div>
        </td>
    </tr>
</table>


<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>

    const injectedData = ${randomData};

    console.log('Loaded')
    google.load("visualization", "1", {
        packages: ['corechart', 'table', 'bar'],
        callback: draw
    });

    function draw() {
        drawChart();
        window.PHANTOM_HTML_TO_PDF_READY = true;
    }

    function drawChart() {
        console.log("Drawing..");
        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows(injectedData);

        // Set chart options
        var options = {
            'title': 'How Much Pizza I Ate Last Night',
            'width': 400,
            'height': 300
        };

        // Instantiate and draw our chart, passing in some options.
        var pie = new google.visualization.PieChart(document.getElementById('pie_div'));
        pie.draw(data, options);

        var barChart = new google.visualization.BarChart(document.getElementById('bar_div'));
        barChart.draw(data, options);

        var pie2 = new google.visualization.PieChart(document.getElementById('pie2_div'));
        pie2.draw(data, options);

        var barChart2 = new google.visualization.BarChart(document.getElementById('bar2_div'));
        barChart2.draw(data, options);
        console.log(google);

    }

</script>
</body>
</html>