#!/usr/bin/env bash

#pull deltasvm
wget http://www.beerlab.org/deltasvm/downloads/deltasvm_script.tar.gz
tar -xzf deltasvm_script.tar.gz

#Also get their kmer scores
wget http://www.beerlab.org/deltasvm/downloads/SupplementaryTable_gm12878weights.txt
perl -lane 'if ($. > 1) {print "$F[0]\t$F[2]"}' SupplementaryTable_gm12878weights.txt > deltasvmpaper.kmerweights.txt

#generate the non-redundant kmers
python ~/lsgkm/scripts/nrkmers.py 10 non_redundant_kmers.txt

#score the nonredundant kmers

compute_kmer_weights () {
   prefix=$1 
   ~/lsgkm/bin/gkmpredict -T 16 non_redundant_kmers.txt $prefix.model.txt $prefix.kmerweights.txt
}

compute_kmer_weights gkmsvm_t2_l10_k6_d3_t16_negset1
compute_kmer_weights gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset1

compute_kmer_weights gkmsvm_t2_l10_k6_d3_t16_negset2
compute_kmer_weights gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset2

compute_kmer_weights gkmsvm_t2_l10_k6_d3_t16_negset3
compute_kmer_weights gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset3

compute_kmer_weights gkmsvm_t2_l10_k6_d3_t16_negset4
compute_kmer_weights gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset4

compute_kmer_weights gkmsvm_t2_l10_k6_d3_t16_negset5
compute_kmer_weights gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset5

#mkdir deltasvm_out
#
run_deltasvm_perl_script () {
    prefix=$1
    perl deltasvm_script/deltasvm.pl dsqtl_test_pos.major.fa dsqtl_test_pos.minor.fa $prefix.kmerweights.txt deltasvm_out/positives_$prefix.txt
    #run deltasvm on negatives
    perl deltasvm_script/deltasvm.pl dsqtl_test_neg.major.fa dsqtl_test_neg.minor.fa $prefix.kmerweights.txt deltasvm_out/negatives_$prefix.txt
    ./compute_perf_stats.py deltasvm_out/positives_$prefix.txt deltasvm_out/negatives_$prefix.txt
}

run_deltasvm_perl_script deltasvmpaper
run_deltasvm_perl_script gkmsvm_t2_l10_k6_d3_t16_negset1
run_deltasvm_perl_script gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset1

run_deltasvm_perl_script gkmsvm_t2_l10_k6_d3_t16_negset2
run_deltasvm_perl_script gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset2

run_deltasvm_perl_script gkmsvm_t2_l10_k6_d3_t16_negset3
run_deltasvm_perl_script gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset3

run_deltasvm_perl_script gkmsvm_t2_l10_k6_d3_t16_negset4
run_deltasvm_perl_script gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset4

run_deltasvm_perl_script gkmsvm_t2_l10_k6_d3_t16_negset5
run_deltasvm_perl_script gkmsvm_t3_l10_k6_d3_c10_g2_t16_negset5
