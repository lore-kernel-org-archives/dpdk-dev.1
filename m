Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09230E81BCC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 14:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 359C440695;
	Mon,  9 Feb 2026 15:14:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id C3F1E4066D
 for <dev@dpdk.org>; Mon,  9 Feb 2026 15:14:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770646451; x=1802182451;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NNksk5G22O3eu/Or0ow1Q51mALWWNG1C478If3NI+s4=;
 b=Wh6V/UCQe0AYrHcCsCP0l7dUuxm/ItHeNRij3dUlWtD5kxBzbLZwhyLU
 rHrYBX8j6Tgr5m2IFWwMknXRZr5LYkSsZeSFYiwqfo1mV6P9m4/EfnVqT
 fgH8gmYrfr7tr0uKk+7yShZpA2jqPmdE0H9w17AP10ddKX1nykhuOcwA7
 nVYTw7sHb9Pl3xbAIsCCxtxmNyOzLYJFXA7XF7sOIeJKrndD+6d2aFWot
 2ChlEQNqA8J9u1BiAtoeF4SrAHmaOF8nO/9AbMBkiXwMxCPcOfbSYkOwg
 syhrXnk66J7z93n2NfZa0m8wu73EkZ3JWI6oScCkpT/HqK6+Hi6fqvoqw A==;
X-CSE-ConnectionGUID: 0IJdTevlSJmb5FDhk2bZmg==
X-CSE-MsgGUID: UHR4Jtj3TqaTA8sbh7jVLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71658493"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71658493"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:14:10 -0800
X-CSE-ConnectionGUID: 8j95xpkbSoO1547BvOqW2Q==
X-CSE-MsgGUID: b8knE3PdS8SEdU2rQZ+DSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="242216023"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 09 Feb 2026 06:14:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 07/12] net/i40e: use unsigned types for queue comparisons
Date: Mon,  9 Feb 2026 14:13:43 +0000
Message-ID: <ee40150b541c3cf302151f1ffeb9ff7e7bfb69bb.1770646012.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770646012.git.anatoly.burakov@intel.com>
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
index 770c78473e..06430e6319 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -9040,7 +9040,7 @@ i40e_pf_reset_rss_reta(struct i40e_pf *pf)
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

