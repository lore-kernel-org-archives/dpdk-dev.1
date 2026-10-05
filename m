Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10435CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 11:06:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0805D4028E;
	Mon,  5 Oct 2026 13:06:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 619514028D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 13:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791198380; x=1822734380;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+tZ5+fdyviaxM+7vM1T+ioXQX5+6uqWVmBoEFYOtw4w=;
 b=AM8qNW++yH0eoFe8UhyXc7lCzNQpgS3tVZaIqu6tqnIPyH0WT2X0ymBo
 tNqEgR2tujrELTsKyPKuf8NNCwhvXQlqW1Ym3FIEWTPgRH6cq5Q+14UW9
 8234cjC4Uv+IChZR1dlYn3Jq0gtjPfhmB6vVb9fnhkkrECrIaHABP2LvJ
 9MGLlYkJOvcRcQK+anmGqR31KC2GfkzZj+9ufw8U4YMKHJVvlxyi+2es+
 pzJ/vLmCMz//RcoUyiR5ZKcSUeN7HNs1l2YkiC8cugPXJ16VitVAx1eKH
 SA8MU/3cSpUaAikkdiZcScriHAFKd8QK7LWRkSSCGJBRmzBTrLcCfAv/Z g==;
X-CSE-ConnectionGUID: eqtdnNz9SBqNKUNQ51LFXA==
X-CSE-MsgGUID: GQtEvVCXTY61NSEBXdpKVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="117384768"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="117384768"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 04:06:19 -0700
X-CSE-ConnectionGUID: eRB62A9FTDGKimFaE2R6Ew==
X-CSE-MsgGUID: qAYU7Y3EQwOCdbsQ2uKAlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="284870791"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa005.fm.intel.com with ESMTP; 05 Oct 2026 04:06:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] net/iavf: set interrupt throttling register
Date: Mon,  5 Oct 2026 12:06:13 +0100
Message-ID: <20261005110613.473007-1-bruce.richardson@intel.com>
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

The interrupt throttling register(ITR) bank 0 value is set to 2, but
to ensure best performance across all systems also set the bank 1 value
to match.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8abe0154c..dc3cea0b95 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -899,10 +899,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 				       (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
 				       IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
 				       (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
-			/* debug - check for success! the return value
-			 * should be 2, offset is 0x2800
-			 */
-			/* IAVF_READ_REG(hw, IAVF_VFINT_ITRN1(0, 0)); */
+			IAVF_WRITE_REG(hw, IAVF_VFINT_ITRN1(1, vf->msix_base - 1), 2);
 		} else {
 			/* If no WB_ON_ITR offload flags, need to set
 			 * interrupt for descriptor write back.
-- 
2.53.0

