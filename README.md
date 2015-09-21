# semver

Semantic Versioning module for Crystal.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  semver:
    github: rosylilly/semver
```

## Usage


```crystal
require "semver"

v1_0_0 = Semver::Version.new("1.0.0")

# or

v1_0_0 = Semver::Version.new(1, 0, 0)
```

## Contributing

1. Fork it ( https://github.com/rosylilly/semver/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- rosylilly(https://github.com/rosylilly) Sho Kusano - creator, maintainer
