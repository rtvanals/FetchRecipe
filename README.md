
### Steps to Run the App
Simply build and run the project after resolving the dependency. No additional setup should be required.

### Focus Areas: 
My primary focus was on the UI, as it formed the core of the project and there wasn’t much additional complexity required. After implementing the basic GET API to fetch data, the majority of my effort went into building and refining the views to meet the requirements of the exercise.  

### Time Spent:
I spent approximately 4 hours on the test, spread out over a few days during the Thanksgiving holiday. I began by setting up the stubs for the views and view model, followed by creating the models and API integration. After completing the backend setup, I focused on building the UI, and finally, I dedicated time to writing the tests.”

### Trade-offs and Decisions:
There weren’t many trade-offs required, but I limited the UI implementation to meet the exercise scope. If this were a full app, I would include animations and spend additional time improving the Empty and Error States.

### Weakest Part of the Project:
I believe the weakest parts of the project are the empty state and error state views. If this were a more comprehensive app, I would enhance these views by adding features like a retry button or displaying more detailed information about the error. Additionally, I would improve the error handling for the list view. Instead of hiding the entire list if a single object in the response is malformed, I would handle such cases more gracefully by either removing the problematic object or displaying an ‘Error Cell’ to indicate there was an issue with a specific item.

### External Code and Dependencies
I used Kingfisher as a quick and reliable solution for downloading and caching images. However, I recognize that third-party solutions are not always optimal. I typically rely on libraries that are widely used and actively maintained.

### Additional Information:
I included comments inline with the code (search for `// Comment:`) to provide additional context and explain key decisions.
