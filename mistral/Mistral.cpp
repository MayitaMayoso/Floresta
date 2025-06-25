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
}

Mistral::Application::~Application()
{
}

void Mistral::Application::Start(std::function<void()> initFunction)
{
	SetConfigFlags(FLAG_MSAA_4X_HINT | FLAG_VSYNC_HINT | FLAG_WINDOW_RESIZABLE);
	InitWindow(static_cast<int>(mScreenSize.x), static_cast<int>(mScreenSize.y), mApplicationName.c_str());
	SetTargetFPS(165);
	rlImGuiSetup(true);

	if (initFunction)
	{
		initFunction();
	}

	while (!WindowShouldClose())
	{
		UpdateEvent();

		RenderEvent();
	}

	CloseWindow();
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

	rlImGuiBegin();

	EntitiesRenderScreenEventCallback();

	rlImGuiEnd();

	EndDrawing();
}