#ifndef COMPONENTS_MANAGER_H
#define COMPONENTS_MANAGER_H

#include <map>
#include <memory>

#include "Components/Component.h"

class ComponentsManager
{
  public:

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

  private:

	std::map<std::string, std::shared_ptr<Component>, std::less<>> mComponents;
	std::vector<std::string> mCreateList;
	std::vector<std::string> mDestroyList;
};

#endif // COMPONENTS_MANAGER_H