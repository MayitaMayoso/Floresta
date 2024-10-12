#ifndef RESOURCE_H
#define RESOURCE_H

#include <filesystem>
#include <memory>

class Resource
{
  public:

	virtual bool Load() = 0;

	virtual bool Unload() = 0;

	std::filesystem::path GetPath();

	void SetPath(const std::filesystem::path& Path);

  private:

	std::filesystem::path mPath;
};

#endif // RESOURCE_H
