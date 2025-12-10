Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AEBD3C928
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 16:56:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C447F40DCB;
	Wed, 10 Dec 2025 17:55:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9205140A84
 for <dev@dpdk.org>; Wed, 10 Dec 2025 17:55:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765385743; x=1796921743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fMc+Kj3gW601WNVyY+UKMkWLI9IMCWoFAdOBnHKoMlg=;
 b=Yyba5I73xkuddSrFpGcblGEyyOHOfnl5HEi6homvXT9ADf+4RW3l0Phz
 AbyVnvzRji2e1Prp0UpfX/9uOMJalWCeO5eNVF5yd/b5AA3Gzkz2te8F9
 D04cGFVnyMNfgELRNOGHUUEyhUhrVPeR+2WN+vItC4VScVyOkAG74oZfx
 rqD/QEFlWE73MWIMTcL08gY7eU6/grqnJ33vMaHLIHCiNPEuOSbEeNwtd
 GcghTVGWbCeGcBT8LcnwHflp1P/zPSy6WK+0AywZxMlwNRx3aAC4vARZk
 zBiiElRqA5ptQDB7Te46RlHAxor5euVnHlFvryMGahYq/pD18tpZZp1jH g==;
X-CSE-ConnectionGUID: T7W1DcCFQMm4XAGVj666ww==
X-CSE-MsgGUID: S11sHlndRKiCjm0hgGZGig==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67088733"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="67088733"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 08:55:43 -0800
X-CSE-ConnectionGUID: JRdpJk8oRBKizSvrU+bSlA==
X-CSE-MsgGUID: VBDHcw9zT0uZqFYeLxn8Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; d="scan'208";a="195828619"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 10 Dec 2025 08:55:42 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 5/7] usertools/telemetry-watcher: add thousands separator
Date: Wed, 10 Dec 2025 16:55:30 +0000
Message-ID: <20251210165532.103450-6-bruce.richardson@intel.com>
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

When printing large values of packets, generally in the millions, things
are far more readable with thousands and millions separators.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 usertools/dpdk-telemetry-watcher.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index bdf1423dd3..59ec4c85b6 100755
--- a/usertools/dpdk-telemetry-watcher.py
+++ b/usertools/dpdk-telemetry-watcher.py
@@ -15,6 +15,7 @@
 import errno
 import json
 import time
+import locale
 
 
 def get_app_name(pid):
@@ -238,10 +239,10 @@ def monitor_stats(process, args):
                     display_value = current_value
 
                 total += display_value
-                row += str(display_value).rjust(25)
+                row += f"{display_value:n}".rjust(25)
 
             if args.total:
-                row += str(total).rjust(25)
+                row += f"{total:n}".rjust(25)
 
             print(row, end=line_ending, flush=True)
             prev_values = current_values
@@ -254,6 +255,9 @@ def monitor_stats(process, args):
 def main():
     """Main function to parse arguments and run dpdk-telemetry.py with a pipe"""
 
+    # Set locale for number formatting
+    locale.setlocale(locale.LC_ALL, "")
+
     # Parse command line arguments - matching dpdk-telemetry.py parameters
     parser = argparse.ArgumentParser(
         description="Monitor DPDK telemetry statistics on the command line"
-- 
2.51.0

