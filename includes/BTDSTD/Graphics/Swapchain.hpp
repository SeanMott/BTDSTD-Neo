#pragma once

//defines various swapchains

#include <BTDSTD/Graphics/GPU.hpp>

namespace BTD::Graphics
{
	//defines a swapchain create info
	struct DesktopSwapchain_CreateInfo
	{
		VkFormat swapchainImageFormat = VK_FORMAT_B8G8R8A8_SRGB;
		VkPresentModeKHR presetMode = VK_PRESENT_MODE_FIFO_KHR;
	};

	//defines a swapchain
	struct DesktopSwapchain
	{
		VkSwapchainKHR swapchain;
		VkFormat swapchainImageFormat;

		std::vector<VkImage> swapchainImages;
		std::vector<VkImageView> swapchainImageViews;
		VkExtent2D swapchainExtent;

		//creates swapchain
		inline bool Create(const GPU* gpu, const DesktopWindow* window, const DesktopSwapchain_CreateInfo* info)
		{
			//creates a swapchain
			vkb::SwapchainBuilder swapchainBuilder{ gpu->chosenGPU, gpu->device, window->surface };

			swapchainImageFormat = VK_FORMAT_B8G8R8A8_SRGB; //VK_FORMAT_B8G8R8A8_UNORM;

			vkb::Swapchain vkbSwapchain = swapchainBuilder
				//.use_default_format_selection()
				.set_desired_format(VkSurfaceFormatKHR{ .format = swapchainImageFormat, .colorSpace = VK_COLOR_SPACE_SRGB_NONLINEAR_KHR })
				//use vsync present mode
				.set_desired_present_mode(info->presetMode)
				.set_desired_extent(window->size.x, window->size.y)
				.add_image_usage_flags(VK_IMAGE_USAGE_TRANSFER_DST_BIT)
				.build()
				.value();

			if (vkbSwapchain.swapchain == VK_NULL_HANDLE)
			{
				BTD::Util::Logger::LogFatalErrorToConsole("BTDSTD", "Windows", "Swapchain", "Create", "Failed to create a swapchain");
				return false;
			}

			swapchainExtent = vkbSwapchain.extent;
			//store swapchain and its related images
			swapchain = vkbSwapchain.swapchain;
			swapchainImages = vkbSwapchain.get_images().value();
			swapchainImageViews = vkbSwapchain.get_image_views().value();

			return true;
		}

		//destroys swapchain
		inline void Destroy(const GPU* gpu)
		{
			if (swapchain == VK_NULL_HANDLE)
				return;

			vkDestroySwapchainKHR(gpu->device, swapchain, nullptr);

			// destroy swapchain resources
			for (int i = 0; i < swapchainImageViews.size(); i++)
				vkDestroyImageView(gpu->device, swapchainImageViews[i], nullptr);
		}
	};
}