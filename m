Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A436E83F1F
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 15:03:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ADFE42686;
	Thu,  5 Feb 2026 16:02:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D5F1641143
 for <dev@dpdk.org>; Thu,  5 Feb 2026 16:02:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770303761; x=1801839761;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oP3lGeriWS1WKyyHXdExKjLBnO9Aqy3fdKB6iEZLJEk=;
 b=EhPD+CCkJzDX6OeExkmuwwUWTSQTHv9sbZlzkE9Dw3GMaNFCF0cC1BsL
 B6sHkumBN7QoRdE35I1sjKEtxIjFQgGnTHlAg4Rq0ctz/6KaFHP6bVvVb
 piu6afb2HWQjM6541Ym/Gy3iJ0BSZkw9V2TlF6xfm8nUnWxtv233ZhTlh
 h0FUpzGmqFf1F6B3N/Pm40Fvqm8OLeSQ4QkzOwZpwclftO0NQ0IQNSFcK
 k5bDH3+jHkO/ATlj/OQ/heRLxJn59J6tUoK+8pysXp9itJ2g8VtGqDb97
 7XuraQ66rGb/Qyy0RuLT6bz+Du7bBRKMiMS5Op8uvg09CntqY+WvyKtex g==;
X-CSE-ConnectionGUID: VXhbnZw+Qpuhqw2REJtXnQ==
X-CSE-MsgGUID: 9+1dRPmmRBy62peroaoO6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="81817226"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="81817226"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 07:02:40 -0800
X-CSE-ConnectionGUID: LBp/8Qv8RRKzx8m9cvPe4A==
X-CSE-MsgGUID: t7lVPV3uR4eEmK/46LpxNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="214722852"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 05 Feb 2026 07:02:39 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 4/7] usertools/telemetry-watcher: add total and one-line
 opts
Date: Thu,  5 Feb 2026 15:02:27 +0000
Message-ID: <20260205150230.123076-5-bruce.richardson@intel.com>
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

Add options to the script to print out totals at the end of each line,
and to print each line replacing the previous one, saving the output
scrolling up the screen constantly.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/tools/telemetrywatcher.rst | 27 +++++++++++++++++++++++++++
 usertools/dpdk-telemetry-watcher.py   | 27 ++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/doc/guides/tools/telemetrywatcher.rst b/doc/guides/tools/telemetrywatcher.rst
index 5a9c60946b..b4ca1fcfc0 100644
--- a/doc/guides/tools/telemetrywatcher.rst
+++ b/doc/guides/tools/telemetrywatcher.rst
@@ -55,6 +55,15 @@ Options
    This shows the change in statistics since the last iteration,
    which is useful for monitoring per-second rates.
 
+.. option:: -T, --total
+
+   Display a total column at the end of each row that sums all monitored statistics.
+
+.. option:: -1, --single-line
+
+   Display output on a single line, replacing the previous output.
+   This is useful for reducing scrolling and keeping the display compact.
+
 .. option:: stat
 
    Statistics to monitor in format ``command.field``.
@@ -106,6 +115,24 @@ List all running DPDK applications::
    dpdk-telemetry-watcher.py -l
 
 
+Output Format
+-------------
+
+The tool displays statistics in a tabular format with:
+
+* **Time column** - Current timestamp (HH:MM:SS)
+* **Statistics columns** - One column per specified statistic
+* **Total column** - Optional sum of all statistics (when ``-T`` is used)
+
+Displayed values use locale-specific number formatting (e.g. comma as thousands separator).
+
+When ``--delta`` mode is enabled, the tool displays the change in each statistic
+since the last iteration, which typically represents the rate per second.
+
+When ``--single-line`` mode is enabled, each new output line replaces the previous one,
+similar to tools like ``top``.
+
+
 Dependencies
 ------------
 
diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index 5f4aa05431..e4cd292515 100755
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

