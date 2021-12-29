//
//  LaunchItems.swift
//  aftermath
//
//
import Foundation


class LaunchItems: PersistenceModule {
    
    let saveToRawDir: URL
    
    init(saveToRawDir: URL) {
        self.saveToRawDir = saveToRawDir
    }
    
    func captureLaunchData(urlLocations: [URL], capturedLaunchFile: URL) {
        for url in urlLocations {
            let plistDict = Aftermath.getPlistAsDict(atUrl: url)
            
            // copy the plists to the persistence directory
            self.copyFileToCase(fileToCopy: url, toLocation: self.saveToRawDir)
            
            // write the plists to one file
            self.addTextToFile(atUrl: capturedLaunchFile, text: "\n----- \(url) -----\n")
            self.addTextToFile(atUrl: capturedLaunchFile, text: plistDict.description)
        }
    }
    
    override func run() {
        let launchDaemonsPath = "/Library/LaunchDaemons/"
        let launchAgentsPath = "/Library/LaunchAgents/"
        let capturedLaunchFile = self.createNewCaseFile(dirUrl: moduleDirRoot, filename: "launchItems.txt")
        let launchDaemons = FileManager.default.filesInDirRecursive(path: launchDaemonsPath)
        let launchAgents = FileManager.default.filesInDirRecursive(path: launchAgentsPath)
        
        captureLaunchData(urlLocations: launchDaemons, capturedLaunchFile: capturedLaunchFile)
        captureLaunchData(urlLocations: launchAgents, capturedLaunchFile: capturedLaunchFile)
    }
    
    // TODO
    //func pivotToBinary(binaryUrl: URL) { }
    
}