/*
var graphdef = {
    categories : ['uvCharts'],
    dataset : {
        'uvCharts' : [
            { name : '2009', value : 32},
            { name : '2010', value : 60 },
            { name : '2011', value : 97 },
            { name : '2012', value : 560 },
            { name : '2013', value : 999 }
        ]
    }
};

var config = {
    graph: {
        bgcolor: 'none'
    },

    frame: {
        bgcolor: 'none'
    }
};

var chart = uv.chart('StackedBar', graphdef, config);
*/
var locationData;

var xhr= new XMLHttpRequest();
xhr.open('GET', 'locationsJson.json', true);
xhr.onreadystatechange= function() {
    locationArray = JSON.parse(this.responseText);
    loadChart(locationArray);

};
xhr.send();


function loadChart(locationArr){
    locationData = locationArr;

    $("#num-cities-label").text(locationData.length);

    var citiesWithEmotion = [];
    var citiesNames = [];

    var numWithEmotion = 0;
    for (var i = 0; i < locationData.length; i++){

        if (locationData[i].emotions != null){
            if (Object.keys(locationData[i].emotions).length > 0){
                numWithEmotion++;
                citiesWithEmotion.push(locationData[i]);
                citiesNames.push(locationData[i].cityName);
            }
        }
    }

    citiesWithEmotion.sort(function(a, b) {
        return parseFloat(a.emotions.happiness) - parseFloat(b.emotions.happiness);
    });

    var citiesWithEmotionNames = [];
    for (var i = 0; i < citiesWithEmotion.length; i++){
        citiesWithEmotionNames.push(citiesWithEmotion[i].cityName);
    }
    $("#num-cities-emotion-label").text(citiesWithEmotionNames.length);

    //Loop through all the emotions, adding them to the data series
    var dataSeries = [];
    //Loop through each of the emotion values (just a constant list)
    var emotions = ['anger','contempt','disgust','fear','sadness','surprise','neutral','happiness'];

    for (var e = 0; e < emotions.length; e++){
        var emotionArray = [];
        for (var i = 0; i < citiesWithEmotion.length; i++){
            emotionArray.push(citiesWithEmotion[i].emotions[emotions[e]] * 100);
        }
        var emotionDataSeriesObj = {name: emotions[e],data: emotionArray};
        dataSeries.push(emotionDataSeriesObj);
        console.log(emotionDataSeriesObj)
    }

    //Similarly to the above code, loop through all the weather conditions and build another chart
    var weatherDataSeries = [];
    var weatherTags = ['averageTempHigh','averageTempMid','averageTempLow','rainfall','snowfall','daysRain','hoursSunshine'];

    for (var e = 0; e < weatherTags.length; e++){
        var weatherArray = [];
        for (var i = 0; i < locationData.length; i++){
            weatherArray.push(locationData[i].weather[weatherTags[e]]);
        }
        var weatherDataSeriesObj = {name: weatherTags[e],data: weatherArray};
        weatherDataSeries.push(weatherDataSeriesObj);
    }

    console.log(locationData);

    Highcharts.chart('location-emotion-chart', {
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Emotion Proportions for Locations'
        },
        xAxis: {
            categories: citiesWithEmotionNames
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Total perceived emotion percentage'
            }
        },
        legend: {
            reversed: true
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },
        series: dataSeries
    });

    Highcharts.chart('location-weather-chart', {
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Weather Statistics For Locations'
        },
        xAxis: {
            categories: citiesNames
        },
        yAxis: {
            min: 0
        },
        legend: {
            reversed: true
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },
        series: weatherDataSeries
    });

}

$(function() {
    renderCustomChart("averageTempMid","happiness");
});

$("#custom-update").click(function(){
    console.log("Updating custom emotion chart.");
    renderCustomChart($("#weather-select").val(),$("#emotion-select").val());
});

/*
$("#emotion-select").change(function(){
    renderCustomChart($("#emotion-select").val(),$("#weather-select").val());
});
$("#weather-select").change(function(){
    renderCustomChart($("#emotion-select").val(),$("#weather-select").val());
});*/

function renderCustomChart(xAxisName,yAxisName){

    if (locationData != null){
        var customDataSeries = [];
        var customDataSeriesData = [];

        var customRegressionDataList = [];

        for (var i = 0; i < locationData.length; i++){
            if (locationData[i].emotions[yAxisName] > 0 & locationData[i].weather[xAxisName] > 0){
                customDataSeries.push({name: locationData[i].cityName, data: [[locationData[i].weather[xAxisName],locationData[i].emotions[yAxisName]]]});
                customRegressionDataList.push([locationData[i].weather[xAxisName],locationData[i].emotions[yAxisName]]);
            }
        }
        console.log(customDataSeries);

        var customRegressionDataSeries = [{
            name: "Cities",
            data: customRegressionDataList,
            regression: true ,
            regressionSettings: {
                type: 'linear',
                color:  'rgba(40, 100, 255, .9)',
                name: "r^2: %r"
            },
        }];
        console.log(customRegressionDataSeries);

        Highcharts.chart('location-custom-chart', {
            chart: {
                type: 'scatter'
            },
            title: {
                text: xAxisName + " vs "+ yAxisName
            },
            xAxis: {
                title: {
                    enabled: true,
                    text: xAxisName
                }
            },
            yAxis: {
                title: {
                    enabled: true,
                    text: yAxisName
                }
            },
            legend: {
                reversed: true
            },
            plotOptions: {
                scatter: {
                    marker: {
                        radius: 5,
                        states: {
                            hover: {
                                enabled: true,
                                lineColor: 'rgb(100,100,100)'
                            }
                        }
                    },
                    states: {
                        hover: {
                            marker: {
                                enabled: false
                            }
                        }
                    },
                    tooltip: {
                        headerFormat: '<b>{series.name}</b><br>',
                        pointFormat: xAxisName+':{point.x} '+yAxisName+':{point.y}'
                    }
                }
            },
            series: customDataSeries
        });

        Highcharts.chart('location-custom-chart-regression', {
            chart: {
                type: 'scatter'
            },
            title: {
                text: xAxisName + " vs "+ yAxisName
            },
            xAxis: {
                title: {
                    enabled: true,
                    text: xAxisName
                }
            },
            yAxis: {
                title: {
                    enabled: true,
                    text: yAxisName
                }
            },
            legend: {
                reversed: true
            },
            plotOptions: {
                scatter: {
                    marker: {
                        radius: 5,
                        states: {
                            hover: {
                                enabled: true,
                                lineColor: 'rgb(100,100,100)'
                            }
                        }
                    },
                    states: {
                        hover: {
                            marker: {
                                enabled: false
                            }
                        }
                    },
                    tooltip: {
                        headerFormat: '<b>{series.name}</b><br>',
                        pointFormat: xAxisName+':{point.x} '+yAxisName+':{point.y}'
                    }
                }
            },
            series: customRegressionDataSeries
        });

    }
}
