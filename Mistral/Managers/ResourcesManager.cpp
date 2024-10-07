#include "ResourcesManager.h"

#include <iostream>

#include "raylib-cpp.hpp"

bool ResourcesManager::LoadResource(const std::filesystem::path& Path)
{
	raylib::Texture NewResource(Path.string());

	if (!NewResource.IsReady())
	{
		std::cout << "Could not load the resource: " << Path.filename() << std::endl;
		return false;
	}

	mResources.try_emplace(Path, Path.string());
	return true;
}

bool ResourcesManager::UnloadResource(const std::filesystem::path& Path)
{
	mResources.erase(Path);
	return true;
}

const raylib::Texture& ResourcesManager::GetResource(const std::filesystem::path& Path)
{
	if (mResources.find(Path) == mResources.cend())
	{
		bool Status = LoadResource(Path);

		if (!Status)
		{
			std::cout << "Could not get the resource: " << Path.filename() << std::endl;
		}
	}

	return mResources.at(Path);
}