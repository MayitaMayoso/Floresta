#include "Mistral.h"

#define RAYGUI_IMPLEMENTATION
#include "raygui.h"

void Mistral::StartApplication(const std::string& applicationName, const Vec2& screenSize, std::function<void()> initFunction)
{
	Application app(applicationName, screenSize);
	app.Start(initFunction);
}

Mistral::Application::Application(const std::string& applicationName, const Vec2& screenSize):
	mApplicationName(applicationName),
	mScreenSize(screenSize)
{
	SetTraceLogLevel(TraceLogLevel::LOG_NONE);
	SetTargetFPS(165);
}

Mistral::Application::~Application()
{
}

void Mistral::Application::Start(std::function<void()> initFunction)
{
	raylib::Window window(static_cast<int>(mScreenSize.x), static_cast<int>(mScreenSize.y), mApplicationName);

	if (initFunction)
	{
		initFunction();
	}

	while (!window.ShouldClose())
	{
		UpdateEvent();

		RenderEvent();
	}

	window.Close();
}

void Mistral::Application::UpdateEvent()
{
	EntitiesCreateEventCallback();

	EntitiesDestroyEventCallback();

	EntitiesUpdateEventCallback();
}

void Mistral::Application::RenderEvent()
{
	BeginDrawing();

	ClearBackground(mClearColor);

	BeginMode3D(CameraManager::camera);

	EntitiesRenderEventCallback();

	EndMode3D();

	EntitiesRenderScreenEventCallback();

	EndDrawing();
}