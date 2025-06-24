#include <iostream>

#include "Managers/ResourcesManager.h"
#include "Mistral.h"
#include "TestSprite.h"

void TestSprite::CreateEvent()
{
}

void TestSprite::UpdateEvent()
{
	auto Dir = Vec2(raylib::Keyboard::IsKeyDown(KEY_D) - raylib::Keyboard::IsKeyDown(KEY_A),
					raylib::Keyboard::IsKeyDown(KEY_S) - raylib::Keyboard::IsKeyDown(KEY_W));
	Dir.Normalize();
	mSpeed = mSpeed.Lerp(Dir * 10.f, .1f);
	mPosition.x += mSpeed.x;
	mPosition.y += mSpeed.y;
}

void TestSprite::RenderEvent()
{
	auto Sprite = Mistral::Resources::GetTexture("pikachu.png");
	DrawTexture(Sprite, mPosition.x, mPosition.y, WHITE);
}
