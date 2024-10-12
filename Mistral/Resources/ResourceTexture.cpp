#include "ResourceTexture.h"

#include <iostream>

ResourceTexture::ResourceTexture(const std::filesystem::path& Path)
{
	SetPath(Path);
	Load();
}

ResourceTexture::~ResourceTexture()
{
	Unload();
}

bool ResourceTexture::Load()
{
	mData.Load(GetPath().string());

	if (!mData.IsReady())
	{
		std::cout << "Could not load the resource: " << GetPath().filename() << std::endl;
		return false;
	}

	return true;
}

bool ResourceTexture::Unload()
{
	mData.Unload();
	return true;
}

const raylib::Texture& ResourceTexture::Get()
{
	return mData;
}
