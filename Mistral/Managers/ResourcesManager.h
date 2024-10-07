#ifndef RESOURCES_MANAGER_H
#define RESOURCES_MANAGER_H

#include <filesystem>
#include <map>

#include "raylib-cpp.hpp"

class ResourcesManager
{
  public:

	bool LoadResource(const std::filesystem::path& Path);

	bool UnloadResource(const std::filesystem::path& Path);

	const raylib::Texture& GetResource(const std::filesystem::path& Path);

  private:

	std::map<std::filesystem::path, raylib::Texture> mResources;
};

#endif // RESOURCES_MANAGER_H