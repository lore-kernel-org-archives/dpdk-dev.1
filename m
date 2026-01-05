Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A69DC79FB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 17:56:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C200E40658;
	Mon,  5 Jan 2026 18:56:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0AA3C40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 18:56:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767635777; x=1799171777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AjXrm57vtZ/57GVS2Ug0WIedTF7r70JY2K+aVDAkW7s=;
 b=dt/50NUOakDxEKWnGgLy52WhQILakGIOQXoWHa2F72/0dH1BBoMG+NHT
 9PB+TH+BaZ0nnedhfGXLZwxLApAZnaEonDM8sFyMsSHR9bCYRWIkcvaAB
 qGgbXp1CUNvGO2hmKZFt391Fi6dcsRyZVFQWTXzCwgo7S/oNDL9Ad9izp
 R7JOA8irezc+FOo0B8zMxHa8YkKtE2wEcHjHAkoiZJ6YSDfpei2s6lmgy
 0ETgKZrVNst5GEo78XlMH+hhRZjab8ChXHgyyyCi9s+aglNFWzEoKQIpX
 70pQ7FAa/KIki7dVgab/eokXCMi9c7dC/8nUlJJ4HJdugQcWn1ICdRrKj Q==;
X-CSE-ConnectionGUID: zZ1v5mrkS8enbSh/9mE03Q==
X-CSE-MsgGUID: 7Mmf4SpKSDOA74IxDiXxZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79308855"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="79308855"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 09:56:16 -0800
X-CSE-ConnectionGUID: /UV+jEroT3eLJE38PkTokA==
X-CSE-MsgGUID: zlP8FLvqQ1i0kB40+RNHBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="239928725"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 05 Jan 2026 09:56:15 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/7] usertools/telemetry-watcher: add displaying stats
Date: Mon,  5 Jan 2026 17:56:00 +0000
Message-ID: <20260105175605.52689-3-bruce.richardson@intel.com>
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

Add support for printing out particular stats once every second. The
stats to be queried are given on the commandline, in the format of
<command>.<result-field>, for example /ethdev/stats,0.ipackets.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-telemetry-watcher.py | 101 +++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index 01c8683d33..824c9a37be 100755
--- a/usertools/dpdk-telemetry-watcher.py
+++ b/usertools/dpdk-telemetry-watcher.py
@@ -14,6 +14,7 @@
 import shutil
 import errno
 import json
+import time
 
 
 def get_app_name(pid):
@@ -137,6 +138,91 @@ def print_connected_app(process):
             print(f'Connected to application: "{app_name}"')
 
 
+def validate_stats(process, stat_specs):
+    """Validate stat specifications and check that fields are numeric.
+
+    Args:
+        process: The subprocess.Popen handle to the telemetry process
+        stat_specs: List of stat specifications in format "command.field"
+
+    Returns:
+        List of tuples (spec, command, field) for valid specs, or None on error
+    """
+    parsed_specs = []
+    for spec in stat_specs:
+        # Parse the stat specification
+        if "." not in spec:
+            print(f"Error: Invalid stat specification '{spec}'", file=sys.stderr)
+            print(
+                "Expected format: 'command.field' (e.g., /ethdev/stats,0.ipackets)",
+                file=sys.stderr,
+            )
+            return None
+
+        command, field = spec.rsplit(".", 1)
+        if not command or not field:
+            print(f"Error: Invalid stat specification '{spec}'", file=sys.stderr)
+            print(
+                "Expected format: 'command.field' (e.g., /ethdev/stats,0.ipackets)",
+                file=sys.stderr,
+            )
+            return None
+
+        # Query the stat once to validate it exists and is numeric
+        data = query_telemetry(process, command)
+        if not isinstance(data, dict):
+            print(f"Error: Command '{command}' did not return a dictionary", file=sys.stderr)
+            return None
+        if field not in data:
+            print(f"Error: Field '{field}' not found in '{command}' response", file=sys.stderr)
+            return None
+        value = data[field]
+        if not isinstance(value, (int, float)):
+            print(
+                f"Error: Field '{field}' in '{command}' is not numeric (got {type(value).__name__})",
+                file=sys.stderr,
+            )
+            return None
+
+        parsed_specs.append((spec, command, field))
+
+    return parsed_specs
+
+
+def monitor_stats(process, stat_specs):
+    """Monitor and display statistics in columns.
+
+    Args:
+        process: The subprocess.Popen handle to the telemetry process
+        stat_specs: List of stat specifications in format "command.field"
+    """
+    # Validate all stat specifications
+    parsed_specs = validate_stats(process, stat_specs)
+    if not parsed_specs:
+        return
+
+    # Print header
+    header = "Time".ljust(10)
+    for spec, _, _ in parsed_specs:
+        header += spec.rjust(25)
+    print(header)
+
+    # Monitor loop - once per second
+    try:
+        while True:
+            timestamp = time.strftime("%H:%M:%S")
+            row = timestamp.ljust(10)
+
+            for spec, command, field in parsed_specs:
+                data = query_telemetry(process, command)
+                row += str(data[field]).rjust(25)
+
+            print(row)
+            time.sleep(1)
+    except KeyboardInterrupt:
+        print("\nMonitoring stopped")
+
+
 def main():
     """Main function to parse arguments and run dpdk-telemetry.py with a pipe"""
 
@@ -164,6 +250,11 @@ def main():
         default=False,
         help="List all possible file-prefixes and exit",
     )
+    parser.add_argument(
+        "stats",
+        nargs="*",
+        help="Statistics to monitor in format 'command.field' (e.g., /ethdev/stats,0.ipackets)",
+    )
 
     args = parser.parse_args()
 
@@ -179,13 +270,21 @@ def main():
         cmd = [sys.executable, telemetry_script] + args_list
         return subprocess.run(cmd).returncode
 
+    # Check if stats were provided
+    if not args.stats:
+        print("Error: No statistics to monitor specified", file=sys.stderr)
+        print("Usage: dpdk-telemetry-watcher.py [options] stat1 stat2 ...", file=sys.stderr)
+        print("Example: dpdk-telemetry-watcher.py /ethdev/stats,0.ipackets", file=sys.stderr)
+        return 1
+
     # Run dpdk-telemetry.py with pipes for stdin and stdout
     process = create_telemetry_process(telemetry_script, args_list)
 
     # Get and display the connected application name
     print_connected_app(process)
 
-    # TODO: Add monitoring logic here
+    # Monitor the requested statistics
+    monitor_stats(process, args.stats)
 
     # Clean up
     process.stdin.close()
-- 
2.51.0

