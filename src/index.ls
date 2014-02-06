# # Immutable List

# Copyright (c) 2013 Quildreen Motta
# 
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


cons = (a, b) -> new Cons(b, a)


/**
 *     class Cons(a) <: Semigroup
 *                    , Monoid
 *                    , Applicative
 *                    , Functor
 *                    , Chain
 *                    , Monad
 *                    , Eq
 *                    , Show
 */
export class Cons

  ## Constructors

  /**
   * Constructs a new cons cell.
   *
   *     (a, Cons(a)) → Cons(a)
   */
  (@head, @tail) ->


  ## Semigroup

  /**
   * Concatenates two conses
   *
   *     (@Cons(a)) => Cons(a) → Cons(a)
   *
   * Example:
   *
   *     new Cons(1, Nil).concat(new Cons(2, Nil))  # => 1 : 2 : Nil
   */
  concat: (bs) ->
    result  = Cons.of @head
    current = result
    xs      = @tail
    while xs isnt Nil
      result.tail := Cons.of xs.head
      current     := result.tail
      xs          := xs.tail
    current.tail := bs
    return result


  ## Monoid

  /**
   * Constructs an empty cons.
   *
   *     (@Cons(a)) => Cons(a)
   */
  empty: -> Nil
  @empty = ::empty

  ## Functor

  /**
   * Maps all itens in the cons using an unary function.
   *
   *     (@Cons(a)) => (a → b) → Cons(b)
   *
   * Example:
   *
   *     new Cons(1, Nil).map(x => x + 1)  # => 2 : Nil
   */
  map: (f) ->
    result  = Cons.of (f @head)
    current = result
    xs      = @tail
    while xs isnt Nil
      current.tail := Cons.of (f xs.head)
      current      := current.tail
      xs           := xs.tail
    return result


  ## Applicative

  /**
   * Constructs a new Cons containing a single item.
   *
   *     (@Cons(a)) => a → Cons(a)
   *
   * Example:
   *
   *     Cons.of(1)  # => 1 : Nil
   */
  of: (a) -> new Cons(a, Nil)
  @of = ::of

  /**
   * Applies the function in this cons to another applicative.
   *
   *     (@Cons(a → b)) => Cons(a) → Cons(b)
   */
  ap: (b) -> @chain (f) -> b.map f


  ## Chain

  /**
   * Maps and flattens the resulting conses.
   *
   *     (@Cons(a)) => (a → Cons(b)) → Cons(b)
   */
  chain: (f) ->
    result  = null
    current = null
    xs      = this
    while xs isnt Nil
      ys = f xs.head
      while ys isnt Nil
        if result isnt null => do
                               current.tail := Cons.of ys.head
                               current      := current.tail
        else                => do
                               result := current := Cons.of ys.head
        ys := ys.tail
      xs := xs.tail
    return result


  ## Foldable
  reduce: (acc, f) ->
    xs   = this
    while xs isnt Nil
      acc := f acc, xs.head
      xs  := xs.tail
    return acc

  reduce-right: (acc, f) -> f @head, (@tail.reduce-right acc, f)


  ## Eq
  is-equal: (ys) ->
    if ys is Nil => return false

    xs = this
    while xs isnt Nil
      if xs.head isnt ys.head => return false
      xs := xs.tail
      ys := ys.tail
      if (xs isnt Nil) and (ys is Nil) => return false
    return ys is Nil


  ## Show
  to-string: -> "List(#{@reduce '', (a, b) -> if a => a + ', ' + b else b}, List.Nil)"

    
# The Nil part
export Nil = new class extends Cons
  concat: (as) -> as
  map: (f) -> this
  ap: (b) -> b
  chain: (f) -> this
  reduce: (acc, f) -> acc
  reduce-right: (acc, f) -> acc
  to-string: -> "List.Nil"
  is-equal: (b) -> b is Nil
