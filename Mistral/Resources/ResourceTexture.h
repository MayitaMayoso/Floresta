#ifndef RESOURCE_TEXTURE_H
#define RESOURCE_TEXTURE_H

#include <filesystem>
#include <memory>

#include "raylib-cpp.hpp"
#include "Resources/Resource.h"

class ResourceTexture : public Resource
{
  public:

	ResourceTexture(const std::filesystem::path& Path);
	~ResourceTexture();

	bool Load() override;

	bool Unload() override;

	const raylib::Texture& Get();

  private:

	raylib::Texture mData;
};

#endif // RESOURCE_TEXTURE_H