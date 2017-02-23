#!/usr/bin/env cwl-runner
#
# Author: Jeltje van Baren jeltje.van.baren@gmail.com

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [ /opt/SomaticSniper.py, -F, vcf, --workdir, ./ ]

doc: "Runs somatic sniper snp caller on input bam files"

hints:
  DockerRequirement:
    dockerPull: quay.io/opengenomics/somatic-sniper

#requirements:
#  - class: InlineJavascriptRequirement

inputs:

  reference:
    type: File
    doc: |
      reference sequence in the FASTA format
    inputBinding:
      position: 3
      prefix: -f

  tumor_name:
    type: string?
    doc: |
      tumor sample id (for VCF header) [TUMOR]
    inputBinding:
      position: 3
      prefix: -t

  normal_name:
    type: string?
    doc: |
      normal sample id (for VCF header) [NORMAL]
    inputBinding:
      position: 3
      prefix: -n

  minmapqual:
    type: int?
    doc: |
         filtering reads with mapping quality less than [0]
    inputBinding:
      position: 3
      prefix: -q

  snvqual:
    type: int?
    doc: |
         filtering somatic snv output with somatic quality less than  [15]
    inputBinding:
      position: 3
      prefix: -Q

  noLOH:
    type: boolean?
    doc: |
        do not report LOH variants as determined by genotypes
    inputBinding:
      position: 3
      prefix: -L

  noGainOfRef:
    type: boolean?
    doc: |
        do not report Gain of Reference variants as determined by genotypes
    inputBinding:
      position: 3
      prefix: -G

  noSomaticPriors:
    type: boolean?
    doc: |
        disable priors in the somatic calculation. Increases sensitivity for solid tumors
    inputBinding:
      position: 3
      prefix: -p

  doPriors:
    type: boolean?
    doc: |
        Use prior probabilities accounting for the somatic mutation rate
    inputBinding:
      position: 3
      prefix: -J

  priorProb:
    type: float?
    doc: |
       prior probability of a somatic mutation (implies -J) [0.010000]
    inputBinding:
      position: 3
      prefix: -s

  tumorbam:
    type: File
    doc: |
      tumor bamfile
    inputBinding:
      position: 1

  normalbam:
    type: File
    doc: |
      normal bamfile
    inputBinding:
      position: 2

  output_name:
    type: string
    default: mutations.vcf
    doc: |
      Name of output file
    inputBinding:
      position: 5

outputs:

  mutations:
    type: File?
    outputBinding:
      glob: $(inputs.output_name)

