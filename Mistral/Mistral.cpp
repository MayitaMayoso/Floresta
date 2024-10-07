#include "Mistral.h"

#include <iostream>

#include "Components/ComponentSprite.h"

Mistral::Mistral(const std::string& applicationName, const Vec2& screenSize):
	mWindow(static_cast<int>(screenSize.x), static_cast<int>(screenSize.y), applicationName)
{
	SetTargetFPS(165);
}

Mistral::~Mistral()
{
}

void Mistral::Start()
{
	Components.RegisterComponent(std::make_shared<ComponentSprite>());

	while (!mWindow.ShouldClose())
	{
		UpdateEvent();

		RenderEvent();
	}
}

void Mistral::UpdateEvent()
{
	Components.CreateEventCallback();

	Components.DestroyEventCallback();

	Components.UpdateEventCallback();
}

void Mistral::RenderEvent()
{
	BeginDrawing();

	ClearBackground(mClearColor);

	Components.RenderEventCallback();

	Components.RenderScreenEventCallback();

	EndDrawing();
}