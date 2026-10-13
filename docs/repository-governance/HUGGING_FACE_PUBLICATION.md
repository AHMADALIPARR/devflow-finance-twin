# Hugging Face publication readiness

Target Hub URL/type/revision: **not supplied**. No Hub publication or settings change occurred. The GitHub baseline contains source/research artifacts; no tracked GGUF/safetensors/checkpoint weights or LFS pointers were found. A code collection must not be advertised as an evaluated trained model without actual model artifacts.

## Proposed publication checklist

1. Owner identifies the exact Hub repository, artifact type and authority to publish.
2. Resolve the path-level license conflicts in [license governance](LICENSE_GOVERNANCE.md), including media, datasets and third-party materials. Retain existing notices and source correspondence.
3. Record artifact and source hashes, initial distribution dates, effective licenses and approved commercial terms. Distinguish source, weights, training data and media.
4. Prepare the appropriate repository card with intended use, limitations, architecture, provenance and actual evaluations. Leave missing data explicitly unavailable.
5. Configure access and gating only under owner authorization; record the access decision and applicable terms. Gating does not establish copyright ownership or revoke previous grants.
6. Validate download contents, card links and reproducibility; document publication revision after upload.

[Hub license documentation](https://huggingface.co/docs/hub/repositories-licenses) explains recognized identifiers and custom `other` licenses with a license name and license file. Select metadata only after determining effective scope; a mixed or modified license cannot be represented as standard AGPL solely for presentation. [Model card documentation](https://huggingface.co/docs/hub/model-cards) and [gated model documentation](https://huggingface.co/docs/hub/models-gated) describe the platform mechanisms. No metadata in this draft changes the existing repository's license.

## Artifact card draft (not active Hub metadata)

**Name:** DevFlow Finance Twin source and research collection.

**Revision:** GitHub source `289e05876f15965a95f990ed178961aee0ebcb73`; Hub revision unavailable.

**Artifact type:** Code, mathematical/formal artifacts, simulator implementations and media. Trained model identity, model weights, training corpus, training procedure and inference interface are not established by this review.

**Intended use:** Research, implementation review and reproducible local testing within applicable artifact permissions.

**Evaluation:** Python finance/audit fixture and simulator checks reported in [baseline results](BASELINE_RESULTS.md). These are software correctness checks, not model quality metrics or live banking validation.

**Limitations:** FSL tests fail to compile; formal reports are incomplete; scoped proof admissions/axioms exist; custom cryptographic security is unverified; WORM LF experiment exposes a preservation failure. Live payment authorization, hardware attack resistance and QPU deployment are not established.

**License and commercial use:** Unresolved mixed notices; consult original texts and the rights review. No blanket commercial-permission or restriction statement is approved in this draft.

**Provenance:** See the source inventory, claim register and primary-source prior art. Responsible owner/reviewer and contact details must be supplied by the owner before publication.
