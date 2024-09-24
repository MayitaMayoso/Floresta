#ifndef FLORESTAPROJECT_COMPONENT_H
#define FLORESTAPROJECT_COMPONENT_H

#include <string>
#include <vector>

#include "raylib-cpp.hpp"

class Component
{
  public:

	// Getters
	std::string GetId();

	Component* GetParent();

	std::vector<Component*>& GetChildren();

	Component* GetChild(const std::string& childId);

	void SetPosition(raylib::Vector3 position);

	raylib::Vector3 GetPosition();

	// Events
	virtual void CreateEvent() {};

	virtual void DestroyEvent() {};

	virtual void UpdateEvent() {};

	virtual void FixedUpdateEvent() {};

	virtual void RenderEvent() {};

	virtual void RenderScreenEvent() {};

  private:

	std::string mId;
	Component* mParent;
	std::vector<Component*> mChildren;
	raylib::Vector3 mPosition;
};

#endif // FLORESTAPROJECT_COMPONENT_H
