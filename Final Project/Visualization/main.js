/*
var c = document.getElementById("imageCanvas");
var ctx = c.getContext("2d");
ctx.beginPath();
ctx.arc(95,50,40,0,2*Math.PI);
ctx.stroke();
*/
var mod = function (n, m) {
    var remain = n % m;
    return Math.floor(remain >= 0 ? remain : remain + m);
};

var canvas = document.getElementById("imageCanvas");
var ctx = canvas.getContext('2d');

var imageArray = null;
var numImages = 0;
var currentImage = 0;

var xhr= new XMLHttpRequest();
xhr.open('GET', 'photosJson.json', true);
xhr.onreadystatechange= function() {
    imageArray = JSON.parse(this.responseText);
    loadImageArray(imageArray);

};
xhr.send();

function loadImageArray(images){
    imageArray = images;
    console.log(imageArray);

    numImages = imageArray.length;

    redrawUI();

}

function redrawUI(){
    $("#num-images-label").text(numImages);
    $("#cur-images-label").text(currentImage + 1);
    //$("#preview-image").attr("src",imageArray[currentImage].url);

    //Save face regions in the image metadata view
    var metaDataTableString = "";
    if (imageArray[currentImage].faces != null){
        for (var i = 0; i < imageArray[currentImage].faces.length; i++) {
            var faceObject = imageArray[currentImage].faces[i];
            metaDataTableString += "<hr/><b>[Face "+i+"]<table><tr><th>Emotion</th><th>Value</th></tr>";
            for (var property in faceObject.emotions) {
                if (faceObject.emotions.hasOwnProperty(property)) {
                    metaDataTableString += "<tr><td>"+property+"</td><td>" + faceObject.emotions[property] +"</td></tr>";
                }
            }
            metaDataTableString += "</table>";
        }
    } else {
        metaDataTableString = "No Faces";
    }
    $("#image-emotion-table").html(metaDataTableString);

    var loc = imageArray[currentImage].location;
    $("#image-metadata-section").text(loc.cityName + ","+loc.stateName+" ("+loc.latitude+","+loc.longitude+")");

    ctx.fillStyle="#969696";
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    ctx.strokeStyle="#c4c4c4";
    for (x=0;x<=canvas.width;x+=100) {
        for (y=0;y<=canvas.height;y+=100) {
            ctx.moveTo(x, 0);
            ctx.lineTo(x, canvas.height);
            ctx.stroke();
            ctx.moveTo(0, y);
            ctx.lineTo(canvas.width, y);
            ctx.stroke();
        }
    }


    var img = new Image();
    img.onload = function() {
        //Draw image, then draw the bounding boxes
        ctx.drawImage(img, 0, 0);

        ctx.strokeStyle="#FFFF00";
        if (imageArray[currentImage].faces != null){
            for (var i = 0; i < imageArray[currentImage].faces.length; i++) {
                var faceObject = imageArray[currentImage].faces[i];
                var bb = faceObject.boundingBox;
                console.log(faceObject);
                ctx.strokeRect(bb.left,bb.top,bb.width,bb.height);
            }
        }
    };
    img.src = imageArray[currentImage].url;
}

function nextImage(){
    currentImage = mod(currentImage + 1,numImages);
    redrawUI();
}

function prevImage(){
    currentImage = mod(currentImage - 1,numImages);
    redrawUI();
}

function nextImageWithFace(){
    var originalCurImage = currentImage;
    var loopCounter = 0;
    currentImage = mod(currentImage + 1,numImages);
    if (imageArray[currentImage].faces != null){
        while (imageArray[currentImage].faces.length == 0){
            currentImage = mod(currentImage + 1,numImages);
            loopCounter++;
            if (loopCounter > numImages){
                currentImage = originalCurImage;
                break;
            }
        }
    }
    redrawUI();
}

function setChartTab(page){
    switch(page) {
        case 1:
            $("#tab-1").show();
            $("#tab-2").hide();
            $("#tab-3").hide();
            break;
        case 2:
            $("#tab-1").hide();
            $("#tab-2").show();
            $("#tab-3").hide();
            break;
        case 3:
            $("#tab-1").hide();
            $("#tab-2").hide();
            $("#tab-3").show();
            break;
        default:
            $("#tab-1").show();
            $("#tab-2").hide();
            $("#tab-3").hide();
    }
}

$(function() {
    setChartTab(1);
});

$("#tab-1-btn").click(function(){
    console.log("tab 1");
    setChartTab(1);
})

$("#tab-2-btn").click(function(){
    setChartTab(2);
})

$("#tab-3-btn").click(function(){
    setChartTab(3);
})

$( "#next-face-image-btn" ).click(function() {
  nextImageWithFace();
});
$( "#next-image-btn" ).click(function() {
  nextImage();
});

$( "#prev-image-btn" ).click(function() {
  prevImage();
});
