#ifndef COMPONENTS_MANAGER_H
#define COMPONENTS_MANAGER_H

#include <map>
#include <memory>

#include "Components/Component.h"

class ComponentsManager
{
  public:

	// Components management
	void RegisterComponent(std::shared_ptr<Component> component);

	void UnregisterComponent(std::shared_ptr<const Component> component);

	void UnregisterComponent(const std::string& componentId);

	// Event callbacks
	void CreateEventCallback();

	void DestroyEventCallback();

	void UpdateEventCallback();

	void FixedUpdateEventCallback();

	void RenderEventCallback();

	void RenderScreenEventCallback();

  private:

	std::map<std::string, std::shared_ptr<Component>, std::less<>> mComponents;
	std::vector<std::string> mCreateList;
	std::vector<std::string> mDestroyList;
};

#endif // COMPONENTS_MANAGER_H