import bb.cascades 1.2
import weather 1.0

Container {
    onCreationCompleted: {
        console.log("Attempting..")
        weatherService.requestWeatherInformation("")
    }
    attachedObjects: WeatherService {
        id: weatherService
        onDescriptionChanged: {
            console.log(description)
            
        }
        onStatusChanged: {
            console.log(succeeded)
        }
        
    }
   
}

