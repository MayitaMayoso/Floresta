#ifndef MISTRAL_H
#define MISTRAL_H

#include "raylib-cpp.hpp"

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
	raylib::Vector2 mPosition;
};

#endif // MISTRAL_H