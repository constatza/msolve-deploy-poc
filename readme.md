# MSolve Integration PoC

A proof of concept for integrating multiple MSolve modules required for the
DComEX Framework.

Proposed Steps:

1. Start with a single MSolve module
2. Define a container image with the module
    - base image with required dependencies (e.g. .NET and xUnit)
    - Docker file for building the image with the module
3. Create a CI/CD pipeline at CSCS that builds and tests the container
4. Add more modules
5. Integrate `NuGet` for package management and dependency wrangling.
