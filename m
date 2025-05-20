Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C9C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 01:51:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7599B402CA;
	Tue, 20 May 2025 03:51:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5AB5A402AE;
 Tue, 20 May 2025 03:51:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747705880; x=1779241880;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2MCqeiCm9Q2mytMV8rSDVAWZWg6A3JqtDWWUqqBNH3w=;
 b=nvYYp53XkULgAIf2S87cdNaAgep5G8cKbeUvPwMEwRuC/o5MamV1I9Ho
 JaLrvCiQct9gvqNvhkvudD+qrRbwqNkCR7H40Fd3famtUkazuP3lKB2uJ
 1dPb1Ykx5vfjvdl142OcMiL/uNGgj8VlvxRgTEgE3nC0FkY1RDwJyOzsx
 PDKtS9h0JMZGmck6JrOuDQQr42lZeoeGrhNrXNSvY40qoRaFJtc1cmHpJ
 phv8HbHT58pcDspge69ANX0opjTilWjyUoSlMwoynxiTU9hdNGLSVVOKd
 jQroNlrsyQVxDWAaU9oQGvikntWNTp7MvySkS36w5nCArqvc2Zqx6UYrU Q==;
X-CSE-ConnectionGUID: r7aGP9BlS7aSD55/jFm08w==
X-CSE-MsgGUID: X4AhksTCT322vx3VXjnOhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="52254972"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="52254972"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2025 18:51:18 -0700
X-CSE-ConnectionGUID: /7fO593XTced+LKF2aDSxQ==
X-CSE-MsgGUID: 29oZ4XaVSIGWEkt/6fq/Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="139444154"
Received: from shwdenpg561.ccr.corp.intel.com (HELO dpdk..) ([10.239.252.3])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2025 18:51:15 -0700
From: Kaiwen Deng <kaiwenx.deng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Kaiwen Deng <kaiwenx.deng@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH v1] net/intel: fix ixgbe get macsec stats
Date: Tue, 20 May 2025 08:54:45 +0800
Message-Id: <20250520005445.555573-1-kaiwenx.deng@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The ixgbe macsec registers are not cleared on read. Reading the
registers and then accumulating the values will cause macsec stats
errors. Each time the data is queried via the testpmd command
“show port stats xstats all”, the macsec statistics are increased.

This commit will add macsec offset stats to record initial data
and update macsec stats based on offset stats.

Fixes: b35d309710fe ("net/ixgbe: add MACsec offload")
Cc: stable@dpdk.org

Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 187 ++++++++++++++++++++-----
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |   2 +
 2 files changed, 151 insertions(+), 38 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 0fa4898aba..84f0458630 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -95,6 +95,10 @@
 #define IXGBE_4_BIT_MASK   RTE_LEN2MASK(IXGBE_4_BIT_WIDTH, uint8_t)
 #define IXGBE_8_BIT_WIDTH  CHAR_BIT
 #define IXGBE_8_BIT_MASK   UINT8_MAX
+#define IXGBE_16_BIT_WIDTH (CHAR_BIT * 2)
+#define IXGBE_16_BIT_MASK  UINT16_MAX
+#define IXGBE_32_BIT_WIDTH (CHAR_BIT * 4)
+#define IXGBE_32_BIT_MASK  UINT32_MAX
 
 #define IXGBEVF_PMD_NAME "rte_ixgbevf_pmd" /* PMD name */
 
@@ -197,7 +201,8 @@ static const uint32_t *ixgbe_dev_supported_ptypes_get(struct rte_eth_dev *dev,
 static int ixgbevf_dev_info_get(struct rte_eth_dev *dev,
 				struct rte_eth_dev_info *dev_info);
 static int ixgbe_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
-
+static void ixgbe_stat_update_32(struct ixgbe_hw *hw, uint32_t reg,
+		bool offset_loaded, uint64_t *offset, uint64_t *stat);
 static int ixgbe_vlan_filter_set(struct rte_eth_dev *dev,
 		uint16_t vlan_id, int on);
 static int ixgbe_vlan_tpid_set(struct rte_eth_dev *dev,
@@ -3171,12 +3176,14 @@ ixgbe_dev_reset(struct rte_eth_dev *dev)
 }
 
 static void
-ixgbe_read_stats_registers(struct ixgbe_hw *hw,
-			   struct ixgbe_hw_stats *hw_stats,
-			   struct ixgbe_macsec_stats *macsec_stats,
+ixgbe_read_stats_registers(struct ixgbe_adapter *adapter,
+			struct ixgbe_hw *hw,
 			   uint64_t *total_missed_rx, uint64_t *total_qbrc,
 			   uint64_t *total_qprc, uint64_t *total_qprdc)
 {
+	struct ixgbe_hw_stats *hw_stats = &adapter->stats;
+	struct ixgbe_macsec_stats *macsec_stats = &adapter->macsec_stats;
+	struct ixgbe_macsec_stats *macsec_stats_offset = &adapter->macsec_stats_offset;
 	uint32_t bprc, lxon, lxoff, total;
 	uint32_t delta_gprc = 0;
 	unsigned i;
@@ -3186,7 +3193,6 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
 	 */
 	int crc_strip = (IXGBE_READ_REG(hw, IXGBE_HLREG0) &
 			IXGBE_HLREG0_RXCRCSTRP);
-
 	hw_stats->crcerrs += IXGBE_READ_REG(hw, IXGBE_CRCERRS);
 	hw_stats->illerrc += IXGBE_READ_REG(hw, IXGBE_ILLERRC);
 	hw_stats->errbc += IXGBE_READ_REG(hw, IXGBE_ERRBC);
@@ -3354,38 +3360,120 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
 					IXGBE_FDIRFSTAT) >> 16) & 0xFFFF;
 	}
 	/* MACsec Stats registers */
-	macsec_stats->out_pkts_untagged += IXGBE_READ_REG(hw, IXGBE_LSECTXUT);
-	macsec_stats->out_pkts_encrypted +=
-		IXGBE_READ_REG(hw, IXGBE_LSECTXPKTE);
-	macsec_stats->out_pkts_protected +=
-		IXGBE_READ_REG(hw, IXGBE_LSECTXPKTP);
-	macsec_stats->out_octets_encrypted +=
-		IXGBE_READ_REG(hw, IXGBE_LSECTXOCTE);
-	macsec_stats->out_octets_protected +=
-		IXGBE_READ_REG(hw, IXGBE_LSECTXOCTP);
-	macsec_stats->in_pkts_untagged += IXGBE_READ_REG(hw, IXGBE_LSECRXUT);
-	macsec_stats->in_pkts_badtag += IXGBE_READ_REG(hw, IXGBE_LSECRXBAD);
-	macsec_stats->in_pkts_nosci += IXGBE_READ_REG(hw, IXGBE_LSECRXNOSCI);
-	macsec_stats->in_pkts_unknownsci +=
-		IXGBE_READ_REG(hw, IXGBE_LSECRXUNSCI);
-	macsec_stats->in_octets_decrypted +=
-		IXGBE_READ_REG(hw, IXGBE_LSECRXOCTD);
-	macsec_stats->in_octets_validated +=
-		IXGBE_READ_REG(hw, IXGBE_LSECRXOCTV);
-	macsec_stats->in_pkts_unchecked += IXGBE_READ_REG(hw, IXGBE_LSECRXUNCH);
-	macsec_stats->in_pkts_delayed += IXGBE_READ_REG(hw, IXGBE_LSECRXDELAY);
-	macsec_stats->in_pkts_late += IXGBE_READ_REG(hw, IXGBE_LSECRXLATE);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECTXUT,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->out_pkts_untagged,
+				  &macsec_stats->out_pkts_untagged);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECTXPKTE,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->out_pkts_encrypted,
+				  &macsec_stats->out_pkts_encrypted);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECTXPKTP,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->out_pkts_protected,
+				  &macsec_stats->out_pkts_protected);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECTXOCTE,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->out_octets_encrypted,
+				  &macsec_stats->out_octets_encrypted);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECTXOCTP,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->out_octets_protected,
+				  &macsec_stats->out_octets_protected);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXUT,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_pkts_untagged,
+				  &macsec_stats->in_pkts_untagged);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXBAD,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_pkts_badtag,
+				  &macsec_stats->in_pkts_badtag);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXNOSCI,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_pkts_nosci,
+				  &macsec_stats->in_pkts_nosci);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXUNSCI,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_pkts_unknownsci,
+				  &macsec_stats->in_pkts_unknownsci);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXOCTD,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_octets_decrypted,
+				  &macsec_stats->in_octets_decrypted);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXOCTV,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_octets_validated,
+				  &macsec_stats->in_octets_validated);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXUNCH,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_pkts_unchecked,
+				  &macsec_stats->in_pkts_unchecked);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXDELAY,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_pkts_delayed,
+				  &macsec_stats->in_pkts_delayed);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXLATE,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_pkts_late,
+				  &macsec_stats->in_pkts_late);
+	u64 in_pkts_ok = 0, in_pkts_invalid = 0, in_pkts_notvalid = 0;
 	for (i = 0; i < 2; i++) {
-		macsec_stats->in_pkts_ok +=
+		in_pkts_ok +=
 			IXGBE_READ_REG(hw, IXGBE_LSECRXOK(i));
-		macsec_stats->in_pkts_invalid +=
+		in_pkts_invalid +=
 			IXGBE_READ_REG(hw, IXGBE_LSECRXINV(i));
-		macsec_stats->in_pkts_notvalid +=
+		in_pkts_notvalid +=
 			IXGBE_READ_REG(hw, IXGBE_LSECRXNV(i));
 	}
-	macsec_stats->in_pkts_unusedsa += IXGBE_READ_REG(hw, IXGBE_LSECRXUNSA);
-	macsec_stats->in_pkts_notusingsa +=
-		IXGBE_READ_REG(hw, IXGBE_LSECRXNUSA);
+	if (!adapter->offset_loaded) {
+		macsec_stats_offset->in_pkts_ok = in_pkts_ok;
+		macsec_stats_offset->in_pkts_invalid = in_pkts_invalid;
+		macsec_stats_offset->in_pkts_notvalid = in_pkts_notvalid;
+	}
+	if (macsec_stats_offset->in_pkts_ok <= in_pkts_ok)
+		macsec_stats->in_pkts_ok = (uint64_t)(in_pkts_ok -
+			macsec_stats_offset->in_pkts_ok);
+	else
+		macsec_stats->in_pkts_ok = (uint64_t)((in_pkts_ok +
+			RTE_BIT64(IXGBE_32_BIT_WIDTH)) - macsec_stats_offset->in_pkts_ok);
+	if (macsec_stats_offset->in_pkts_invalid <= in_pkts_invalid)
+		macsec_stats->in_pkts_invalid = (uint64_t)(in_pkts_invalid -
+			macsec_stats_offset->in_pkts_invalid);
+	else
+		macsec_stats->in_pkts_invalid = (uint64_t)((in_pkts_invalid +
+			RTE_BIT64(IXGBE_32_BIT_WIDTH)) - macsec_stats_offset->in_pkts_invalid);
+	if (macsec_stats_offset->in_pkts_notvalid <= in_pkts_notvalid)
+		macsec_stats->in_pkts_notvalid = (uint64_t)(in_pkts_notvalid -
+			macsec_stats_offset->in_pkts_notvalid);
+	else
+		macsec_stats->in_pkts_notvalid = (uint64_t)((in_pkts_notvalid +
+			RTE_BIT64(IXGBE_32_BIT_WIDTH)) - macsec_stats_offset->in_pkts_notvalid);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXUNSA,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_pkts_unusedsa,
+				  &macsec_stats->in_pkts_unusedsa);
+	ixgbe_stat_update_32(hw,
+				  IXGBE_LSECRXNUSA,
+				  adapter->offset_loaded,
+				  &macsec_stats_offset->in_pkts_notusingsa,
+				  &macsec_stats->in_pkts_notusingsa);
+
+	adapter->offset_loaded = true;
 }
 
 /*
@@ -3394,13 +3482,12 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
 static int
 ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 {
+	struct ixgbe_adapter *adapter =
+			(struct ixgbe_adapter *)(dev->data->dev_private);
 	struct ixgbe_hw *hw =
 			IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ixgbe_hw_stats *hw_stats =
 			IXGBE_DEV_PRIVATE_TO_STATS(dev->data->dev_private);
-	struct ixgbe_macsec_stats *macsec_stats =
-			IXGBE_DEV_PRIVATE_TO_MACSEC_STATS(
-				dev->data->dev_private);
 	uint64_t total_missed_rx, total_qbrc, total_qprc, total_qprdc;
 	unsigned i;
 
@@ -3409,7 +3496,7 @@ ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	total_qprc = 0;
 	total_qprdc = 0;
 
-	ixgbe_read_stats_registers(hw, hw_stats, macsec_stats, &total_missed_rx,
+	ixgbe_read_stats_registers(adapter, hw, &total_missed_rx,
 			&total_qbrc, &total_qprc, &total_qprdc);
 
 	if (stats == NULL)
@@ -3633,6 +3720,8 @@ static int
 ixgbe_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 					 unsigned n)
 {
+	struct ixgbe_adapter *adapter =
+			(struct ixgbe_adapter *)(dev->data->dev_private);
 	struct ixgbe_hw *hw =
 			IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ixgbe_hw_stats *hw_stats =
@@ -3653,7 +3742,7 @@ ixgbe_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 	total_qprc = 0;
 	total_qprdc = 0;
 
-	ixgbe_read_stats_registers(hw, hw_stats, macsec_stats, &total_missed_rx,
+	ixgbe_read_stats_registers(adapter, hw, &total_missed_rx,
 			&total_qbrc, &total_qprc, &total_qprdc);
 
 	/* If this is a reset xstats is NULL, and we have cleared the
@@ -3708,6 +3797,8 @@ ixgbe_dev_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		uint64_t *values, unsigned int n)
 {
 	if (!ids) {
+		struct ixgbe_adapter *adapter =
+			(struct ixgbe_adapter *)(dev->data->dev_private);
 		struct ixgbe_hw *hw =
 				IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 		struct ixgbe_hw_stats *hw_stats =
@@ -3729,7 +3820,7 @@ ixgbe_dev_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		total_qprc = 0;
 		total_qprdc = 0;
 
-		ixgbe_read_stats_registers(hw, hw_stats, macsec_stats,
+		ixgbe_read_stats_registers(adapter, hw,
 				&total_missed_rx, &total_qbrc, &total_qprc,
 				&total_qprdc);
 
@@ -5406,6 +5497,26 @@ ixgbe_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	return 0;
 }
 
+static void
+ixgbe_stat_update_32(struct ixgbe_hw *hw,
+		   uint32_t reg,
+		   bool offset_loaded,
+		   uint64_t *offset,
+		   uint64_t *stat)
+{
+	uint64_t new_data;
+
+	new_data = (uint64_t)IXGBE_READ_REG(hw, reg);
+	if (!offset_loaded)
+		*offset = new_data;
+
+	if (new_data >= *offset)
+		*stat = (uint64_t)(new_data - *offset);
+	else
+		*stat = (uint64_t)((new_data +
+			RTE_BIT64(IXGBE_32_BIT_WIDTH)) - *offset);
+}
+
 /*
  * Virtual Function operations
  */
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 8ad841ea2c..fd7a786fbb 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -474,6 +474,7 @@ struct ixgbe_adapter {
 	struct ixgbe_hw             hw;
 	struct ixgbe_hw_stats       stats;
 	struct ixgbe_macsec_stats   macsec_stats;
+	struct ixgbe_macsec_stats   macsec_stats_offset;
 	struct ixgbe_macsec_setting	macsec_setting;
 	struct rte_eth_fdir_conf    fdir_conf;
 	struct ixgbe_hw_fdir_info   fdir;
@@ -495,6 +496,7 @@ struct ixgbe_adapter {
 #endif
 	bool rx_bulk_alloc_allowed;
 	bool rx_vec_allowed;
+	bool offset_loaded;
 	struct rte_timecounter      systime_tc;
 	struct rte_timecounter      rx_tstamp_tc;
 	struct rte_timecounter      tx_tstamp_tc;
-- 
2.34.1

