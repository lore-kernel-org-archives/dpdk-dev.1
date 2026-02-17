Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBC0E6817A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:15:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB9B44067C;
	Tue, 17 Feb 2026 13:14:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5CD8E40656
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:14:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330485; x=1802866485;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=qcWNwFAF1LywIeD9/nSHE34xeSlZGQiU+aDzQGh8y6c=;
 b=k8O6silSDgwRKj8grXut5UyKEC/oWpHAT6kfUVjNIaWpW+AGBlLNSOuT
 udzY1Bfp0PQjbaJaBQQqzr445vNwvIE1NgGKu+gsTqgqjDRX0a9Kdb6Fa
 a0lzlfvPYzP4kyIQcStI9A9Uf7WI2VIqKQeIP4pRFGpY/FR6xe/B9J7G6
 HAKpZyRazyPct6lr2sOCgES3qg3GnhmH9nu1omETFsi8yiZRH3QN3CgBS
 aJksdvhWtFVipa9cndPS3+BlVG+plyqggooiu9muL9nY5DBW44JPYDOcq
 O587eZrt63ljUDEpW6WJW1++JFKULEAp3x9I26FIXAb8nSn79lzOS0B8R w==;
X-CSE-ConnectionGUID: MFFsgF3KSGmq1KksFU5WpQ==
X-CSE-MsgGUID: U6Yn3rRxSZqJU+o7Ufy9Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996019"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996019"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:14:45 -0800
X-CSE-ConnectionGUID: AtSh41x4SYO4zmGl7vMMUg==
X-CSE-MsgGUID: jLTApprzRZWT+2b7gVuwNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396781"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:14:45 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 06/27] net/i40e: use unsigned types for queue comparisons
Date: Tue, 17 Feb 2026 12:13:55 +0000
Message-ID: <f91731080720fa5d4b89587b6355fe3579bfab98.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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
value. Make it unsigned 16-bit, and adjust callers to use correct types.
As a consequence, `i40e_align_floor` now returns unsigned value as well -
this is correct, because nothing about that function implies signed usage
being a valid use case.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 11 ++++++-----
 drivers/net/intel/i40e/i40e_ethdev.h |  8 ++++----
 drivers/net/intel/i40e/i40e_hash.c   |  4 ++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 2deb87b01b..608a6cff4d 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -8978,11 +8978,12 @@ i40e_dev_udp_tunnel_port_del(struct rte_eth_dev *dev,
 }
 
 /* Calculate the maximum number of contiguous PF queues that are configured */
-int
+uint16_t
 i40e_pf_calc_configured_queues_num(struct i40e_pf *pf)
 {
 	struct rte_eth_dev_data *data = pf->dev_data;
-	int i, num;
+	int i;
+	uint16_t num;
 	struct ci_rx_queue *rxq;
 
 	num = 0;
@@ -9058,7 +9059,7 @@ i40e_pf_reset_rss_reta(struct i40e_pf *pf)
 	struct i40e_hw *hw = &pf->adapter->hw;
 	uint8_t lut[RTE_ETH_RSS_RETA_SIZE_512];
 	uint32_t i;
-	int num;
+	uint16_t num;
 
 	/* If both VMDQ and RSS enabled, not all of PF queues are
 	 * configured. It's necessary to calculate the actual PF
@@ -9074,7 +9075,7 @@ i40e_pf_reset_rss_reta(struct i40e_pf *pf)
 		return 0;
 
 	for (i = 0; i < hw->func_caps.rss_table_size; i++)
-		lut[i] = (uint8_t)(i % (uint32_t)num);
+		lut[i] = (uint8_t)(i % num);
 
 	return i40e_set_rss_lut(pf->main_vsi, lut, (uint16_t)i);
 }
@@ -10771,7 +10772,7 @@ i40e_vsi_update_queue_mapping(struct i40e_vsi *vsi,
 		PMD_INIT_LOG(ERR, " number of queues is less that tcs.");
 		return I40E_ERR_INVALID_QP_ID;
 	}
-	qpnum_per_tc = RTE_MIN(i40e_align_floor(qpnum_per_tc),
+	qpnum_per_tc = RTE_MIN((uint16_t)i40e_align_floor(qpnum_per_tc),
 				I40E_MAX_Q_PER_TC);
 	bsf = rte_bsf32(qpnum_per_tc);
 
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 0de036f2d9..ca6638b32c 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -24,7 +24,7 @@
 #define I40E_AQ_LEN               32
 #define I40E_AQ_BUF_SZ            4096
 /* Number of queues per TC should be one of 1, 2, 4, 8, 16, 32, 64 */
-#define I40E_MAX_Q_PER_TC         64
+#define I40E_MAX_Q_PER_TC         UINT16_C(64)
 #define I40E_NUM_DESC_DEFAULT     512
 #define I40E_NUM_DESC_ALIGN       32
 #define I40E_BUF_SIZE_MIN         1024
@@ -1456,7 +1456,7 @@ int i40e_flush_queue_region_all_conf(struct rte_eth_dev *dev,
 void i40e_init_queue_region_conf(struct rte_eth_dev *dev);
 void i40e_flex_payload_reg_set_default(struct i40e_hw *hw);
 void i40e_pf_disable_rss(struct i40e_pf *pf);
-int i40e_pf_calc_configured_queues_num(struct i40e_pf *pf);
+uint16_t i40e_pf_calc_configured_queues_num(struct i40e_pf *pf);
 int i40e_pf_reset_rss_reta(struct i40e_pf *pf);
 int i40e_pf_reset_rss_key(struct i40e_pf *pf);
 int i40e_pf_config_rss(struct i40e_pf *pf);
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
index f20b40e7d0..5756ebf255 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -949,7 +949,7 @@ i40e_hash_parse_queues(const struct rte_eth_dev *dev,
 	struct i40e_pf *pf;
 	struct i40e_hw *hw;
 	uint16_t i;
-	int max_queue;
+	uint16_t max_queue;
 
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

