# Feature Name: Ward Round Documentation

## 1. Problem Statement

    - Briefly describe the current workflows' main point(s) this feature aims to address.

The manner in which ward rounds are documented varies considerably between hospitals and even between different wards within the same hospital. Frequently, this documentation is merely a free text entry, which is often made hours after the ward rounds have concluded. This can result in the loss of valuable information. Additionally, the required information is not always readily available, which makes it challenging to make informed decisions and may also lead to the overlooking of important findings, which could potentially endanger the patient. The procedure discussed during ward rounds necessitates the prompt distribution of tasks to the team to ensure timely patient care. The objective of the "Ward Round Documentation" system is to integrate the required functionality to provide doctors with a comprehensive overview of relevant information and to facilitate the swift documentation and task distribution processes.

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
- Interface design
    - Modular design with automated optimized arrangement
    - Possibility to drag and drop boxes with certain information or tools
    - A fixed box for the ward round documentation itself should be located on the left (?) side of the screen
- Pre-designed structure of the ward round documentation
    - e.g. SOAP:
        - Subjective: Current complaints reported by the patient.
        - Objective: Current findings (physical examination, laboratory results, imaging, consultations etc.).
        - Assessment: Brief assessment of the current problems.
        - Procedure: Numerical list of current decisions regarding the diagnosis and treatment.
    - Possibility to define ward-/hospital-specific templates (e.g. FAST HUGS for ICU) with semi-automated step-by-step assessment with the relevant information provided at each step
    - Possibility to create personalized text modules that can be inserted via short-cuts
- Current findings from last 1-3 days at a glance (possibly each type in a separate box that can be navigated and adjusted individually, i.e. to see full history)
    - Laboratory (possibly only abnormal values)
    - Add late registration of desired lab values
    - Plan lab test (e.g. for next day), possibly with connection to the label printer
    - Microbiology
    - Summary of findings of functional diagnostics (not performed by ward team)
    - Summary of radiology reports
    - Summary of medical consultations
    - Summary of surgeries
- Medication
    - List of current Medication
    - Possibility to discontinue medication, pause medication, change dose, start medication
    - Links to systems to research appropriate doses, interactions, etc. (e.g. MMI Pharmaindex)
- Relevant “properties” of the patient
    - Name, age, height, weight
    - Contact person, phone number
    - Allergies
    - ICD-coded diagnoses
- Links to the most recent doctor’s letter and current draft of the doctor’s letter
- Tasks
    - List of current patient-specific tasks with assigned responsibility
    - Create new task
    - Assign responsibility
    - Edit tasks
    - Etc.
- Particularly relevant for ICUs:
    - Vital signs (in case of ICU dynamically displayed, otherwise collected from manual entries)
    - List of currently used equipment (e.g. intravenous catheters, arterial indwelling catheters, central lines, drainages, bladder catheter), each with date of insertion and automated reminder to change the material, e.g. as a helpwave task (intervals can previously be determined based on the local SOPs = standard operating procedures)
- Appointments
    - List of important planned appointments, e.g.:
    - Therapy (surgery, dialysis, etc.)
    - Diagnostics (beyond the scope of the own ward, e.g. imaging)
    - External appointments (rehabilitation, ambulatory follow-up, etc.)
    - Status of planned discharge or transferal to a different ward or medical facility
    - Possibility to register new appointments directly (e.g. chest x-ray) or communicate with the patient management team (without having to write an e-mail)
    - Possibility to view ward occupancy plan, ward calendar, etc.
- Scores and scales
    - “one-click” documentation of relevant scores and scales (e.g. NRS, SOFA, GCS, RASS)
    - Image documentation (e.g. for wound management)

___

## 4. User Stories

    - List several user stories or scenarios, which are brief descriptions of how different user roles (doctors, nurses, pharmacists, administrative staff etc.) will interact with the feature.
    - Each user story should follow the format: "As a [user role], I want to [action] so that [benefit]." (e.g., "As a doctor, I want to quickly access a patients' medication history so that I can make informed prescribing decisions.")

- What types of ward rounds are there?
    1. Doctors daily round on each patient in their ward. Ward Rounds usually include all junior doctors that are assigned to the ward as well as some senior doctors. It is common that nurses join the ward round only for those patients that they are responsible for, so that they can give additional information if needed.
    2. Nurses usually round on patients at the beginning of their shift to pass on relevant information between from one shift to the next. The relevant information differs from the doctor ward rounds. Usually there are no decisions to be made regarding diagnostics and therapy.
    3. Interdisciplinary ward rounds take place in settings such as ICU (intensive care unit) and IMC (intermediate care unit). This might include the following employee groups: doctors, nurses, physiotherapist, speech therapist, patient management team (admin), etc.

**Main user story:**

- > As a physician, I want to see a summary of all relevant information at a glance, with an emphasis on the latest developments, so that I do not miss important facts. I want to be able to present a complete picture of the patient's current situation so that the medical team can agree on the next steps to ensure that the patient receives the best possible medical care.

___

## 5. User Flow

    - A graph that describes the flow of the user throughout the feature should be drawn. Where does the user access the feature? What can he or she do with it? What are possible actions within the process? Exact definitions of the views are not (yet) needed.


![Ward Round Documentation: User Flow](images%20and%20documents/Ward%20Round%20Documentation_User%20Flow_v1.png)
___

## 6. Functional Requirements

    - List all the specific functionalities the feature must have.
    - Be as clear and detailed as possible, considering different use cases.
    - Use common / user-friendly terms whenever possible, but include technical ones if necessary.

- Ward Round Documentation interface:
    - challenge: designing the ward round documentation interface in a way, that the relevant information can be seen without having to perform further actions but also not overcrowding the view
    - Main view with prioritized information arranged in boxes (no scrolling!)
    - Additional information (e.g. appointments, scores and scales, extensive lab results and not only abnormal values)
        - 1) One idea would be to have de-prioritized boxes minimized in a corner and extended when clicked on. The ideal arrangement of opened boxes could be automatic (e.g. including adjustment of text size and spacing) -> disadvantage: it would be more intuitive if the same information is always at the same spot
        - 2) A set number of predefined boxes and the information blocks can be added by drag-and-drop functionality. If a box is already filled, the previously displayed information is minimized and sent to the list of minimized information blocks
        - 3) De-prioritized information can be accessed via a tab function, where it would be visualized on the full-screen. The main view would always be available with one click or shortcut. There could also be standardized tabs with a specific topic, e.g. a whole view with a bit more detailed overview of all current findings. The main view could be reduced to the most pressing information that should not be overlooked (e.g. abnormal lab values, new radiology reports, planned appointments for the day)

___

## 7. Non-Functional Requirements

    - Specify any non-functional requirements such as:
        - Security: How will patient data privacy and security be ensured?
        - Performance: How fast should the feature respond to user actions? E.g. is stuff like immediate updating necessary?
        - Usability: What should the focus be in terms of accessibility to use for medical staff with varying levels of technical expertise? Can you anticipate any challenges? Be as detailed as possible and don't just repeat requirements to common design patterns.

- Security
    - Only physicians that are involved in the patient’s treatment have access to the full range of data
    - Digital documentation ensures that patient data does not leave the IT-system, e.g. by printing a patient list and not disposing it in data sensitive trash
- Performance
    - All data points should always be up to date (e.g. automatic refresh every 5 minutes and the possibility to refresh manually)
    - System interoperability should be seamless so that new windows open and close quickly
- Usability
    - Expected challenge: modular design might be confusing to some users

___

## 8. Dependencies and Constraints

    - Identify any dependencies or constraints, e.g. compatibility with existing hospital systems? What data is needed from where? Where is the data output possibly going?
        - other features, third-party systems  
        - regulatory requirements, hardware limitations, etc.

- Link to helpwave tasks and helpwave properties
- Third-party systems: laboratory, imaging
- Possibly real-time data from bedside monitoring systems

___

## 9. Success Criteria

    - Define how you will measure the success of the feature. What are the conditions under which the feature will be considered complete and satisfactory?
    - This could involve metrics like:
        - Reduction in time spent on specific tasks
        - Increase in user adoption of the feature
        - Decrease in error rates
        - Acceptance Criteria

- Ward round documented for 100% of assigned patients each day
- 20% (?) reduction in time spent searching for relevant information during ward rounds, resulting in increased time spent with patient interaction
- Decrease in error rates due to missed information (difficult to measure)

___

## 10. Potential Risks and Issues

    - Highlight any potential risks or issues that might arise from implementing the feature (e.g. acceptance of staff). 

- As long as only individual helpwave products are used, it may seem effortful to switch to the ward round documentation feature. This can be a problem, especially if the connection to other systems is difficult, making the feature slow. If it is not possible to connect to third party systems and extract summary findings etc., the value proposition of this new feature might be smaller.

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

**M-PDMS from Meierhofer**
- <https://www.meierhofer.com/loesungen/intensivmedizin/>
- > “Our web-based, touch-enabled and interoperable patient data management solution M-PDMS is used in many of the activities of your medical staff in the intensive care unit, intermediate care unit, chest pain unit, stroke unit and shock room.”
- Advantages mentioned:
    - Interoperability: All necessary data sources flexibly connected
    - Modern GUI: Pleasant to use user interface
    - Decision support: Avoid risks with control
    - Information and cost-effectiveness: Correct and revenue-securing documentation
- What we want to do differently: Focusing on ward round documentation, it is essential to combine all relevant information on one page. Additional information can be accessed from there. M-PDMS is not always intuitive, and we should be able to develop a better design. However, we should keep in mind, that M-PDMS in combination with M-KIS (Clinical Information System) is a system that offers almost all features needed for ward work. We therefore won’t need all features and information for you ward round documentation tool.
- Schematic overview of the system with in- and output:
![Schematic System Overview](images%20and%20documents/Ward%20Round%20Documentation_Market%20Research_M-PDMS_1.png)
- Screenshots:
![Screenshot 1 M-PDMS Interface](images%20and%20documents/Ward%20Round%20Documentation_Market%20Research_M-PDMS_2.png)
![Screenshot 2 M-PDMS Interface](images%20and%20documents/Ward%20Round%20Documentation_Market%20Research_M-PDMS_3.png)
![Screenshot 3 M-PDMS Interface](images%20and%20documents/Ward%20Round%20Documentation_Market%20Research_M-PDMS_4.png)
![Screenshot 4 M-PDMS Interface](images%20and%20documents/Ward%20Round%20Documentation_Market%20Research_M-PDMS_5.png)

**ICM-PDMS (Integrated Care Manager-Patient Data Management System) from Dräger**
- <https://www.draeger.com/de_de/Hospital/Patient-Data-Management-System>
- Like M-PDMS, it does not have a dedicated feature to make ward round documentation as easy and effective as possible. Also, these PDMS systems are mainly being used in intensive care units, whereas we want to create a tool that can be used in all parts of the hospital by offering different modules.
- Screenshot:
![Screenshot ICM-PDMS Interface](images%20and%20documents/Ward%20Round%20Documentation_Market%20Research_ICM-PDMS_1.png)

**Research Study from Medical University Clinic Tübingen**
- <https://www.wissenschaftscampus-tuebingen.de/www/en/forschung/forschungsbereiche/projekt08/index.html>
- Publication ([pdf](images%20and%20documents/The%20Interactive%20Ward%20Round%20Table:%20A%20Cognitive%20User%20Interface%20for%20Multi-Touch%20Tables%20to%20Support%20Clinical%20Diagnosis%20%7C%20Enhanced%20Reader.pdf)): Caroline Leroy et al., “The Interactive Ward Round Table: A Cognitive User Interface for Multi-Touch Tables to Support Clinical Diagnosis”, 2020,

- >“Our cognitive interface will allow externalizing parts of these mental representations, specifically information regarding the documents’ relevance and the relationships between documents (e.g. through the possibility to filter and group documents or to mark or annotate them). Thereby, we aim at reducing the amount of time and cognitive resources needed by medical experts to find the right diagnosis or to decide on a treatment. Implemented as a multi-user application with intuitive multi-touch movements such as rotating, sliding or zooming, our system also offers opportunities for group discussions during ward round preparation.“

- Take away for us: The timeline visualization of documents could be interesting.
- Screenshots:
![Screenshot 1 Study Tübingen Interface](images%20and%20documents/Ward%20Round%20Documentation_Market%20Research_Research%20Study%20T%C3%BCbingen_1.jpg)
![Screenshot 2 Study Tübingen Interface](images%20and%20documents/Ward%20Round%20Documentation_Market%20Research_Research%20Study%20T%C3%BCbingen_2.png)
___

## 12. Additional Information

    - Include any relevant information not captured in the above sections, such as:
       - Screenshots or mockups of the desired interface (if available)
       - References to relevant medical guidelines or protocols

- tbd
