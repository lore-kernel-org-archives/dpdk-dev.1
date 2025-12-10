Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D995BD3C92B
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 16:56:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE8F140DCF;
	Wed, 10 Dec 2025 17:55:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0AF9F40B94
 for <dev@dpdk.org>; Wed, 10 Dec 2025 17:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765385745; x=1796921745;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ax2XZxWskuNAgNfbV4NUr2RpurL7v67K5uB9Fq9VUiA=;
 b=jGZB5qERi1hJNBzvm+pabCj3x1Mt2dInurw6KkmcQ6iaAHxWCz+Y9l5V
 jTU/pFzDsxoX5FcAbL4SohfU9hgDfDc6OsnqeDSGcTz8xmXufxeqhaboi
 aTU2fWUTLSL47n5sHkJQycZDn2N67c91gOuuoA1UVyRrT9/IZnRpJs+2Y
 mSz4JQ0ITG3HZ/dmkY4bkWKdzd3GY7Sn0Qjn0an2WpaHiBEQ0ZIR23LDG
 2YRrjo6UVxxsKK56Rh9XxniES6jSTo6Y3IAX6QvGEzgvylwGH6rT6l7lW
 kyvXGHWKIHjaSfjHR4BE4LAaAoWjfM62EJ304V5bl+eTUSRAnEiQ/ceOG A==;
X-CSE-ConnectionGUID: 1j8wgK2WSdOKXkpnTObu7Q==
X-CSE-MsgGUID: gG3CiX0ISVynHiTlb4HENA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67088735"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="67088735"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 08:55:44 -0800
X-CSE-ConnectionGUID: VHzdo+2aQSKpeCQScvMVGA==
X-CSE-MsgGUID: aIS/4vIISeyhg9f27TE9GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="195828624"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 10 Dec 2025 08:55:42 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 6/7] usertools/telemetry-watcher: add eth name shortcuts
Date: Wed, 10 Dec 2025 16:55:31 +0000
Message-ID: <20251210165532.103450-7-bruce.richardson@intel.com>
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

