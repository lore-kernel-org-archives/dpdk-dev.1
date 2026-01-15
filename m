Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C79D46613
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 19:04:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63FC442D35;
	Thu, 15 Jan 2026 20:03:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9E285427BE
 for <dev@dpdk.org>; Thu, 15 Jan 2026 20:03:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768503821; x=1800039821;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dUIuQaRt23CTb3FXhYnqvdnRlX3KZHiDg2xuWSAvR8E=;
 b=Xc0SGJ07asHTi2uAG6mkfCYvpb8RPZiWgqk3EAtfTgHIB1NSRnqb9WwX
 PTEWfI2AbUm0UpDKRj4fSC0QXgP4/DSTaHG0JhRH//cCvKyHkLm6yxTnE
 N8vf+lpoZwvGcd0MmyoNjNksfvnasbeiMl26FBvd2RWMmXy3Jb2wgHvz1
 4Jncs/4T5X8guVFT65N19e4+JkDHAgzjoqTzmpDjA7nyjuXssvBNGpk6g
 xU7eXaFSwKlf8xtdxqKtPV9wqqKmLvhvs8fscxzqiibG6yeJIvm2fTC73
 GckV06QbRvLnIQFObEYu23YCu3CJCPDDeDy7f3+6xHDZDcuoaEfWusylX A==;
X-CSE-ConnectionGUID: qk9g5ND8RSO52+bncILdSQ==
X-CSE-MsgGUID: f7DluND5TBKmi26GZrN/Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="80461402"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; d="scan'208";a="80461402"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 11:03:40 -0800
X-CSE-ConnectionGUID: a60iGL7NSPCvZhlAcmS+Yw==
X-CSE-MsgGUID: E+3K3U8oTCuwkY3XVFn8uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; d="scan'208";a="205307688"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 15 Jan 2026 11:03:39 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 5/7] usertools/telemetry-watcher: add thousands separator
Date: Thu, 15 Jan 2026 19:03:29 +0000
Message-ID: <20260115190331.3721281-6-bruce.richardson@intel.com>
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

