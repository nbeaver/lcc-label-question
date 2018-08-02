changequote(`<<<', `>>>')
I am creating a page of sticky labels containing Library of Congress Classification call numbers (LCCs). They are in what the [`labels` package](https://www.ctan.org/pkg/labels) calls "plain format".

include(<<<example-1.markdown>>>)

It looks like this:

[![simple labels, left flush][1]][1]

However, I actually want to adjust the formatting of the labels so that they are shifted to the right while still being left-aligned. I accomplished this like so:

    \begin{center}%
    \parbox{20mm}{%
    PR
    6051
    .D3352
    M68}\end{center}

Full text here:

include(<<<example-2.markdown>>>)

It looks like this:

[![better formatted labels][2]][2]

Of course, I still need to read in from the external file. I don't think the `labels` package permits formatting changes when reading from a file, so I tried [`textmerg`](https://www.ctan.org/pkg/textmerg).

include(<<<example-3.markdown>>>)

Unfortunately, LCCs are variable length; they are typically between two to four lines long. Some have one or more Cutter numbers; some do not. This means the numbers get split up incorrectly.

[![labels split up incorrectly][3]][3]

Of the following, what would be the best approach?

- Override the macros in `labels` to get the formatting I want?

  (I wasn't able to find a hint on this in the documentation.)

- Use an advanced feature of `textmerg` to handle the variable-length format?

  (The "complicated example" in the manual deals with a "table of indeterminate length, albeit fixed width". I believe in this case the width is not fixed.)

- Use a different package, such as `datatool`?

  Most of the examples in `datatool` deal with CSVs, so I'm not sure how well this would work.


  [1]: https://i.stack.imgur.com/7hLhA.png
  [2]: https://i.stack.imgur.com/UdduQ.png
  [3]: https://i.stack.imgur.com/rzXjY.png
