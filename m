Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4759DC88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:40:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E4F740269;
	Fri, 11 Sep 2026 11:40:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 572D140264;
 Fri, 11 Sep 2026 11:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789119648; x=1820655648;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=d0Diuqbef0oLXC5UhGz085aGPcVF0Y1JfqJRtPATjlc=;
 b=Bikm25MW49yHi2cxfeT+qJamAGJlg+EqHnbVL4QAWtcfGe9e2esaG+8D
 mkbUTsH15F2z7VOBtzY+x4o74l2NjkLJrTzCxhFYhBEF4VQiChENhnK14
 E5vqwXqd6G2QG8cDI8LMxH0nFCRlT+WJ/F2Tkq3VtweVwa+7gSvqYjayI
 IPKlYi72hDGOUy+7LdBx/mnziiBuh3OZ30X+70qq2q+iA7gTDrVf9ALhD
 o7uU9neHcW7AijPfuHl0bgCzCIfydZ/Hy2aZc+l5bfaHZHnseAJ4oh5Z9
 3nY4Ev/Oq9q+3d+Q0GEbFTk0qt3pdsdnByhf3bggwva6iOEtveFrmOO85 w==;
X-CSE-ConnectionGUID: MC8GlN4/RQWttw7kbA1a3A==
X-CSE-MsgGUID: 7lhCMm3EREebqvbgNz3BLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="106949016"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="106949016"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:40:46 -0700
X-CSE-ConnectionGUID: UcJzdUn5S2ynnIAxy15Fww==
X-CSE-MsgGUID: 2utJK/0jRFK82ULD+fDhQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="267593946"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa006.fm.intel.com with ESMTP; 11 Sep 2026 02:40:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/i40e: fix missing error handling for QinQ filter
Date: Fri, 11 Sep 2026 10:40:43 +0100
Message-ID: <20260911094043.1683329-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

When installing a QinQ tunnel filter, errors were not properly caught
leading to the situation where the app got a successful return code even
though the filter was not properly installed. Add an appropriate log
message and error return code on error to fix.

Fixes: 116b7910d641 ("net/i40e: add QinQ filter create function")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291ee..c91abe7626 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -8597,9 +8597,11 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
 	case I40E_TUNNEL_TYPE_QINQ:
 		if (!pf->qinq_replace_flag) {
 			ret = i40e_cloud_filter_qinq_create(pf);
-			if (ret < 0)
-				PMD_DRV_LOG(DEBUG,
-					    "QinQ tunnel filter already created.");
+			if (ret < 0) {
+				PMD_DRV_LOG(ERR, "Failed to create QinQ tunnel filter.");
+				/* ret is a raw i40e_status_code, not an errno */
+				return -ENOTSUP;
+			}
 			pf->qinq_replace_flag = 1;
 		}
 		/*	Add in the General fields the values of
-- 
2.53.0

