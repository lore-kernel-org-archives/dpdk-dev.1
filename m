Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571F7C3ABA9
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 22:10:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4962A40613;
	Fri,  2 May 2025 00:10:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 51C88402A4
 for <dev@dpdk.org>; Fri,  2 May 2025 00:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746137438; x=1777673438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rVfAgu1chYLbp3tbARKpUkTN2drGDPDQM29Rnyq1hTY=;
 b=IaZgxBjDTBNqcjIzWllNc7yfDLyH1DZIwx9vOeHW1upW1idto7yvT3Yh
 FEakKRt3uKBbz12e27oklNGPB8Ww8gvf5hdqcXKuDQ2UANh5SUlgvLq5Z
 y6DlOrOiv51GVY0cAs6l6QjZgWi3lSgXSVmRbIJJdRSqoBqbg4tlNE2dd
 +TOQIW/c9qZrG7fIfMI5AIfxeH40rVbFpVm0t98GsMNt1UXOZ4Hd4s8rH
 vUJm+hd3UDxjqRqK0AQUwmbnGWqNPNAcxhQq1Z6ldXsKjIFzfTfz/eEts
 dt1ZKGwVgQAoczm3WBtck6p+f3f8lbMhBC+5C6TGTW2Z6JJBnuUBnFNyW w==;
X-CSE-ConnectionGUID: auu/HCJBRw2KxUfqlAzNuQ==
X-CSE-MsgGUID: 4/FER277ROykKFHHa4/bBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="46930667"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="46930667"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 15:10:35 -0700
X-CSE-ConnectionGUID: E7aMowoFROyzIssKYw8tZg==
X-CSE-MsgGUID: xCYa9FN4RBiiuAqsvqL9MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="134998130"
Received: from spr-npg-bds1-eec2.sn.intel.com (HELO spr-npg-bds1-eec2..)
 ([10.233.181.123])
 by orviesa007.jf.intel.com with ESMTP; 01 May 2025 15:10:35 -0700
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 1/1] bbdev: fix possible null pointer dereference
Date: Thu,  1 May 2025 15:10:31 -0700
Message-Id: <20250501221031.4569-2-nicolas.chautru@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501221031.4569-1-nicolas.chautru@intel.com>
References: <20250501221031.4569-1-nicolas.chautru@intel.com>
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

This change addresses the CID 457446:  Null pointer dereferences
(REVERSE_INULL). Not expected to happen in practice, but the
config may be potentially undefined through API.

Coverity issue: 457446
Fixes: 61aa25b96e14 ("bbdev: add trace points")

Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
---
 lib/bbdev/rte_bbdev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index f341e6f3b9..56f313ee64 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -440,10 +440,6 @@ int
 rte_bbdev_queue_configure(uint16_t dev_id, uint16_t queue_id,
 		const struct rte_bbdev_queue_conf *conf)
 {
-
-	rte_bbdev_trace_queue_configure(dev_id, queue_id, rte_bbdev_op_type_str(conf->op_type),
-			conf->priority);
-
 	int ret = 0;
 	struct rte_bbdev_driver_info dev_info;
 	struct rte_bbdev *dev = get_dev(dev_id);
@@ -451,6 +447,11 @@ rte_bbdev_queue_configure(uint16_t dev_id, uint16_t queue_id,
 	struct rte_bbdev_queue_conf *stored_conf;
 	const char *op_type_str;
 	unsigned int max_priority;
+
+	rte_bbdev_trace_queue_configure(dev_id, queue_id,
+			conf != NULL ? rte_bbdev_op_type_str(conf->op_type) : NULL,
+			conf != NULL ? conf->priority : 0);
+
 	VALID_DEV_OR_RET_ERR(dev, dev_id);
 
 	VALID_DEV_OPS_OR_RET_ERR(dev, dev_id);
-- 
2.34.1

