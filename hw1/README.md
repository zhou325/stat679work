# Homework 1

## Document

This directory contains the following document:

* `hw1-snaqTimeTests`: contains all data files
    * `out`: for the main output
    * `log`: to record the parameter values and details on the individual runs of a single analysis
* `script`: contains all shell scripts
    * `normalizeFileNames.sh`: for normalizing file names
    * `summarizeSNaQres.sh`: for creating a summary table for `ex2`
    * `summarizeSNaQres2.sh`: the corrected code for creating a summary table for `ex2`
* `results`: contains all result files
    * `summarizeSNaQres.csv`: a summary table for `ex2`
    * `summarizeSNaQres.csv2`: a new summary table created by running `summarizeSNaQres2.sh`

* `README.md`: gives higher-level explanations and all the tools (commands) to reproduce my results

###working directory: `hw1`

## Instructions

* To change the working directory to `hw1` and run the following code:
`bash scripts/normalizeFileNames.sh`
will reproduce the results of `ex1`.

    (The file names of all data files in this repository were already changed.)

* To change the working directory to `hw1` and run the following code:
`bash scripts/summarizeSNaQres2.sh`
will reproduce the correct results of `ex2`.
