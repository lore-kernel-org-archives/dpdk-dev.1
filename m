Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F87FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 10:09:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2D4440678;
	Tue,  5 May 2026 12:08:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3AD2440668
 for <dev@dpdk.org>; Tue,  5 May 2026 12:08:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777975733; x=1809511733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9pMxmD+OWX91C6WJ4i6iYzVdkk+K7wNkJvsnedOFvkI=;
 b=i4Y9v6TNXtZoIkzWcnVKaKoQy5HjHu+Y7CP4d5nmYMDF6T6CRMTBS/5i
 W9IcGOyuMeykYkx2nfw/dzuZPoe/0VmyhOVI4bKlcfQtBlG/ge6znYwbR
 OQ8MYRVEMAvbm1MdZsaADYf64P3/tmfFWymvU4V9FNRfYWSdNUxAVjP6P
 CrktQEp9vGjbHUk8bw0mwoyIyOkKtRUSAzoK4lD6nWLk4IUznz98Y7QPO
 kUMoW6zP00Ad3rusTtkzt9e2rMlBKAkRDbDzInL9slpKacxVh5DekAjim
 dEXacHIVgLcsHomAKuQjKhVLP04pXXdICb5fskZABw1PVw/5h+YlG2+uE g==;
X-CSE-ConnectionGUID: 06uxxf1lSeadDeRj3xIbEA==
X-CSE-MsgGUID: mVP861olTXqVM7FbJGYspA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89945947"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="89945947"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:08:52 -0700
X-CSE-ConnectionGUID: obLABygXS5KWFysnNU9EMg==
X-CSE-MsgGUID: mGDZXz/0QAaEcjsMDB7h8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="239767027"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa003.jf.intel.com with ESMTP; 05 May 2026 03:08:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 4/7] usertools/telemetry-watcher: add total and one-line
 opts
Date: Tue,  5 May 2026 11:08:30 +0100
Message-ID: <20260505100833.2885047-5-bruce.richardson@intel.com>
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

