Given some cats:

```rb
class Cat
  attr_accessor :id, :name, :secret, :mama, :siblings

  def initialize(id:, name:, secret:, mama: nil, siblings: [])
    @id, @name, @secret, @mama, @siblings = id, name, secret, mama, siblings
  end
end

mama   = Cat.new(id: 1, name: "Linda", secret: "I'm a human")
kitty  = Cat.new(id: 2, name: "Sennacy", secret: "I'm a dog", mama: mama)
kitty2 = Cat.new(id: 3, name: "Marvok", secret: "I can't meow", mama: mama, siblings: [kitty])
```

we can extract spcific attributes and format as we please:

```rb
Extract.call do
  {
    kitties: extract!(
      [kitty, kitty2],
      :id,
      :name,
      mama: [:id, :name],
      siblings: [:name, :secret]
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
      siblings: []
    },
    {
      id: 3,
      name: "Marvok",
      mama: { id: 1, name: "Linda" },
      siblings: [{ name: "Sennacy", secret: "I'm a dog" }]
    }
  ],
  special_news: { secret: "I'm a dog" }
}
```
