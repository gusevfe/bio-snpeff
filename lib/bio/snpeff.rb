require 'bio/snpeff/version'
require 'parslet'

module Bio
  module Snpeff
    class MissenseVariant
    end

    class Parser < Parslet::Parser
      rule(:effects) { effect.as(:effect).repeat(1, 1) >> (str(",") >> effect.as(:effect)).repeat }
      rule(:effect) { type.as(:type) >> str("(") >> attributes.as(:attributes) >> str(")") }
      rule(:type) { match['a-zA-Z0-9_'].repeat.as(:name) >> (str("[") >> (str("]").absent? >> any).repeat >> str("]")).maybe.as(:qualifier) }
      # Effect ( Effect_Impact | Functional_Class | Codon_Change | Amino_Acid_Change| Amino_Acid_Length | Gene_Name | Transcript_BioType | Gene_Coding | Transcript_ID | Exon_Rank  | Genotype_Number [ | ERRORS | WARNINGS ] )
      rule(:attributes) { attribute.as(:effect_impact) >> str("|") >> 
                          attribute.as(:functional_class) >> str("|") >> 
                          attribute.as(:codon_change) >> str("|") >> 
                          attribute.as(:amino_acid_change) >> str("|") >> 
                          attribute.as(:amino_acid_length) >> str("|") >> 
                          attribute.as(:gene_name) >> str("|") >> 
                          attribute.as(:transcript_biotype) >> str("|") >> 
                          attribute.as(:gene_coding) >> str("|") >> 
                          attribute.as(:transript_id) >> str("|") >> 
                          attribute.as(:exon_rank) >> str("|") >> 
                          attribute.as(:genotype_number) >> 
                          (str("|") >> attribute.as(:error)).repeat.as(:errors)
      }
      rule(:attribute) { ((str("|") | str(")")).absent? >> any).repeat }
      root(:effects)
    end
  end
end
