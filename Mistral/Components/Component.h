#ifndef COMPONENT_H
#define COMPONENT_H

#include <raylib-cpp.hpp>
#include <string>
#include <vector>

class Component
{
  public:

	Component();

	Component(const std::string& Type);

	// Getters
	std::string GetId() const;

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

  protected:

	std::string mId;
	Component* mParent;
	std::vector<Component*> mChildren;
	raylib::Vector3 mPosition;
};

#endif // COMPONENT_H
