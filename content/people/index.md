
---
title: People
date: 2022-10-24
type: landing

sections:
  - block: people
    content:
      title: Meet the Team
      # Define the exact display order of groups
      user_groups_order:
        - Group Leader
        - Principal Investigators
        - Researchers
        - PostDoc
        - PhD Candidate
        - MSc Student
        - Grad Students
        - Administration
        - Visitors
        - Alumni
      
      # Filter which groups to display (can be subset of order)
      user_groups:
        - Group Leader
        - Principal Investigators
        - Researchers
        - PostDoc
        - PhD Candidate
        - MSc Student
        - Grad Students
        - Administration
        - Visitors
        - Alumni
        
      # Sorting configuration
      sort_by: "user_groups,last_name"  # Sort by group first, then last name
      sort_ascending: true  # A-Z for names, lower groups first
      show_email: true  # Don't show emails by default
    design:
      show_organization: true  # Shows their organization
      show_interests: false  # Hide research interests
      show_role: true  # Show their role/position
      show_social: true  # Show social icons
      card_view: true  # Display as cards (false for list view)
      columns: "2"  # Number of columns for cards
      # Optional group headers
      show_group_headers: true  # Add section headers between groups
      group_headers_centered: false  # Left-align headers
      
---
        
