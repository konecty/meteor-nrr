# NRR - Non-Reactive Render

```shell
meteor add konecty:nrr
```

This package adds a helper to render templates with less reactivity and computations.
This is ideal to improve the render of a high amount of data.

# Use
```handlebars
	{{nrr 'templateName' dataContext}}
```
or
```handlebars
	{{nrr 'templateName' data1=data1 data2=data2}}
```

# Example
```handlebars
	{{nrr 'message' message}}
```