# WordPress Cloudflare robots.txt Updater

A bash script that automatically adds Cloudflare recommended directives to robots.txt files in WordPress installations.

## Overview

When using Cloudflare with WordPress sites, the `/cdn-cgi/` endpoint is automatically added to your domain. This endpoint is used by various internal Cloudflare services and cannot be modified or customized. Some crawlers or web analysis tools may report errors when trying to access this endpoint.

Although these errors do not affect SEO ranking or site performance, they can create noise in your reports. To prevent this, Cloudflare officially recommends adding the following line to your `robots.txt` file:

```
Disallow: /cdn-cgi/
```

This script automates this process across multiple WordPress installations.

## Features

- Recursively searches for WordPress installations in a specified directory
- Identifies WordPress sites by the presence of wp-config.php
- Adds the `Disallow: /cdn-cgi/` directive to existing robots.txt files
- Creates a new robots.txt with recommended settings if one doesn't exist
- Skips WordPress core directories (wp-includes, wp-admin, wp-content) for better performance
- Properly formats the robots.txt file with appropriate line breaks
- Provides detailed logs of all actions performed

## Installation

You can install the script in one of two ways:

### Option 1: Direct download

```bash
curl -O https://raw.githubusercontent.com/dcarrero/WordPress-Cloudflare-robots.txt-Updater/refs/heads/main/update_robots_cloudflare.sh
chmod +x update_robots_cloudflare.sh
```

### Option 2: Clone the repository

```bash
git clone https://github.com/dcarrero/WordPress-Cloudflare-robots.txt-Updater.git
cd WordPress-Cloudflare-robots.txt-Updater
chmod +x update_robots_cloudflare.sh
```

## Usage

Run the script by specifying the directory that contains your WordPress installations:

```bash
./update_robots_cloudflare.sh /path/to/your/sites
```

If no directory is specified, the script will use the current directory:

```bash
./update_robots_cloudflare.sh
```

## What the script does

1. Searches for all wp-config.php files in the specified directory (recursively)
2. For each WordPress installation found:
   - If robots.txt exists and doesn't have the Cloudflare directive, adds it
   - If robots.txt doesn't exist, creates one with WordPress best practices and the Cloudflare directive
3. Provides detailed output of all actions taken

## Example robots.txt created by the script

```
# File created by WordPress Cloudflare robots.txt Updater
User-agent: *
Disallow: /wp-admin/
Allow: /wp-admin/admin-ajax.php

# WordPress Cloudflare robots.txt Updater
# Cloudflare recommendation for proper indexing
Disallow: /cdn-cgi/
```

## Why is this important?

According to [Cloudflare's official documentation](https://developers.cloudflare.com/fundamentals/reference/cdn-cgi-endpoint/#disallow-using-robotstxt):

> "/cdn-cgi/ also can cause issues with various web crawlers. Search engine crawlers can encounter errors when crawling these endpoints and — though these errors do not impact site rankings — they may surface in your webmaster dashboard. SEO and other web crawlers may also mistakenly crawl these endpoints, thinking that they are part of your site's content. As a best practice, update your robots.txt file to include Disallow: /cdn-cgi/."

## Author

- **David Carrero Fernández-Baillo**
- Email: dcarrero@stackscale.com
- Website: [https://carrero.es](https://carrero.es) & [Stackscale Private Cloud](https://www.stackscale.com)
- GitHub: https://github.com/dcarrero
- Twitter/X: @carrero

## License

MIT License

Copyright (c) 2025 David Carrero Fernández-Baillo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Please cite the original author when sharing or modifying.
