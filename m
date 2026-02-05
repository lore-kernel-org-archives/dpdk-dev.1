Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5366BE83F1F
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 15:03:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03C5C42670;
	Thu,  5 Feb 2026 16:02:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8730A40E09
 for <dev@dpdk.org>; Thu,  5 Feb 2026 16:02:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770303760; x=1801839760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6FvqUlqiicMk1XT0/0yHZ99iYb9ImGYFEek7Yvgtur8=;
 b=D6le5JZZjctz7s+L+8AeySMc/DQJgmeg6bnico9rXg1ynb6fzgjkLVop
 rUy2fjtv3RHfNPK85CXp63cL1EItZ3FvZHn+azTRJAcIZlXnV08iNr3vR
 E5OqDUv8sPRGaC7gmbKE0bolR+5+fzuVXmIlRSHt3Y9hGi/boH87/O1xs
 FQRiyFxZ5JHvSApErT1Fgkb8LZBwG3DrK+jbGB+H71aXXCbMB2yXOWGDe
 EF+sIP3aWrfOFZ15668sNK57pocmRA9E+yZ2lNh7kRYq60t9PnK4pwkaH
 IIxy/As7dv90ciqsGof46+dySe8BUfMlFFShUylDVZoSNwJxN3AZEfb8A g==;
X-CSE-ConnectionGUID: 7t+W3eB5RVm1ks1Y6k/utw==
X-CSE-MsgGUID: sT3btNFLRHWw8TXlDkmbpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="81817222"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="81817222"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 07:02:39 -0800
X-CSE-ConnectionGUID: /rkhmCELR4yajYdwBW1UAA==
X-CSE-MsgGUID: ZLF5RC4gR4msT3nlFtBwIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="214722846"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 05 Feb 2026 07:02:38 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 3/7] usertools/telemetry-watcher: add delta and timeout opts
Date: Thu,  5 Feb 2026 15:02:26 +0000
Message-ID: <20260205150230.123076-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205150230.123076-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20260205150230.123076-1-bruce.richardson@intel.com>
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

Add options to the script to time out and quit after a certain number of
seconds. Also, add an option to display delta instead of absolute
values, allowing easy display of e.g. PPS.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/tools/telemetrywatcher.rst | 11 +++++
 usertools/dpdk-telemetry-watcher.py   | 64 ++++++++++++++++++++-------
 2 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/doc/guides/tools/telemetrywatcher.rst b/doc/guides/tools/telemetrywatcher.rst
index 44780e28c0..5a9c60946b 100644
--- a/doc/guides/tools/telemetrywatcher.rst
+++ b/doc/guides/tools/telemetrywatcher.rst
@@ -44,6 +44,17 @@ Options
    List all possible file-prefixes and exit.
    This is useful to discover which DPDK applications are currently running.
 
+.. option:: -t TIMEOUT, --timeout TIMEOUT
+
+   Number of iterations to run before exiting.
+   If not specified, the tool runs indefinitely until interrupted with Ctrl+C.
+
+.. option:: -d, --delta
+
+   Display delta values instead of absolute values.
+   This shows the change in statistics since the last iteration,
+   which is useful for monitoring per-second rates.
+
 .. option:: stat
 
    Statistics to monitor in format ``command.field``.
diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index dad4e60475..5f4aa05431 100755
--- a/usertools/dpdk-telemetry-watcher.py
+++ b/usertools/dpdk-telemetry-watcher.py
@@ -146,9 +146,13 @@ def validate_stats(process, stat_specs):
         stat_specs: List of stat specifications in format "command.field"
 
     Returns:
-        List of tuples (spec, command, field) for valid specs, or None on error
+        Tuple of (parsed_specs, initial_values) where:
+            parsed_specs: List of tuples (spec, command, field) for valid specs
+            initial_values: List of initial values for each stat
+        Returns (None, None) on error
     """
     parsed_specs = []
+    initial_values = []
     for spec in stat_specs:
         # Parse the stat specification
         if "." not in spec:
@@ -157,7 +161,7 @@ def validate_stats(process, stat_specs):
                 "Expected format: 'command.field' (e.g., /ethdev/stats,0.ipackets)",
                 file=sys.stderr,
             )
-            return None
+            return None, None
 
         command, field = spec.rsplit(".", 1)
         if not command or not field:
@@ -166,38 +170,39 @@ def validate_stats(process, stat_specs):
                 "Expected format: 'command.field' (e.g., /ethdev/stats,0.ipackets)",
                 file=sys.stderr,
             )
-            return None
+            return None, None
 
         # Query the stat once to validate it exists and is numeric
         data = query_telemetry(process, command)
         if not isinstance(data, dict):
             print(f"Error: Command '{command}' did not return a dictionary", file=sys.stderr)
-            return None
+            return None, None
         if field not in data:
             print(f"Error: Field '{field}' not found in '{command}' response", file=sys.stderr)
-            return None
+            return None, None
         value = data[field]
         if not isinstance(value, (int, float)):
             print(
                 f"Error: Field '{field}' in '{command}' is not numeric (got {type(value).__name__})",
                 file=sys.stderr,
             )
-            return None
+            return None, None
 
         parsed_specs.append((spec, command, field))
+        initial_values.append(value)
 
-    return parsed_specs
+    return parsed_specs, initial_values
 
 
-def monitor_stats(process, stat_specs):
+def monitor_stats(process, args):
     """Monitor and display statistics in columns.
 
     Args:
         process: The subprocess.Popen handle to the telemetry process
-        stat_specs: List of stat specifications in format "command.field"
+        args: Parsed command line arguments
     """
-    # Validate all stat specifications
-    parsed_specs = validate_stats(process, stat_specs)
+    # Validate all stat specifications and get initial values
+    parsed_specs, prev_values = validate_stats(process, args.stats)
     if not parsed_specs:
         return
 
@@ -208,17 +213,30 @@ def monitor_stats(process, stat_specs):
     print(header)
 
     # Monitor loop - once per second
+    count = 0
     try:
-        while True:
+        while args.timeout is None or count < args.timeout:
+            time.sleep(1)
+            count += 1
+
             timestamp = time.strftime("%H:%M:%S")
             row = timestamp.ljust(10)
 
-            for spec, command, field in parsed_specs:
+            current_values = []
+            for i, (spec, command, field) in enumerate(parsed_specs):
                 data = query_telemetry(process, command)
-                row += str(data[field]).rjust(25)
+                current_value = data[field]
+                current_values.append(current_value)
+
+                if args.delta:
+                    display_value = current_value - prev_values[i]
+                else:
+                    display_value = current_value
+
+                row += str(display_value).rjust(25)
 
             print(row)
-            time.sleep(1)
+            prev_values = current_values
     except KeyboardInterrupt:
         print("\nMonitoring stopped")
 
@@ -250,6 +268,20 @@ def main():
         default=False,
         help="List all possible file-prefixes and exit",
     )
+    parser.add_argument(
+        "-t",
+        "--timeout",
+        type=int,
+        default=None,
+        help="Number of iterations to run before stopping (default: run indefinitely)",
+    )
+    parser.add_argument(
+        "-d",
+        "--delta",
+        action="store_true",
+        default=False,
+        help="Display delta values instead of absolute values",
+    )
     parser.add_argument(
         "stats",
         nargs="*",
@@ -284,7 +316,7 @@ def main():
     print_connected_app(process)
 
     # Monitor the requested statistics
-    monitor_stats(process, args.stats)
+    monitor_stats(process, args)
 
     # Clean up
     process.stdin.close()
-- 
2.51.0

