# Acoustic telemetry datasets

This repository was used to [discuss](https://github.com/inbo/etn-occurrences/issues) the open data publication of a number of acoustic telemetry datasets. These datasets are exported from the [European Tracking Network (ETN)](http://www.lifewatch.be/etn/) database and contain detections of tagged fish that were picked up by the [Permanent Belgian Acoustic Receiver Network](https://lifewatch.be/en/fish-acoustic-receiver-network).

The repository also contains a [proof of concept](src) to standardize these data to Darwin Core.

## Workflow

1. Assess, discuss and improve quality of data related to an animal project in the ETN database
2. Download data using the ETN R package function [`download_acoustic_dataset()`](https://inbo.github.io/etn/reference/download_acoustic_dataset.html)
3. Deposit the data on the [Marine Data Archive](https://mda.vliz.be/)
4. Document the dataset on [IMIS](http://www.vliz.be/en/imis)
5. Publish the dataset and assign a DOI

## Datasets

Shortname | Publisher | DOI | DataCite
:--- | :--- | :--- | :---:
2010_PHD_REUBENS | Ghent University | <https://doi.org/10.14284/437> | [DataCite](https://commons.datacite.org/doi.org/10.14284/437)
2011_RIVIERPRIK | INBO | <https://doi.org/10.14284/429> | [DataCite](https://commons.datacite.org/doi.org/10.14284/429)
2012_LEOPOLDKANAAL | INBO | <https://doi.org/10.14284/428> | [DataCite](https://commons.datacite.org/doi.org/10.14284/428)
2013_ALBERTKANAAL | INBO | <https://doi.org/10.14284/431> | [DataCite](https://commons.datacite.org/doi.org/10.14284/431)
2014_DEMER | INBO | <https://doi.org/10.14284/432> | [DataCite](https://commons.datacite.org/doi.org/10.14284/432)
2015_DIJLE | INBO | <https://doi.org/10.14284/430> | [DataCite](https://commons.datacite.org/doi.org/10.14284/430)
2015_HOMARUS | VLIZ | <https://doi.org/10.14284/433> | [DataCite](https://commons.datacite.org/doi.org/10.14284/433)
2015_PHD_VERHELST_COD | Ghent University | <https://doi.org/10.14284/435> | [DataCite](https://commons.datacite.org/doi.org/10.14284/435)
2015_PHD_VERHELST_EEL | Ghent University | <https://doi.org/10.14284/434> | [DataCite](https://commons.datacite.org/doi.org/10.14284/434)

## Contributors

[List of contributors](https://github.com/inbo/etn-occurrences/contributors)

## License

[MIT License](https://github.com/inbo/etn-occurrences/blob/master/LICENSE)
