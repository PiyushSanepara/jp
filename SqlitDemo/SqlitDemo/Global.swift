//
//  Global.swift
//  SqlitDemo
//
//  Created by Ratnakala53 on 1/21/16.
//  Copyright © 2016 ratnakala. All rights reserved.
//

import Foundation

class GLobal
{
    class func CreatConnection() -> FMDatabase
    {
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as NSString
        
        let databasePath = docsDir.stringByAppendingPathComponent("/CC.db")
        print(databasePath)
        if filemgr.fileExistsAtPath(databasePath as String) {
            
            let contactDB = FMDatabase(path: databasePath as String)
            
            if contactDB == nil {
                print("Error: \(contactDB.lastErrorMessage())")
            }
            
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
                if !contactDB.executeStatements(sql_stmt) {
                    print("Error: \(contactDB.lastErrorMessage())")
                }else
                {
                    return contactDB
                }
                contactDB.close()
            } else {
                print("Error: \(contactDB.lastErrorMessage())")
            }
        }else
        {
            return FMDatabase(path: databasePath as String)
        }
        
        return FMDatabase()
    }
    
    
    class func insert(nm:String,address:String,city:String)
    {
        let db = GLobal.CreatConnection()
        if db.open()
        {
            let sql = "INSERT INTO CONTACTS (name, address, phone) VALUES ('\(nm)', '\(address)', '\(city)')"
            do{
                let result = try db.executeUpdate(sql, values: nil)
                if Bool(result)
                {
                    
                }
                
            }catch
            {
                print(error)
            }
            
        }else{
            
        }
    }
    
    
    class func selectAll()
    {
        let db = GLobal.CreatConnection()
        if db.open()
        {
            let sql = "SELECT * FROM CONTACTS"
            do{
                let result : FMResultSet = try db.executeQuery(sql, values: nil)
                while(result.next())
                {
                    result.stringForColumn("NAME")
                    print(result.stringForColumn("NAME") + " ---- " + result.stringForColumn("PHONE"))
                }
            }catch
            {
                print(error)
            }
            
        }else{
            
        }
    }
    
}