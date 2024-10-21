#pragma once

#include <map>
#include <memory>

#include "Components/Component.h"

namespace Mistral::Components
{
	// Components management
	void Create(std::shared_ptr<Component> component);

	void Destroy(std::shared_ptr<const Component> component);

	void Destroy(const std::string& componentId);

	// Event callbacks
	void CreateEventCallback();

	void DestroyEventCallback();

	void UpdateEventCallback();

	void FixedUpdateEventCallback();

	void RenderEventCallback();

	void RenderScreenEventCallback();
};