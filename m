Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A1CD342F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 10:09:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C53F940668;
	Tue,  5 May 2026 12:08:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id BA07A4060B
 for <dev@dpdk.org>; Tue,  5 May 2026 12:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777975730; x=1809511730;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RMM1u1p9iVT8zx97kZngB6Yqu0SUsVVTeC6TUSr7iXQ=;
 b=MsUd7mndgpeL/kM5qiqXwm2lKkbf/SycBpolOp4q/lvJHttQV67GNvAW
 5/tlqk5PyUTHIrxXJ5iQj/V7i7txEMfoJUv08H+10HgtNzaZp1VASZWHY
 Z5NtApS9Jv4ox/gbKPXRC8CGfPbRkmVChAqfhWPtPdaaARJwm3UrsojnM
 Aem6tMXjEYxHKlfrqGOw7k/TsTPrw+Rr82ip+NvEJ/QkLY9k0Y8ZDgIuh
 GHdT2GP/CmWmRuGFJIp3lshCk0cgPpSwUXPVMGzffkLWADLKFXpfoCksN
 DKaEQNw2tXr+W3gqFnp2BZkKBLbH+F/6wsw94jgcV+bGoCmI93J3WTFvJ g==;
X-CSE-ConnectionGUID: KDvrt80eQhu7I/t+KTuyBg==
X-CSE-MsgGUID: aEqW9X8ASaa0qcOkzyZBIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89945942"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="89945942"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:08:50 -0700
X-CSE-ConnectionGUID: kPlxNY6RQOacYyInSyrTag==
X-CSE-MsgGUID: dJrGbPo4RpuD7JCAK8YPvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="239767020"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa003.jf.intel.com with ESMTP; 05 May 2026 03:08:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 2/7] usertools/telemetry-watcher: add displaying stats
Date: Tue,  5 May 2026 11:08:28 +0100
Message-ID: <20260505100833.2885047-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505100833.2885047-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20260505100833.2885047-1-bruce.richardson@intel.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/tools/telemetrywatcher.rst |  51 +++++++++++++
 usertools/dpdk-telemetry-watcher.py   | 101 +++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/doc/guides/tools/telemetrywatcher.rst b/doc/guides/tools/telemetrywatcher.rst
index b337e4114f..44780e28c0 100644
--- a/doc/guides/tools/telemetrywatcher.rst
+++ b/doc/guides/tools/telemetrywatcher.rst
@@ -44,6 +44,57 @@ Options
    List all possible file-prefixes and exit.
    This is useful to discover which DPDK applications are currently running.

+.. option:: stat
+
+   Statistics to monitor in format ``command.field``.
+   Multiple statistics can be specified and will be displayed in columns.
+   See the `Statistics Format`_ section below for details on specifying statistics.
+
+
+Statistics Format
+-----------------
+
+Specify statistics in the format ``command.field`` where:
+
+* ``command`` is a telemetry command (e.g., ``/ethdev/stats,0``)
+* ``field`` is a field name from the command's JSON response (e.g., ``ipackets``)
+
+To discover available commands and fields, follow the steps below:
+
+1. Use ``dpdk-telemetry.py`` interactively to explore available commands
+2. Use the ``/`` command to list all available telemetry endpoints
+3. Query specific commands to see their response format
+
+Example telemetry commands:
+
+* ``/ethdev/list`` - List all Ethernet devices
+* ``/ethdev/stats,N`` - Get statistics for Ethernet device N
+* ``/ethdev/xstats,N`` - Get extended statistics for Ethernet device N
+* ``/eal/mempool_list`` - List all mempools
+* ``/mempool/info,N`` - Get information about mempool N
+
+See `Examples`_ section for usage examples based on the results of these telemetry commands.
+
+Examples
+--------
+
+Monitor received packets on Ethernet device 0::
+
+   dpdk-telemetry-watcher.py /ethdev/stats,0.ipackets
+
+Monitor received and transmitted packets on device 0::
+
+   dpdk-telemetry-watcher.py /ethdev/stats,0.ipackets /ethdev/stats,0.opackets
+
+Monitor a DPDK application with a custom file-prefix::
+
+   dpdk-telemetry-watcher.py -f myapp /ethdev/stats,0.ipackets
+
+List all running DPDK applications::
+
+   dpdk-telemetry-watcher.py -l
+
+
 Dependencies
 ------------

diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index a5ac293d06..dad4e60475 100755
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

