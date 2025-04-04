#!/bin/bash
#
# =========================================================================
# Title:         WordPress Cloudflare robots.txt Updater
# Description:   Automatically adds Cloudflare recommended directives to 
#                robots.txt files in WordPress installations
# Author:        David Carrero Fernández-Baillo <dcarrero@stackscale.com>
# Website:       https://carrero.es
# GitHub:        https://github.com/dcarrero
# Twitter/X:     @carrero
# Version:       0.1 beta
# Created:       April 4, 2025
# License:       MIT License
#                Copyright (c) 2025 David Carrero Fernández-Baillo
#
#                Permission is hereby granted, free of charge, to any person
#                obtaining a copy of this software and associated documentation
#                files (the "Software"), to deal in the Software without
#                restriction, including without limitation the rights to use,
#                copy, modify, merge, publish, distribute, sublicense, and/or
#                sell copies of the Software, and to permit persons to whom the
#                Software is furnished to do so, subject to the following
#                conditions:
#
#                The above copyright notice and this permission notice shall be
#                included in all copies or substantial portions of the Software.
#
#                Please cite the original author when sharing or modifying.
# ==========================================================================

# Function to print messages
log() {
    echo "$1"
}

# Check if a directory was provided as an argument
if [ $# -eq 0 ]; then
    BASE_DIR="."
else
    BASE_DIR="$1"
fi

log "Starting recursive search from: $BASE_DIR"

# Search for all wp-config.php files recursively
# Excluding wp-includes, wp-admin and wp-content directories for better performance
find "$BASE_DIR" -name "wp-config.php" -type f -not -path "*/wp-includes/*" -not -path "*/wp-admin/*" -not -path "*/wp-content/*" | while read -r WP_CONFIG; do
    # Get the directory where wp-config.php is located
    WP_DIR=$(dirname "$WP_CONFIG")
    log "=========================="
    log "WordPress detected in: $WP_DIR"
    
    # Check if robots.txt exists in the same directory
    ROBOTS_FILE="$WP_DIR/robots.txt"
    
    if [ -f "$ROBOTS_FILE" ]; then
        log "robots.txt file found at: $ROBOTS_FILE"
        
        # Check if the line "Disallow: /cdn-cgi/" already exists
        if grep -q "Disallow: /cdn-cgi/" "$ROBOTS_FILE"; then
            log "The directive 'Disallow: /cdn-cgi/' already exists in the file. No changes made."
        else
            log "Adding 'Disallow: /cdn-cgi/' to robots.txt..."
            
            # Check if the file ends with a blank line
            if [ -s "$ROBOTS_FILE" ] && [ "$(tail -c 1 "$ROBOTS_FILE" | wc -l)" -eq 0 ]; then
                # If the file doesn't end with a new line, add one first
                echo "" >> "$ROBOTS_FILE"
                log "Added initial carriage return"
            fi
            
            # Add the comment and directive with carriage return at the end
            echo "# WordPress Cloudflare robots.txt Updater" >> "$ROBOTS_FILE"
            log "Added updater comment"
            
            echo "# Cloudflare recommendation for proper indexing" >> "$ROBOTS_FILE"
            log "Added Cloudflare recommendation comment"
            
            echo "Disallow: /cdn-cgi/" >> "$ROBOTS_FILE"
            log "Added directive 'Disallow: /cdn-cgi/'"
            
            echo "" >> "$ROBOTS_FILE"
            log "Added final carriage return"
            
            log "Directive successfully added to existing robots.txt"
        fi
    else
        log "No robots.txt found in $WP_DIR"
        log "Creating new robots.txt file with the required directive..."
        
        # Create new robots.txt with header comment
        echo "# File created by WordPress Cloudflare robots.txt Updater" > "$ROBOTS_FILE"
        log "Added header comment"
        
        echo "User-agent: *" >> "$ROBOTS_FILE"
        log "Added line 'User-agent: *'"
        
        echo "Disallow: /wp-admin/" >> "$ROBOTS_FILE"
        log "Added line 'Disallow: /wp-admin/'"
        
        echo "Allow: /wp-admin/admin-ajax.php" >> "$ROBOTS_FILE"
        log "Added line 'Allow: /wp-admin/admin-ajax.php'"
        
        echo "" >> "$ROBOTS_FILE"
        log "Added separator"
        
        echo "# WordPress Cloudflare robots.txt Updater" >> "$ROBOTS_FILE"
        log "Added updater comment"
        
        echo "# Cloudflare recommendation for proper indexing" >> "$ROBOTS_FILE"
        log "Added Cloudflare recommendation comment"
        
        echo "Disallow: /cdn-cgi/" >> "$ROBOTS_FILE"
        log "Added directive 'Disallow: /cdn-cgi/'"
        
        echo "" >> "$ROBOTS_FILE"
        log "Added final carriage return"
        
        log "New robots.txt file successfully created at $ROBOTS_FILE"
    fi
done

log "=========================="
log "Recursive search completed"
