### Summary of NIST IR 8278A Rev. 1 – Submission Guidance for OLIR Developers

#### Overview
The National Institute of Standards and Technology (NIST) Internal Report 8278A Revision 1 provides comprehensive guidance for developers creating Online Informative References (OLIRs). These references, often called crosswalks, are structured mappings between NIST frameworks (Focal Documents) and other cybersecurity, privacy, or information technology documents (Reference Documents).

#### Detailed Guidance for Document Decomposition and Mapping Styles

### 2. Decompose the Documents

Developers must meticulously define discrete elements from both the Focal and Reference Documents for accurate and meaningful mappings. This detailed decomposition process includes:

- **Focal Document Element**: Defined explicitly as "a discrete section, sentence, phrase, or other identifiable piece of content from a Focal Document."
- **Reference Document Element**: Defined explicitly as "a discrete section, sentence, phrase, or other identifiable piece of content from a Reference Document."

Decomposition involves:
- Identifying clear and distinct elements within each document capable of individual mappings.
- Targeting the lowest practical level of abstraction to minimize ambiguity and maximize precision.

Specific recommendations provided by NIST:
- For **NIST SP 800-53**, decomposition should target the control enhancements, representing the lowest abstraction level for detailed mapping.
- For the **NIST Cybersecurity Framework**, developers should map at the subcategory level, offering specific outcomes and practices for accurate reference.

Each element used for mapping should clearly reflect the document structure and capture the specific content being mapped. Developers may create custom identifiers if necessary to clarify and precisely indicate the text sections being compared.

### 3. Choose Appropriate Mapping Style

The mapping style significantly influences the comprehensiveness and interpretability of the OLIR. Developers have three primary mapping styles, each with distinct purposes:

#### Concept Crosswalk
- Simply states a relationship exists without providing additional characterization.
- Best for high-level or initial mappings where detailed description is not critical.

#### Set Theory Relationship Mapping
- Explicitly characterizes relationships using set theory concepts for precision:
  - **Subset of**: The Reference Document Element is entirely encompassed by the Focal Document Element.
  - **Intersects with**: Partial overlap exists between elements.
  - **Equal**: Both elements are exactly the same in scope and meaning.
  - **Superset of**: The Focal Document Element is entirely encompassed by the Reference Document Element.
  - **Not related**: Elements have no meaningful relationship.
- Developers must provide a rationale for each mapping relationship, categorized as:
  - **Syntactic**: Direct textual similarity or exact wording.
  - **Semantic**: Meaningful interpretation and similar conceptual intent.
  - **Functional**: Similar practical outcomes, despite textual or conceptual differences.

#### Supportive Relationship Mapping
- Clearly explains how one document element supports or is supported by another.
- Relationship types include:
  - **Supports**: Facilitates achievement of another element’s objective.
  - **Supported by**: Relies on another element for its objective.
  - **Identical**: Exactly the same purpose and definition.
  - **Equivalent**: Effectively deliver the same outcome or objective with minor variations.
  - **Contrary**: Explicitly opposing objectives or meanings.

Detailed documentation of rationale and relationship types is required to maintain transparency and clarity.

#### Validation and Review
- Conduct peer reviews and stakeholder engagement for thorough validation.
- Refine mappings iteratively based on received feedback.

#### Submission and Publication
- Submit completed mappings via NIST OLIR submission portal.
- Undergo public comment and NIST review before final catalog listing.

#### Key Elements of OLIR Submission
- Clear relationship and rationale documentation.
- Detailed justifications for mappings.
- Comprehensive metadata.

#### Resources
- [NIST IR 8278A Rev. 1 Full Document](https://doi.org/10.6028/NIST.IR.8278Ar1)
- [OLIR Program Information](https://csrc.nist.gov/projects/olir)

Adhering to this detailed guidance ensures robust OLIRs that effectively support compliance and interoperability objectives.


