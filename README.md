# Fish tracking data

## Rationale

This repository contains the functionality to standardize the _Fish tracking data_ to a [Darwin Core occurrence dataset](https://www.gbif.org/dataset-classes) that can be harvested by [GBIF](http://www.gbif.org). It was developed for [LifeWatch](http://www.lifewatch.be).

## Workflow

[source data](https://github.com/inbo/etn-occurrences/blob/master/data/raw) → Darwin Core [mapping script](http://inbo.github.io/etn-occurrences/dwc_mapping.html) → generated [Darwin Core files](https://github.com/inbo/etn-occurrences/blob/master/data/processed)

## Published dataset

* Dataset on the IPT **unpublished**
* Dataset on GBIF **unpublished**

## Repo structure

The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/). Files and directories indicated with `GENERATED` should not be edited manually.

```
├── README.md         : Description of this repository
├── LICENSE           : Repository license
├── .gitignore        : Files and directories to be ignored by git
│
├── data
│   ├── raw           : Source data, input for mapping script
│   └── processed     : Darwin Core output of mapping script GENERATED
│
├── docs              : Repository website GENERATED
│
└── src
    ├── dwc_mapping.Rmd : Darwin Core mapping script, core functionality of this repository
    └── src.Rproj       : RStudio project file
```

## Contributors

[List of contributors](https://github.com/inbo/etn-occurrences/contributors)

## License

[MIT License](https://github.com/inbo/etn-occurrences/blob/master/LICENSE)
