#ifndef RESOURCES_MANAGER_H
#define RESOURCES_MANAGER_H

#include <filesystem>
#include <iostream>
#include <map>

#include "raylib-cpp.hpp"
#include "Resources/Resource.h"

class ResourcesManager
{
  public:

	bool Load(const std::filesystem::path& Path);

	bool Unload(const std::filesystem::path& Path);

	std::shared_ptr<Resource> Get(const std::filesystem::path& Path);

	template <typename Type>
	std::shared_ptr<Type> Get(const std::filesystem::path& Path)
	{
		if (mResources.find(Path) == mResources.cend())
		{
			bool Status = Load(Path);

			if (!Status)
			{
				std::cout << "Could not get the resource: " << Path.filename() << std::endl;
			}
		}

		return std::static_pointer_cast<Type>(mResources.at(Path));
	}

  private:

	std::map<std::filesystem::path, std::shared_ptr<Resource>, std::less<>> mResources;
};

#endif // RESOURCES_MANAGER_H