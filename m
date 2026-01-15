Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D25DD46612
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 19:03:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17DF642789;
	Thu, 15 Jan 2026 20:03:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9327C4003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 20:03:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768503818; x=1800039818;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bxtn/w+/985+dryftVP2UywUohzGNj9t85CFQJ3W9es=;
 b=i2vN/QJV30mVtspFwQjbLgVkFl7cZeRR3DKJbXUpCtAY4+I/EIvksjiJ
 sNmsEAlexuS4GDuNxFy2nezOxCLGYV8NwkvZ1rkX2lJ68s6AKeRPUzIEk
 LY7kyhXXYsFJJ29fuDNi0oMIj6eVS+ZAkFAoLsA5/qAL6BVd8pgnTuhqC
 QOAiR4zjAizCioCZBOCMGaHxzJnlhqeqCiEZU2giXuIRX3PgIev7wFARW
 Le6odT4usVg4jdiuHCeQEl8paVSkq8K3iRXTZiynRaspgoramGqsgLtJj
 CrhiiRxGKU1FYIWvrHgkR94jfS8eqkextGBjJuk+q56lPDNKLmP3x6rou Q==;
X-CSE-ConnectionGUID: GgRzA5WqRymKRKh6LA52dA==
X-CSE-MsgGUID: P17tzDwJTpWNdyrAMQx49Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80461385"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; d="scan'208";a="80461385"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 11:03:37 -0800
X-CSE-ConnectionGUID: 6faYgUuhR/i9hs2mpb/hMg==
X-CSE-MsgGUID: /eHHrkjURoGi/xJdSqazIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; d="scan'208";a="205307662"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 15 Jan 2026 11:03:35 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 1/7] usertools: add new script to monitor telemetry on
 terminal
Date: Thu, 15 Jan 2026 19:03:25 +0000
Message-ID: <20260115190331.3721281-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115190331.3721281-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20260115190331.3721281-1-bruce.richardson@intel.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/tools/index.rst            |   1 +
 doc/guides/tools/telemetrywatcher.rst |  56 ++++++++
 usertools/dpdk-telemetry-watcher.py   | 200 ++++++++++++++++++++++++++
 usertools/meson.build                 |   1 +
 4 files changed, 258 insertions(+)
 create mode 100644 doc/guides/tools/telemetrywatcher.rst
 create mode 100755 usertools/dpdk-telemetry-watcher.py

diff --git a/doc/guides/tools/index.rst b/doc/guides/tools/index.rst
index 8ec429ec53..13f75a5bc6 100644
--- a/doc/guides/tools/index.rst
+++ b/doc/guides/tools/index.rst
@@ -14,6 +14,7 @@ DPDK Tools User Guides
     pmdinfo
     dumpcap
     pdump
+    telemetrywatcher
     dmaperf
     flow-perf
     securityperf
diff --git a/doc/guides/tools/telemetrywatcher.rst b/doc/guides/tools/telemetrywatcher.rst
new file mode 100644
index 0000000000..e813bf0207
--- /dev/null
+++ b/doc/guides/tools/telemetrywatcher.rst
@@ -0,0 +1,56 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation
+
+dpdk-telemetry-watcher Application
+===================================
+
+The ``dpdk-telemetry-watcher`` tool is a Data Plane Development Kit (DPDK) utility
+that provides continuous monitoring of DPDK telemetry statistics on the command line.
+It wraps the ``dpdk-telemetry.py`` script to provide real-time statistics display capabilities.
+
+
+Running the Application
+-----------------------
+
+The tool has a number of command line options:
+
+.. code-block:: console
+
+   dpdk-telemetry-watcher.py [options] stat1 stat2 ...
+
+
+Options
+-------
+
+.. program:: dpdk-telemetry-watcher.py
+
+.. option:: -h, --help
+
+   Display usage information and quit
+
+.. option:: -f FILE_PREFIX, --file-prefix FILE_PREFIX
+
+   Provide file-prefix for DPDK runtime directory.
+   Passed to ``dpdk-telemetry.py`` to identify the target DPDK application.
+   Default is ``rte``.
+
+.. option:: -i INSTANCE, --instance INSTANCE
+
+   Provide instance number for DPDK application when multiple applications are running with the same file-prefix.
+   Passed to ``dpdk-telemetry.py`` to identify the target DPDK application instance.
+   Default is ``0``.
+
+.. option:: -l, --list
+
+   List all possible file-prefixes and exit.
+   This is useful to discover which DPDK applications are currently running.
+
+Dependencies
+------------
+
+The tool requires:
+
+* Python 3
+* The ``dpdk-telemetry.py`` script must be available in the same directory
+  or in the system PATH
+* A running DPDK application with telemetry enabled
diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
new file mode 100755
index 0000000000..a5ac293d06
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
+        print("Error: Python interpreter or script not found", file=sys.stderr)
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

