#!/bin/bash

set -eu

PROJECT_DIR=$(pwd)
BUILD_DIR="/tmp/buildlatex-"$(date "+%Y%m%d-%H%M%S")

mkdir "${BUILD_DIR}"
cp -R "${PROJECT_DIR}/src" "${BUILD_DIR}/"
cp "${PROJECT_DIR}/.latexmkrc" "${BUILD_DIR}/"
cd "${BUILD_DIR}/src"
pandoc --filter pandoc-crossref \
  --top-level-division=chapter \
  ./*.md -o ./main.tex
mv "${BUILD_DIR}/src/template/boilerplate.tex" "${BUILD_DIR}/src"
latexmk boilerplate
mv ./boilerplate.pdf "${PROJECT_DIR}/dest/output.pdf"
rm -rf "${BUILD_DIR}"
