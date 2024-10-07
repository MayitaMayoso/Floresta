#ifndef MISTRAL_H
#define MISTRAL_H

#include "Managers/ComponentsManager.h"
#include "Managers/InputManager.h"
#include "Managers/ResourcesManager.h"
#include "raylib-cpp.hpp"

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

	// Management
	static inline ComponentsManager Components;
	static inline ResourcesManager Resources;
	static inline InputManager Input;

  private:

	void UpdateEvent();

	void RenderEvent();

	// Rendering
	raylib::Window mWindow;
	Color mClearColor = RAYWHITE;
};

#endif // MISTRAL_H