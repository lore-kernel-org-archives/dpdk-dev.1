Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD8CC79FAF
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 17:56:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDBC740678;
	Mon,  5 Jan 2026 18:56:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4A7024064F
 for <dev@dpdk.org>; Mon,  5 Jan 2026 18:56:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767635781; x=1799171781;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UKE+t1fHeW79H68pukxahQ1+G7DE6OJKsyVSicXWYH0=;
 b=IyU9Ffec7hW1dtiC9wPdZDKimOFtTOLgLLCBd+GAyqqM8iExJir2inpW
 vkWe9nE2oOky1QxCttTQIU3R/8LeHQgEFiVKnxsUA9pHxVqc+4xmdZWyk
 yPsHtEUufPlz/aB4PMfO6gTMhE3Qhz95yRgvfDuPcx3ehSm6TFAqi1JVC
 UQB+JSbUmEfcZnTAGYz9hqW/LxqunblOtPHvQ4l2Bk+vTMsi+8gPPG5Se
 dD/2FQnFvKMKThZskopvHifQd0tTKG9VHYp3iKEVCh7FMYCYgkUbWZ4k7
 dPfZcLIUdW6tKf/Q2ZisUn5CTT/yKikhWEIM8FqIe370qYNCpJL7C5Dmg g==;
X-CSE-ConnectionGUID: R0SVIRUISYebNxI16lMwDg==
X-CSE-MsgGUID: 2VoImzGqTQm/VvzCkEPtnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79308865"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="79308865"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 09:56:21 -0800
X-CSE-ConnectionGUID: Ravix4eaQbKglL93CTOvxw==
X-CSE-MsgGUID: sCudipfSRwSWGOjhg2o7/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="239928779"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 05 Jan 2026 09:56:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 7/7] usertools/telemetry-watcher: support reconnection
Date: Mon,  5 Jan 2026 17:56:05 +0000
Message-ID: <20260105175605.52689-8-bruce.richardson@intel.com>
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

Allow the watcher binary to run even when there is no DPDK process
running. In that case, wait for a suitable process to start and begin
monitoring then. In case of disconnection, keep trying to reconnect and
resume once reconnection succeeds.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-telemetry-watcher.py | 52 ++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index 6beb67d29a..5c568c1e88 100755
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
         print(f"Error: Python interpreter or script not found", file=sys.stderr)
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

