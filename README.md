# Project Calculator Setup

A bash script to quickly set up a Next.js project with an advanced project timeline calculator component.

## Overview

This repository contains a bash script (`setup_project_calculator.sh`) that automates the creation of a complete Next.js project with TypeScript, Tailwind CSS, and a sophisticated Project Timeline Calculator component. The calculator helps you plan and visualize project timelines, resource allocation, and evaluation points needed.

## Features

The Project Calculator allows you to:

- Add multiple projects with customizable names, hours needed, and priorities
- Set working hours per day and days per week
- Account for break times in your schedule
- Track evaluation points needed vs. available
- Visualize project distribution with interactive charts
- Generate detailed statistics about project timelines
- Export all data as formatted Markdown
- See a projected completion date based on your work schedule

## Prerequisites

To use this script, you need to have the following installed on your system:

- Node.js (14.x or higher)
- npm (6.x or higher)
- Bash shell (comes pre-installed on macOS and most Linux distributions)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/project-calculator-setup.git
   cd project-calculator-setup
   ```

2. Make the script executable:
   ```bash
   chmod +x setup_project_calculator.sh
   ```

3. Run the script:
   ```bash
   ./setup_project_calculator.sh
   ```

4. Follow the prompts to create your project.

## Usage

When you run the script, it will:

1. Prompt you for a project directory name
2. Create a new Next.js project with TypeScript and Tailwind CSS
3. Install all required dependencies
4. Set up the UI component library
5. Create the Project Calculator component
6. Configure everything to work out of the box

After the script completes:

```bash
cd your-project-name
npm run dev
```

Then open your browser to http://localhost:3000 to see the Project Calculator.

## Project Calculator Features

The calculator includes several powerful features:

### Time Management
- Set custom working hours per day
- Define your working days per week
- Account for breaks in your schedule

### Project Management
- Add unlimited projects
- Set hours required for each project
- Assign evaluations needed
- Set priority levels and difficulty ratings

### Visualization
- Bar charts showing project distribution
- Timeline calculations
- Progress metrics
- Time breakdown statistics

### Export
- Copy all data as formatted Markdown with one click
- Generate detailed project timeline reports

## Component Structure

The generated project includes the following main components:

- `project-calculator.tsx`: The main calculator component
- UI components from shadcn/ui (Button, Card, Input)
- Tailwind CSS for styling
- Recharts for data visualization

## Customization

After installation, you can customize the calculator by editing:

- `src/components/project-calculator.tsx`: The main component code
- `src/app/page.tsx`: The page that renders the calculator
- `tailwind.config.js`: For styling adjustments

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Next.js](https://nextjs.org/)
- [Tailwind CSS](https://tailwindcss.com/)
- [shadcn/ui](https://ui.shadcn.com/)
- [Recharts](https://recharts.org/)
- [Lucide Icons](https://lucide.dev/)
