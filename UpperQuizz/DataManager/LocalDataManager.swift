//
//  LocalManager.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 24/07/21.
//

import Foundation


final class LocalDataManager {
    public static func getData<T: Codable>(of type: T.Type,from jsonFile: String) -> T? {
//        Leeer el archivo local
        guard let dataJson = self.readLocalJSONFile(forName: jsonFile) else { return nil }

//        Retornar el archivo ya parseado
        guard let dataModel = self.parseModelJSON(of: T.self, from: dataJson) else { return nil }
        return dataModel
    }
    
    public static func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                return data
            }
        } catch {
            debugPrint("[-] Error Read File: \(error.localizedDescription)")
        }
        return nil
    }
    
    private static func parseModelJSON<T: Codable>(of type: T.Type, from data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData: T = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            debugPrint("[-] Error Convert File: \(error.localizedDescription)")
        }
        return nil
    }
}
