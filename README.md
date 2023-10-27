# rtl_433 Home Assistant add-ons

This is a collection of Home Assistant add-ons that work with [rtl_433](https://github.com/merbanan/rtl_433).

* [How to add this add-on repository to your Home Assistant install](https://home-assistant.io/hassio/installing_third_party_addons/)
* Use `https://github.com/pbkhrv/rtl_433-hass-addons` as the URL for the repository.

## Running the Development Version

- First, follow the tutorial at [Tutorial: Making your first add-on](https://developers.home-assistant.io/docs/add-ons/tutorial/) to learn how to build a basic addon.
- Use `git` to clone this repository same `addons` folder used in the tutorial.
- Make changes to the code, or use `git` to checkout branches to test.
- Remember to to [reload](https://developers.home-assistant.io/docs/add-ons/tutorial/#i-dont-see-my-add-on) and reinstall the addon to rebuild the Docker containers to see any changes.

## Release Process

* The [next](https://github.com/pbkhrv/rtl_433-hass-addons/tree/next) branch represents the upcoming version of these addons.
* [rtl_433/config.json](rtl_433/config.json) and [rtl_433_mqtt_autodiscovery/config.json](rtl_433_mqtt_autodiscovery/config.json) will contain the version numbers of the previously set addon versions, but will have different code.
* When `next` is ready to be tagged for a release:
  1. Create a pull request against `main`, bumping the versions of each `config.json` file if the individual addon has been changed. As well, update the `CHANGELOG.md` in the same pull request.
  2. When the pull request has been approved, create a date-based tag such as `2022.12.01.0` on the last commit of the pull request. This will build docker containers with the version numbers in `config.json`.
  3. Merge the PR into `main` to actually promote the release to end users. Note the new version(s) in the commit message.
    - Note we do not tag `main` in git, since each addon has it's own version number.
  4. Create a new branch off of `main` setting the addon versions back to `next`. Create a PR to merge `main` into `next` to reconcile the branches.
