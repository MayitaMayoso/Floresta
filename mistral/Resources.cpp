#include <filesystem>
#include <iostream>
#include <map>

#include "Resources.h"

static std::map<std::filesystem::path, Mistral::Resource, std::less<>> mResources;

static bool FileIsSupported(const std::filesystem::path& path, const std::vector<std::string>& extensions)
{
	return std::any_of(extensions.cbegin(), extensions.cend(), [path](const std::string& extension) { return path.extension() == extension; });
}

bool Mistral::ResourceLoad(const std::filesystem::path& path)
{
	const auto fullPath = ("resources" / path).string();

	if (!std::filesystem::exists(fullPath))
	{
		return false;
	}

	Resource resource;
	if (FileIsSupported(path, {".png", ".bmp", ".tga", ".jpg", ".gif", ".qoi", ".psd", ".dds", ".hdr", ".ktx", ".astc", ".pkm", ".pvr"}))
	{
		resource.texture = LoadTexture(fullPath.c_str());
	}
	else if (FileIsSupported(path, {".wav", ".ogg", ".mp3", ".flac", ".xm", ".mod", ".qoa"}))
	{
		resource.sound = LoadSound(fullPath.c_str());
	}
	else if (FileIsSupported(path, {".obj", ".iqm", ".gltf", ".vox", ".m3d", ".glb"}))
	{
		resource.model = LoadModel(fullPath.c_str());
	}
	else if (FileIsSupported(path, {".ttf", ".otf"}))
	{
		resource.font = LoadFont(fullPath.c_str());
	}
	mResources.emplace(path, resource);

	return true;
}

bool Mistral::ResourceUnload(const std::filesystem::path& path)
{
	mResources.erase(path);
	return true;
}

Mistral::Resource& Mistral::ResourceGet(const std::filesystem::path& path)
{
	if (mResources.find(path) == mResources.cend())
	{
		if (!ResourceLoad(path))
		{
			std::cout << "Could not get the resource: " << path.filename() << std::endl;
			// TODO error handling of unexistent resources
		}
	}

	return mResources.at(path);
}

Texture& Mistral::GetTexture(const std::filesystem::path& path)
{
	return ResourceGet(path).texture;
}

Sound& Mistral::GetSound(const std::filesystem::path& path)
{
	return ResourceGet(path).sound;
}

Model& Mistral::GetModel(const std::filesystem::path& path)
{
	return ResourceGet(path).model;
}

Font& Mistral::GetFont(const std::filesystem::path& path)
{
	return ResourceGet(path).font;
}
