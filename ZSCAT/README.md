# SCAT (SAP Cutover Activities Tool)

## Description

SCAT (SAP Cutover Activities Tool) is a comprehensive ABAP report designed to assist technical teams during SAP system cutovers, testing, hypercare, and support phases. It provides a wide range of utilities for comparing SAP systems, managing transports, and analyzing source code, helping to identify discrepancies and ensure system consistency across the landscape.

## Features

The tool is organized into several main functions, each offering a variety of detailed reports and actions:

### 1. ABAP RFC Connection Test
-   Allows for testing multiple Type 3 (ABAP connections) RFC Destinations simultaneously to ensure they are working correctly.

### 2. Comparisons
This function allows for the comparison of various repository and configuration objects between a source and a target system.

#### Generic Comparisons
-   **Table Entries:** Compares data entries in a specified table.
-   **Graphics:** Compares graphics and logos (e.g., those used in forms).
-   **Report Variants:** Identifies differences in report variants.
-   **Standard Texts:** Compares standard text objects (SO10).
-   **Custom Page Formats:** Compares custom page formats for printing.
-   **External OS Commands:** Compares the definition of external operating system commands.
-   **Message Classes:** Compares message classes and their messages.
-   **Workflow Event Linkages:** Compares the event linkage configuration for workflows.
-   **Ports:** Compares transactional RFC (tRFC) and file ports.
-   **Fonts:** Compares font families.
-   **Barcodes:** Compares barcode definitions.
-   **Change Pointers:** Compares the status of ALE change pointers.
-   **VOFM Routines:** Validates the generation status of VOFM routines.

#### Interface Comparisons
-   **Partner Profiles:** Compares partner profiles for both inbound and outbound parameters.
-   **Distribution Models:** Compares ALE distribution models.

### 3. Transport Utility
A set of tools for managing and analyzing transport requests.

-   **Status of Released Transports:** Checks the import status and return codes of released transports in target systems.
-   **List of Open Transports:** Lists all modifiable transport requests in the development environment.
-   **Dependency Check (Quality):** Identifies dependent transports that are open in the quality system for a specific object or transport.
-   **Dependency Check (Development):** Finds all dependent objects for a given transport request within the development system to ensure all necessary components are included before release.

### 4. Source Code Comparison Utility
-   Compares different versions of repository objects (Programs, Function Modules, Classes) between a source and multiple target systems.
-   Highlights differences in both the source code and the associated text elements.

### 5. Other Utilities
-   **List of Local Objects:** Generates a list of all custom objects assigned to the local `$TMP` package.
-   **Unlocked Standard Texts:** Identifies custom standard texts that are not locked in any transport request.

## Prerequisites

1.  **System Environment:** The SCAT tool must be installed in a development environment.
2.  **RFC Connections:** Reliable ABAP RFC connections (Type 3) must be configured in `SM59` from the development system to all other systems in the landscape (e.g., Quality, Production) that you wish to test or compare.
3.  **User Authorizations:** The RFC user configured in the RFC destination should be of type "System User" and must have sufficient authorizations to read repository objects, configuration data, and transport information in the target systems.

## How to Use

1.  **Execution:**
    -   Run the report `ZSCAT_UTR` via transaction `SE38`.
    -   Alternatively, if a transaction code has been created (e.g., `ZUTSCAT`), you can use that.

2.  **Selection Screen:**
    -   The main screen presents the five primary functions of the tool as radio buttons:
        -   `ABAP RFC Connection Test`
        -   `Comparisons`
        -   `Transport Utility`
        -   `Source Code Comparison Utility`
        -   `Other Utilities`
    -   Select the desired function. The selection screen will dynamically display the relevant options for the chosen function.
    -   Fill in the required parameters, such as RFC destinations, object names, transport numbers, or date ranges.
    -   Click the "Execute" button (F8) to run the report.

3.  **Output:**
    -   The results are displayed in a clear and interactive ALV (ABAP List Viewer) grid, allowing for easy sorting, filtering, and analysis.
