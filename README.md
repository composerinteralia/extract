# Extract

AKA Jbuilder Lite

Given some cats:

```rb
mama   = Cat.new(id: 1, name: "Linda", secret: "I'm a human")
kitty  = Cat.new(id: 2, name: "Sennacy", secret: "I'm a dog", mama: mama)
kitty2 = Cat.new(id: 3, name: "Marvok", secret: "I can't meow", mama: mama, friends: [kitty])
```

we can extract specific attributes:

```rb
Extract.call do
  {
    kitties: extract!(
      [kitty, kitty2],
      :id,
      :name,
      mama: [:id, :name],
      friends: [:name, :secret]
    ),
    special_news: extract!(kitty, :secret)
  }
end
```

to produce:

```rb
{
  kitties: [
    {
      id: 2,
      name: "Sennacy",
      mama: { id: 1, name: "Linda" },
      friends: []
    },
    {
      id: 3,
      name: "Marvok",
      mama: { id: 1, name: "Linda" },
      friends: [{ name: "Sennacy", secret: "I'm a dog" }]
    }
  ],
  special_news: { secret: "I'm a dog" }
}
```
