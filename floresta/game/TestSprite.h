#pragma once

#include "Mistral.h"

class TestSprite final : public Mistral::Entity
{
  public:

	void CreateEvent() override;

	void UpdateEvent() override;

	void RenderEvent() override;

  private:

	Vec2 mSpeed;
};