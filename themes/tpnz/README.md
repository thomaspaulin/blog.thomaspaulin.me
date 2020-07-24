# tpnz

A minimalist Hugo which tweaks the Candy theme by Hugo Martins.

## Requirements

- Hugo v0.59

## Installation
Follow Hugo Martin's instructions written below

```
$ cd themes/
$ git clone https://github.com/caramelomartins/candy.git
```

You can find an example `config.yaml` inside `exampleSite`.

## Content

### Static

You can use static pages at the root of `content/`. If you wish to create a small introduction on the hompage, you can use `_index.md` at the root of `content/`. As per Hugo's templating order, it will be loaded as the body content for the root of the website.

## Dynamic

### Essays

`posts` are the default dynamic content, representing posts, blog posts, etc. You can add a `_index.md` to add a custom introduction to the list of posts page, similar to the homepage. These have specific layouts applied to them.

### Other

You should be able to add more dynamic content under different archetypes and folders, the theme will collect that content and create default single and list pages for that content.

## Archetypes

Currently there's only one archetype, which is `default.md`.


