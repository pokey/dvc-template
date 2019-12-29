from setuptools import find_packages, setup


setup(
    name='src',
    packages=find_packages(),
    install_requires=[
        "beautifulsoup4>=4.8.1",
        "dvc[s3]>=0.71.0",
        "jupytext>=1.3.0",
        "lxml>=4.4.2",
        "openpyxl==3.0.1",  # pin due to https://stackoverflow.com/a/59172160/2605678
        "pandas>=0.25.3",
        "papermill>=1.2.1",
        "pyarrow>=0.15.1",
    ],
    version='0.1.0',
    description='APOBEC3B overexpression in EGFR driven lung cancer',
    author='Debbie Caswell',
    license='',
)
