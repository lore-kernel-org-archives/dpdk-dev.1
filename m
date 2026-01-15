Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F8D46613
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 19:04:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D99D42D89;
	Thu, 15 Jan 2026 20:03:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 94B6A427D3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 20:03:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768503823; x=1800039823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=85fGW94x7aHBpSapZs56d3UovDukbJbk+nrWoF25Ego=;
 b=iCLE5umZxZOp7T+tkne3EARqIB8NHeZgr0aIJ7NBKydCL8vD8INtWZ3a
 DtXYBQuSCaYOlKZd2DWkcioXdmiNzS3lgtge8oI1R1fGuC6LJjYJuK/c0
 N95vooMMX/WH9ws7W69XlQq95fk9OI9pYw6TJOODIZE/hCqgOcJ514ujE
 td671t3rdPJnRQ79axhQD25RA4cL16wBoZA5Y8V7UKvv42beVNkR32Ggq
 QL2XE/AhlaKodM6kq/Xm5zCC8iWFYDTXrq5yJWjCq7/v97j+DzX3nXqa6
 lJbzXvAnjhUymzZfrPVQBWWMFHV2OHg+gktaivUh0yqurK2rNNAwfLQxX A==;
X-CSE-ConnectionGUID: dMmBqsiqRgKxObfNxv5maQ==
X-CSE-MsgGUID: xdNtbj4dQxOz9bwXMPnUvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80461408"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; d="scan'208";a="80461408"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 11:03:42 -0800
X-CSE-ConnectionGUID: yeMRhcMtTFKP73gambQyQA==
X-CSE-MsgGUID: z3BE2BQLT1qHlONpxgRhYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; d="scan'208";a="205307702"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 15 Jan 2026 11:03:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 7/7] usertools/telemetry-watcher: support reconnection
Date: Thu, 15 Jan 2026 19:03:31 +0000
Message-ID: <20260115190331.3721281-8-bruce.richardson@intel.com>
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

Allow the watcher binary to run even when there is no DPDK process
running. In that case, wait for a suitable process to start and begin
monitoring then. In case of disconnection, keep trying to reconnect and
resume once reconnection succeeds.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  7 ++++
 doc/guides/tools/telemetrywatcher.rst  |  6 +++
 usertools/dpdk-telemetry-watcher.py    | 52 ++++++++++++++++++++------
 3 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..a418491daf 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,13 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added Script for Real-time Telemetry Monitoring.**
+
+  Introduced the `dpdk-telemetry-watcher.py` script, enabling users to monitor
+  real-time telemetry statistics from running DPDK applications.
+  The tool supports customizable display options, including delta values,
+  total statistics, and single-line output for compact monitoring.
+
 
 Removed Items
 -------------
diff --git a/doc/guides/tools/telemetrywatcher.rst b/doc/guides/tools/telemetrywatcher.rst
index 99e51881ff..070a93223f 100644
--- a/doc/guides/tools/telemetrywatcher.rst
+++ b/doc/guides/tools/telemetrywatcher.rst
@@ -12,6 +12,12 @@ It wraps the ``dpdk-telemetry.py`` script to provide real-time statistics displa
 Running the Application
 -----------------------
 
+The watcher tool can be run at any time, whether or not a DPDK application is currently running.
+When a DPDK application with telemetry enabled starts
+(assuming correct file-prefix and instance are specified),
+the watcher will automatically connect and begin displaying the requested statistics.
+If the DPDK application stops, the watcher will attempt to reconnect when the application restarts.
+
 The tool has a number of command line options:
 
 .. code-block:: console
diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index 9685ffa01f..bd5dc92fe6 100755
--- a/usertools/dpdk-telemetry-watcher.py
+++ b/usertools/dpdk-telemetry-watcher.py
@@ -85,6 +85,12 @@ def create_telemetry_process(telemetry_script, args_list):
             text=True,
             bufsize=1,  # Line buffered
         )
+
+        # Get and display the connected application name
+        if not print_connected_app(process):
+            return None
+        process.script = telemetry_script  # Store script path for reference
+        process.args = args_list  # Store args for reference
         return process
     except FileNotFoundError:
         print("Error: Python interpreter or script not found", file=sys.stderr)
@@ -102,15 +108,32 @@ def query_telemetry(process, command):
         command: The telemetry command to send (e.g., "/info" or "/ethdev/stats,0")
 
     Returns:
-        dict: The parsed JSON response with the command wrapper stripped,
+        (process, dict): The process handle, in case of reconnection, and the
+              parsed JSON response with the command wrapper stripped,
               or None if there was an error
     """
+    # Handle case where process is None
+    if process is None:
+        return (None, None)
+
     # Send the command
     process.stdin.write(f"{command}\n")
     process.stdin.flush()
 
-    # Read the JSON response
+    # Read the JSON response, reconnecting if necessary
     response = process.stdout.readline()
+    while not response:
+        script = process.script
+        args_list = process.args
+        process = None
+        print("Application disconnected, retrying...", file=sys.stderr)
+        while not process:
+            time.sleep(1)
+            process = create_telemetry_process(script, args_list)
+        process.stdin.write(f"{command}\n")
+        process.stdin.flush()
+        response = process.stdout.readline()
+
     try:
         data = json.loads(response)
         # When run non-interactively, the response is wrapped with the command
@@ -119,11 +142,11 @@ def query_telemetry(process, command):
         # The response should have exactly one key which is the command
         if len(data) == 1:
             # Extract the value, ignoring the key
-            return next(iter(data.values()))
+            return (process, next(iter(data.values())))
         else:
-            return data
+            return (process, data)
     except (json.JSONDecodeError, KeyError):
-        return None
+        return (None, None)
 
 
 def print_connected_app(process):
@@ -132,11 +155,12 @@ def print_connected_app(process):
     Args:
         process: The subprocess.Popen handle to the telemetry process
     """
-    info = query_telemetry(process, "/info")
+    process, info = query_telemetry(process, "/info")
     if info and "pid" in info:
         app_name = get_app_name(info["pid"])
         if app_name:
             print(f'Connected to application: "{app_name}"')
+    return process
 
 
 def expand_shortcuts(process, stat_specs):
@@ -169,7 +193,7 @@ def expand_shortcuts(process, stat_specs):
         field = field_map.get(field, field)
 
         # Get list of ethernet devices
-        port_list = query_telemetry(process, "/ethdev/list")
+        process, port_list = query_telemetry(process, "/ethdev/list")
         if not isinstance(port_list, list):
             print(f"Error: Failed to get ethernet device list", file=sys.stderr)
             return None
@@ -216,7 +240,7 @@ def validate_stats(process, stat_specs):
             return None, None
 
         # Query the stat once to validate it exists and is numeric
-        data = query_telemetry(process, command)
+        process, data = query_telemetry(process, command)
         if not isinstance(data, dict):
             print(f"Error: Command '{command}' did not return a dictionary", file=sys.stderr)
             return None, None
@@ -276,7 +300,9 @@ def monitor_stats(process, args):
             current_values = []
             total = 0
             for i, (spec, command, field) in enumerate(parsed_specs):
-                data = query_telemetry(process, command)
+                process, data = query_telemetry(process, command)
+                if not data:
+                    continue
                 current_value = data[field]
                 current_values.append(current_value)
 
@@ -387,9 +413,11 @@ def main():
 
     # Run dpdk-telemetry.py with pipes for stdin and stdout
     process = create_telemetry_process(telemetry_script, args_list)
-
-    # Get and display the connected application name
-    print_connected_app(process)
+    if not process:
+        print("Waiting for connection to DPDK application...", file=sys.stderr)
+        while not process:
+            time.sleep(1)
+            process = create_telemetry_process(telemetry_script, args_list)
 
     # Monitor the requested statistics
     monitor_stats(process, args)
-- 
2.51.0

