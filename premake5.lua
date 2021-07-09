-- premake5.lua
-- version: premake-5.0.0-alpha14

-- %TM_SDK_DIR% should set to the directory of The Machinery SDK

workspace "hello_world"
    configurations { "Debug", "Release" }
    language "C++"
    cppdialect "C++11"
    flags { "FatalWarnings", "MultiProcessorCompile" }
    warnings "Extra"
    inlining "Auto"
    sysincludedirs { "" }
    targetdir "bin/%{cfg.buildcfg}"

filter "system:windows"
    platforms { "Win64" }
    systemversion "latest"

filter "platforms:Win64"
    defines { "TM_OS_WINDOWS", "_CRT_SECURE_NO_WARNINGS" }
    includedirs { "%TM_SDK_DIR%/headers" }
    staticruntime "On"
    architecture "x64"
    libdirs { "%TM_SDK_DIR%/lib/" .. _ACTION .. "/%{cfg.buildcfg}" }
    disablewarnings {
        "4057", -- Slightly different base types. Converting from type with volatile to without.
        "4100", -- Unused formal parameter. I think unusued parameters are good for documentation.
        "4152", -- Conversion from function pointer to void *. Should be ok.
        "4200", -- Zero-sized array. Valid C99.
        "4201", -- Nameless struct/union. Valid C11.
        "4204", -- Non-constant aggregate initializer. Valid C99.
        "4206", -- Translation unit is empty. Might be #ifdefed out.
        "4214", -- Bool bit-fields. Valid C99.
        "4221", -- Pointers to locals in initializers. Valid C99.
        "4702", -- Unreachable code. We sometimes want return after exit() because otherwise we get an error about no return value.
    }
    linkoptions { "/ignore:4099" } -- warning LNK4099: linking object as if no debug info

filter "configurations:Debug"
    defines { "TM_CONFIGURATION_DEBUG", "DEBUG" }
    symbols "On"

filter "configurations:Release"
    defines { "TM_CONFIGURATION_RELEASE" }
    optimize "On"

project "hello_world"
    location "build/hello_world"
    targetname "hello_world"
    targetdir "bin/%{cfg.buildcfg}"
    kind "ConsoleApp"
    language "C++"
        files { "hello_world.c" }
        defines { "TM_LINKS_FOUNDATION" }
        links { "foundation" }
