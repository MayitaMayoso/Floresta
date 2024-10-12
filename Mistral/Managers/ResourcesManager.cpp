#include "ResourcesManager.h"

#include <iostream>

#include "raylib-cpp.hpp"
#include "Resources/ResourceTexture.h"

bool ResourcesManager::Load(const std::filesystem::path& Path)
{
	bool Ready = false;

	if (Path.extension() == ".jpg" || Path.extension() == ".png")
	{
		auto Texture = std::make_shared<ResourceTexture>(Path);
		if (Texture->Get().IsReady())
		{
			mResources.try_emplace(Path, Texture);
			Ready = true;
		}
	}

	if (!Ready)
	{
		std::cout << "Could not load the resource: " << Path.filename() << std::endl;
		return false;
	}

	return true;
}

bool ResourcesManager::Unload(const std::filesystem::path& Path)
{
	mResources.erase(Path);
	return true;
}

std::shared_ptr<Resource> ResourcesManager::Get(const std::filesystem::path& Path)
{
	if (mResources.find(Path) == mResources.cend())
	{
		bool Status = Load(Path);

		if (!Status)
		{
			std::cout << "Could not get the resource: " << Path.filename() << std::endl;
		}
	}

	return mResources.at(Path);
}