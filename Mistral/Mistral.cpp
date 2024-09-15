#include "Mistral.h"

#include <iostream>

Mistral::Mistral(const std::string& applicationName, const raylib::Vector2 screenSize):
	mWindow(static_cast<int>(screenSize.x), static_cast<int>(screenSize.y), applicationName)
{
	std::cout << "Mistral init" << std::endl;
	SetTargetFPS(165);
	mPosition = screenSize / 2.f;
}

Mistral::~Mistral()
{
	std::cout << "Mistral destroy" << std::endl;
}

void Mistral::Start()
{
	while (!mWindow.ShouldClose())
	{
		UpdateEvent();

		RenderEvent();
	}
}

void Mistral::UpdateEvent()
{
	static float angle = 0;
	static float radius = mWindow.GetSize().x * .2f;

	angle += 2.f * 3.141532f / 60.f * 10.f * GetMousePosition().x / mWindow.GetSize().x;

	mPosition = mWindow.GetSize() / 2.f + raylib::Vector2(cos(angle), sin(angle)) * radius;
}

void Mistral::RenderEvent()
{
	BeginDrawing();

	ClearBackground(mClearColor);

	mPosition.DrawCircle(60.f, RED);

	DrawText(std::to_string(GetMousePosition().x / mWindow.GetSize().x).c_str(), 20, 20, 20.f, RED);

	EndDrawing();
}