Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8E0FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 10:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A50334069D;
	Tue,  5 May 2026 12:08:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6342E4066E
 for <dev@dpdk.org>; Tue,  5 May 2026 12:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777975736; x=1809511736;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GP8m7rvX+h4HFi1LF4MSVscp+NHVjKz79iTsQrfuY84=;
 b=KRypONjGs0smDrH7SiIBzcWcEb8KWcGnpq/DLDGGZGG5OMS7KL1b5BEe
 ZNqka475hJOm6Fw50SF+3IykR6Et+0JVvPl8Ir0b7Lm0PvyxlhgINUkqA
 NQoQOT6V5o/avIlVm0w12u8wAdwaooO60lHIEyoWLksV9ymd5I0OMmXJa
 WsooJotREaeJHyaYPXlC2bLZkpsO+Fx8/8AFkpG00+ppidwCRTttp0u1p
 x+TwjMD9chqguyhRyaCOpAd6nPRDW7l4Knf9rfi09oCfr/Qj0gh8EXLYu
 ovjdywTgU/e++mTbaAlJOJcwmVfOeUqkvEHfdV1bRwq7pGVhpWUDKHkwr w==;
X-CSE-ConnectionGUID: 5rsVGnROSWinGed21boJ8Q==
X-CSE-MsgGUID: ckdfPlkqSDmSusmg/1zjZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89945955"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="89945955"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:08:56 -0700
X-CSE-ConnectionGUID: EspgKVNjSmqnXE68SJKjnw==
X-CSE-MsgGUID: S68voHdES4yR6rPVa12gSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="239767038"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa003.jf.intel.com with ESMTP; 05 May 2026 03:08:55 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 7/7] usertools/telemetry-watcher: support reconnection
Date: Tue,  5 May 2026 11:08:33 +0100
Message-ID: <20260505100833.2885047-8-bruce.richardson@intel.com>
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

Allow the watcher binary to run even when there is no DPDK process
running. In that case, wait for a suitable process to start and begin
monitoring then. In case of disconnection, keep trying to reconnect and
resume once reconnection succeeds.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_07.rst |   7 ++
 doc/guides/tools/telemetrywatcher.rst  |   6 +
 usertools/dpdk-telemetry-watcher.py    | 166 +++++++++++++++++++------
 3 files changed, 141 insertions(+), 38 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..a049bacfe0 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,13 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.

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
index 251d99a085..f3be49982f 100644
--- a/doc/guides/tools/telemetrywatcher.rst
+++ b/doc/guides/tools/telemetrywatcher.rst
@@ -11,6 +11,12 @@ It wraps the ``dpdk-telemetry.py`` script to provide real-time statistics displa
 Running the Tool
 ----------------

+The watcher tool can be run at any time, whether or not a DPDK application is currently running.
+When a DPDK application with telemetry enabled starts
+(assuming correct file-prefix and instance are specified),
+the watcher will automatically connect and begin displaying the requested statistics.
+If the DPDK application stops, the watcher will attempt to reconnect when the application restarts.
+
 The tool has a number of command line options:

 .. code-block:: console
diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index eda57e5ba5..51b5736381 100755
--- a/usertools/dpdk-telemetry-watcher.py
+++ b/usertools/dpdk-telemetry-watcher.py
@@ -60,6 +60,29 @@ def find_telemetry_script():
     return telemetry_script


+def cleanup_telemetry_process(process):
+    """Close pipes and terminate/wait for a telemetry subprocess.
+
+    Args:
+        process (subprocess.Popen): Telemetry subprocess to clean up.
+    """
+    if process is None:
+        return
+
+    for stream in (process.stdin, process.stdout, process.stderr):
+        stream.close()
+
+    if process.poll() is None:
+        process.terminate()
+        try:
+            process.wait(timeout=1)
+        except subprocess.TimeoutExpired:
+            process.kill()
+            process.wait()
+    else:
+        process.wait()
+
+
 def create_telemetry_process(telemetry_script, args_list):
     """Create a subprocess for dpdk-telemetry.py with pipes.

@@ -85,6 +108,8 @@ def create_telemetry_process(telemetry_script, args_list):
             text=True,
             bufsize=1,  # Line buffered
         )
+        process.script = telemetry_script  # Store script path for reference
+        process.args = args_list  # Store args for reference
         return process
     except FileNotFoundError:
         print("Error: Python interpreter or script not found", file=sys.stderr)
@@ -102,15 +127,42 @@ def query_telemetry(process, command):
         command: The telemetry command to send (e.g., "/info" or "/ethdev/stats,0")

     Returns:
-        dict: The parsed JSON response with the command wrapper stripped,
+        (process, dict): The process handle, in case of reconnection, and the
+              parsed JSON response with the command wrapper stripped,
               or None if there was an error
     """
-    # Send the command
-    process.stdin.write(f"{command}\n")
-    process.stdin.flush()
+    # Handle case where process is None
+    if process is None:
+        return (None, None)
+
+    # Send/read may fail with broken pipes if the app dies; reconnect on failure.
+    try:
+        process.stdin.write(f"{command}\n")
+        process.stdin.flush()
+        response = process.stdout.readline()
+    except (BrokenPipeError, OSError):
+        response = None
+
+    # Reconnect and retry until a non-empty response is received.
+    while not response:
+        script = process.script
+        args_list = process.args
+        cleanup_telemetry_process(process)
+        process = None
+        print("Application disconnected, retrying...", file=sys.stderr)
+        while not process:
+            time.sleep(1)
+            candidate = create_telemetry_process(script, args_list)
+            process = print_connected_app(candidate)
+            if not process:
+                cleanup_telemetry_process(candidate)
+        try:
+            process.stdin.write(f"{command}\n")
+            process.stdin.flush()
+            response = process.stdout.readline()
+        except (BrokenPipeError, OSError):
+            response = None

-    # Read the JSON response
-    response = process.stdout.readline()
     try:
         data = json.loads(response)
         # When run non-interactively, the response is wrapped with the command
@@ -119,24 +171,47 @@ def query_telemetry(process, command):
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
+        return (process, None)


 def print_connected_app(process):
     """Query and print the name of the connected DPDK application.

+    This helper sends /info directly instead of using query_telemetry()
+    to avoid a recursive reconnect call chain when it is used during
+    process creation/reconnection.
+
     Args:
         process: The subprocess.Popen handle to the telemetry process
     """
-    info = query_telemetry(process, "/info")
+    try:
+        process.stdin.write("/info\n")
+        process.stdin.flush()
+        response = process.stdout.readline()
+    except (BrokenPipeError, OSError):
+        return None
+
+    if not response:
+        return None
+
+    try:
+        data = json.loads(response)
+        if len(data) == 1:
+            info = next(iter(data.values()))
+        else:
+            info = data
+    except (json.JSONDecodeError, KeyError):
+        return None
+
     if info and "pid" in info:
         app_name = get_app_name(info["pid"])
         if app_name:
             print(f'Connected to application: "{app_name}"')
+    return process


 def expand_shortcuts(process, stat_specs):
@@ -147,7 +222,10 @@ def expand_shortcuts(process, stat_specs):
         stat_specs: List of stat specifications, possibly including shortcuts

     Returns:
-        List of expanded stat specifications
+        Tuple of (process, expanded_specs) where:
+            process: Updated process handle, in case of reconnection
+            expanded_specs: List of expanded stat specifications
+        Returns (process, None) on error
     """
     expanded = []
     for spec in stat_specs:
@@ -159,7 +237,7 @@ def expand_shortcuts(process, stat_specs):
         field = spec[4:]  # Remove "eth." prefix
         if not field:
             print(f"Error: Invalid shortcut '{spec}' - missing field name", file=sys.stderr)
-            return None
+            return process, None

         # Map common shortcuts to actual field names
         field_map = {
@@ -169,16 +247,16 @@ def expand_shortcuts(process, stat_specs):
         field = field_map.get(field, field)

         # Get list of ethernet devices
-        port_list = query_telemetry(process, "/ethdev/list")
+        process, port_list = query_telemetry(process, "/ethdev/list")
         if not isinstance(port_list, list):
             print("Error: Failed to get ethernet device list", file=sys.stderr)
-            return None
+            return process, None

         # Create stat specs for each port
         for port in port_list:
             expanded.append(f"/ethdev/stats,{port}.{field}")

-    return expanded
+    return process, expanded


 def validate_stats(process, stat_specs):
@@ -189,10 +267,11 @@ def validate_stats(process, stat_specs):
         stat_specs: List of stat specifications in format "command.field"

     Returns:
-        Tuple of (parsed_specs, initial_values) where:
+        Tuple of (process, parsed_specs, initial_values) where:
+            process: Updated process handle, in case of reconnection
             parsed_specs: List of tuples (spec, command, field) for valid specs
             initial_values: List of initial values for each stat
-        Returns (None, None) on error
+        Returns (process, None, None) on error
     """
     parsed_specs = []
     initial_values = []
@@ -204,7 +283,7 @@ def validate_stats(process, stat_specs):
                 "Expected format: 'command.field' (e.g., /ethdev/stats,0.ipackets)",
                 file=sys.stderr,
             )
-            return None, None
+            return process, None, None

         command, field = spec.rsplit(".", 1)
         if not command or not field:
@@ -213,28 +292,28 @@ def validate_stats(process, stat_specs):
                 "Expected format: 'command.field' (e.g., /ethdev/stats,0.ipackets)",
                 file=sys.stderr,
             )
-            return None, None
+            return process, None, None

         # Query the stat once to validate it exists and is numeric
-        data = query_telemetry(process, command)
+        process, data = query_telemetry(process, command)
         if not isinstance(data, dict):
             print(f"Error: Command '{command}' did not return a dictionary", file=sys.stderr)
-            return None, None
+            return process, None, None
         if field not in data:
             print(f"Error: Field '{field}' not found in '{command}' response", file=sys.stderr)
-            return None, None
+            return process, None, None
         value = data[field]
         if not isinstance(value, (int, float)):
             print(
                 f"Error: Field '{field}' in '{command}' is not numeric (got {type(value).__name__})",
                 file=sys.stderr,
             )
-            return None, None
+            return process, None, None

         parsed_specs.append((spec, command, field))
         initial_values.append(value)

-    return parsed_specs, initial_values
+    return process, parsed_specs, initial_values


 def monitor_stats(process, args):
@@ -243,16 +322,19 @@ def monitor_stats(process, args):
     Args:
         process: The subprocess.Popen handle to the telemetry process
         args: Parsed command line arguments
+
+    Returns:
+        subprocess.Popen: The latest telemetry process handle
     """
     # Expand any shortcuts like eth-rx, eth-tx
-    expanded_stats = expand_shortcuts(process, args.stats)
+    process, expanded_stats = expand_shortcuts(process, args.stats)
     if not expanded_stats:
-        return
+        return process

     # Validate all stat specifications and get initial values
-    parsed_specs, prev_values = validate_stats(process, expanded_stats)
+    process, parsed_specs, prev_values = validate_stats(process, expanded_stats)
     if not parsed_specs:
-        return
+        return process

     # Print header
     header = "Time".ljust(10)
@@ -276,7 +358,12 @@ def monitor_stats(process, args):
             current_values = []
             total = 0
             for i, (spec, command, field) in enumerate(parsed_specs):
-                data = query_telemetry(process, command)
+                process, data = query_telemetry(process, command)
+                if not data:
+                    fallback_value = prev_values[i] if i < len(prev_values) else 0
+                    current_values.append(fallback_value)
+                    row += "N/A".rjust(25)
+                    continue
                 current_value = data[field]
                 current_values.append(current_value)

@@ -298,6 +385,8 @@ def monitor_stats(process, args):
             print()  # Add newline before exit message
         print("\nMonitoring stopped")

+    return process
+

 def main():
     """Main function to parse arguments and run dpdk-telemetry.py with a pipe"""
@@ -386,19 +475,20 @@ def main():
         return 1

     # Run dpdk-telemetry.py with pipes for stdin and stdout
-    process = create_telemetry_process(telemetry_script, args_list)
-
-    # Get and display the connected application name
-    print_connected_app(process)
+    process = None
+    print("Waiting for connection to DPDK application...", file=sys.stderr)
+    while not process:
+        candidate = create_telemetry_process(telemetry_script, args_list)
+        process = print_connected_app(candidate)
+        if not process:
+            cleanup_telemetry_process(candidate)
+            time.sleep(1)

     # Monitor the requested statistics
-    monitor_stats(process, args)
+    process = monitor_stats(process, args)

     # Clean up
-    process.stdin.close()
-    process.stdout.close()
-    process.stderr.close()
-    process.wait()
+    cleanup_telemetry_process(process)

     return 0

--
2.51.0

