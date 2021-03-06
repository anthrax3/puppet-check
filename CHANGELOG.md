### 1.6.0 (Next)
- Minimum Ruby version increased to 2.1.
- Minimum Puppet version increased to 3.7.

### 1.5.1
- Slight cleanup and optimization.
- Fixed check for no spec directories during RSpec Puppet helper.
- Fixed check for semantic versioning in `metadata.json` for numbering > 9.
- Accounted for Puppet syntax validation output bugfix in 5.3.
- Fix bad symlink for module fixture during RSpec Puppet.
- Updating Beaker Rake task usage.

### 1.5.0
- Maximum Puppet version increased from 4 to 5.
- Added capability to check EYAML (experimental).
- Test Kitchen frontend interface.
- Updated Puppet error output for Puppet 5 differences.
- Slight optimization for smaller test sets.
- Suppress constant redefinition warnings from Octocatalog-Diff's Puppet code reuse.
- Changed FileName cop to reflect change in RuboCop >= 0.50.
- Entire module is now symlinked into `spec/fixtures/modules` during  RSpec Puppet testing (formerly specific components).

### 1.4.1
- Support for using SVN to download external module dependencies for RSpec Puppet.
- Better handled situations with uninstalled optional dependencies.
- Code cleanup and optimization.
- Added option to fail on warnings.
- Added additional error info for failed smoke checks.

### 1.4.0
- Optimized and fixed checks on dependencies and requirements in `metadata.json`.
- Optional octocatalog-diff smoke testing.
- Optional octocatalog-diff config file support.

### 1.3.2
- For the Puppet Forge method of downloading external module dependencies as spec fixtures, the module is now updated if it is already present. Previously, a fresh forced install was always attempted.
- A good `spec_helper` for RSpec Puppet is now generated if one is missing. This is instead of the buggy one that `rspec-puppet-init` generates.
- Fix blocking of hieradata checks on `hiera.yaml`.
- A check was added for '---' appearing more than once in YAML hieradata as Hiera attempts to parse these additional lines as data.
- Additional `metadata.json` warnings for `version_requirement` nested key.

### 1.3.1
- For the git and mercurial methods of downloading external module dependencies as spec fixtures, the module is now updated if it is already present and previously retrieved with git or mercurial respectively. Previously, a fresh clone was always attempted.
- Additional syntax and style checks within the `operatingsystem_support`, `requirements`, and `dependencies` hashes in `metadata.json`.
- Reek is now required dependency for all Ruby versions and locked to 3.11 for Ruby 2.0.
- Slight code cleanup and optimization.

### 1.3.0
- Minimum Ruby version increased from 1.9.3 to 2.0.0.
- Minimum Puppet version increased from 3.2 to 3.4.
- Fixed issue where invalid arguments to PuppetLint were not displayed in error message.
- Support for outputting the results in YAML or JSON formats.
- Additional style check for `metadata.json`.
- Slight code cleanup and optimization.
- Block hieradata checks from executing on `hiera.yaml`.

### 1.2.1
- Code and output cleanup.
- Add arguments support to external module download methods.
- PuppetLint dependency version updated for 2.0 release.

### 1.2.0
- Support for external module dependencies with RSpecPuppet.
- Support for nested hash parsing in Hieradata checks.
- Support for `.puppet-lint.rc` config files in manually specified paths.
- A few bug fixes for RSpecPuppet support.

### 1.1.1 (yanked from rubygems.org)
- Rewrote and optimized RSpecPuppet module support.
- A variety of minor fixes, cleanup, and improvements (e.g. ignored files now outputs in cyan and not blue)

### 1.1.0
- Support for RSpec, RSpecPuppet, and Beaker.
- Empty hieradata file bug fix.

### 1.0.0
- Initial release.
