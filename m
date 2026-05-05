Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A2BFF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 10:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76E654068E;
	Tue,  5 May 2026 12:08:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 62E814066E
 for <dev@dpdk.org>; Tue,  5 May 2026 12:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777975734; x=1809511734;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tciT51Jjj8+YA3un0WuB06YFCh60zvPB6IVw045i4Fw=;
 b=BEG/4kZRcH0/x1RoopbqV/yaz6v1UBnk40yFXt9IaJtBsMRwXundXsNz
 K81in4zG/+LiyiGNX7woIjAUEqirSiCxdT1dXG+LK98VKhNZwFp1+AFTs
 NMyAuQPt8nd364iy+hiNxJQS4YZ7+U2YM17GDfKBoLpUBfRD0NPh3dewm
 S/i6hpX98vLvV+Cqa49nJZj3xlQkBrq9Z8KqkWYhdEme9/8FrB45MSuZM
 2//sJYIcM0hI7uPe19aGrzxvZuQh+PScfjlvQ+IHcd7iugEHX4Huah6t9
 JRmZ2wDcQ/zSEuCS6yNFj99vyC/SdZCOCDffRjwvgJpdrmKPJIgGr8yLf A==;
X-CSE-ConnectionGUID: bVipu16gQY2XZrOxz8jWiA==
X-CSE-MsgGUID: wqnM4tHgTbe+uDJIVLZm4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89945949"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="89945949"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 03:08:53 -0700
X-CSE-ConnectionGUID: ioJ1U6eHTIm3dVZYmSxGEQ==
X-CSE-MsgGUID: oWBnnqROQCmfKmFQBb79iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="239767031"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa003.jf.intel.com with ESMTP; 05 May 2026 03:08:53 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 5/7] usertools/telemetry-watcher: add thousands separator
Date: Tue,  5 May 2026 11:08:31 +0100
Message-ID: <20260505100833.2885047-6-bruce.richardson@intel.com>
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

When printing large values of packets, generally in the millions, things
are far more readable with thousands and millions separators.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 usertools/dpdk-telemetry-watcher.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/usertools/dpdk-telemetry-watcher.py b/usertools/dpdk-telemetry-watcher.py
index e4cd292515..7ec7267a38 100755
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

