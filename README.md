[![Build Status](https://travis-ci.org/aiming-cookbooks/growthforecast.png?branch=master)](https://travis-ci.org/aiming-cookbooks/growthforecast)

GrowthForecast Cookbook
=======================

This cookbook is [GrowthForecast](https://github.com/kazeburo/GrowthForecast) install.

This cookbook makes your favorite breakfast sandwhich.

Platforms
---------

- CentOS

Requirements
------------

## cookbook

- [perlbrew](https://github.com/aiming-cookbooks/perlbrew) *aiming customize*
- [buildessential](http://community.opscode.com/cookbooks/build-essential) 

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### growthforecast::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['growthforecast']['system']['perlbrew_ver']</tt></td>
    <td>String</td>
    <td>Install perlbrew version</td>
    <td><tt>perl-5.18.0</tt></td>
  </tr>
  <tr>
    <td><tt>['growthforecast']['user']['name']</tt></td>
    <td>String</td>
    <td>GrowthForecast user name</td>
    <td><tt>growthf</tt></td>
  </tr>

</table>

Usage
-----
#### growthforecast::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `growthforecast` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[growthforecast]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/aiming-cookbooks/growthforecast/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

