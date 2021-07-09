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

project "hello_world"
    location "build/symbols"
    targetname "hello_world"
    kind "ConsoleApp"
    language "C++"
        files { "hello_world.c" }
        defines { "TM_LINKS_FOUNDATION" }
        links { "foundation" }
