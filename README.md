## Spine for cocos2d-x

- This is NOT the official spine standalone project. Official website
  is [here](https://github.com/EsotericSoftware/spine-runtimes/tree/master/spine-cocos2dx/3)
- the version of spine is 1.1

## Prerequisite

You must setup ANDROID_NDK environment in your ~/.bashrc file to point to your NDK directory.

##Build

###Build for Android
```cpp
./build_android.sh
```

###Build for iOS and Mac
```cpp
./build_iosmac.sh
```


##Build for Linux
```cpp
./build_linux.sh
```

##Build for Windows, WP8 and WinRT
1. Generate VS project file from CMakeLists.txt

2. Compile the static library.
