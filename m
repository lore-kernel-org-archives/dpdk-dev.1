Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0684D3C928
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 16:56:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4BE740C35;
	Wed, 10 Dec 2025 17:55:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 12C8440A84
 for <dev@dpdk.org>; Wed, 10 Dec 2025 17:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765385743; x=1796921743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BxeaOwbNLwx8fUKtHT7wKSKAWAPF8NDdtPMt2Rrb7p4=;
 b=Vl541/fvYR5fWe8n0rmYcIqjoNG3h8VdaIfLkkSS+6h1Oq2AGwuIdE74
 aubCZXtJYb6Y3oZgBvgSIVBtCUTYWXl0dVvi2uYGcpKqeHL4n6XGz3ppK
 La/UkncsE2AMxnf0OaSrkt7SC5y9vXaRQAYCGaBR9O74w2lqiysyRrzs1
 ysO8yUotuPwkd2gSZa3ZxAzhX8Yx+YgUpd5dt5PaDH/hjt8QsgL8kddZy
 vyf3j3FpxfTR74JTBfaK7vmm7ewI+lMRaYhRnq3vZKtynBxMWDOJsVCmW
 u4JDmj50X/b7vP8BmTsujcMDPj8IzpUaRy9IAmAHaAmOoK6ZVjnu6yRFJ g==;
X-CSE-ConnectionGUID: AZhQff1XRb+L10IRO2kgOQ==
X-CSE-MsgGUID: iZsGrON7RUqb2FVLhM148Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67088732"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="67088732"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 08:55:42 -0800
X-CSE-ConnectionGUID: /vVxXLjBTvGORJl9Yr2cNQ==
X-CSE-MsgGUID: kN8sFJNLRSCBZPamBf0P7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="195828616"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 10 Dec 2025 08:55:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 4/7] usertools/telemetry-watcher: add total and one-line
 opts
Date: Wed, 10 Dec 2025 16:55:29 +0000
Message-ID: <20251210165532.103450-5-bruce.richardson@intel.com>
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

Add options to the script to print out totals at the end of each line,
and to print each line replacing the previous one, saving the output
scrolling up the screen constantly.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-telemetry-watcher.py | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index 8af9af867c..bdf1423dd3 100755
--- a/usertools/dpdk-telemetry-watcher.py
+++ b/usertools/dpdk-telemetry-watcher.py
@@ -210,10 +210,13 @@ def monitor_stats(process, args):
     header = "Time".ljust(10)
     for spec, _, _ in parsed_specs:
         header += spec.rjust(25)
+    if args.total:
+        header += "Total".rjust(25)
     print(header)
 
     # Monitor loop - once per second
     count = 0
+    line_ending = "\r" if args.single_line else "\n"
     try:
         while args.timeout is None or count < args.timeout:
             time.sleep(1)
@@ -223,6 +226,7 @@ def monitor_stats(process, args):
             row = timestamp.ljust(10)
 
             current_values = []
+            total = 0
             for i, (spec, command, field) in enumerate(parsed_specs):
                 data = query_telemetry(process, command)
                 current_value = data[field]
@@ -233,11 +237,17 @@ def monitor_stats(process, args):
                 else:
                     display_value = current_value
 
+                total += display_value
                 row += str(display_value).rjust(25)
 
-            print(row)
+            if args.total:
+                row += str(total).rjust(25)
+
+            print(row, end=line_ending, flush=True)
             prev_values = current_values
     except KeyboardInterrupt:
+        if args.single_line:
+            print()  # Add newline before exit message
         print("\nMonitoring stopped")
 
 
@@ -282,6 +292,21 @@ def main():
         default=False,
         help="Display delta values instead of absolute values",
     )
+    parser.add_argument(
+        "-T",
+        "--total",
+        action="store_true",
+        default=False,
+        help="Display a total column at the end of each row",
+    )
+    parser.add_argument(
+        "-1",
+        "--single-line",
+        action="store_true",
+        default=False,
+        dest="single_line",
+        help="Display output on a single line, replacing the previous output",
+    )
     parser.add_argument(
         "stats",
         nargs="*",
-- 
2.51.0

