configurations
    {
        "Debug",
        "Release",
        "Dist" --,

        --"Desktop_Debug",
        --"Desktop_Release",
        --"Desktop_Dist",

        --"Android_Debug",
        --"Android_Release",
        --"Android_Dist",

        --"IOS_Debug",
        --"IOS_Release",
        --"IOS_Dist",
    }

    outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}-%{cfg.startproject}"


include "Libraries\\yaml-cpp"
include "Libraries\\glfw"

    project "BTDSTD"
    kind "StaticLib"
    language "C++"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-obj/" .. outputdir .. "/%{prj.name}")
    
    
    files 
    {
        "includes/**.h",
        "src/**.c",
        "includes/**.hpp",
        "src/**.cpp",

        --ImGUI file includes
        "Libraries\\imgui/imgui.h",
        "Libraries\\imgui/imgui.cpp",
        "Libraries\\imgui/imgui_demo.cpp",
        "Libraries\\imgui/imgui_draw.cpp",
        "Libraries\\imgui/imgui_widgets.cpp",
        "Libraries\\imgui/imgui_tables.cpp",
        "Libraries\\imgui/backends/imgui_impl_vulkan.h",
        "Libraries\\imgui/backends/imgui_impl_vulkan.cpp",
        "Libraries\\imgui/backends/imgui_impl_glfw.h",
        "Libraries\\imgui/backends/imgui_impl_glfw.cpp",
    }

    includedirs
    {
        "includes",
        
        "Libraries\\yaml-cpp\\include",
        "Libraries\\glm",
        "Libraries\\glfw\\include",
        "C:\\GameDev\\BTDSTD\\Libraries\\assimp\\include",
        "C:\\GameDev\\BTDSTD\\Libraries\\assimp\\Build\\include",
        "Libraries\\VulkanMemoryAllocator\\include",
        "Libraries\\imgui",
        "Libraries\\imgui/backends",

        "C:\\VulkanSDK\\1.3.275.0\\Include",

       -- "Libraries\\Steam-public"
    }
    
    links
    {
        "yaml-cpp",
        "GLFW",
        "C:\\VulkanSDK\\1.3.275.0\\Lib\\vulkan-1.lib",
        --"Libraries\\Assimp\\assimp-vc143-mt.lib"
       -- "Libraries\\redistributable_bin\\win64\\steam_api64.lib"
    }
    
    defines
    {
        "GLFW_INCLUDE_NONE",
        "GLM_FORCE_RADIANS",
        "GLM_FORCE_DEPTH_ZERO_TO_ONE",
        "GLM_ENABLE_EXPERIMENTAL"
    }
    
    flags
    {
        "NoRuntimeChecks",
        "MultiProcessorCompile"
    }
    
    --platforms
    filter "system:windows"
        cppdialect "C++20"
      --  cdialect "C99"
        staticruntime "On"
        systemversion "latest"
    
        defines
        {
            "Window_Build",
            "Desktop_Build"
        }
    
    --configs
    filter "configurations:Debug"
        defines "BTD_DEBUG"
        symbols "On"
    
        links
        {
           "C:\\GameDev\\BTDSTD\\Libraries\\assimp\\Build\\lib\\RelWithDebInfo\\assimp-vc143-mt.lib",
           "C:\\GameDev\\BTDSTD\\Libraries\\assimp\\Build\\lib\\RelWithDebInfo\\draco.lib",
        }
    
    filter "configurations:Release"
        defines "BTD_RELEASE"
        optimize "On"
    
        flags
        {
            
        }

        links
        {
            "C:\\GameDev\\BTDSTD\\Libraries\\assimp\\Build\\lib\\RelWithDebInfo\\assimp-vc143-mt.lib",
            "C:\\GameDev\\BTDSTD\\Libraries\\assimp\\Build\\lib\\RelWithDebInfo\\draco.lib",
        }
    
    filter "configurations:Dist"
        defines "BTD_DIST"
        optimize "On"
    
        defines
        {
            "NDEBUG"
        }
    
        flags
        {
           
        }
    
        links
        {
            "C:\\GameDev\\BTDSTD\\Libraries\\assimp\\Build\\lib\\Release\\assimp-vc143-mt.lib",
            "C:\\GameDev\\BTDSTD\\Libraries\\assimp\\Build\\lib\\Release\\draco.lib",
        }