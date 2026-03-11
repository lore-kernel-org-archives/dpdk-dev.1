Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390D9FD88DA
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 09:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A6DB40A76;
	Wed, 11 Mar 2026 10:02:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id F2D5B4067C;
 Wed, 11 Mar 2026 10:02:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773219723; x=1804755723;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8RsrBlhp4o2Ac8UimW09WwaYUW2Cf2YJTYfqtt3ElqA=;
 b=YN74KWP7gpoYtdvCLV9PLmM8jKeeaPlsl4AWgevoMs3q7Kx03gRs7urM
 vaf37UtHA074ObLfG6Lx6UegbAsOr3Wxx2krPYaI3zJxU0Lo1vIENq0c+
 IvHl2L+B29NND1z1B6wfsDV9FxczTN6A3Ba8N98qu/5P3eb2Fy6cFURXc
 Cc6kv/U0qRPDOlXfObbH2+RS9mF+cM1Vbdd3pjx6sFm3LS6q+4kY+lqIM
 VJ0rzkEteL/6/hGvQe+Yy6tCcrkX0jOImu680ZQL/ShmPpjwrLTo54AvC
 IlXVhH+EibY32zxXrXJbjL3STc3OpuCp66hUxz6pRwdaoi56b2sCcithJ w==;
X-CSE-ConnectionGUID: xhyyzlLWQESdmCISrCvv4A==
X-CSE-MsgGUID: kF7AeYuWQx+YyWhi08BMrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74401085"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74401085"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 02:02:01 -0700
X-CSE-ConnectionGUID: 7fjQHvzoQ1qMG9T8Ryv4ww==
X-CSE-MsgGUID: P6/A3yjGT4icp3ZxUeug6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="220434242"
Received: from unknown (HELO srv13..) ([10.190.213.143])
 by orviesa008.jf.intel.com with ESMTP; 11 Mar 2026 02:01:57 -0700
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: shaiq.wani@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, stable@dpdk.org
Subject: [PATCH] app/testpmd: fix DCB forwarding TC mask and queue guard
Date: Wed, 11 Mar 2026 08:37:51 +0000
Message-ID: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
X-Mailer: git-send-email 2.43.0
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

Update forwarding TC mask based on configured traffic classes to properly
handle both 4 TC and 8 TC modes. The bitmask calculation (1u << nb_tcs) - 1
correctly creates masks for all available traffic classes (0xF for 4 TCs,
0xFF for 8 TCs).

When the mask is not updated after a TC configuration change, it stays at
the default 0xFF, which causes dcb_fwd_tc_update_dcb_info() to skip the
compress logic entirely (early return when mask ==
DEFAULT_DCB_FWD_TC_MASK).
This can lead to inconsistent queue allocations.

Additionally, the existing VMDQ pool guard in dcb_fwd_config_setup() only
checks RX queue counts, missing the case where the TX port has zero queues
for a given pool/TC combination. When nb_tx_queue is 0, the expression
"j % nb_tx_queue" triggers a SIGFPE (integer division by zero).

Fix this by:
1. Updating dcb_fwd_tc_mask after port DCB reconfiguration, and returning
   on failure so fwd_config_setup() is not called with a stale mask.
2. Extending the existing pool guard to also check TX queue counts.
3. Adding a defensive break after the division by dcb_fwd_tc_cores to
   catch integer truncation to zero.

Fixes: 0ecbf93f5001 ("app/testpmd: add command to disable DCB")
Cc: stable@dpdk.org

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 app/test-pmd/cmdline.c | 13 +++++++++++++
 app/test-pmd/config.c  |  9 ++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c33c66f327..3fb9b940eb 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3682,6 +3682,19 @@ cmd_config_dcb_parsed(void *parsed_result,
 		return;
 	}
 
+	/*
+	 * Update forwarding TC mask to match actual configured TCs.
+	 * Must query after init_port_dcb_config() to get updated nb_tcs.
+	 */
+	ret = rte_eth_dev_get_dcb_info(port_id, &dcb_info);
+	if (ret == 0 && dcb_info.nb_tcs > 0) {
+		dcb_fwd_tc_mask = (1u << dcb_info.nb_tcs) - 1;
+	} else if (ret != 0) {
+		fprintf(stderr, "Failed to get DCB info for port %u: %s\n",
+				port_id, rte_strerror(-ret));
+		return;
+	}
+
 	fwd_config_setup();
 
 	cmd_reconfig_device_queue(port_id, 1, 1);
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index f9f3c542a6..9b201ac241 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -5450,7 +5450,8 @@ dcb_fwd_config_setup(void)
 			/* if the nb_queue is zero, means this tc is
 			 * not enabled on the POOL
 			 */
-			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0)
+			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0 ||
+			    txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue == 0)
 				break;
 			k = fwd_lcores[lc_id]->stream_nb +
 				fwd_lcores[lc_id]->stream_idx;
@@ -5458,6 +5459,12 @@ dcb_fwd_config_setup(void)
 						dcb_fwd_tc_cores;
 			nb_tx_queue = txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue /
 						dcb_fwd_tc_cores;
+			/* guard against integer truncation to zero (e.g.
+			 * nb_queue=1, dcb_fwd_tc_cores=2) to prevent SIGFPE
+			 * from "j % nb_tx_queue" below.
+			 */
+			if (nb_rx_queue == 0 || nb_tx_queue == 0)
+				break;
 			rxq = rxp_dcb_info.tc_queue.tc_rxq[i][tc].base + nb_rx_queue * sub_core_idx;
 			txq = txp_dcb_info.tc_queue.tc_txq[i][tc].base + nb_tx_queue * sub_core_idx;
 			for (j = 0; j < nb_rx_queue; j++) {
-- 
2.43.0

