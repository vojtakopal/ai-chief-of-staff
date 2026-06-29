#!/usr/bin/env bash
# Dump GitHub project #42 (apify data team board) items as JSON for analysis.
#
# Prereqs:
#   - gh CLI installed (this repo's setup installs it)
#   - GH_TOKEN env var set to a token that can read the apify org's Projects v2
#     (scopes: read:project, read:org, repo; SSO-authorised for the apify org)
#
# Usage:
#   bash scripts/gh-project42-dump.sh > p42.json
#
# Fields pulled per item: Status, Size, Iteration, Team (single-select / number /
# iteration) plus the linked Issue/PR number, title, state, closedAt, and assignees
# (logins) - assignees enable /1on1 per-person "what's on their plate".

set -euo pipefail

gh api graphql --paginate -f org=apify -F number=42 -f query='
query($org:String!, $number:Int!, $endCursor:String){
  organization(login:$org){
    projectV2(number:$number){
      title
      items(first:100, after:$endCursor){
        pageInfo{ hasNextPage endCursor }
        nodes{
          fieldValues(first:20){ nodes{
            __typename
            ... on ProjectV2ItemFieldSingleSelectValue{ name field{ ... on ProjectV2FieldCommon{ name } } }
            ... on ProjectV2ItemFieldNumberValue{ number field{ ... on ProjectV2FieldCommon{ name } } }
            ... on ProjectV2ItemFieldIterationValue{ title field{ ... on ProjectV2FieldCommon{ name } } }
          }}
          content{
            __typename
            ... on Issue{ number title state closedAt assignees(first:10){ nodes{ login } } }
            ... on PullRequest{ number title state closedAt assignees(first:10){ nodes{ login } } }
          }
        }
      }
    }
  }
}'
