//
//  WorkWithJSON.swift
//
//  Created by Igor Malyarov on 27.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//
//  Methods to handle JSON data

import Foundation

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T? {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        print("Couldn't find \(filename) in main bundle.")
        return nil
        //        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        print("Couldn't load \(filename) from main bundle:\n\(error)")
        return nil
        //        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Couldn't parse \(filename) as \(T.self):\n\(error)")
        return nil
        //        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func loadFromDocDir<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T? {
    let data: Data
    
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let file = dir.appendingPathComponent(filename)
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            print("Couldn't load \(filename) from main bundle:\n\(error)")
            return nil
            //        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Couldn't parse \(filename) as \(T.self):\n\(error)")
            return nil
            //        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }    }
    else {
        print("error getting Document Directory")
        return nil
        //        fatalError("Couldn't find \(filename) in User Document Directory.")
    }
}

func saveJSON<T: Codable>(data: T, filename: String) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    let jsonData: Data
    do {
        jsonData = try encoder.encode(data)
    }
    catch {
        return
    }
    
    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
        print("error creating JSON string from data")
        return
    }
        
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(filename)
        
//        print("dir:     \(dir)")
        print("fileURL: \(fileURL)")
        
        do{
            try jsonString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        }
        catch {
            return
        }
    }
    else { print("error getting Document Directory") }
}
