#include "Mistral.h"

#include <iostream>

Mistral::Mistral(const std::string& applicationName, const raylib::Vector2 screenSize):
	mWindow(static_cast<int>(screenSize.x), static_cast<int>(screenSize.y), applicationName)
{
	SetTargetFPS(165);

	for (size_t i = 0; i < 10000; i++)
	{
		mComponents.emplace_back();
		mComponents.back().SetPosition({GetRandomValue(0, 1280), GetRandomValue(0, 720), 0});
	}
}

Mistral::~Mistral()
{
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
	for (auto component : mComponents)
	{
		component.RenderEvent();
	}
}

void Mistral::RenderEvent()
{
	BeginDrawing();

	ClearBackground(mClearColor);

	for (auto component : mComponents)
	{
		component.RenderEvent();
		DrawCircle(component.GetPosition().x, component.GetPosition().y, 3, RED);
	}
	DrawCircle(GetMousePosition().x, GetMousePosition().y, 10, RED);

	EndDrawing();
}