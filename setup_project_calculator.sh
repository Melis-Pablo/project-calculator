#!/bin/bash
# Project Calculator Setup Script - Fixed Version
# This script will set up a complete Next.js project with the Project Calculator component

# Color codes for better output readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}    Project Calculator Setup Script    ${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# Create project directory
echo -e "${YELLOW}Enter the name of your project directory:${NC}"
read project_name

if [ -z "$project_name" ]; then
  project_name="project-calculator"
  echo -e "${YELLOW}Using default project name: ${project_name}${NC}"
fi

# Check if directory already exists
if [ -d "$project_name" ]; then
  echo -e "${RED}Directory $project_name already exists. Please choose a different name or remove the existing directory.${NC}"
  exit 1
fi

echo -e "${GREEN}Creating project: $project_name${NC}"
echo -e "${YELLOW}This will take a few minutes. Please be patient...${NC}"

# Create Next.js project with TypeScript, Tailwind CSS, and ESLint
echo -e "${BLUE}Setting up Next.js with TypeScript, Tailwind CSS, and ESLint...${NC}"
npx create-next-app@latest $project_name --typescript --tailwind --eslint

# Navigate to project directory
cd $project_name

# Install required dependencies for shadcn/ui components
echo -e "${BLUE}Installing dependencies for UI components...${NC}"
npm install @radix-ui/react-slot
npm install class-variance-authority
npm install clsx
npm install tailwindcss-animate
npm install lucide-react recharts

# Create UI component directory structure
echo -e "${BLUE}Creating UI component directories...${NC}"
mkdir -p src/components/ui
mkdir -p src/lib

# Create necessary UI utility files
echo -e "${BLUE}Creating UI utility files...${NC}"

# Create utils.ts file
cat > src/lib/utils.ts << 'EOL'
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
EOL

# Create basic UI components

# Button component
cat > src/components/ui/button.tsx << 'EOL'
import * as React from "react";
import { Slot } from "@radix-ui/react-slot";
import { cva, type VariantProps } from "class-variance-authority";

import { cn } from "@/lib/utils";

const buttonVariants = cva(
  "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-white transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-slate-950 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 dark:ring-offset-slate-950 dark:focus-visible:ring-slate-300",
  {
    variants: {
      variant: {
        default: "bg-slate-900 text-slate-50 hover:bg-slate-900/90 dark:bg-slate-50 dark:text-slate-900 dark:hover:bg-slate-50/90",
        destructive: "bg-red-500 text-slate-50 hover:bg-red-500/90 dark:bg-red-900 dark:text-slate-50 dark:hover:bg-red-900/90",
        outline: "border border-slate-200 bg-white hover:bg-slate-100 hover:text-slate-900 dark:border-slate-800 dark:bg-slate-950 dark:hover:bg-slate-800 dark:hover:text-slate-50",
        secondary: "bg-slate-100 text-slate-900 hover:bg-slate-100/80 dark:bg-slate-800 dark:text-slate-50 dark:hover:bg-slate-800/80",
        ghost: "hover:bg-slate-100 hover:text-slate-900 dark:hover:bg-slate-800 dark:hover:text-slate-50",
        link: "text-slate-900 underline-offset-4 hover:underline dark:text-slate-50",
      },
      size: {
        default: "h-10 px-4 py-2",
        sm: "h-9 rounded-md px-3",
        lg: "h-11 rounded-md px-8",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
);

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean;
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : "button";
    return (
      <Comp
        className={cn(buttonVariants({ variant, size, className }))}
        ref={ref}
        {...props}
      />
    );
  }
);
Button.displayName = "Button";

export { Button, buttonVariants };
EOL

# Card component
cat > src/components/ui/card.tsx << 'EOL'
import * as React from "react";

import { cn } from "@/lib/utils";

const Card = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn(
      "rounded-lg border border-slate-200 bg-white text-slate-950 shadow-sm dark:border-slate-800 dark:bg-slate-950 dark:text-slate-50",
      className
    )}
    {...props}
  />
));
Card.displayName = "Card";

const CardHeader = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn("flex flex-col space-y-1.5 p-6", className)}
    {...props}
  />
));
CardHeader.displayName = "CardHeader";

const CardTitle = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLHeadingElement>
>(({ className, ...props }, ref) => (
  <h3
    ref={ref}
    className={cn(
      "text-2xl font-semibold leading-none tracking-tight",
      className
    )}
    {...props}
  />
));
CardTitle.displayName = "CardTitle";

const CardDescription = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLParagraphElement>
>(({ className, ...props }, ref) => (
  <p
    ref={ref}
    className={cn("text-sm text-slate-500 dark:text-slate-400", className)}
    {...props}
  />
));
CardDescription.displayName = "CardDescription";

const CardContent = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div ref={ref} className={cn("p-6 pt-0", className)} {...props} />
));
CardContent.displayName = "CardContent";

const CardFooter = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn("flex items-center p-6 pt-0", className)}
    {...props}
  />
));
CardFooter.displayName = "CardFooter";

export {
  Card,
  CardHeader,
  CardFooter,
  CardTitle,
  CardDescription,
  CardContent,
};
EOL

# Input component
cat > src/components/ui/input.tsx << 'EOL'
import * as React from "react";

import { cn } from "@/lib/utils";

export interface InputProps
  extends React.InputHTMLAttributes<HTMLInputElement> {}

const Input = React.forwardRef<HTMLInputElement, InputProps>(
  ({ className, type, ...props }, ref) => {
    return (
      <input
        type={type}
        className={cn(
          "flex h-10 w-full rounded-md border border-slate-200 bg-white px-3 py-2 text-sm ring-offset-white file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-slate-500 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-slate-950 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 dark:border-slate-800 dark:bg-slate-950 dark:ring-offset-slate-950 dark:placeholder:text-slate-400 dark:focus-visible:ring-slate-300",
          className
        )}
        ref={ref}
        {...props}
      />
    );
  }
);
Input.displayName = "Input";

export { Input };
EOL

# Install tailwind-merge
npm install tailwind-merge

# Create the ProjectCalculator component
echo -e "${BLUE}Creating the ProjectCalculator component...${NC}"

cat > src/components/project-calculator.tsx << 'EOL'
"use client"
import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Plus, Trash2, Calendar, Clock, Trophy, FileDown } from 'lucide-react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts';

const ProjectCalculator = () => {
  const [projects, setProjects] = useState([]);
  const [hoursPerDay, setHoursPerDay] = useState(4);
  const [daysPerWeek, setDaysPerWeek] = useState(5);
  const [evaluationPoints, setEvaluationPoints] = useState(5);
  const [startDate, setStartDate] = useState(new Date().toISOString().split('T')[0]);
  const [breaksPerDay, setBreaksPerDay] = useState(1);
  const [breakDuration, setBreakDuration] = useState(15);

  const addProject = () => {
    setProjects([...projects, {
      name: '',
      hours: 0,
      evaluations: 1,
      priority: projects.length + 1,
      difficulty: 'medium',
      id: Date.now()
    }]);
  };

  const removeProject = (id) => {
    setProjects(projects.filter(project => project.id !== id));
  };

  const updateProject = (id, field, value) => {
    setProjects(projects.map(project =>
      project.id === id ? { ...project, [field]: value } : project
    ));
  };

  const calculateDetailedStats = () => {
    const totalHours = projects.reduce((sum, project) => sum + Number(project.hours), 0);
    const totalEvaluations = projects.reduce((sum, project) => sum + Number(project.evaluations), 0);
    const evaluationsNeeded = Math.max(0, totalEvaluations - evaluationPoints);

    const effectiveHoursPerDay = hoursPerDay - (breaksPerDay * breakDuration / 60);
    const hoursPerWeek = effectiveHoursPerDay * daysPerWeek;
    const totalWorkDays = Math.ceil(totalHours / effectiveHoursPerDay);
    const totalWorkWeeks = Math.ceil(totalWorkDays / daysPerWeek);
    const totalCalendarDays = Math.ceil(totalWorkDays * (7/daysPerWeek));

    const completionDate = new Date(startDate);
    completionDate.setDate(completionDate.getDate() + totalCalendarDays);

    const dailyWorkload = {
      grossHours: hoursPerDay,
      netHours: effectiveHoursPerDay,
      totalBreakTime: (breaksPerDay * breakDuration / 60),
      projectsPerDay: totalHours / totalWorkDays
    };

    const progressMetrics = {
      evaluationsPerWeek: totalEvaluations / totalWorkWeeks,
      averageHoursPerProject: totalHours / projects.length || 0,
      projectsPerWeek: projects.length / totalWorkWeeks
    };

    const projectData = projects.map(project => ({
      name: project.name || 'Unnamed Project',
      hours: Number(project.hours),
      evaluations: Number(project.evaluations)
    }));

    return {
      totals: {
        hours: totalHours,
        evaluations: totalEvaluations,
        evaluationsNeeded,
        workDays: totalWorkDays,
        calendarDays: totalCalendarDays,
        workWeeks: totalWorkWeeks
      },
      daily: dailyWorkload,
      progress: progressMetrics,
      completion: completionDate,
      projectData
    };
  };

  const generateMarkdown = () => {
    const stats = calculateDetailedStats();
    const currentDate = new Date().toLocaleDateString();
    const startDateObj = new Date(startDate);

    // Create project table rows
    const projectTable = projects.length > 0
      ? projects.map(p => `| ${p.name || 'Unnamed'} | ${p.hours} | ${p.evaluations} | ${p.priority} | ${p.difficulty} |`).join('\n')
      : '| | | | | |';

    let markdown = `# Project Timeline Analysis
*Generated on ${currentDate}*
## Overview
- **Total Projects**: ${projects.length}
- **Total Work Hours**: ${stats.totals.hours.toFixed(1)}
- **Expected Completion**: ${startDateObj.toLocaleDateString()}
- **Timeline**: ${startDateObj.toLocaleDateString()} -> ${stats.completion.toLocaleDateString()}
- **Total Calendar Days**: ${stats.totals.calendarDays}
## Schedule Details
- Working Days: ${daysPerWeek} days/week
- Daily Hours: ${hoursPerDay} hours/day
- Break Schedule: ${breaksPerDay}x ${breakDuration}min breaks/day
- Total Daily Break Time: ${stats.daily.totalBreakTime.toFixed(2)} hours
- Net Working Hours: ${stats.daily.netHours.toFixed(1)} hours/day
## Progress Metrics
- Projects Per Week: ${stats.progress.projectsPerWeek.toFixed(2)}
- Average Hours Per Project: ${stats.progress.averageHoursPerProject.toFixed(2)}
- Daily Workload: ${stats.daily.projectsPerDay.toFixed(2)} hours
## Evaluation Points
- Total Evaluations Required: ${stats.totals.evaluations}
- Available Evaluation Points: ${evaluationPoints}
- Additional Points Needed: ${stats.totals.evaluationsNeeded}
- Evaluations Per Week: ${stats.progress.evaluationsPerWeek.toFixed(2)}
## Timeline
- Start Date: ${startDateObj.toLocaleDateString()}
- Projected Completion Date: ${stats.completion.toLocaleDateString()}
- Total Work Days: ${stats.totals.workDays}
- Calendar Days: ${stats.totals.calendarDays}
- Total Work Weeks: ${stats.totals.workWeeks.toFixed(1)}
- Working Schedule: ${daysPerWeek} days/week -> ${hoursPerDay}h/day
## Project Details

| Project Name | Hours | Evaluations | Priority | Difficulty |
|--------------|-------|-------------|-----------|------------|
${projectTable}

## Daily Breakdown
- Gross working hours: ${hoursPerDay}
- Net working hours: ${stats.daily.netHours.toFixed(1)}
- Total break time: ${stats.daily.totalBreakTime.toFixed(1)} hours
- Average project work: ${stats.daily.projectsPerDay.toFixed(1)} hours

## Notes
- All estimates based on consistent work schedule
- Break times included in calculations
- Weekend days accounted for in timeline
- Priority ranges from 1 (highest) to ${projects.length || 0} (lowest)

---
*This analysis was generated using the Project Timeline Calculator*`;

    return markdown;
  };

  const copyToClipboard = async () => {
    const markdown = generateMarkdown();
    try {
      await navigator.clipboard.writeText(markdown);
      alert('Markdown copied to clipboard!');
    } catch (err) {
      console.error('Failed to copy text: ', err);
      alert('Failed to copy to clipboard. Please try again.');
    }
  };

  const stats = calculateDetailedStats();

  return (
    <div className="min-h-screen bg-gray-50 text-gray-900 p-4">
      <Card className="max-w-6xl mx-auto bg-white border-gray-200">
        <CardHeader>
          <CardTitle className="text-2xl text-gray-800">Advanced Project Timeline Calculator</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-6">
            {/* Settings */}
            <div className="grid grid-cols-3 gap-4">
              <div>
                <label className="block text-sm mb-2">Hours per Day</label>
                <Input
                  type="number"
                  value={hoursPerDay}
                  onChange={(e) => setHoursPerDay(Number(e.target.value))}
                  className="bg-white border-gray-300 text-gray-900"
                />
              </div>
              <div>
                <label className="block text-sm mb-2">Days per Week</label>
                <Input
                  type="number"
                  value={daysPerWeek}
                  min="1"
                  max="7"
                  onChange={(e) => setDaysPerWeek(Number(e.target.value))}
                  className="bg-white border-gray-300 text-gray-900"
                />
              </div>
              <div>
                <label className="block text-sm mb-2">Available Evaluation Points</label>
                <Input
                  type="number"
                  value={evaluationPoints}
                  onChange={(e) => setEvaluationPoints(Number(e.target.value))}
                  className="bg-white border-gray-300 text-gray-900"
                />
              </div>
              <div>
                <label className="block text-sm mb-2">Start Date</label>
                <Input
                  type="date"
                  value={startDate}
                  onChange={(e) => setStartDate(e.target.value)}
                  className="bg-white border-gray-300 text-gray-900"
                />
              </div>
              <div>
                <label className="block text-sm mb-2">Breaks per Day</label>
                <Input
                  type="number"
                  value={breaksPerDay}
                  onChange={(e) => setBreaksPerDay(Number(e.target.value))}
                  className="bg-white border-gray-300 text-gray-900"
                />
              </div>
              <div>
                <label className="block text-sm mb-2">Break Duration (minutes)</label>
                <Input
                  type="number"
                  value={breakDuration}
                  onChange={(e) => setBreakDuration(Number(e.target.value))}
                  className="bg-white border-gray-300 text-gray-900"
                />
              </div>
            </div>

            {/* Projects List */}
            <div className="space-y-4">
              {projects.map((project) => (
                <div key={project.id} className="grid grid-cols-6 gap-4 items-end">
                  <div>
                    <label className="block text-sm mb-2">Project Name</label>
                    <Input
                      value={project.name}
                      onChange={(e) => updateProject(project.id, 'name', e.target.value)}
                      placeholder="Project name"
                      className="bg-white border-gray-300 text-gray-900"
                    />
                  </div>
                  <div>
                    <label className="block text-sm mb-2">Hours Needed</label>
                    <Input
                      type="number"
                      value={project.hours}
                      onChange={(e) => updateProject(project.id, 'hours', Number(e.target.value))}
                      className="bg-white border-gray-300 text-gray-900"
                    />
                  </div>
                  <div>
                    <label className="block text-sm mb-2">Evaluations Needed</label>
                    <Input
                      type="number"
                      value={project.evaluations}
                      onChange={(e) => updateProject(project.id, 'evaluations', Number(e.target.value))}
                      className="bg-white border-gray-300 text-gray-900"
                    />
                  </div>
                  <div>
                    <label className="block text-sm mb-2">Priority</label>
                    <Input
                      type="number"
                      value={project.priority}
                      onChange={(e) => updateProject(project.id, 'priority', Number(e.target.value))}
                      className="bg-white border-gray-300 text-gray-900"
                    />
                  </div>
                  <div>
                    <label className="block text-sm mb-2">Difficulty</label>
                    <select
                      value={project.difficulty}
                      onChange={(e) => updateProject(project.id, 'difficulty', e.target.value)}
                      className="w-full rounded-md bg-white border-gray-300 text-gray-900 p-2"
                    >
                      <option value="easy">Easy</option>
                      <option value="medium">Medium</option>
                      <option value="hard">Hard</option>
                    </select>
                  </div>
                  <Button
                    variant="destructive"
                    onClick={() => removeProject(project.id)}
                    className="bg-red-500 hover:bg-red-600"
                  >
                    <Trash2 className="w-4 h-4" />
                  </Button>
                </div>
              ))}
            </div>

            {/* Action Buttons */}
            <div className="flex gap-4">
              <Button onClick={addProject} className="bg-blue-500 hover:bg-blue-600 text-white">
                <Plus className="w-4 h-4 mr-2" /> Add Project
              </Button>
              <Button
                onClick={copyToClipboard}
                className="bg-green-500 hover:bg-green-600 text-white"
                disabled={projects.length === 0}
              >
                <FileDown className="w-4 h-4 mr-2" /> Copy to Clipboard
              </Button>
            </div>

            {/* Detailed Statistics */}
            <div className="grid grid-cols-3 gap-4">
              {/* Time Stats */}
              <Card className="bg-white border-gray-200">
                <CardHeader>
                  <CardTitle className="text-lg flex items-center text-gray-800">
                    <Clock className="w-5 h-5 mr-2" /> Time Breakdown
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    <p>Total Hours: {stats.totals.hours.toFixed(1)}</p>
                    <p>Work Days: {stats.totals.workDays}</p>
                    <p>Calendar Days: {stats.totals.calendarDays}</p>
                    <p>Work Weeks: {stats.totals.workWeeks.toFixed(1)}</p>
                    <p>Daily Net Hours: {stats.daily.netHours.toFixed(1)}</p>
                    <p>Daily Break Time: {stats.daily.totalBreakTime.toFixed(1)}h</p>
                  </div>
                </CardContent>
              </Card>

              {/* Progress Stats */}
              <Card className="bg-white border-gray-200">
                <CardHeader>
                  <CardTitle className="text-lg flex items-center text-gray-800">
                    <Trophy className="w-5 h-5 mr-2" /> Progress Metrics
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    <p>Projects Per Week: {stats.progress.projectsPerWeek.toFixed(1)}</p>
                    <p>Hours Per Project: {stats.progress.averageHoursPerProject.toFixed(1)}</p>
                    <p>Daily Project Hours: {stats.daily.projectsPerDay.toFixed(1)}</p>
                    <p>Evaluations Per Week: {stats.progress.evaluationsPerWeek.toFixed(1)}</p>
                    <p>Additional Points Needed: {stats.totals.evaluationsNeeded}</p>
                  </div>
                </CardContent>
              </Card>

              {/* Timeline Stats */}
              <Card className="bg-white border-gray-200">
                <CardHeader>
                  <CardTitle className="text-lg flex items-center text-gray-800">
                    <Calendar className="w-5 h-5 mr-2" /> Timeline
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-2">
                    <p>Start Date: {new Date(startDate).toLocaleDateString()}</p>
                    <p>Completion Date: {stats.completion.toLocaleDateString()}</p>
                    <p>Working Days: {daysPerWeek} days/week</p>
                    <p>Daily Schedule: {hoursPerDay}h gross, {stats.daily.netHours.toFixed(1)}h net</p>
                    <p>Breaks: {breaksPerDay}x {breakDuration}min</p>
                  </div>
                </CardContent>
              </Card>
            </div>

            {/* Project Distribution Chart */}
            {projects.length > 0 && (
              <Card className="bg-white border-gray-200 p-4">
                <CardHeader>
                  <CardTitle className="text-lg text-gray-800">Project Distribution</CardTitle>
                </CardHeader>
                <CardContent className="h-64">
                  <ResponsiveContainer width="100%" height="100%">
                    <BarChart data={stats.projectData}>
                      <XAxis dataKey="name" stroke="#4B5563" />
                      <YAxis stroke="#4B5563" />
                      <Tooltip
                        contentStyle={{ backgroundColor: '#FFFFFF', border: '1px solid #E5E7EB' }}
                        labelStyle={{ color: '#111827' }}
                      />
                      <Bar dataKey="hours" fill="#3B82F6" name="Hours" />
                      <Bar dataKey="evaluations" fill="#10B981" name="Evaluations" />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default ProjectCalculator;
EOL

# Update the main page to use the calculator
echo -e "${BLUE}Updating the main page to include the calculator...${NC}"

cat > src/app/page.tsx << 'EOL'
import ProjectCalculator from '@/components/project-calculator'

export default function Home() {
  return <ProjectCalculator />
}
EOL

# Update tailwind.config.js to include animation
echo -e "${BLUE}Updating Tailwind configuration...${NC}"
cat > tailwind.config.js << 'EOL'
/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: [
    './pages/**/*.{ts,tsx}',
    './components/**/*.{ts,tsx}',
    './app/**/*.{ts,tsx}',
    './src/**/*.{ts,tsx}',
  ],
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      keyframes: {
        "accordion-down": {
          from: { height: 0 },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: 0 },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
}
EOL

# Final steps
echo -e "${GREEN}Setup completed successfully!${NC}"
echo -e "${BLUE}================================================${NC}"
echo -e "${YELLOW}To run your project:${NC}"
echo -e "${GREEN}cd $project_name${NC}"
echo -e "${GREEN}npm run dev${NC}"
echo -e "${YELLOW}Then open your browser to: ${GREEN}http://localhost:3000${NC}"
echo -e "${BLUE}================================================${NC}"
