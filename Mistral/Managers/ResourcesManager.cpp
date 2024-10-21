#include "ResourcesManager.h"

static std::map<std::filesystem::path, Mistral::Resources::Type, std::less<>> mResources;

static bool FileIsSupported(const std::filesystem::path& path, const std::vector<std::string>& extensions)
{
	for (const auto& extension : extensions)
	{
		if (path.extension() == extension)
		{
			return true;
		}
	}

	return false;
}

bool Mistral::Resources::Load(const std::filesystem::path& path)
{
	auto fullPath = ("resources" / path).string().c_str();

	if (!std::filesystem::exists(fullPath))
	{
		return false;
	}

	Type resource;
	if (FileIsSupported(path, {".png", ".bmp", ".tga", ".jpg", ".gif", ".qoi", ".psd", ".dds", ".hdr", ".ktx", ".astc", ".pkm", ".pvr"}))
	{
		resource.texture = LoadTexture(fullPath);
	}
	else if (FileIsSupported(path, {".wav", ".ogg", ".mp3", ".flac", ".xm", ".mod", ".qoa"}))
	{
		resource.sound = LoadSound(fullPath);
	}
	else if (FileIsSupported(path, {".obj", ".iqm", ".gltf", ".vox", ".m3d"}))
	{
		resource.model = LoadModel(fullPath);
	}
	else if (FileIsSupported(path, {".ttf", ".otf"}))
	{
		resource.font = LoadFont(fullPath);
	}
	mResources.emplace(path, resource);

	return true;
}

bool Mistral::Resources::Unload(const std::filesystem::path& path)
{
	mResources.erase(path);
	return true;
}

Mistral::Resources::Type& Mistral::Resources::Get(const std::filesystem::path& path)
{
	if (mResources.find(path) == mResources.cend())
	{
		if (!Load(path))
		{
			std::cout << "Could not get the resource: " << path.filename() << std::endl;
			// TODO error handling of unexistent resources
		}
	}

	return mResources.at(path);
}

Texture& Mistral::Resources::GetTexture(const std::filesystem::path& path)
{
	return Get(path).texture;
}

Sound& Mistral::Resources::GetSound(const std::filesystem::path& path)
{
	return Get(path).sound;
}

Model& Mistral::Resources::GetModel(const std::filesystem::path& path)
{
	return Get(path).model;
}

Font& Mistral::Resources::GetFont(const std::filesystem::path& path)
{
	return Get(path).font;
}
