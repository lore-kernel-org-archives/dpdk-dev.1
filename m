Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46981C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 16:59:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 654F140EE1;
	Thu, 15 May 2025 18:59:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 210CC40A79;
 Thu, 15 May 2025 18:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747328347; x=1778864347;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fc8Z5RD1BDdK5yBMYCCL7GyOmDWKs9KN1nTm9ihTwUg=;
 b=ktH4Gnk9uLGI7QoC559mA16U9/J/UDB4+8Gw6qftXkvFDsWHi5U2dJ8V
 6agKSohHc3Fm6v8Atu6snKaGP5Nphdk3j+BBRbimk/QzgDk1WjGirwzTH
 ByLIM5oi0hb0Y497CklpqBWvoz2vizRfyLe4rDWM701vt/OLvlW9XWEMB
 +RIiKFK5dL+L1kHWYkpHnk1jYGp/RGpoZVU9De2dzN87d4J9x+bCOAE2t
 aaNi3PlEOBwkPWXjXe44exbFguvUtEjnj5KMwNDue7dp516HDSXyVYFsX
 O490SM6IyzwfMF+wAltddD9cpH0FtE5hdV6zvCRzcS70UwvDa2yUbQ+ft w==;
X-CSE-ConnectionGUID: ifgXeN/7Rguq/XsZ8wG9TQ==
X-CSE-MsgGUID: Q8OSBD6XS8GO898B7kns0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="52952963"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="52952963"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 09:59:04 -0700
X-CSE-ConnectionGUID: cPEwQSmmTO6ZTJWxqmOIRg==
X-CSE-MsgGUID: /BSSOdajTfqmXbKdLA+XpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="138156489"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by orviesa009.jf.intel.com with ESMTP; 15 May 2025 09:59:02 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Tadhg Kearney <tadhg.kearney@intel.com>
Subject: [PATCH 1/2] power/intel_uncore: fix crash closing uninitialized driver
Date: Thu, 15 May 2025 17:58:53 +0100
Message-ID: <20250515165854.1087247-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

When the power_intel_uncore_autotest unit test is run as an unprivileged
user which cannot init the power library, it crashes the unit test
binary due to calling "rte_power_uncore_exit" after the first test case
(initialization) fails. This crash is due to trying to write to NULL
file handles.

Fix the crash by checking each file handle is non-null before writing to
it and closing it.

Fixes: 60b8a661a957 ("power: add Intel uncore frequency control")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/power/intel_uncore/intel_uncore.c | 35 ++++++++++++-----------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/power/intel_uncore/intel_uncore.c b/drivers/power/intel_uncore/intel_uncore.c
index 804ad5d755..6759ea1445 100644
--- a/drivers/power/intel_uncore/intel_uncore.c
+++ b/drivers/power/intel_uncore/intel_uncore.c
@@ -307,27 +307,28 @@ power_intel_uncore_exit(unsigned int pkg, unsigned int die)
 
 	ui = &uncore_info[pkg][die];
 
-	if (fprintf(ui->f_cur_min, "%u", ui->org_min_freq) < 0) {
-		POWER_LOG(ERR, "Fail to write original uncore frequency for "
-				"pkg %02u die %02u", ui->pkg, ui->die);
-		return -1;
+	if (ui->f_cur_min != NULL) {
+		if (fprintf(ui->f_cur_min, "%u", ui->org_min_freq) < 0) {
+			POWER_LOG(ERR, "Fail to write original uncore frequency for pkg %02u die %02u",
+					 ui->pkg, ui->die);
+			return -1;
+		}
+		fflush(ui->f_cur_min);
+		fclose(ui->f_cur_min);
+		ui->f_cur_min = NULL;
 	}
 
-	if (fprintf(ui->f_cur_max, "%u", ui->org_max_freq) < 0) {
-		POWER_LOG(ERR, "Fail to write original uncore frequency for "
-				"pkg %02u die %02u", ui->pkg, ui->die);
-		return -1;
+	if (ui->f_cur_max != NULL) {
+		if (fprintf(ui->f_cur_max, "%u", ui->org_max_freq) < 0) {
+			POWER_LOG(ERR, "Fail to write original uncore frequency for pkg %02u die %02u",
+					 ui->pkg, ui->die);
+			return -1;
+		}
+		fflush(ui->f_cur_max);
+		fclose(ui->f_cur_max);
+		ui->f_cur_max = NULL;
 	}
 
-	fflush(ui->f_cur_min);
-	fflush(ui->f_cur_max);
-
-	/* Close FD of setting freq */
-	fclose(ui->f_cur_min);
-	fclose(ui->f_cur_max);
-	ui->f_cur_min = NULL;
-	ui->f_cur_max = NULL;
-
 	return 0;
 }
 
-- 
2.48.1

