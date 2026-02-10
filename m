Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352F3EA8130
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E6F140B97;
	Tue, 10 Feb 2026 17:14:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 90A7D400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740052; x=1802276052;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pRed54M/EIGiMR7HelzJHjh5nNPmH2PNcRV790rq/7Y=;
 b=Q2zvsatUnOqmTLrWf2nWsJPAW9dy6jYSZOsQOm3dwGN1Hi+S40tVCfum
 8P+aHBo/b8/9CGlMH0nCLxcUIjMs5xvn1RPXK93VANw3QjN8jxlq/+kEU
 8TNJBjPnX7pG1GIB0y0Vwm6Ixi87WWvW7qKA/HpNi0MI4PFGqeltfS/39
 zrKBgmNNDx5fi+7y5y5lktnZrlK9NfC5jBQNAB6hVsfdmwDaVOix/50pI
 KPJccfvRJYbr+J+3lEJsCBupmfbp1e6QHhpJIHkEGZ/+ATy7mYwGRE8xo
 MXqFE8k0Rq9niFXADxzy1DSY45zSeIAbw7KUtbnFY1y5GHbxKaK69thzF Q==;
X-CSE-ConnectionGUID: RWj+joZlTjWRyd3PBAN6DQ==
X-CSE-MsgGUID: PTGVxJ9TRuemhvGZFFWt5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286188"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:11 -0800
X-CSE-ConnectionGUID: jFTHiJ5vQuijshSwtA86XQ==
X-CSE-MsgGUID: +QHqPYG8RMy23ZSHPBxDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127736"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 06/26] net/i40e: use unsigned types for queue comparisons
Date: Tue, 10 Feb 2026 16:13:35 +0000
Message-ID: <8bf18b1284a0ebd7d8df07878f6fe4a016ce7e87.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
References: 
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

Currently, when we compare queue numbers against maximum traffic class
value of 64, we do not use unsigned values, which results in compiler
warning when attempting to compare `I40E_MAX_Q_PER_TC` to an unsigned
value. Make it unsigned, and adjust callers to use correct types. As a
consequence, `i40e_align_floor` now returns unsigned value as well - this
is correct, because nothing about that function implies signed usage being
a valid use case.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 2 +-
 drivers/net/intel/i40e/i40e_ethdev.h | 6 +++---
 drivers/net/intel/i40e/i40e_hash.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 2deb87b01b..d5c61cd577 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -9058,7 +9058,7 @@ i40e_pf_reset_rss_reta(struct i40e_pf *pf)
 	struct i40e_hw *hw = &pf->adapter->hw;
 	uint8_t lut[RTE_ETH_RSS_RETA_SIZE_512];
 	uint32_t i;
-	int num;
+	size_t num;
 
 	/* If both VMDQ and RSS enabled, not all of PF queues are
 	 * configured. It's necessary to calculate the actual PF
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 0de036f2d9..d144297360 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -24,7 +24,7 @@
 #define I40E_AQ_LEN               32
 #define I40E_AQ_BUF_SZ            4096
 /* Number of queues per TC should be one of 1, 2, 4, 8, 16, 32, 64 */
-#define I40E_MAX_Q_PER_TC         64
+#define I40E_MAX_Q_PER_TC         64U
 #define I40E_NUM_DESC_DEFAULT     512
 #define I40E_NUM_DESC_ALIGN       32
 #define I40E_BUF_SIZE_MIN         1024
@@ -1517,8 +1517,8 @@ i40e_init_adminq_parameter(struct i40e_hw *hw)
 	hw->aq.asq_buf_size = I40E_AQ_BUF_SZ;
 }
 
-static inline int
-i40e_align_floor(int n)
+static inline uint32_t
+i40e_align_floor(uint32_t n)
 {
 	if (n == 0)
 		return 0;
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index f20b40e7d0..cbb377295d 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -949,7 +949,7 @@ i40e_hash_parse_queues(const struct rte_eth_dev *dev,
 	struct i40e_pf *pf;
 	struct i40e_hw *hw;
 	uint16_t i;
-	int max_queue;
+	size_t max_queue;
 
 	hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	if (!rss_act->queue_num ||
@@ -971,7 +971,7 @@ i40e_hash_parse_queues(const struct rte_eth_dev *dev,
 	max_queue = RTE_MIN(max_queue, I40E_MAX_Q_PER_TC);
 
 	for (i = 0; i < rss_act->queue_num; i++) {
-		if ((int)rss_act->queue[i] >= max_queue)
+		if (rss_act->queue[i] >= max_queue)
 			break;
 	}
 
-- 
2.47.3

