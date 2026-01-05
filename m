Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7281C79FB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 17:56:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3C4B40650;
	Mon,  5 Jan 2026 18:56:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3D5EB40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 18:56:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767635776; x=1799171776;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/F+HJPkfDdgEUjTBaQhuw0tRqFV4pVVS3fK34fNXUl4=;
 b=noJb3bIY4/1o9VQu9VCXTcS5haVJg8jeLTHJg3yP4vy/2dM3ogkKVUcd
 sK/PjhkpIC2zUInIqPeG9XwPUHUi6ZUe66kMC/D4Ilz3+ywGB4vjiztgy
 CXOZQhfmKGPQqwpjNMocdRbr9bZwiZX+d3DgDgveAfbb+KbFB9VRA+B6v
 yYK4h9e5uExXF8qFRUOm0pDSsd6Nm6Zk7LOi6vGpvBArViNYAR00TIMLl
 lyg7KeKcNO1qC8PpWsdGEQ0JWRPn/kMKT6mdT8KldyBTyXV4t6GVyUrKm
 leQ68hcMj4V71fKkHiPgVZ6xJRZejNBaOo6rvdew4iOcEHkoeCVZCspyS w==;
X-CSE-ConnectionGUID: 3kpdBewHSlq019F9cCYuxA==
X-CSE-MsgGUID: T9s/ua4ZQM2FWEvbixiAMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79308853"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="79308853"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 09:56:15 -0800
X-CSE-ConnectionGUID: AqLCdYVoSKOWqJpP4C8WeQ==
X-CSE-MsgGUID: bM64VeVLSU2jO9UonDktvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="239928712"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 05 Jan 2026 09:56:14 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/7] usertools: add new script to monitor telemetry on
 terminal
Date: Mon,  5 Jan 2026 17:55:59 +0000
Message-ID: <20260105175605.52689-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105175605.52689-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20260105175605.52689-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

The dpdk-telemetry.py script is useful for getting telemetry
interactively, but sometimes we want to monitor stats over time, so add
a telemetry-watcher script to do so.

Start off such a script with basic arg processing, and connecting to
dpdk-telemetry as a subprocess, so that we can send-receive commands
from it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-telemetry-watcher.py | 200 ++++++++++++++++++++++++++++
 usertools/meson.build               |   1 +
 2 files changed, 201 insertions(+)
 create mode 100755 usertools/dpdk-telemetry-watcher.py

diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
new file mode 100755
index 0000000000..01c8683d33
--- /dev/null
+++ b/usertools/dpdk-telemetry-watcher.py
@@ -0,0 +1,200 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Intel Corporation
+
+"""
+Script to monitor DPDK telemetry statistics on the command line.
+Wraps dpdk-telemetry.py to provide continuous monitoring capabilities.
+"""
+
+import argparse
+import subprocess
+import sys
+import os
+import shutil
+import errno
+import json
+
+
+def get_app_name(pid):
+    """return the app name for a given PID, for printing"""
+    proc_cmdline = os.path.join("/proc", str(pid), "cmdline")
+    try:
+        with open(proc_cmdline) as f:
+            argv0 = f.read(1024).split("\0")[0]
+            return os.path.basename(argv0)
+    except IOError as e:
+        # ignore file not found errors
+        if e.errno != errno.ENOENT:
+            raise
+    return None
+
+
+def find_telemetry_script():
+    """Find the dpdk-telemetry.py script in the script directory or PATH.
+
+    Returns:
+        str: Path to the dpdk-telemetry.py script
+
+    Exits:
+        If the script cannot be found
+    """
+    # First, try to find it in the same directory as this script
+    script_dir = os.path.dirname(os.path.abspath(__file__))
+    telemetry_script = os.path.join(script_dir, "dpdk-telemetry.py")
+
+    # If not found locally, check if it's in PATH
+    if not os.path.exists(telemetry_script):
+        telemetry_in_path = shutil.which("dpdk-telemetry.py")
+        if telemetry_in_path:
+            telemetry_script = telemetry_in_path
+        else:
+            print(
+                "Error: dpdk-telemetry.py not found in script directory or PATH",
+                file=sys.stderr,
+            )
+            sys.exit(1)
+
+    return telemetry_script
+
+
+def create_telemetry_process(telemetry_script, args_list):
+    """Create a subprocess for dpdk-telemetry.py with pipes.
+
+    Args:
+        telemetry_script: Path to the dpdk-telemetry.py script
+        args_list: List of arguments to pass to the script
+
+    Returns:
+        subprocess.Popen: Process handle with stdin/stdout/stderr pipes
+
+    Exits:
+        If the process cannot be created
+    """
+    # Build the command
+    cmd = [sys.executable, telemetry_script] + args_list
+
+    try:
+        process = subprocess.Popen(
+            cmd,
+            stdin=subprocess.PIPE,
+            stdout=subprocess.PIPE,
+            stderr=subprocess.PIPE,
+            text=True,
+            bufsize=1,  # Line buffered
+        )
+        return process
+    except FileNotFoundError:
+        print(f"Error: Python interpreter or script not found", file=sys.stderr)
+        sys.exit(1)
+    except Exception as e:
+        print(f"Error running dpdk-telemetry.py: {e}", file=sys.stderr)
+        sys.exit(1)
+
+
+def query_telemetry(process, command):
+    """Send a telemetry command and return the parsed JSON response.
+
+    Args:
+        process: The subprocess.Popen handle to the telemetry process
+        command: The telemetry command to send (e.g., "/info" or "/ethdev/stats,0")
+
+    Returns:
+        dict: The parsed JSON response with the command wrapper stripped,
+              or None if there was an error
+    """
+    # Send the command
+    process.stdin.write(f"{command}\n")
+    process.stdin.flush()
+
+    # Read the JSON response
+    response = process.stdout.readline()
+    try:
+        data = json.loads(response)
+        # When run non-interactively, the response is wrapped with the command
+        # e.g., {"/info": {"version": ..., "pid": ...}}
+        # or {"/ethdev/stats,0": {...}}
+        # The response should have exactly one key which is the command
+        if len(data) == 1:
+            # Extract the value, ignoring the key
+            return next(iter(data.values()))
+        else:
+            return data
+    except (json.JSONDecodeError, KeyError):
+        return None
+
+
+def print_connected_app(process):
+    """Query and print the name of the connected DPDK application.
+
+    Args:
+        process: The subprocess.Popen handle to the telemetry process
+    """
+    info = query_telemetry(process, "/info")
+    if info and "pid" in info:
+        app_name = get_app_name(info["pid"])
+        if app_name:
+            print(f'Connected to application: "{app_name}"')
+
+
+def main():
+    """Main function to parse arguments and run dpdk-telemetry.py with a pipe"""
+
+    # Parse command line arguments - matching dpdk-telemetry.py parameters
+    parser = argparse.ArgumentParser(
+        description="Monitor DPDK telemetry statistics on the command line"
+    )
+    parser.add_argument(
+        "-f",
+        "--file-prefix",
+        default="rte",
+        help="Provide file-prefix for DPDK runtime directory",
+    )
+    parser.add_argument(
+        "-i",
+        "--instance",
+        default=0,
+        type=int,
+        help="Provide instance number for DPDK application",
+    )
+    parser.add_argument(
+        "-l",
+        "--list",
+        action="store_true",
+        default=False,
+        help="List all possible file-prefixes and exit",
+    )
+
+    args = parser.parse_args()
+
+    # Find the dpdk-telemetry.py script
+    telemetry_script = find_telemetry_script()
+
+    # Build arguments list
+    args_list = ["-f", args.file_prefix, "-i", str(args.instance)]
+
+    if args.list:
+        args_list.append("-l")
+        # For --list, just run the command directly without pipes
+        cmd = [sys.executable, telemetry_script] + args_list
+        return subprocess.run(cmd).returncode
+
+    # Run dpdk-telemetry.py with pipes for stdin and stdout
+    process = create_telemetry_process(telemetry_script, args_list)
+
+    # Get and display the connected application name
+    print_connected_app(process)
+
+    # TODO: Add monitoring logic here
+
+    # Clean up
+    process.stdin.close()
+    process.stdout.close()
+    process.stderr.close()
+    process.wait()
+
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/usertools/meson.build b/usertools/meson.build
index eb48e2f440..114d0a65b4 100644
--- a/usertools/meson.build
+++ b/usertools/meson.build
@@ -12,6 +12,7 @@ install_data([
             'dpdk-hugepages.py',
             'dpdk-rss-flows.py',
             'dpdk-telemetry-exporter.py',
+            'dpdk-telemetry-watcher.py',
         ],
         install_dir: 'bin')
 
-- 
2.51.0

