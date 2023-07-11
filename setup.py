from setuptools import setup, find_packages

setup(
    name="project_package",
    version='1.2.6',
    packages=find_packages(),
    description='A simple Python package',
    author='Sweet Heart',
    install_requires=[
        "Flask",
    ],
)