#pragma once

#include "Components/Component.h"

class TestSprite : public Mistral::Component
{
  public:

	void CreateEvent();

	void UpdateEvent();

	void RenderEvent();

  private:

	Vec2 mSpeed;
};