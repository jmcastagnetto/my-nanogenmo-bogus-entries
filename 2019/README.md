# Entry for the 2019 [NaNoGenMo](https://nanogenmo.github.io/)

- Used the file `compound` from PDB (ftp://ftp.wwpdb.org/pub/pdb/derived_data/index/compound.idx) as the source of words for the generated "novel". This file was downloaded on 2019-11-13 (15:20, PET).

- The file was processed using `gawk` (just because is quicker that way), to extract only the protein descriptions:

```awk
$ gawk BEGIN {FS="\\t"} (NR > 4){print $2} < compound.idx > desc.txt
```

- And, finally, I run the `R` script `2019-code.R` to generate the file `nanogenmo-novel.txt`

That's it. Now go read ["On the importance of being structured"](https://github.com/jmcastagnetto/my-nanogenmo-bogus-entries/blob/master/2019/nanogenmo-novel.txt). And how can you not? not with gems such a:

> ... resolution antitoxin determined, structure sigr reduction
> repressor, complex of movement anti catalytic ...
>
> ... Of peptide structure complex trna, m k domain rich phosphate uv pntm
> specific of of amine catalysis cdna orotidine an project cadmium crystal
> thermolasma domain through a phosphodiesterase crystal n complexed ...
>
> ... domain resistance d of crystal filamin in a
> thermotoga of horikoshii death the nanomolar amino galactose protein ...

--- 

**License**: MIT
