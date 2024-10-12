#include "Mistral.h"

#include <iostream>

#include "Components/ComponentSprite.h"

Mistral::Mistral(const std::string& applicationName, const Vec2& screenSize):
	mApplicationName(applicationName),
	mScreenSize(screenSize)
{
	SetTraceLogLevel(TraceLogLevel::LOG_NONE);
	SetTargetFPS(165);
}

Mistral::~Mistral()
{
}

void Mistral::Start()
{
	raylib::Window window(static_cast<int>(mScreenSize.x), static_cast<int>(mScreenSize.y), mApplicationName);

	Components.Create(std::make_shared<ComponentSprite>());

	while (!window.ShouldClose())
	{
		UpdateEvent();

		RenderEvent();
	}

	window.Close();
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