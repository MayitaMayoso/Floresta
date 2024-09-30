#ifndef MISTRAL_H
#define MISTRAL_H

#include <raylib-cpp.hpp>

#include "Managers/ComponentsManager.h"
#include "Managers/InputManager.h"
#include "Managers/ResourcesManager.h"

using Vec2 = raylib::Vector2;
using Vec3 = raylib::Vector3;
using Vec4 = raylib::Vector4;
using Mat = raylib::Matrix;
using Quat = raylib::Quaternion;

class Mistral
{
  public:

	Mistral(const std::string& applicationName, const Vec2& screenSize);

	~Mistral();

	void Start();

  private:

	void UpdateEvent();

	void RenderEvent();

	// Rendering
	raylib::Window mWindow;
	Color mClearColor = RAYWHITE;

	// Management
	ComponentsManager mComponentManager;
	ResourcesManager mResourcesManager;
	InputManager mInputManager;
};

#endif // MISTRAL_H