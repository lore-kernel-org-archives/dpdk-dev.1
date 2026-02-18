Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66747E9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 09:50:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 125D64064E;
	Wed, 18 Feb 2026 10:50:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2271E40647
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:50:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771408210; x=1802944210;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iLS+7M48h/C77lPdEj8BV9xGyqlbNy1h9wj7Ek4hoEU=;
 b=DFLFTrWC8J8M/JzUwbb4nlXYqqis6Q+VRyZ+bUMTdilQbY+YGTsJJwJg
 ARYuZ2dbAgtzyxwfqeu/lV97ivE8aF2XCM44Z18uQ+HR+40dc0885mV5a
 Op8Uvxbro7+PYcvcFOYZmJqXW8OUC+DZt9eITBn74vVL9hW+9aWC+60Pa
 n26ZwcnrZZtPxpRTiBc89p0CM7ScX6lRyOGSbApM9do94F3GFuAQpnth7
 DT3Sp3jVtpawVv6Ys4rzLW+k72F0YcdgDsEGrrdsyGJMZx3+ohLqfhKGN
 V5Tqiv82BQr5p91EYywbLqljSoYakfhFTe4WWwu/spXW11Jr484LGGAnY Q==;
X-CSE-ConnectionGUID: EwXeZ63kRX+bf+kj0vDmdQ==
X-CSE-MsgGUID: 3DObhvLxSw6WnzNFhD2kaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83929848"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="83929848"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 01:50:10 -0800
X-CSE-ConnectionGUID: cGyeX6aKQD2vEfpst34x3A==
X-CSE-MsgGUID: aCEfFneUTduWdeAcLcDHbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214257123"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 18 Feb 2026 01:50:09 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 07/10] net/iavf: permit secondary process Tx path selection
Date: Wed, 18 Feb 2026 09:49:34 +0000
Message-ID: <20260218094937.1652391-8-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218094937.1652391-1-ciara.loftus@intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
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

Commit ebcfb039afa8 ("net/iavf: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

This commit also introduces logic to the secondary process probe
sequence that ensures that if a dynamic mbuf field was registered in the
primary process for LLDP, that the offset is visible in the secondary
process. This also ensures that a correct Tx path with context
descriptor support will be selected by the secondary process.

Fixes: ebcfb039afa8 ("net/iavf: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 5 +++++
 drivers/net/intel/iavf/iavf_rxtx.c   | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 802e095174..954bce723d 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2804,6 +2804,11 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	 */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		iavf_set_rx_function(eth_dev);
+		/* LLDP may have been enabled by the primary process. Store the offset before
+		 * setting the TX function because it may be used in the selection function.
+		 */
+		rte_pmd_iavf_tx_lldp_dynfield_offset =
+			rte_mbuf_dynfield_lookup(IAVF_TX_LLDP_DYNFIELD, NULL);
 		iavf_set_tx_function(eth_dev);
 		return 0;
 	}
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index a47d2547dd..0d19efb94d 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3877,8 +3877,8 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

