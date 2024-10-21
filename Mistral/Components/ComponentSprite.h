#pragma once

#include "Component.h"
#include "Mistral.h"

class ComponentSprite : public Mistral::Component
{
  public:

	void CreateEvent();

	void UpdateEvent();

	void RenderEvent();

  private:

	Vec2 mSpeed;
};