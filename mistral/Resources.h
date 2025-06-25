#pragma once

#include <filesystem>

#include "Mistral.h"

namespace Mistral
{
	union Resource
	{
		Texture texture;
		Sound sound;
		Model model;
		Font font;
	};

	bool ResourceLoad(const std::filesystem::path& path);

	bool ResourceUnload(const std::filesystem::path& path);

	Resource& ResourceGet(const std::filesystem::path& path);

	Texture& GetTexture(const std::filesystem::path& path);

	Sound& GetSound(const std::filesystem::path& path);

	Model& GetModel(const std::filesystem::path& path);

	Font& GetFont(const std::filesystem::path& path);
}