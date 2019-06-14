# docker-scilab-gdojo

[Dojo](https://github.com/ai-traders/dojo) docker image with [Scilab](https://www.scilab.org/software/scilab)

## Specification

[Scilab](https://www.scilab.org/software/scilab) 6.0.2 is installed. Its code is available on [github](https://github.com/scilab/scilab).

## Usage
1. Setup docker.
2. Install [Dojo](https://github.com/ai-traders/dojo) binary.
3. Provide a Dojofile:
```
DOJO_DOCKER_IMAGE="kudulab/scilab-gdojo:0.1.0"
```
4. Create and enter the container by running `dojo` at the root of project.
5. Run Scilab graphical application:
```bash
scilab &
```

By default, current directory in docker container is `/dojo/work`.


## Development

### Dependencies
* Bash
* Docker daemon
* Dojo
* Bats

Full spec is [ops-base](https://github.com/kudulab/ops-base)

### Lifecycle
1. In a feature branch:
 * you make changes
 * and run tests:
     * `./tasks build`
     * `./tasks itest`
1. You decide that your changes are ready and you:
 * merge into master branch
 * run locally:
   * `./tasks set_version` to set version in CHANGELOG, bump patch version
   * e.g. `./tasks set_version 1.2.3` to set version in CHANGELOG to 1.2.3
 * push to master onto private git server
1. CI server (GoCD) tests and releases.


## License

GNU General Public License v2.0
