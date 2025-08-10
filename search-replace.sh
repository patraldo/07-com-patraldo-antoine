#!/bin/bash

# search-replace.sh or rename-artist.sh
# Safely rename artist across project with full log
# Fixed to properly find files like +layout.svelte

OLD_NAME="MAYA CHEN"
NEW_NAME="Antoine Patraldo"

LOG_FILE="rename-artist-log.txt"
TIMESTAMP=$(date)

echo "🎨 Artist Name Replacement Log" > "$LOG_FILE"
echo "From: $OLD_NAME" >> "$LOG_FILE"
echo "To:   $NEW_NAME" >> "$LOG_FILE"
echo "Date: $TIMESTAMP" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

TOTAL_CHANGES=0
CHANGED_FILES=()

# Find all relevant files with proper precedence
mapfile -t files < <(find . \
  -type f \
  \( -name "*.svelte" -o -name "*.js" -o -name "*.css" -o -name "*.html" -o -name "*.json" -o -name "*.jsonc" \) \
  -not -path "*/node_modules/*" \
  -not -path "*/.git/*" \
  -not -path "*/build/*" \
  -not -path "*/dist/*" \
  -not -path "*/static/*" \
  -not -path "*.backup*" \
  -not -path "$LOG_FILE" \
  -print)

for file in "${files[@]}"; do
  # Skip if file doesn't contain old name (case-insensitive)
  if ! grep -qi "$OLD_NAME" "$file"; then
    continue
  fi

  # Backup first
  backup="${file}.backup.$(date +%s)"
  cp "$file" "$backup"

  # Count matches (case-insensitive)
  count=$(grep -io "$OLD_NAME" "$file" | wc -l)
  ((TOTAL_CHANGES += count))

  # Perform replacement (case-insensitive)
  sed -i '' "s/$OLD_NAME/$NEW_NAME/gi" "$file"
  CHANGED_FILES+=("$file ($count occurrence(s))")

  echo "📄 Modified: $file" >> "$LOG_FILE"
  echo "   🔁 Replaced $count occurrence(s)" >> "$LOG_FILE"
  echo "   🔁 Backed up as: $backup" >> "$LOG_FILE"
done

# Summary
echo "" >> "$LOG_FILE"
echo "✅ SUMMARY" >> "$LOG_FILE"
if [ $TOTAL_CHANGES -eq 0 ]; then
  echo "No instances of '$OLD_NAME' found." >> "$LOG_FILE"
else
  echo "Total replacements made: $TOTAL_CHANGES" >> "$LOG_FILE"
  echo "Files updated:" >> "$LOG_FILE"
  for f in "${CHANGED_FILES[@]}"; do
    echo "  - $f" >> "$LOG_FILE"
  done
fi

echo "Log saved to: $LOG_FILE"
echo ""
cat "$LOG_FILE"
