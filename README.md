# Ineza Jules's Stepper Widget Presentation

**Widget description:** The Material `Stepper` widget guides users through a two-step account registration form.

## Run the app

1. Make sure Flutter is installed and an emulator, simulator, or physical device is available.
2. From the project directory, install the dependencies:

   ```bash
   flutter pub get
   ```

3. Run the application:

   ```bash
   flutter run
   ```

Tap **Sign up** on the login screen to open the registration stepper.

## Three important `Stepper` attributes

- `currentStep`: Stores the active step and controls which part of the form is currently selected.
- `onStepContinue`: Validates the current form and advances to the next step, or completes registration on the final step.
- `onStepCancel`: Moves back to the previous step when the user selects **Back**.

## Final UI screenshot


