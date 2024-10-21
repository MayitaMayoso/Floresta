#include "Mistral.h"

#include "Components/ComponentSprite.h"
#include "Managers/ComponentsManager.h"

void Mistral::StartApplication(const std::string& applicationName, const Vec2& screenSize)
{
	Application app("test", Vec2(1920.f, 1080.f));
	app.Start();
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

void Mistral::Application::Start()
{
	raylib::Window window(static_cast<int>(mScreenSize.x), static_cast<int>(mScreenSize.y), mApplicationName);

	Components::Create(std::make_shared<ComponentSprite>());

	while (!window.ShouldClose())
	{
		UpdateEvent();

		RenderEvent();
	}

	window.Close();
}

void Mistral::Application::UpdateEvent()
{
	Components::CreateEventCallback();

	Components::DestroyEventCallback();

	Components::UpdateEventCallback();
}

void Mistral::Application::RenderEvent()
{
	BeginDrawing();

	ClearBackground(mClearColor);

	Components::RenderEventCallback();

	Components::RenderScreenEventCallback();

	EndDrawing();
}