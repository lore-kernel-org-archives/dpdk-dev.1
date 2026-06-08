Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9253ECD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:15:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA5F4402DD;
	Mon,  8 Jun 2026 19:15:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 4C9934029D;
 Mon,  8 Jun 2026 19:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780938940; x=1812474940;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rFSfCp8pFOk5arcIAHB+qkjgaN8qmQ7mm4gzGlq0cSU=;
 b=GGL/W7PwuH1EewtwCmE3TLXhmV0Seagi7QR0nykAZF9Tv/Xg+38RfUds
 HtxHWf5XCIcqiriXiNKDBBCvCMU1NDivUuJkIqjT/SnItpin8kYb830y+
 MRLEVVc13qGY99Ohh+bL4WgFZd4Waw0w/ctiq3ebpHhqYksHRgDuYXpon
 xUbrNHPqPGlvb/lYK8jLVf3fhDeKalS/wqrxLAaqxs7azV2IR0RuDcdGH
 6jxw3rc39DSbNMY5AF2hs7sbpLkzn9rCfKj9LNf+QpapWX1EvCKPeaBDt
 f1dCr45irQ2tDdqMTswoPLs4geVVvBeokaVEoG3lCxtcsoOkdBjdI7HGp A==;
X-CSE-ConnectionGUID: WMRO2IDrQ/WesMy5Z6TGGQ==
X-CSE-MsgGUID: hwjJVUc0RnGI7CY8OFEvqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92250858"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="92250858"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 10:15:39 -0700
X-CSE-ConnectionGUID: /0TPPzjNRL2cwla+gc16RQ==
X-CSE-MsgGUID: Bu+vvwC6QniogeBLzb82Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="249901392"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa004.jf.intel.com with ESMTP; 08 Jun 2026 10:15:37 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH] net/iavf: fix misleading AQ failure logging
Date: Mon,  8 Jun 2026 17:15:59 +0000
Message-Id: <20260608171559.355521-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

iavf_handle_virtchnl_msg() drains the admin receive queue in a loop
until iavf_clean_arq_element() reports that no descriptors are
pending. When the queue becomes empty, the base driver returns
IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57), which is the documented
terminator for the drain loop, and is not an error.

The current loop treats every non-IAVF_SUCCESS return as a failure
and logs it as follows:

"Failed to read msg from AdminQ, ret: -57"

This message floods the logs on every interrupt cycle and misleads
the triage during VF reset by chasing a real virtchnl problem
seeing these spurious -57 AQ failure lines in logs and assumes
the admin queue is broken, when in fact it has just been drained.

This patch fixes the aforesaid issue by treating
IAVF_ERR_ADMIN_QUEUE_NO_WORK in virtchnl message drain as a normal
loop exit empty-queue condition and avoid logging it as an misleading
AQ failure.

Fixes: 02d212ca3125 ("net/iavf: rename remaining avf strings")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 94ccfb5d6e..870d5c1820 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -570,7 +570,15 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 	while (pending) {
 		ret = iavf_clean_arq_element(hw, &info, &pending);
 
-		if (ret != IAVF_SUCCESS) {
+		/*
+		 * IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57) means AQ is empty
+		 * and is a normal way to terminate the drain loop.
+		 * Log error only for genuine other failure codes.
+		 * Incorrect logging like this during VF resets might
+		 * mislead into chasing a non-existent AQ failure.
+		 */
+		if (ret != IAVF_SUCCESS &&
+		    ret != IAVF_ERR_ADMIN_QUEUE_NO_WORK) {
 			PMD_DRV_LOG(INFO, "Failed to read msg from AdminQ,"
 				    "ret: %d", ret);
 			break;
-- 
2.34.1

