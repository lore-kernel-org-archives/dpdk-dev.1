Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA65E83F1F
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 15:03:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B909F4278D;
	Thu,  5 Feb 2026 16:02:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7366341143
 for <dev@dpdk.org>; Thu,  5 Feb 2026 16:02:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770303762; x=1801839762;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dUIuQaRt23CTb3FXhYnqvdnRlX3KZHiDg2xuWSAvR8E=;
 b=F3frvwjHtel24kgpDgBb1KGg5TQp80us6VHBFcOEJTy0m+Fm7LvRLCX/
 2ocEuJEp9rVqHuckIM0QWAnbZTDfDa1zycX/t9CzQemK7nyvS0/aoi2jk
 Q6SsultJ2LNfhd/ckjT4n9FPkmjyCy2oqvnX5Ds6AW1HhR4somGiyQ1e+
 4PgXlDlysWcYxfYVY/4NIsbYvy/o6iCjfnPNPn0ZdeOvkLphS5nf/x4k1
 K9kCFRmG/zrfVGVzcIV/zPoMdooqnsYFfs6IPyGuLEqZguzfsOAw8kjd5
 rELtvK5FV6OO+FsxeE1RJVnayS9YwLAR10RlWi+L/ki164ihGNrwbLx6O g==;
X-CSE-ConnectionGUID: SWWJoEk9TaGslYl5fwdEhQ==
X-CSE-MsgGUID: /8cODyK5R1+OtCSntxQK1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="81817230"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="81817230"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 07:02:41 -0800
X-CSE-ConnectionGUID: WTSRgrEAQfK/1e+I6hIUBQ==
X-CSE-MsgGUID: JTkSK/idS/qR7ObmEZOsfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="214722858"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 05 Feb 2026 07:02:40 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 5/7] usertools/telemetry-watcher: add thousands separator
Date: Thu,  5 Feb 2026 15:02:28 +0000
Message-ID: <20260205150230.123076-6-bruce.richardson@intel.com>
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

