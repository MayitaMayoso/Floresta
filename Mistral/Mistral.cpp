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
	mComponentManager.RegisterComponent(std::make_shared<ComponentSprite>());

	while (!mWindow.ShouldClose())
	{
		UpdateEvent();

		RenderEvent();
	}
}

void Mistral::UpdateEvent()
{
	mComponentManager.CreateEventCallback();

	mComponentManager.DestroyEventCallback();

	mComponentManager.UpdateEventCallback();
}

void Mistral::RenderEvent()
{
	BeginDrawing();

	ClearBackground(mClearColor);

	mComponentManager.RenderEventCallback();

	mComponentManager.RenderScreenEventCallback();

	EndDrawing();
}