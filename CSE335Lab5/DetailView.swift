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
   // var location:CLLocation
    
    private static let defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
    @State private var region = MKCoordinateRegion(
        center: defaultLocation,
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    
    @State private var markers = [
        Location(name: "cityName", coordinate: defaultLocation)
    ]
    
    
    @State var location: CLLocationCoordinate2D?

    
    
    var body: some View {
        ZStack(alignment: .bottom)
        {
            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: markers) {
                location in MapAnnotation(coordinate: location.coordinate)
                {
                    Text("\(cityName)")
                    Text(String(location.coordinate.latitude) + "," + String(location.coordinate.longitude))
                }
                
            }
        }            .onAppear{self.getLocation(from: cityName)
            {coordinates in
                print(coordinates)
                self.location = coordinates}
            
        }
        
    

    }
    
    func getLocation(from address: String, completion: @escaping (_ location:CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder();
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in guard let placemarks = placemarks,
            
            let location = placemarks.first?.location?.coordinate
            else {
                completion(nil);
                return
            }

                    region.center = location
            markers[0] = Location(name: cityName, coordinate: location);


        }
    }
    
    
    
    
    
    
    
    
    
    /*struct DetailView_Previews: PreviewProvider {
     static var previews: some View {
     DetailView(picture:"Hi", name:"Hi", description:"A")
     }
     }*/
}
