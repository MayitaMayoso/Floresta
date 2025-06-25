#pragma once

#include "Mistral.h"

class Vendaval final : public Mistral::Entity
{
  public:

	void CreateEvent() override;

	void UpdateEvent() override;

	void RenderEvent() override;

	void RenderScreenEvent() override;
};