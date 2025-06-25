#pragma once

#include <functional>

#include "raylib-cpp.hpp"
#include "imgui.h"
#include "rlImGui.h"

using Vec2 = raylib::Vector2;
using Vec3 = raylib::Vector3;
using Vec4 = raylib::Vector4;
using Mat = raylib::Matrix;
using Quat = raylib::Quaternion;

#include "Camera.h"
#include "Entity.h"
#include "Random.h"
#include "Resources.h"

namespace Mistral
{
	void StartApplication(const std::string& applicationName, const Vec2& screenSize, std::function<void()> initFunction = nullptr);

	class Application
	{
	  public:

		Application(const std::string& applicationName, const Vec2& screenSize);

		~Application();

		void Start(std::function<void()> initFunction = nullptr);

	  private:

		void UpdateEvent();

		void RenderEvent();

		// Rendering
		std::string mApplicationName;
		Vec2 mScreenSize;
		Color mClearColor = RAYWHITE;
	}; // class Application
} // namespace Mistral