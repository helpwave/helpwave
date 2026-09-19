# Feature Name: Ward Round Documentation

## 1. Problem Statement

    - Briefly describe the current workflows' main point(s) this feature aims to address.

The manner in which ward rounds are documented varies considerably between hospitals and even between different wards within the same hospital. Frequently, this documentation is merely a free text entry, which is often made hours after the ward rounds have concluded. This can result in the loss of valuable information. Additionally, the required information is not always readily available, which makes it challenging to make informed decisions and may also lead to the overlooking of important findings, which could potentially endanger the patient. The procedure discussed during ward rounds necessitates the prompt distribution of tasks to the team to ensure timely patient care. The objective of the "Ward Round Documentation" system is to allow clinics to develop process-oriented templates that enable quality management and lead to swift and still comprehensive documentation by health care workers. Ultimately, improved ward round documentation will help in enhancing patient safety.

___

## 2. Background and Objective

    - Give some background information and explain how the current process is inefficient, error-prone, or lacks functionality (e.g. anecdotes from clinical practice)
    - Outline the specific objectives and goals of the feature.
    - What do we aim to achieve by implementing this feature?
    - Quantify the impact of the problem if possible (e.g., increased time spent on tasks, medication errors, scientific references are definitely welcome!).

**Challenges of conventional ward round documentation (paper-based or digital but limited to free-text entries):**
- Time constraints: Clinicians only have limited time with each patient and document the ward round.
- Incomplete or Inaccurate Information: Lack of access to up-to-date patient records or missing information cause harm to the patient assessment.
- Coordination and logistics: Essential multidisciplinary team members might not be available at the time of ward rounds.
- Follow-up actions: Ensuring that all agreed-upon actions are tracked and followed up can be challenging.
- Technology limitations: Manually searching for relevant data points can be hindered by slow, unreliable, or difficult to use systems.
- Training and standardization: Variability in the training and practices of team members can lead to inconsistencies in patient care and documentation.
- Interruptions and distractions: In case of interruptions, it is not easily comprehensible what tasks still need to be fulfilled

**Purpose of ward round documentation software:**
- Efficient record-keeping and time savings: Manual note-taking or repetitive documentation is not required and automating repetitive tasks reduces the time needed for documentation.
- Improved communication: All team-members have access to up-to-date and consistent patient data.
- Enhanced patient safety: Errors can be minimized by providing accurate relevant information, alerting clinicians to potentials issues such as allergies, contraindications, or pending test results.
- Compliance: It is ensured that documentation meets regulatory and legal requirement, while standards and protocols can be upheld.
- Integration with other systems: A holistic view of patient care and streamlined workflows are provided by integrating electronic health records, laboratory systems, imaging systems, etc.
- Decision support: Tools that provide evidence-based recommendations, reminders, and alerts are included to assist clinicians in making informed decisions.
- Data analysis and reporting: It enables the collection and analysis of patient data over time, facilitating the identification of trends, outcomes, and areas for improvement in patient care and hospital operations (quality management).
- Patient engagement: Allowing for patient access or input can lead to improved quality of care and patient satisfaction.

___

## 3. Proposed Solution

    - Describe the new feature and how it will address the problem statement.
    - Explain the expected benefits of the feature for both medical staff and patients (e.g., improved workflow efficiency, reduced errors, enhanced patient care).

**Features of “Ward Round Documentation”**

_Interfaces_
1) Main ward round documentation interface
    -	Dependency: Specific for a patient
    -	Simultaneous view of current ward round documentation and already performed ward rounds (starting with most recent entries)
    -	Functionality
        - Use free text or choose template
        - Edit existing entry: possible for e.g. 24 hours after creation (rolling window)
2) Interface for creating new templates
    -	Dependency: the same for every kind of user 
    -	Functionality
        - the user can choose from design elements (e.g. drop-down menus etc.)
        - drag-and-drop functionality to add or rearrange elements
3) Interface for management of template library
    -	Dependency: editable by authorized personnel (e.g. attendings), view-only for others, personal templates also editable by owning user
4) Interface for management of personal text blocks
    -	Dependency: specific for every user 
    -	List of abbreviations and connected texts
    -	Functionality
        - Possibility for direct edits
        - Import text blocks, e.g. used in a specific speciality, can be edited (in a local environment)

_Templates_
-	Simple vs. specific templates
    -	Simplest template: e.g. based on the SOAP-structure
        - Subjective: Current complaints reported by the patient
        - Objective: Current findings (physical examination, laboratory results, imaging, consultations etc.)
        - Assessment: Brief assessment of the current problems
        - Procedure: Numerical list of current decisions regarding the diagnosis and treatment
    -	Specific templates for different diseases/surgeries/complications/etc.
        - depending on the main diagnosis (the reason for the current hospital stay)
        - with suggestions for next steps (can be selected and de-selected)
        - including “one-click” documentation of relevant scores and scales (e.g. NRS, SOFA, GCS, RASS)
        - also specific templates for different kinds of ward rounds (e.g. with chief/attending or interdisciplinary)
-	pre-defined & self-created templates
    -	self-created templates (each department can create templates, e.g. based on the hospitals standard operating procedures)
    -	pre-defined templates: templates that are based on national/international guidelines (could be monetized additionally)
    -	All templates should be editable, some only by authorized personnel (e.g. attendings)

_General functionality_
-	the templates evolve along with the disease process (for surgical cases e.g. pre-surgery, post-surgery and occurance of common complications)
-	semi-automated step-by-step assessment with the relevant information provided at each step
-	auto-populate or auto-fill e.g. of vital signs and relevant lab results in the templates
-	Possibility to create personalized text modules that can be inserted via short-cuts
-	Possibility to scroll through the previous ward round documentations with the same case number (same hospital stay), starting with the most recent ones
-	Possibility for image documentation (e.g. for wound management), if needed with connection to a mobile device with a camera
-	Choice to use voice-recognition software during ward round documentation
-	Indication in the ward overview of which patients have already been rounded on and also documented


___

## 4. User Stories

    - List several user stories or scenarios, which are brief descriptions of how different user roles (doctors, nurses, pharmacists, administrative staff etc.) will interact with the feature.
    - Each user story should follow the format: "As a [user role], I want to [action] so that [benefit]." (e.g., "As a doctor, I want to quickly access a patients' medication history so that I can make informed prescribing decisions.")

- What types of ward rounds are there?
    1. Doctors daily round on each patient in their ward. Ward Rounds usually include all junior doctors that are assigned to the ward as well as some senior doctors. It is common that nurses join the ward round only for those patients that they are responsible for, so that they can give additional information if needed.
    2. Nurses usually round on patients at the beginning of their shift to pass on relevant information between from one shift to the next. The relevant information differs from the doctor ward rounds. Usually there are no decisions to be made regarding diagnostics and therapy.
    3. Interdisciplinary ward rounds take place in settings such as ICU (intensive care unit) and IMC (intermediate care unit). This might include the following employee groups: doctors, nurses, physiotherapist, speech therapist, patient management team (admin), etc.

&nbsp;

- _User story:_

    -	>“As a doctor, I want to have guidance in planning and documenting the patient’s treatment journey on a daily basis so that I can achieve the best possible quality of care for the patient.”
    -	A patient was admitted to the hospital 5 days ago with a suspected case of pneumonia. After a couple of days the patient’s state deteriorated with increasing clinical signs of infection. The patient was transferred to the ICU and a sepsis was diagnosed. Standard lab results then showed values that suggested an acute kidney injury, possibly due to septic shock. The evaluation of acute kidney injury amongst hospitalized patients always follow a similar pattern, that is based on guidelines etc. (e.g. as seen in the picture from uptodate.com). To ensure that no consideration of possibly causes or complicating factors is forgotten, a template that is evolving along the shown diagnostic pathway can be used during daily ward rounds, where the next steps are being discussed.
    -	https://www.uptodate.com/contents/search?search=acute%20kidney%20injury&sp=0&searchType=PLAIN_TEXT&source=USER_INPUT&searchControl=TOP_PULLDOWN&autoComplete=false

___

## 5. User Flow

    - A graph that describes the flow of the user throughout the feature should be drawn. Where does the user access the feature? What can he or she do with it? What are possible actions within the process? Exact definitions of the views are not (yet) needed.

![Ward Round Documentation: User Flow](images%20and%20documents/2024-07-20_user%20flow_ward%20round%20documentation.png)

___

## 6. Functional Requirements

    - List all the specific functionalities the feature must have.
    - Be as clear and detailed as possible, considering different use cases.
    - Use common / user-friendly terms whenever possible, but include technical ones if necessary.

- See “3. Proposed Solution”

___

## 7. Non-Functional Requirements

    - Specify any non-functional requirements such as:
        - Security: How will patient data privacy and security be ensured?
        - Performance: How fast should the feature respond to user actions? E.g. is stuff like immediate updating necessary?
        - Usability: What should the focus be in terms of accessibility to use for medical staff with varying levels of technical expertise? Can you anticipate any challenges? Be as detailed as possible and don't just repeat requirements to common design patterns.

-	Pre-defined templates need to be kept up-to-date
-	Challenge: The templates should make ward rounds easier for health care workers and should not restrict them. There should be very little mandatory fields (only if it is absolutely necessary for quality management). Text blocks should remain editable, so that adjustments can easily and quickly be made during ward rounds.

___

## 8. Dependencies and Constraints

    - Identify any dependencies or constraints, e.g. compatibility with existing hospital systems? What data is needed from where? Where is the data output possibly going?
        - other features, third-party systems  
        - regulatory requirements, hardware limitations, etc.

-	Linked to helpwave ward overview
-	Third-party systems for automated integration of data: laboratory, imaging, real-time bedside monitoring systems, etc.

___

## 9. Success Criteria

    - Define how you will measure the success of the feature. What are the conditions under which the feature will be considered complete and satisfactory?
    - This could involve metrics like:
        - Reduction in time spent on specific tasks
        - Increase in user adoption of the feature
        - Decrease in error rates
        - Acceptance Criteria

-	Ward round documented for 100% of assigned patients each day using the new tool
-	Number of (specific) templates created/used


___

## 10. Potential Risks and Issues

    - Highlight any potential risks or issues that might arise from implementing the feature (e.g. acceptance of staff). 

- tbd

___

## 10. Open Questions/Clarifications

    - List any outstanding questions or areas requiring further clarification for the development team.

- tbd

___

## 11. Market research

    - Identify competitors with software products that address a similar customer need. 
        - If possible, include screenshots of the product.
        - What are advantages and disadvantages of their approach?
        - What are we intending to do differently, what is our "secret sauce" in the feature?

-	**Phrase Expander**
    -	https://www.phraseexpander.com/text-expansion-and-template-builder-customer-care/
    -	Product: “Save time in data entry with universal autocomplete and templates. Get instant access to your templates and snippets of text in any application, by typing an abbreviation”
    -	Features:
        -	Text expansion
        -	Smart complete
        -	Dynamic forms
        -	Manage templates
        -	Macros
        -	Team work
        -	Autocorrects
        -	Clipboard
    -	Free premade templates, e.g. for score calculation, can be downloaded on the website
    -	What we want to do differently: A better design, adjusted for ward rounds, not only text expansion but also more elaborate templates with multiple (design) elements
    ![PhraseExpander Screenshot 1](images%20and%20documents/2024-07-20_Ward%20Round%20Documentation_Market%20Research_PhraseExpander_1.png)
    ![PhraseExpander Screenshot 2](images%20and%20documents/2024-07-20_Ward%20Round%20Documentation_Market%20Research_PhraseExpander_2.png)
    ![PhraseExpander Screenshot 3](images%20and%20documents/2024-07-20_Ward%20Round%20Documentation_Market%20Research_PhraseExpander_3.png)
    ![PhraseExpander Screenshot 4](images%20and%20documents/2024-07-20_Ward%20Round%20Documentation_Market%20Research_PhraseExpander_4.png)
    ![PhraseExpander Screenshot 5](images%20and%20documents/2024-07-20_Ward%20Round%20Documentation_Market%20Research_PhraseExpander_5.png)

&nbsp;

-	**TextExpander**
    -	https://textexpander.com/industry/healthcare
    -	Product for healthcare:
        -	Centralized knowledge base: Build and manage your own custom library of medical and terminology.
        -	Document knowledge with ease: Reduce the time spent retyping the same things and get back to what you love — taking care of patients.
        -	Accessible anywhere you type: Work on any device, within any EMR, patient management system, or billing software.
        -	Maintain patient privacy: Enterprise-grade security keeps your sensitive information secure and confidential.
    -	Access of text blocks via abbreviations, key combo or search
    -	What we want to do differently: Develop a product uniquely designed for health care professionals and not for all industries. A lot of the functionality can however be interesting for us, but maybe not short term.
    ![TextExpander Screenshot 1](images%20and%20documents/2024-07-20_Ward%20Round%20Documentation_Market%20Research_TextExpander_1.png)
    ![TextExpander Screenshot 2](images%20and%20documents/2024-07-20_Ward%20Round%20Documentation_Market%20Research_TextExpander_2.png)

___

## 12. Additional Information

    - Include any relevant information not captured in the above sections, such as:
       - Screenshots or mockups of the desired interface (if available)
       - References to relevant medical guidelines or protocols

- tbd
