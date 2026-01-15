Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87EBD46613
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 19:04:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59DC642D7D;
	Thu, 15 Jan 2026 20:03:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0606C427D3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 20:03:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768503822; x=1800039822;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bKRHDkciXpLoh28j0MaHOqAxvEk8mlM0w3Jtz1MZLpg=;
 b=kNNYwy7QFZyo2iikRUHT2q098y91noqhVePQNuoRd9GhNNxVpIxKVuZW
 M8lkyvsa0q1i4Q/+AwA7odEOjRDydrq1+OBoqY0IPhYbzUA+a4+EpAejf
 DJ6mr5B+CWK1R+dX6tzr4YtbKPDcu6CRHIBeZU00HxMBNppD8ibxp+9mP
 Q/eSQvF5KKkK0isNgEagoMkTeJqFpZj2/cSGU1acgRp8eyixIUtwanYIj
 S5KO/qWcEHzLaZprpeAxli2VsLlVZ+s9g8qWLXtz2MiNeMy6jIwqk7fu2
 accnuUXUwHW77V0Up6d9FYSDZjaCW6mbOFPb9ZAodLJta4paC/B0yxBAh g==;
X-CSE-ConnectionGUID: mzmyXa7tR/6B7k96TDVCnQ==
X-CSE-MsgGUID: gld8uEA6S528hrc3f69Q7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80461404"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; d="scan'208";a="80461404"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 11:03:41 -0800
X-CSE-ConnectionGUID: W7M1DPcbQ4S0e2iRwg5Rrw==
X-CSE-MsgGUID: IlUiHnlRTja0TUuKvZ4YQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; d="scan'208";a="205307694"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 15 Jan 2026 11:03:40 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 6/7] usertools/telemetry-watcher: add eth name shortcuts
Date: Thu, 15 Jan 2026 19:03:30 +0000
Message-ID: <20260115190331.3721281-7-bruce.richardson@intel.com>
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

Since an expected main use of the script is to monitor ethdev packet
stats, provide a shortened form of parameters to make it easier to
monitor all ports on the system. Any stat starting with "eth." is taken
not as a direct command, but instead as a shortcut for getting the stats
for all ports on the system. For example: eth.ibytes shows the byte
counts for all ports.

Beyond that, provide a shortcut for ipackets and opackets as just rx and
tx respectively. Therefore, to monitor the output rate of an app, one
can use "dpdk-telemetry-watcher -dT eth.tx"

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/tools/telemetrywatcher.rst | 33 ++++++++++++++++++
 usertools/dpdk-telemetry-watcher.py   | 49 ++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/doc/guides/tools/telemetrywatcher.rst b/doc/guides/tools/telemetrywatcher.rst
index 3d22818260..99e51881ff 100644
--- a/doc/guides/tools/telemetrywatcher.rst
+++ b/doc/guides/tools/telemetrywatcher.rst
@@ -96,6 +96,19 @@ Example telemetry commands:
 
 See `Examples`_ section for usage examples based on the results of these telemetry commands.
 
+Shortcuts
+---------
+
+The tool provides convenient shortcuts for common statistics:
+
+* ``eth.rx`` - Expands to ``/ethdev/stats,N.ipackets`` for all ethernet devices
+* ``eth.tx`` - Expands to ``/ethdev/stats,N.opackets`` for all ethernet devices
+* ``eth.FIELD`` - Expands to ``/ethdev/stats,N.FIELD`` for all ethernet devices
+
+These shortcuts automatically detect all available ethernet devices
+and create a column for each one.
+
+
 Examples
 --------
 
@@ -107,10 +120,30 @@ Monitor received and transmitted packets on device 0::
 
    dpdk-telemetry-watcher.py /ethdev/stats,0.ipackets /ethdev/stats,0.opackets
 
+Monitor received packets on all ethernet devices using shortcut::
+
+   dpdk-telemetry-watcher.py eth.rx
+
+Monitor packet deltas (rates) for device 0::
+
+   dpdk-telemetry-watcher.py -d /ethdev/stats,0.ipackets /ethdev/stats,0.opackets
+
+Monitor with a total column showing aggregate traffic::
+
+   dpdk-telemetry-watcher.py -d -T eth.rx eth.tx
+
+Monitor for a specific duration (60 iterations = 60 seconds)::
+
+   dpdk-telemetry-watcher.py -t 60 /ethdev/stats,0.ipackets
+
 Monitor a DPDK application with a custom file-prefix::
 
    dpdk-telemetry-watcher.py -f myapp /ethdev/stats,0.ipackets
 
+Monitor in single-line mode (no scrolling)::
+
+   dpdk-telemetry-watcher.py -1 -d eth.rx eth.tx
+
 List all running DPDK applications::
 
    dpdk-telemetry-watcher.py -l
diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index 7ec7267a38..9685ffa01f 100755
--- a/usertools/dpdk-telemetry-watcher.py
+++ b/usertools/dpdk-telemetry-watcher.py
@@ -139,6 +139,48 @@ def print_connected_app(process):
             print(f'Connected to application: "{app_name}"')
 
 
+def expand_shortcuts(process, stat_specs):
+    """Expand special shortcuts like eth.rx and eth.tx into actual stat specifications.
+
+    Args:
+        process: The subprocess.Popen handle to the telemetry process
+        stat_specs: List of stat specifications, possibly including shortcuts
+
+    Returns:
+        List of expanded stat specifications
+    """
+    expanded = []
+    for spec in stat_specs:
+        if not spec.startswith("eth."):
+            expanded.append(spec)
+            continue
+
+        # Extract the field name after "eth."
+        field = spec[4:]  # Remove "eth." prefix
+        if not field:
+            print(f"Error: Invalid shortcut '{spec}' - missing field name", file=sys.stderr)
+            return None
+
+        # Map common shortcuts to actual field names
+        field_map = {
+            "rx": "ipackets",
+            "tx": "opackets",
+        }
+        field = field_map.get(field, field)
+
+        # Get list of ethernet devices
+        port_list = query_telemetry(process, "/ethdev/list")
+        if not isinstance(port_list, list):
+            print(f"Error: Failed to get ethernet device list", file=sys.stderr)
+            return None
+
+        # Create stat specs for each port
+        for port in port_list:
+            expanded.append(f"/ethdev/stats,{port}.{field}")
+
+    return expanded
+
+
 def validate_stats(process, stat_specs):
     """Validate stat specifications and check that fields are numeric.
 
@@ -202,8 +244,13 @@ def monitor_stats(process, args):
         process: The subprocess.Popen handle to the telemetry process
         args: Parsed command line arguments
     """
+    # Expand any shortcuts like eth-rx, eth-tx
+    expanded_stats = expand_shortcuts(process, args.stats)
+    if not expanded_stats:
+        return
+
     # Validate all stat specifications and get initial values
-    parsed_specs, prev_values = validate_stats(process, args.stats)
+    parsed_specs, prev_values = validate_stats(process, expanded_stats)
     if not parsed_specs:
         return
 
-- 
2.51.0

