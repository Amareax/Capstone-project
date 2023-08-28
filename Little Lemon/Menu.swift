//
//  Menu.swift
//  Little Lemon
//
//  Created by YOLISA MAGIBILE on 2023/08/27.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            Text("Little Lemon")
                .font(.title)
            Text("Chicago")
            Text("This is Little Lemon's Application")
            
            FetchedObjects { (dishes: [Dish]) in
                        List {
                            ForEach(dishes) { dish in
                                HStack {
                                    Text("\(dish.title) - $\(dish.price)")
                                    AsyncImage(url: URL(string: (dish.image ?? <#default value#>)!)) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        } else if phase.error != nil {
                                            // Handle error case
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        } else {
                                            // Placeholder while loading
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: 50, height: 50)
                                }
                            }
                        }
                    }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let serverURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        guard let url = URL(string: serverURLString) else {
                   print("Invalid URL")
                   return
               }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    if let menuList = try? decoder.decode(MenuList.self, from: data) {
                        for menuItem in menuList.menu {
                            let dish = Dish(context: viewContext)
                            dish.title = menuItem.title
                        }
                        try? viewContext.save() // Save the data to the database
                    } else {
                        print("Failed to decode menu data")
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                            }
                        }
                    }
                    
        task.resume()
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
