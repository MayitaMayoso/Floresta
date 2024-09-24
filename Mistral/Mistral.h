#ifndef MISTRAL_H
#define MISTRAL_H

#include <raylib-cpp.hpp>

#include "Component.h"

class Mistral
{
  public:

	Mistral(const std::string& applicationName, raylib::Vector2 screenSize);

	~Mistral();

	void Start();

  private:

	void UpdateEvent();

	void RenderEvent();

	raylib::Window mWindow;
	Color mClearColor = RAYWHITE;
	std::vector<Component> mComponents;
};

#endif // MISTRAL_H