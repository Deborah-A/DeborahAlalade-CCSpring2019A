var url = "https://api.openweathermap.org/data/2.5/weather?q=Brooklyn&appid=eb77ac510d148e179ca79a30fe494dd5"

var result; //a container for our results

var loaded = false; //boolean to make sure that we have our data before we do anything


function preload(){
    //use httpGet to query openWeather
    result = httpGet(url, 'json', false, function(response){
        result = response.list;
        console.log(result);
        //set loaded to true
        loaded = true;
    });

}

function setup() {
    createCanvas(800, 800)

    console.log(result);
}

function draw() {
    sky(result);
}


function sky(result) {
    background(135, 206, 250);
    fill(250, 218, 94);

    circle(width / 2, height / 2, result.main.temp);

}