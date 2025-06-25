#include "Cube.h"

#include <iostream>

#include "raygui.h"

void Cube::CreateEvent()
{
	Mistral::CameraManager::camera.target = mPosition;
	Mistral::CameraManager::camera.up = Vec3(0.f, 1.f, 0.f);
	Mistral::CameraManager::camera.fovy = 60.f;
	Mistral::CameraManager::camera.projection = CAMERA_PERSPECTIVE;
}

void Cube::UpdateEvent()
{
	auto Dir = Vec2(raylib::Keyboard::IsKeyDown(KEY_D) - raylib::Keyboard::IsKeyDown(KEY_A),
					raylib::Keyboard::IsKeyDown(KEY_S) - raylib::Keyboard::IsKeyDown(KEY_W));
	Dir.Normalize();
	mSpeed = mSpeed.Lerp(Dir * 10.f, .1f);
	mPosition.x += mSpeed.x;
	mPosition.y += mSpeed.y;
}

void Cube::RenderEvent()
{
	const auto Model = Mistral::GetModel("Cube.glb");
	DrawModel(Model, mPosition, 1.f, WHITE);
	Mistral::CameraManager::camera.position = mPosition + Vec3(cos(mRotation), 0.f, sin(mRotation)) * 20.f + Vec3(0.f, 10.f, 0.f);
	mRotation += 2.f * PI / 300.f;
}

void Cube::RenderScreenEvent()
{
	static bool showMessageBox = false;
	if (GuiButton({24, 24, 120, 30}, "#191#Show Message"))
	{
		showMessageBox = true;
	}

	if (showMessageBox)
	{
		int result = GuiMessageBox({85, 70, 250, 100}, "#191#Message Box", "Hi! This is a message!", "Nice;Cool");

		if (result >= 0)
		{
			showMessageBox = false;
		}
	}
}
