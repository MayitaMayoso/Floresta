#pragma once

#include <filesystem>
#include <iostream>
#include <map>

#include "Mistral.h"
#include "raylib-cpp.hpp"

namespace Mistral::Resources
{
	union Type
	{
		Texture texture;
		Sound sound;
		Model model;
		Font font;
	};

	bool Load(const std::filesystem::path& path);

	bool Unload(const std::filesystem::path& path);

	Type& Get(const std::filesystem::path& path);

	Texture& GetTexture(const std::filesystem::path& path);

	Sound& GetSound(const std::filesystem::path& path);

	Model& GetModel(const std::filesystem::path& path);

	Font& GetFont(const std::filesystem::path& path);
}