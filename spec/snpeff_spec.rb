require 'spec_helper'
require 'parslet/convenience'

      #s = "synonymous_variant(LOW|SILENT|acG/acA|p.Thr37Thr/c.111G>A|73|KCNQ1|protein_coding|CODING|ENST00000380776|2|1),sequence_feature[transmembrane_region:Transmembrane_region](LOW|||c.387G>A|676|KCNQ1|protein_coding|CODING|ENST00000155840|1|1),sequence_feature[transmembrane_region:Transmembrane_region](LOW|||c.387G>A|676|KCNQ1|protein_coding|CODING|ENST00000155840|2|1),intron_variant(MODIFIER|||c.387-6423G>A|676|KCNQ1|protein_coding|CODING|ENST00000155840|1|1),intron_variant(MODIFIER|||c.126-6423G>A|192|KCNQ1|protein_coding|CODING|ENST00000496887|2|1|WARNING_TRANSCRIPT_INCOMPLETE),intron_variant(MODIFIER|||c.6-6423G>A|549|KCNQ1|protein_coding|CODING|ENST00000335475|1|1),non_coding_exon_variant(MODIFIER|||n.190G>A||KCNQ1|processed_transcript|CODING|ENST00000345015|2|1)"

      #parser.attributes.parse("LOW|SILENT|acG/acA|p.Thr37Thr/c.111G>A|73|KCNQ1|protein_coding|CODING|ENST00000380776|2|1")

describe Bio::Snpeff::Parser do
  let(:parser) { Bio::Snpeff::Parser.new }

  context "rule <type>" do
    it "should parse simple" do parser.type.parse("synonymous_variant") end
    it "should parse attribute" do parser.type.parse("sequence_feature[transmembrane_region:Transmembrane_region]") end
  end

  context "rule <attribute>" do
    it "should parse simple" do parser.attribute.parse("p.Thr37Thr/c.111G") end
    it "should parse simple" do expect{parser.attribute.parse("AAA|BBB")}.to raise_error(Parslet::ParseFailed) end
    it "should parse simple" do expect{parser.attribute.parse("AAA)BBB")}.to raise_error(Parslet::ParseFailed) end
  end

  context "rule <attributes>" do
    it "should parse simple" do parser.attributes.parse("LOW|SILENT|acG/acA|p.Thr37Thr/c.111G>A|73|KCNQ1|protein_coding|CODING|ENST00000380776|2|1") end
  end

  context "rule <effect>" do
    it "should parse with attribute" do parser.effect.parse("sequence_feature[transmembrane_region:Transmembrane_region](LOW|||c.387G>A|676|KCNQ1|protein_coding|CODING|ENST00000155840|1|1)") end
  end

  context "rule <effects>" do
    it "should parse simple" do parser.effects.parse("synonymous_variant(LOW|SILENT|acG/acA|p.Thr37Thr/c.111G>A|73|KCNQ1|protein_coding|CODING|ENST00000380776|2|1)") end
    it "should parse multiple" do parser.effects.parse("synonymous_variant(LOW|SILENT|acG/acA|p.Thr37Thr/c.111G>A|73|KCNQ1|protein_coding|CODING|ENST00000380776|2|1),sequence_feature[transmembrane_region:Transmembrane_region](LOW|||c.387G>A|676|KCNQ1|protein_coding|CODING|ENST00000155840|1|1)") end
  end

  context "tree" do
    it "should parse simple" do 
      u = parser.parse("synonymous_variant(LOW|SILENT|acG/acA|p.Thr37Thr/c.111G>A|73|KCNQ1|protein_coding|CODING|ENST00000380776|2|1),sequence_feature[transmembrane_region:Transmembrane_region](LOW|||c.387G>A|676|KCNQ1|protein_coding|CODING|ENST00000155840|1|1)") 
      expect(u.inspect).to eq(%{[{:effect=>{:type=>{:name=>"synonymous_variant"@0, :qualifier=>nil}, :attributes=>{:effect_impact=>"LOW"@19, :functional_class=>"SILENT"@23, :codon_change=>"acG/acA"@30, :amino_acid_change=>"p.Thr37Thr/c.111G>A"@38, :amino_acid_length=>"73"@58, :gene_name=>"KCNQ1"@61, :transcript_biotype=>"protein_coding"@67, :gene_coding=>"CODING"@82, :transript_id=>"ENST00000380776"@89, :exon_rank=>"2"@105, :genotype_number=>"1"@107}}}, {:effect=>{:type=>{:name=>"sequence_feature"@110, :qualifier=>"[transmembrane_region:Transmembrane_region]"@126}, :attributes=>{:effect_impact=>"LOW"@170, :functional_class=>[], :codon_change=>[], :amino_acid_change=>"c.387G>A"@176, :amino_acid_length=>"676"@185, :gene_name=>"KCNQ1"@189, :transcript_biotype=>"protein_coding"@195, :gene_coding=>"CODING"@210, :transript_id=>"ENST00000155840"@217, :exon_rank=>"1"@233, :genotype_number=>"1"@235}}}]})
      u = parser.parse("synonymous_variant(LOW|SILENT|acG/acA|p.Thr37Thr/c.111G>A|73|KCNQ1|protein_coding|CODING|ENST00000380776|2|1)") 
      expect(u.inspect).to eq(%{[{:effect=>{:type=>{:name=>"synonymous_variant"@0, :qualifier=>nil}, :attributes=>{:effect_impact=>"LOW"@19, :functional_class=>"SILENT"@23, :codon_change=>"acG/acA"@30, :amino_acid_change=>"p.Thr37Thr/c.111G>A"@38, :amino_acid_length=>"73"@58, :gene_name=>"KCNQ1"@61, :transcript_biotype=>"protein_coding"@67, :gene_coding=>"CODING"@82, :transript_id=>"ENST00000380776"@89, :exon_rank=>"2"@105, :genotype_number=>"1"@107}}}]})
    end
  end
end
