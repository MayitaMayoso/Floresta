#pragma once

#include "Mistral.h"

class Cube : public Mistral::Entity
{
public:

	void CreateEvent() override;

	void UpdateEvent() override;

	void RenderEvent() override;

	void RenderScreenEvent() override;

private:

	Vec2 mSpeed;
	float mRotation = 0.f;
};