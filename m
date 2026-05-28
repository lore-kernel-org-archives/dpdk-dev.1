Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE11CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 20:51:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FC244021F;
	Thu, 28 May 2026 22:51:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 805364003C;
 Thu, 28 May 2026 22:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780001467; x=1811537467;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8y/yclEqJfajUimQU0tjbbBg57NfMO1sJjbDEnOcYUM=;
 b=RpC5Kts3azPstrxWIIn4yss13/Xy4u5KGy6jmpJXpmZK3C7f+SWYoBrU
 h5YMHkGTAVSDWt/1h6duhyWk3diVD6GEnNHHsKnCR4SMdsPrDgdBkTPJ3
 E30fQnb8UohBWAUcmINz6Yr5ndpTnQmiigci6DKjzQGHgJRbDNraH1KNh
 AJ7ITtPAPRj8gSxpIUgWqc+4H6tKvSsGjpNFBW4XH2iQ571o0NToHl8Ni
 Ffsy1IQml8PI2XgAjhBerD/x2NIObomjRP/LWGqmbV3DArESEKe9Q/38p
 nHSgCn3Hxsg8lzEwv2akh8CqfQ5OZUn4pYhKVMD5KEtYMAeWHIVgLbhNT g==;
X-CSE-ConnectionGUID: FZYdRfRcQ5yOsX0g/EGNjQ==
X-CSE-MsgGUID: pJzez5g2QEaDVIPTCDvFgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91162144"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; d="scan'208";a="91162144"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 13:51:05 -0700
X-CSE-ConnectionGUID: sP3BtRU9Tz6W4C+dXziY6g==
X-CSE-MsgGUID: id2jIZK+QE6CnKBlYw7zKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; d="scan'208";a="242502690"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa008.jf.intel.com with ESMTP; 28 May 2026 13:51:03 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/iavf: fix vectorization high ping latency
Date: Thu, 28 May 2026 20:51:38 +0000
Message-Id: <20260528205138.286743-1-anurag.mandal@intel.com>
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

High ping latency is observed when icmp echo requests are
sent from a VPP VF and icmp echo replies get delayed by
~3 seconds which at times, also results in packet loss.

With WB_ON_ITR, the descriptor writeback interval lives in
the IAVF_VFINT_ITRN1 register. This register only resets
during a VF reset, so it could be left with a stale or
uninitialized value causing unreliable or high latency
writeback like high ping latency with VPP VF.

This patch fixes the issue by adding explicit reinitialization
of the separate ITR index interval register (IAVF_VFINT_ITRN1)
to a known 2us value and does not rely on the dynamic control
register (IAVF_VFINT_DYN_CTLN1) for the same.
Also, added a low interval value of 2us in IAVF_VFINT_DYN_CTLN1
ITR index 0 ensuring prompt writeback in polling mode
regardless of what the PF's adaptive algorithm has set in ITRN.

Fixes: ead06572bd8f ("net/iavf: fix performance with writeback policy")
Fixes: a08f9cb698c3 ("net/iavf: fix Rx queue interrupt setting")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index bdf650b822..971c10cefe 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -862,6 +862,16 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 				       (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
 				       IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
 				       (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
+			/* The interval value lives in the separate IAVF_VFINT_ITRN1
+			 * index register, which is only cleared on a VF reset
+			 * It is not implicitly re-initialized by the DYN_CTLN1 write
+			 * above, so if it was left dirty by a previous configuration,
+			 * program it explicitly here to the same 2us interval for
+			 * ITR index 0.
+			 */
+			IAVF_WRITE_REG(hw,
+				       IAVF_VFINT_ITRN1(0, vf->msix_base - 1),
+				       2UL);
 			/* debug - check for success! the return value
 			 * should be 2, offset is 0x2800
 			 */
@@ -2078,9 +2088,16 @@ iavf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 		return -EIO;
 	}
 
+	/* Set the ITR for index zero, to 2us to make sure that
+	 * sufficient time for aggregation to occur, but not to
+	 * increase the latency drastically.
+	 */
+
 	IAVF_WRITE_REG(hw,
 		      IAVF_VFINT_DYN_CTLN1(msix_intr - IAVF_RX_VEC_START),
-		      IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK);
+		      (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
+		      IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
+		      (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
 
 	IAVF_WRITE_FLUSH(hw);
 	return 0;
-- 
2.25.1

