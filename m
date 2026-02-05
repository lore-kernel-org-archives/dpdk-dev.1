Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38462EC1EBC
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 15:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6EDC4278C;
	Thu,  5 Feb 2026 16:02:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 55BE942686
 for <dev@dpdk.org>; Thu,  5 Feb 2026 16:02:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770303763; x=1801839763;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KBF7Q9KyLzav0CPhSBFUEegtkRPUUSDrd1vfv1Swdvw=;
 b=f9Lh3vbC503c9sE9S2SC3hv5a6Q79bEtknhkhm8pTzpWV342o0KAO/bp
 1hrQ5geW6dnqv3BxzuZcFK2ZR9wg6jrIcPz05Hp4WtNkRzIJKSwOPANV5
 6UySvVpx7yAXF1j2FCa+nS/+o3lgdTrjI1kdU4FUSdzFf58XzSunJ/ESJ
 4sQavjuPv+Wp/qjX/R0yhYvz4erMPSuWJZIhTwujQcglU39g9Ge07egbA
 DdhNrU/ELvAeon2hhMEDByqfKVbQHincm8dhJlMsr4mKsVkzvbolEFyrH
 PeawKyqLgCysOh8qafjJfRRGwJG4XDzAJZGPYihsbm/tlrDENISU5127e g==;
X-CSE-ConnectionGUID: XgciXGL/TuSz4ewmQp2vYg==
X-CSE-MsgGUID: IRpdifgcQx+gKMhb1OFEjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="81817235"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="81817235"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 07:02:42 -0800
X-CSE-ConnectionGUID: z4gR/dhQQDarv8mLX7FGcg==
X-CSE-MsgGUID: 3kIzJ7naTfeHiJ5TcEEZtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="214722865"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 05 Feb 2026 07:02:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 6/7] usertools/telemetry-watcher: add eth name shortcuts
Date: Thu,  5 Feb 2026 15:02:29 +0000
Message-ID: <20260205150230.123076-7-bruce.richardson@intel.com>
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
index b4ca1fcfc0..251d99a085 100644
--- a/doc/guides/tools/telemetrywatcher.rst
+++ b/doc/guides/tools/telemetrywatcher.rst
@@ -95,6 +95,19 @@ Example telemetry commands:
 
 See `Examples`_ section for usage examples based on the results of these telemetry commands.
 
+Shortcuts
+---------
+
+The tool provides convenient shortcuts for common statistics:
+
+* ``eth.rx`` - Expands to ``/ethdev/stats,N.ipackets`` for all Ethernet devices
+* ``eth.tx`` - Expands to ``/ethdev/stats,N.opackets`` for all Ethernet devices
+* ``eth.FIELD`` - Expands to ``/ethdev/stats,N.FIELD`` for all Ethernet devices
+
+These shortcuts automatically detect all available Ethernet devices
+and create a column for each one.
+
+
 Examples
 --------
 
@@ -106,10 +119,30 @@ Monitor received and transmitted packets on device 0::
 
    dpdk-telemetry-watcher.py /ethdev/stats,0.ipackets /ethdev/stats,0.opackets
 
+Monitor received packets on all Ethernet devices using shortcut::
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
index 7ec7267a38..eda57e5ba5 100755
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
+            print("Error: Failed to get ethernet device list", file=sys.stderr)
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

