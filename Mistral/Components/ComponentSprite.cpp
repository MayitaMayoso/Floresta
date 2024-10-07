#include "ComponentSprite.h"

#include <iostream>

#include "Mistral.h"

void ComponentSprite::CreateEvent()
{
}

void ComponentSprite::UpdateEvent()
{
	auto Dir = Vec2(raylib::Keyboard::IsKeyDown(KEY_D) - raylib::Keyboard::IsKeyDown(KEY_A),
					raylib::Keyboard::IsKeyDown(KEY_S) - raylib::Keyboard::IsKeyDown(KEY_W));
	Dir.Normalize();
	mSpeed = mSpeed.Lerp(Dir * 10.f, .1f);
	mPosition.x += mSpeed.x;
	mPosition.y += mSpeed.y;
}

void ComponentSprite::RenderEvent()
{
	Mistral::Resources.GetResource("resources/pikachu.png").Draw(mPosition.x, mPosition.y);
}
