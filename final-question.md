
I am creating a page of sticky labels containing Library of Congress Classification call numbers (LCCs). They are in what the [`labels` package](https://www.ctan.org/pkg/labels) calls "plain format".

    \begin{filecontents*}{\jobname.dat}
    PR
    6051
    .D3352
    M68
    
    Z
    253.4
    .T47
    K58
    
    QA
    76.6
    .K644
    
    Z
    250.8
    .M46
    E578
    
    PR
    5815
    
    PR
    6039
    .O32
    T65
    \end{filecontents*}
    \documentclass[letterpaper,10pt]{article}
    
    \usepackage[newdimens]{labels}
    \LabelCols=3
    \LabelRows=10
    \LeftPageMargin=4mm
    \RightPageMargin=4mm
    \TopPageMargin=12.5mm
    \BottomPageMargin=13mm
    \InterLabelColumn=4mm
    \InterLabelRow=0mm
    \LeftLabelBorder=0.2mm
    \RightLabelBorder=0.2mm
    \TopLabelBorder=0.2mm
    \BottomLabelBorder=0mm
    
    \LabelGridtrue % show grid for labels
    \LabelInfotrue % show info for labels
    
    \begin{document}
    \labelfile{\jobname.dat}
    \end{document}


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

    \documentclass[letterpaper,10pt]{article}
    
    \usepackage[newdimens]{labels}
    \LabelCols=3
    \LabelRows=10
    \LeftPageMargin=4mm
    \RightPageMargin=4mm
    \TopPageMargin=12.5mm
    \BottomPageMargin=13mm
    \InterLabelColumn=4mm
    \InterLabelRow=0mm
    \LeftLabelBorder=0.2mm
    \RightLabelBorder=0.2mm
    \TopLabelBorder=0.2mm
    \BottomLabelBorder=0mm
    
    \LabelGridtrue % show grid for labels
    \LabelInfotrue % show info for labels
    
    \begin{document}
    \begin{labels}%
    \begin{center}%
    \parbox{20mm}{%
    PR
    6051
    .D3352
    M68}\end{center}
    
    \begin{center}%
    \parbox{20mm}{%
    Z
    253.4
    .T47
    K58}\end{center}
    
    \begin{center}%
    \parbox{20mm}{%
    QA
    76.6
    .K644}\end{center}
    
    \begin{center}%
    \parbox{20mm}{%
    Z
    250.8
    .M46
    E578}\end{center}
    
    \begin{center}%
    \parbox{20mm}{%
    PR
    5815}\end{center}
    
    \begin{center}%
    \parbox{20mm}{%
    PR
    6039
    .O32
    T65}\end{center}
    
    \end{labels}
    
    \end{document}


It looks like this:

[![better formatted labels][2]][2]

Of course, I still need to read in from the external file. I don't think the `labels` package permits formatting changes when reading from a file, so I tried [`textmerg`](https://www.ctan.org/pkg/textmerg).

    \begin{filecontents*}{\jobname.dat}
    PR
    6051
    .D3352
    M68
    
    Z
    253.4
    .T47
    K58
    
    QA
    76.6
    .K644
    
    Z
    250.8
    .M46
    E578
    
    PR
    5815
    
    PR
    6039
    .O32
    T65
    \end{filecontents*}
    \documentclass[letterpaper,10pt]{article}
    
    \usepackage{textmerg}
    
    \usepackage[newdimens]{labels}
    \LabelCols=3
    \LabelRows=10
    \LeftPageMargin=4mm
    \RightPageMargin=4mm
    \TopPageMargin=12.5mm
    \BottomPageMargin=13mm
    \InterLabelColumn=4mm
    \InterLabelRow=0mm
    \LeftLabelBorder=0.2mm
    \RightLabelBorder=0.2mm
    \TopLabelBorder=0.2mm
    \BottomLabelBorder=0mm
    
    \LabelGridtrue % show grid for labels
    \LabelInfotrue % show info for labels
    
    \begin{document}
    \Fields{\subclass\number\cutter}
    
    \Merge{\jobname.dat}{%
      \addresslabel{
        \begin{center}
        \parbox{20mm}{
          \subclass\\
          \number\\
          \cutter}
        \end{center}
      }%
    }%
    \end{document}


Unfortunately, LCCs are variable length; they are typically between two to four lines long. Some have one or more Cutter numbers; some do not. This means the numbers get split up incorrectly.

[![labels split up incorrectly][3]][3]

Of the following, what would be the best approach?

- Override the macros in `labels` to get the formatting I want?

  (I wasn't able to find a hint on this in the documentation.)

- Use an advanced feature of `textmerg` to handle the variable-length format?

  (The "complicated example" in the manual deals with a "table of indeterminate length, albeit fixed width". I believe in this case the width is not fixed.)

- Use a different package, such as `datatool`?

  Most of the examples in `datatool` deal with CSVs, so I'm not sure how well this would work.

Here is a link to a git repository to make it easier to get the files:

https://github.com/nbeaver/lcc-label-question


  [1]: https://i.stack.imgur.com/7hLhA.png
  [2]: https://i.stack.imgur.com/UdduQ.png
  [3]: https://i.stack.imgur.com/rzXjY.png
