Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4478C79FAF
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 17:56:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E58F4066D;
	Mon,  5 Jan 2026 18:56:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6BDD34064E
 for <dev@dpdk.org>; Mon,  5 Jan 2026 18:56:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767635779; x=1799171779;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fMc+Kj3gW601WNVyY+UKMkWLI9IMCWoFAdOBnHKoMlg=;
 b=PYO3kMCprfOOT891g6K67zB2OfBjrcKwCNUwMJkZENKscU18lQT7Pw/p
 +UVu4c6xNY0LT6yVuOHLMsp2j2hj4Ij3aF2A59zMiI8L4v2PolMes3VEx
 YAmqfZiE2Qv62Rf9+IviMcwP4JBIbMvzhjgCj+TupcGiY5HEKOi554HSS
 RPeDCmPfXk1GwNtgAv1rJiIaz67owyoPmowxLp8dyRgIOeWBe0VM80xXj
 H8lONXkV0QSdVJ+tDaHUsKlyyXJuyOzHEOlWjRQr2XSOdykLey92DOX9z
 6QSL3d2Lc4Rq6ZGRJlsQ71SjsabETID0ohZc9THifwtcuIpoWjZ56oH2N Q==;
X-CSE-ConnectionGUID: mPLPKZxaSvCgRx+SnNdkfA==
X-CSE-MsgGUID: HQYRjp8JTLCor/w0VsaUHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79308862"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="79308862"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 09:56:19 -0800
X-CSE-ConnectionGUID: qMw+jt26Rjirv9uFY95I5A==
X-CSE-MsgGUID: 8OnKdBzySUOn6rSLzvU/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="239928755"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 05 Jan 2026 09:56:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 5/7] usertools/telemetry-watcher: add thousands separator
Date: Mon,  5 Jan 2026 17:56:03 +0000
Message-ID: <20260105175605.52689-6-bruce.richardson@intel.com>
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

