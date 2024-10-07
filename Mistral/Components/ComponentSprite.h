#ifndef COMPONENT_SPRITE_H
#define COMPONENT_SPRITE_H

#include "Component.h"
#include "Mistral.h"

class ComponentSprite : public Component
{
  public:

	void CreateEvent();

	void UpdateEvent();

	void RenderEvent();

  private:

	Vec2 mSpeed;
};

#endif