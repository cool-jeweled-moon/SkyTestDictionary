//
//  SoundLoader.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 24.09.2020.
//

import Foundation

protocol SoundLoadable {
    func downloadSoundIfNeeded(withLink link: String,
                               completion: @escaping (_ soundPath: URL?) -> Void)
    func downloadSound(withUrl url: URL,
                       andFilePath filePath: URL,
                       completion: @escaping (_ soundPath: URL?) -> Void)
}

class SoundLoader: SoundLoadable {
    
    let fileManager = FileManager.default
    
    func downloadSoundIfNeeded(withLink link: String, completion: @escaping (_ soundPath: URL?) -> Void) {
        guard let urlString = link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
              let url = URL(string: urlString),
              let documentDirectory = try? fileManager.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: false)
        else { return }

        let filePath = documentDirectory.appendingPathComponent("\(url.hashValue)", isDirectory: false)

        if (try? filePath.checkResourceIsReachable()) ?? false {
            completion(filePath)
        } else {
            downloadSound(withUrl: url, andFilePath: filePath, completion: completion)
        }
    }
    
    func downloadSound(withUrl url: URL, andFilePath filePath: URL, completion: @escaping (_ soundPath: URL?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data.init(contentsOf: url)
                try data.write(to: filePath, options: .atomic)
                print("saved at \(filePath.absoluteString)")
                completion(filePath)
            } catch {
                completion(nil)
            }
        }
    }
}
