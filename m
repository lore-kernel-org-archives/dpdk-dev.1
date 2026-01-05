Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265CC79FAF
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 17:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A59344066B;
	Mon,  5 Jan 2026 18:56:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 61D164064E
 for <dev@dpdk.org>; Mon,  5 Jan 2026 18:56:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767635780; x=1799171780;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ax2XZxWskuNAgNfbV4NUr2RpurL7v67K5uB9Fq9VUiA=;
 b=fD4L5mNNei8YFAS+m+Xt8Nl8+mKnXux6FegpgVPHoqpy7Xd5GC3F9LFi
 iRMikjAVVzbqV3sMDsHoG97GzyFMfD4N78r/FmJJ32iFuBaEbpQ7htSnS
 H9EYXa8OqdGQS1bfr4vDu4ukQnx7P6zPhTykw0z64uI+GwTDbaKBhhJyr
 ACXTnrHei6vWcMlm2m/G/epKIhGybvn4TlOtYxwNt2diZxXgFF/u9klqY
 QFnClCMx094+3awoAMPRj9/mOo5sApD6rAOhlRefZotDRaZDqK+MnJIFV
 rIp5ImqCGWLWfNjWbV7xVun0oRZmqa+WG87ACVQqer5A8TsFcKejb1+wU A==;
X-CSE-ConnectionGUID: 0DMI+I0KTEed1jCLRxqPKQ==
X-CSE-MsgGUID: ORa0ZXlXTfashKxtaAXd/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79308863"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="79308863"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 09:56:20 -0800
X-CSE-ConnectionGUID: ktjCRZu7RKeLuTVNxN3l/A==
X-CSE-MsgGUID: hiCH34i7Tp+Zbo6KdM1PQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="239928771"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 05 Jan 2026 09:56:18 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 6/7] usertools/telemetry-watcher: add eth name shortcuts
Date: Mon,  5 Jan 2026 17:56:04 +0000
Message-ID: <20260105175605.52689-7-bruce.richardson@intel.com>
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
---
 usertools/dpdk-telemetry-watcher.py | 49 ++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index 59ec4c85b6..6beb67d29a 100755
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

