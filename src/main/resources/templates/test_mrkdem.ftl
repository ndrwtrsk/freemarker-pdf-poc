<!DOCTYPE HTML>
<html>

<head>
    <meta charset="utf-8">
    <!--Load the AJAX API-->
    <!-- <<script src="charts.js" type="text/javascript" charset="utf-8" async defer></script> -->
</head>

<body>
    <h1>Beat this document into submission</h1>
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
            <td colspan="2">
                <div id="column_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="line_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="table_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="trendlines_div"></div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="donutchart_div"></div>
            </td>
            <td>
                <div id="3dPie_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="visualization_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="stepped_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="scatter_div"></div>
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
        <tr>
            <td colspan="2">
                <div id="column2_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="line2_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="table2_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="trendlines2_div"></div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="donutchart2_div"></div>
            </td>
            <td>
                <div id="3dPie2_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="visualization2_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="stepped2_div"></div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div id="scatter2_div"></div>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
    console.log('Loaded')


    const injectedData = ${randomData};>

    google.load("visualization", "1", {
        packages: ['corechart', 'table', 'bar'],
        callback: draw
    });

    function draw() {
        drawChart();
        drawLineChart();
        drawTable();
        drawColColors();
        drawTrendlines();
        drawVisualization();
        drawDonutChart();
        draw3dPieChart();
        drawSteppedChart();
        window.PHANTOM_HTML_TO_PDF_READY = true;
    }

    function drawChart() {
        console.log("Drawing..");
        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');

		randomData.forEach((val, i) => {
           data.addRow(['Mushrooms'+i, val]);
		});

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

    function drawLineChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Month');
        data.addColumn('number', 'Apples');
        data.addColumn('number', 'Oranges');

		for (var i = 0; i < Math.floor((Math.random() * 30) + 1); i++)
			data.addRow(['Oct '+i, Math.floor((Math.random() * 100) + 1), Math.floor((Math.random() * 100) + 1)]); 

		<#list values.vals as v>
			data.addRow(['Oct '+${v?index}, ${v}, ${v}]); 
		</#list>		
			
        // Set chart options
        var options = {
            'width': 960,
            'height': 300
        };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.LineChart(document.getElementById('line_div'));
        chart.draw(data, options);
        var chart2 = new google.visualization.LineChart(document.getElementById('line2_div'));
        chart2.draw(data, options);
    }


    function drawTable() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('number', 'Salary');
        data.addColumn('boolean', 'Full Time Employee');
		
//		for (var i = 0; i < Math.floor((Math.random() * 30) + 1); i++)
//			data.addRow(['Mike'+i, {v: 9, f: '$10,000'}, true]);
		<#list values.vals as v>
			data.addRow(['Mike'+${v?index}, {v: ${v}, f: '${v}'}, true]);
		</#list>
		

        var table = new google.visualization.Table(document.getElementById('table_div'));
        table.draw(data, {
            showRowNumber: true,
            width: '100%',
            height: '100%'
        });

        var table2 = new google.visualization.Table(document.getElementById('table2_div'));
        table2.draw(data, {
            showRowNumber: true,
            width: '100%',
            height: '100%'
        });
    }

    function drawColColors() {
        var data = new google.visualization.DataTable();
        data.addColumn('timeofday', 'Time of Day');
        data.addColumn('number', 'Motivation Level');
        data.addColumn('number', 'Energy Level');

		<#list values.vals as v>
			data.addRow([{
                v: [${v?index}, 0, 0],
                f: '8 am'
            }, ${v}, ${v}]);
		</#list>

        var options = {
            title: 'Motivation and Energy Level Throughout the Day',
            colors: ['#9575cd', '#33ac71'],
            hAxis: {
                title: 'Time of Day',
                format: 'h:mm a',
                viewWindow: {
                    min: [7, 30, 0],
                    max: [17, 30, 0]
                }
            },
            vAxis: {
                title: 'Rating (scale of 1-10)'
            }
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('column_div'));
        chart.draw(data, options);

        var chart2 = new google.visualization.ColumnChart(document.getElementById('column2_div'));
        chart2.draw(data, options);
    }

    function drawTrendlines() {
        var data = new google.visualization.DataTable();
        data.addColumn('timeofday', 'Time of Day');
        data.addColumn('number', 'Motivation Level');
        data.addColumn('number', 'Energy Level');

		<#list values.vals as v>
			data.addRow([{
                v: [${v?index}, 0, 0],
                f: '8 am'
            }, ${v}, ${v}]);
		</#list>

        var options = {
            title: 'Motivation and Energy Level Throughout the Day',
            trendlines: {
                0: {
                    type: 'linear',
                    lineWidth: 5,
                    opacity: .3
                },
                1: {
                    type: 'exponential',
                    lineWidth: 10,
                    opacity: .3
                }
            },
            hAxis: {
                title: 'Time of Day',
                format: 'h:mm a',
                viewWindow: {
                    min: [7, 30, 0],
                    max: [17, 30, 0]
                }
            },
            vAxis: {
                title: 'Rating (scale of 1-10)'
            }
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('trendlines_div'));
        chart.draw(data, options);

        var chart2 = new google.visualization.ColumnChart(document.getElementById('trendlines2_div'));
        chart2.draw(data, options);
    }

    function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
            ['2004/05', Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1)],
            ['2005/06', Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1)],
            ['2006/07', Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1)],
            ['2007/08', Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1)],
            ['2008/09', Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1)]
        ]);

		for (var i = 0; i < Math.floor((Math.random() * 30) + 1); i++)
			data.addRow(['2016/12', Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1), Math.floor((Math.random() * 2000) + 1)]);
		<#list values.vals as v>
			data.addRow(['2016/12', ${v}, ${v}, ${v}, ${v}, ${v}, ${v}]);
		</#list>

        var options = {
            title: 'Monthly Coffee Production by Country',
            vAxis: {
                title: 'Cups'
            },
            hAxis: {
                title: 'Month'
            },
            seriesType: 'bars',
            series: {
                5: {
                    type: 'line'
                }
            }
        };

        var chart = new google.visualization.ComboChart(document.getElementById('visualization_div'));
        chart.draw(data, options);
        var chart2 = new google.visualization.ComboChart(document.getElementById('visualization2_div'));
        chart2.draw(data, options);
    }

    function drawDonutChart() {
        var data = google.visualization.arrayToDataTable([
            ['Task', 'Hours per Day'],
            ['Work', Math.floor((Math.random() * 30) + 1)],
            ['Eat', Math.floor((Math.random() * 30) + 1)],
            ['Commute', Math.floor((Math.random() * 30) + 1)],
            ['Watch TV', Math.floor((Math.random() * 30) + 1)],
            ['Sleep', Math.floor((Math.random() * 30) + 1)]
        ]);

		<#list values.vals as v>
			data.addRow(['Work'+${v?index}, ${v}]);
		</#list>

        var options = {
            title: 'My Daily Activities',
            pieHole: Math.random()
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart_div'));
        chart.draw(data, options);
        var chart2 = new google.visualization.PieChart(document.getElementById('donutchart2_div'));
        chart2.draw(data, options);
    }

    function draw3dPieChart() {
        var data = google.visualization.arrayToDataTable([
            ['Task', 'Hours per Day'],
            ['Work',  Math.floor((Math.random() * 20) + 1)],
            ['Eat', Math.floor((Math.random() * 20) + 1)],
            ['Commute', Math.floor((Math.random() * 20) + 1)],
            ['Watch TV', Math.floor((Math.random() * 20) + 1)],
            ['Sleep', Math.floor((Math.random() * 20) + 1)]
        ]);

		<#list values.vals as v>
			data.addRow(['Work'+${v?index}, ${v}]);
		</#list>

        var options = {
            title: 'My Daily Activities',
            is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('3dPie_div'));
        chart.draw(data, options);
        var chart2 = new google.visualization.PieChart(document.getElementById('3dPie2_div'));
        chart2.draw(data, options);
    }

    function drawSteppedChart() {
        var data = google.visualization.arrayToDataTable([
            ['Director (Year)', 'Rotten Tomatoes', 'IMDB'],
            ['Alfred Hitchcock (1935)', Math.floor((Math.random() * 20) + 1), Math.floor((Math.random() * 20) + 1)],
            ['Ralph Thomas (1959)', Math.floor((Math.random() * 20) + 1), Math.floor((Math.random() * 20) + 1)],
            ['Don Sharp (1978)', Math.floor((Math.random() * 20) + 1), Math.floor((Math.random() * 20) + 1)],
            ['James Hawes (2008)', Math.floor((Math.random() * 20) + 1), Math.floor((Math.random() * 20) + 1)]
        ]);

		for (var i = 0; i < Math.floor((Math.random() * 30) + 1); i++)
			data.addRow(['Alfred Hitchcock (1935)'+i, Math.floor((Math.random() * 20) + 1), Math.floor((Math.random() * 20) + 1)]);
		<#list values.vals as v>
			data.addRow(['Alfred Hitchcock (1935)'+${v?index}, ${v}, ${v}]);
		</#list>

		var options = {
            title: 'The decline of \'The 39 Steps\'',
            vAxis: {
                title: 'Accumulated Rating'
            },
            isStacked: true
        };

        var chart = new google.visualization.SteppedAreaChart(document.getElementById('stepped_div'));
        chart.draw(data, options);
        var chart2 = new google.visualization.SteppedAreaChart(document.getElementById('stepped2_div'));
        chart2.draw(data, options);
        var scatter = new google.visualization.ScatterChart(document.getElementById('scatter_div'));
        scatter.draw(data, options);
        var scatter2 = new google.visualization.ScatterChart(document.getElementById('scatter2_div'));
        scatter2.draw(data, options);
    }
    </script>
</body>

</html>
