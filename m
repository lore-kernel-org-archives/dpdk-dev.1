Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4054C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 08:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9F944026D;
	Fri, 27 Jun 2025 10:30:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id A48604025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 10:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751013015; x=1782549015;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pUKZYL4kv1TdzbGYAy7UxGVdvL3xDflVBeCOxdBLrXA=;
 b=lMuR5DDpWiCqMEzYJzrwMaocccM45CFpSVejSnkocEFvL0uu9Tu3SXuh
 BDkeuJNAj2WHIr9PEwB8Y36gepTIuP+k4QnokJMWliORxSCU7ImnunX6p
 UZ0pY31FOWK6Fv+R+FA1n3AC7E5rVsOHC0LOGdNLIf8ow+Vy2kow3H3lF
 pDMT3I+GDTugZl9y/6s3aMEW5Beom/juKj6CVh9JQiPP80aomlPIqqCEb
 1hi4Yqtp3me34iB+TJCdDou9T0dPFX+cgvt4wlLFv1xfTB/eopEEKbCeF
 7gSNZa6xG/AkOg+ZDZ6T9yuypau46Mtpa71GjVPkncQDZoCqt3G4AjMG0 A==;
X-CSE-ConnectionGUID: kDX/bWuiQ3icf0VmfejBlw==
X-CSE-MsgGUID: o/6m2GXMQZ+aW7LaAzwQIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="75868124"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="75868124"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 01:30:14 -0700
X-CSE-ConnectionGUID: r67CnAmdQbaRPRyjtWydHA==
X-CSE-MsgGUID: 6sV6FU9hSEW0lJsx8fnTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="153268250"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa008.fm.intel.com with ESMTP; 27 Jun 2025 01:30:11 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v1] net/ice: update null check for TxPP support
Date: Fri, 27 Jun 2025 00:20:44 +0000
Message-ID: <20250627002044.632971-1-soumyadeep.hore@intel.com>
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

The absence of NULL checking was causing segmentation fault.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index e33fd74543..de2902bba4 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -865,7 +865,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	/* record what kind of descriptor cleanup we need on teardown */
 	txq->vector_tx = ad->tx_vec_allowed;
 
-	if (txq->tsq->ts_flag > 0) {
+	if (txq->tsq && txq->tsq->ts_flag > 0) {
 		struct ice_aqc_set_txtime_qgrp *ts_elem;
 		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
 		struct ice_txtime_ctx txtime_ctx = { 0 };
@@ -1118,7 +1118,7 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
 	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
 
-	if (txq->tsq->ts_flag > 0) {
+	if (txq->tsq && txq->tsq->ts_flag > 0) {
 		for (i = 0; i < txq->tsq->nb_ts_desc; i++) {
 			volatile struct ice_ts_desc *tsd =
 							&txq->tsq->ice_ts_ring[i];
@@ -1161,7 +1161,7 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	q_ids[0] = txq->reg_idx;
 	q_teids[0] = txq->q_teid;
 
-	if (txq->tsq->ts_flag > 0) {
+	if (txq->tsq && txq->tsq->ts_flag > 0) {
 		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
 		dev->dev_ops->timesync_disable(dev);
 		status = ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0,
@@ -3162,7 +3162,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	tx_id = txq->tx_tail;
 	txe = &sw_ring[tx_id];
 
-	if (txq->tsq->ts_flag > 0)
+	if (txq->tsq && txq->tsq->ts_flag > 0)
 		ts_id = txq->tsq->ts_tail;
 
 	/* Check if the descriptor ring needs to be cleaned. */
@@ -3353,7 +3353,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
 					 ICE_TXD_QW1_CMD_S);
 
-		if (txq->tsq->ts_flag > 0) {
+		if (txq->tsq && txq->tsq->ts_flag > 0) {
 			uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt,
 					txq->tsq->ts_offset, uint64_t *);
 			uint32_t tstamp = (uint32_t)(txtime % NS_PER_S) >>
@@ -3383,7 +3383,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	}
 end_of_tx:
 	/* update Tail register */
-	if (txq->tsq->ts_flag > 0) {
+	if (txq->tsq && txq->tsq->ts_flag > 0) {
 		ICE_PCI_REG_WRITE(txq->qtx_tail, ts_id);
 		txq->tsq->ts_tail = ts_id;
 	} else {
-- 
2.43.0

