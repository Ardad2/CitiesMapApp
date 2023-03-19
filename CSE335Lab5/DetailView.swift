//
//  DetailView.swift
//  CSE335Lab5
//
//  Created by Arjun Dadhwal on 3/10/23.
//

import Foundation

import CoreLocation
import MapKit

import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}


struct DetailView: View {
    
    
    
    var picture:String
    var cityName:String
    var description:String
    
    @State private static var defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
    
    // state property that represents the current map region
    @State private var region = MKCoordinateRegion(
        center: defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    // state property that stores marker locations in current map region
    @State private var markers = [
        Location(name: "", coordinate: defaultLocation)
    ]
    
    
    var body: some View {
        NavigationView(){
            
            Map(coordinateRegion: $region,
                interactionModes: .all,
                annotationItems: markers
            ){ location in
                MapAnnotation(coordinate: location.coordinate){
                    Text(cityName).font(.system(size: 36))
                }
                
                
            }
            
            Button{
                forwardGeocoding(addressStr: cityName)
                
            }label: {
                Text("Get Location Information")
            }
            
            
        }.onAppear{self.forwardGeocoding(addressStr: self.cityName)}
    }
    
    func forwardGeocoding(addressStr: String)
    {
        let geoCoder = CLGeocoder();
        let addressString = addressStr
        
        var longitude = 0.0;



        CLGeocoder().geocodeAddressString(addressString, completionHandler:
                                            {(placemarks, error) in
            
            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                
                
                print(coords.latitude)
                print(coords.longitude)
                
                longitude = coords.longitude
                
                
                
                
                DispatchQueue.main.async
                {
                    region.center = coords
                    markers[0].name = placemark.locality!
                    markers[0].coordinate = coords
                }
                
                
                
                
                
                
                
            }
        })
            }
    
    
    
    
    /*struct DetailView_Previews: PreviewProvider {
     static var previews: some View {
     DetailView(picture:"Hi", name:"Hi", description:"A")
     }
     }*/
}
