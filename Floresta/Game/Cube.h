#pragma once

#include "Components/Component.h"

class Cube : public Mistral::Component
{
public:

	void CreateEvent();

	void UpdateEvent();

	void RenderEvent();

private:

	Vec2 mSpeed;
	float mRotation = 0.f;
};