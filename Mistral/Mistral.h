#pragma once

#include "raylib-cpp.hpp"

using Vec2 = raylib::Vector2;
using Vec3 = raylib::Vector3;
using Vec4 = raylib::Vector4;
using Mat = raylib::Matrix;
using Quat = raylib::Quaternion;

namespace Mistral
{
	void StartApplication(const std::string& applicationName, const Vec2& screenSize);

	class Application
	{
	  public:

		Application(const std::string& applicationName, const Vec2& screenSize);

		~Application();

		void Start();

	  private:

		void UpdateEvent();

		void RenderEvent();

		// Rendering
		std::string mApplicationName;
		Vec2 mScreenSize;
		Color mClearColor = RAYWHITE;
	}; // class Application
} // namespace Mistral