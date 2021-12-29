//
//  Swap.swift
//  aftermath
//
//

import Foundation

class Swap: MemoryModule {
    
    let swapDir: URL
    
    init(swapDir: URL) {
        self.swapDir = swapDir
    }
    
    func captureSwapFile() {
        let fm = FileManager.default
        let dir = "/private/var/vm/"
        let files = fm.filesInDirRecursive(path: dir)
        
        for file in files {
            self.copyFileToCase(fileToCopy: file, toLocation: self.swapDir)
        }
    }
    
    override func run() {
        self.log("Collecting swap files...")
        captureSwapFile()
    }
}