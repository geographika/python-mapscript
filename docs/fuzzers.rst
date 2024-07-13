https://github.com/MapServer/MapServer/tree/main/fuzzers
Can build the project in C:\MapServer\VS2022\build\fuzzers
# outputs to C:\MapServer\VS2022\build\fuzzers\RelWithDebInfo

Or:

cmake -DBUILD_FUZZER_REPRODUCER=ON --config RelWithDebInfo


# manually build from 
C:\MapServer\VS2022\build\fuzzers\RelWithDebInfo\mapfuzzer_reproducer.exe C:\Temp\clusterfuzz-testcase-minimized-mapfuzzer-6151191465426944

# we need to add in the folder containing the debug version of mapserver.dll
PROJ_LIB=C:\MapServer\VS2022\sdk\release-1930-x64\bin\proj9\SHARE
PATH=C:\MapServer\VS2022\build\RelWithDebInfo;C:\MapServer\VS2022\sdk\release-1930-x64\bin;%PATH%
MAPSERVER_CONFIG_FILE=C:\MapServer\apps\mapserver.conf

mapfuzzer_reproducer.exe C:\Temp\clusterfuzz-testcase-minimized-mapfuzzer-6151191465426944


Memory Leaks
------------

https://stackoverflow.com/questions/4790564/finding-memory-leaks-in-a-c-application-with-visual-studio
https://stackoverflow.com/questions/58439722/how-to-install-visual-leak-detector-vld-on-visual-studio-2019

https://github.com/KindDragon/vld/wiki/Using-Visual-Leak-Detector

Downloaded from GitHub. Updated projects. Built.

Used VS2022 updated fork: https://github.com/hongxinGuo/vld

https://github.com/KindDragon/vld/issues/85


mapfuzzer_reproducer -> View > Property Pages > VC++ Directories


From ChatGPT (!)

To include the Visual Leak Detector (VLD) library in a Visual Studio project and use `#include <vld.h>` for memory leak detection, follow these steps:

1. **Download and Install Visual Leak Detector (VLD):**
   - First, download the Visual Leak Detector library from the official website (https://vld.codeplex.com/) or from its GitHub repository (https://github.com/KindDragon/vld). Ensure you download the appropriate version for your Visual Studio and Windows architecture.

   - Install VLD by running the installer.

2. **Create or Open Your Visual Studio Project:**
   - Open your existing project in Visual Studio or create a new C++ project.

3. **Configure Project Properties:**
   - Right-click on your project in Solution Explorer and select "Properties."

4. **Configuration and Platform:**
   - Make sure you are configuring the correct build configuration (e.g., Debug) and platform (e.g., x86 or x64) for which you want to enable memory leak detection.

5. **Include VLD Headers:**
   - Under "Configuration Properties" in your project's Property Pages, expand "C/C++" and select "General."

   - In the "Additional Include Directories" field, add the path to the VLD header files, which is typically located in the installation directory. You can use the `$(VLD_INC)` macro to reference the VLD header path. For example, if you installed VLD in the default location, you can add `$(VLD_INC)`.

6. **Link to VLD Library:**
   - Still under "Configuration Properties," expand "Linker" and select "Input."

   - In the "Additional Dependencies" field, add the VLD library file specific to your platform (e.g., vld_x86.lib for 32-bit or vld_x64.lib for 64-bit). Use the `$(VLD_LIB)` macro to reference the VLD library path, like `$(VLD_LIB)\vld_x86.lib`.

7. **Specify VLD as a Preprocessor Definition:**
   - Under "Configuration Properties," expand "C/C++" and select "Preprocessor."

   - In the "Preprocessor Definitions" field, add `VLD` to enable VLD during compilation.

8. **Build and Run Your Project:**
   - Build and run your project in the configured configuration (e.g., Debug). Visual Leak Detector will intercept memory allocation and deallocation calls and check for memory leaks.

9. **Include VLD Header in Your Code:**
   - In your code, include the VLD header at the top of your source file where you want to use it:
     ```cpp
     #include <vld.h>
     ```

10. **Run Your Code:**
    - Now, when you run your application in Debug mode, VLD will monitor memory allocation and report any memory leaks in the Visual Studio Output window.

Remember that VLD is intended for debugging purposes and should not be used in production code. It's a valuable tool for identifying memory leaks during development and testing.