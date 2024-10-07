#ifndef RESOURCES_H
#define RESOURCES_H

#include <filesystem>
#include <memory>

class Resources
{
  public:

  private:

	// std::shared_ptr<T> mData = nullptr;
	std::filesystem::path mPath;
	bool mLoaded = false;
	uint32_t mUseCount = 0u;
};

#endif // RESOURCES_H
