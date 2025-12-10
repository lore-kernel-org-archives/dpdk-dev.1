Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC93D3C92B
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 16:56:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B35C740BA2;
	Wed, 10 Dec 2025 17:55:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id C226140A77
 for <dev@dpdk.org>; Wed, 10 Dec 2025 17:55:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765385742; x=1796921742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DkZBG8VsyMmfHPvv8l+ICBqcaRdcO+xlkpAmA/0yVdU=;
 b=JNQU79MKUsxyEARo8xqLTHg+pFMd1iG91l2fKD8bJTsj0Shc/nrFZv+3
 cQTdoLjuEMa70zcTiXyvYAp5YUJWyTAF856d7/a1tcACfHfjG3Q5Vadd2
 IouwFj6ZC0CqUtKuRnGLQW63Mun4cTJLTAyCaOWPLPd2MFspCAif+4P2E
 oHAXK2+6r1oMG1h/tfPbMWS5urmJdtVYYaIHU1G0hybH1bemEWpxlByu8
 R5FE/s7SHnOGce5/EmShkNCGe0X40LN63v3GDV3eci8gWE9RkCGmyzlvg
 KKa0zilM3mtC+7WW9mgPChazjGTF5IvEsVbVbGa74Zce0OvzWEwoGF9rN A==;
X-CSE-ConnectionGUID: tJrudTuzSEKj8P7ls9s60Q==
X-CSE-MsgGUID: /oG1gsxTSu+1cj9i8bofLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67088731"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="67088731"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 08:55:41 -0800
X-CSE-ConnectionGUID: XKFUBoH1SxCgylKIKdN93g==
X-CSE-MsgGUID: xW5oGsZHTs20Ve/P+yttTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="195828612"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 10 Dec 2025 08:55:40 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 3/7] usertools/telemetry-watcher: add delta and timeout
 opts
Date: Wed, 10 Dec 2025 16:55:28 +0000
Message-ID: <20251210165532.103450-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251210165532.103450-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
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
---
 usertools/dpdk-telemetry-watcher.py | 64 +++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index 824c9a37be..8af9af867c 100755
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

