# SimpleFS
A simple and performant filesystem API. The syntax is easy and consistent across all language/platform implementations.  Available for the following: Java, Android, C#, .NET Android, Python, TypeScript/JavaScript.  
Published under MIT License  

[![License: MIT](https://img.shields.io/github/license/mku11/SimpleFS.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.1-blue)](https://github.com/mku11/SimpleFS/releases)
[![GitHub Releases](https://img.shields.io/github/downloads/mku11/SimpleFS/latest/total?logo=github)](https://github.com/mku11/SimpleFS/releases)

## Features
* Abstract file system API with common file operations: create, delete, read, write, list, copy, move, etc
* Abstract Virtual drive with support for parallel batch import/export/delete/search file operations.

## Implementations
- Java (Local Read/Write)
- C# (Local Read/Write .NET 8+, no support for UWP Windows Storage, no support for IsolatedStorage)
- Android: (Supports internal and external SD cards with Android Storage Framework)
- .NET Android: (Supports internal and external SD cards with Android Storage Framework)
- Python (Local files Read/Write)
- TypeScript/JavaScript (supports node.js, browser FileSystemHandle API, and limited virtual localStorage)
- Http (Read-Only, supports Basic Auth)
- WebService (Read/Write, compatible with WebFS, supports Basic Auth)

## Example  
The API is consistent across all platforms/languages, this example is for Java.  
There is a full list of file system operations, for more details see the API documentation reference in the project web site.  

1. Get a directory:
```
// For local directory (read/write):
File dir = new File("C:\my_local_directory");

// For remote HTTP directory (read-only):  
HttpFile dir = new HttpFile("https://localhost/my_remote_directory");

// HTTP remote directory with Basic Auth (read-only):  
HttpFile dir = new HttpFile("https://localhost/my_remote_directory/",  new Credentials("user", "password"));

// Web Service remote directory, compatible with WebFS (read/write):
WSFile dir = new WSFile("/my_remote_directory", "https://localhost:8443",  new Credentials("user", "password"));
```

2. List files:
```
File[] files = dir.listFiles();
```

3. Read a file:   
```
RandomAccessStream stream = file.getInputStream();
stream.seek();
stream.read();
stream.close();
```

4. Write a file:   
```
RandomAccessStream stream = file.getOutputStream();
stream.seek();
stream.write();
stream.close();
```

5. Other operations:
```
file.getName();
file.getPath();
file.getParent();
file.exists();
file.delete();
file.isFile();
file.isDirectory();
file.copy();
file.move();
...
```

6. To import/copy a file in a directory using multiple threads you can use FileImporter:
```
FileImporter importer = new FileImporter();
importer.initialize(bufferSize, threads);
FileImportOptions options = new FileImportOptions();
options.onProgressChanged = (pos, len) -> {
	System.out.println("bytes copied: " + position);
};
IVirtualFile importFile(fileToImport, dir, options);
importer.close();
```

7. To import files in batches use FileCommander:
```
FileCommander commander = new FileCommander(new FileImporter(), new FileExporter(), new FileSearcher());
File[] importedFiles = commander.importFiles(files, dir);
commander.close();
```

8. To search for a file by filename:
```
SearchOptions options = new SearchOptions();
options.onResultFound = (file) -> {
	System.out.println("File found: " + file.getPath());
}
File[] files = searcher.search(dir, "filename.txt", options);
```
