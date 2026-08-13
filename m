Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD410C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:04:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD27642E6A;
	Thu, 13 Aug 2026 20:04:40 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2D9E042E6C
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:39 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbedf6a6fe8so63742a12.3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644278;
 x=1787249078; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKYGPuGDN976sLwkleOiXAiFbBMqogTDfOIRxb3AAbU=;
 b=WZw/dqzjqM2ziCWW80d7AsF5AzEl3EHw4qMOzIZQS/4juJoaFNV9uKmvnlG4gnlH0x
 anNkQxv3kSuKl7MVuwQ8zAsq/QM5nrI2YCmgnootOjxrhF3nUb6CnHKQoDeFD9RetnRQ
 lOq3zcQ/qBzrZ7ryqr7xVyZWJNRQ53xqVbeIKS7OFaA2qhhTRgQPn0C0GeW2lSE8QaYG
 nXKVraLg05C+aUqPqdFbTc2hJsgCeRy3zTrbOJeLafF5nmLUzliMZkPvt7tM6+ZQLWmF
 wZfecLI5ap9Q7zy4Ht3kMijJ3X5UVzjdtikLu1BUn4dfqVjIsoKOAqPxxbxTRYUdC2it
 R07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644278; x=1787249078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PKYGPuGDN976sLwkleOiXAiFbBMqogTDfOIRxb3AAbU=;
 b=Hhn1Ub+JyBZMRr4Qigw9n8HDOmRMufyUyNbkKRRUqok1CaNbnk66U0aFLVDpYHRRhM
 cFlBwV53bZtxWZdzadHiDpcS+3YjiVrVSQp10kUiGn5SUcHLUo7UlPhS1GPfFXMNr8Ym
 jwNckVCatVkqeV6u+Yp8/UtLSlTCsI9cGbQK1bG2K+dC27h6cpUhTKyn/VnVNFnkr+Da
 AIVoEOzNoP7rG+JiUHPJkHvIktaMk/KzW4X16bOrCYmUxSxLH7AvpLrHPvFYoDMTbL0T
 8gUPEe+MA7HjYhpHBw3dx2SaBR7QMIwK5jPqPNlgPZWKf+J8wB3DsKXHrT3F7a/ssN1h
 Mfbw==
X-Gm-Message-State: AOJu0YwM4nI2w6vZx8IIbUZqwzJ+e0DDj778mqGdOvK6qTDHq8a345uu
 k/u671mUA5nEYfrUADl84ye8s0w1ceFLITFS+gh2k+lTUHc0NJAY9RPVYFicR0Cjdsbj8BGYZmq
 6G6D/
X-Gm-Gg: AR+sD107J8rmszo5QQFyhXssCochyeIABF5uTjcjIN2tPssNw59PcapdbcmWsalL7BG
 neDm5c8u7vtFNd7xQ15zoojZAGE2ytxMGho4br3n2IP1soFbJNlc5M8MnYGNV51NMUHy9KeqqNA
 QhjgI3uVsi06om6HGCXRJWFBSdDtBPSfshNoakIRYiYGGds3lVeiXkEYbISVrFvvBXI1HW5V5p/
 SlEhZV61LurhSYhGmJzrs/+D83LYhRlyG1IP2X7Oe8LLHm7XDZmV2l6UWSXkRc+HKLQYta/5TL2
 4UadsXjFE7OaiHMw0JZZZVpHZINOf9dVGUyyGuMZBfITZ8HVO4ir0kGgBn45wDOYAf5Zz7E6oMA
 eb/B112cHU1sT6/hyYCxbz7TmpkgUQ2wouud97/aIbqF7Lfrsw9Br1Allbgg4zQgL8fBJl2oy8/
 tD8LPHPgF+gDS/RjjoqWAVYvt1UIM8Ew5Ac+WRO7NjzvFXOjkcyhZhQj+DjSqPGGuaSQQoaQYPS
 x9rFHfBleYpZ5BmXsDggnX/pMM=
X-Received: by 2002:a05:6a20:6f8d:b0:3c3:8044:8b0d with SMTP id
 adf61e73a8af0-3cc55039827mr11518599637.12.1786644278175; 
 Thu, 13 Aug 2026 11:04:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 07/16] net/ixgbe: remove queue stats mapping
Date: Thu, 13 Aug 2026 10:55:06 -0700
Message-ID: <20260813180402.622784-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

The support for queue_stats_map has been deprecated since 25.11.
Remove support for queue mapping in ixgbe driver.

Unlike other drivers where the mapping was a software renumbering,
the ixgbe per-queue counters (QPRC/QPTC/QBRC/QBTC/QPRDC) are routed
by the RQSMR and TQSM registers which must be programmed after reset.
These were previously zeroed at probe, which routes every queue to
counter 0, and relied on the application to program a mapping.

Program the identity mapping instead, so queue N is counted by
counter N without application involvement. DCB still overrides this
with its own per traffic class mapping when configured.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 123 ++++---------------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |   9 --
 2 files changed, 19 insertions(+), 113 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..d35da73d69 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -182,10 +182,6 @@ static int ixgbe_dev_xstats_get_names_by_id(
 	const uint64_t *ids,
 	struct rte_eth_xstat_name *xstats_names,
 	unsigned int limit);
-static int ixgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
-					     uint16_t queue_id,
-					     uint8_t stat_idx,
-					     uint8_t is_rx);
 static int ixgbe_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 				 size_t fw_size);
 static int ixgbe_dev_info_get(struct rte_eth_dev *dev,
@@ -511,7 +507,6 @@ static const struct eth_dev_ops ixgbe_eth_dev_ops = {
 	.xstats_reset         = ixgbe_dev_xstats_reset,
 	.xstats_get_names     = ixgbe_dev_xstats_get_names,
 	.xstats_get_names_by_id = ixgbe_dev_xstats_get_names_by_id,
-	.queue_stats_mapping_set = ixgbe_dev_queue_stats_mapping_set,
 	.fw_version_get       = ixgbe_fw_version_get,
 	.dev_infos_get        = ixgbe_dev_info_get,
 	.dev_supported_ptypes_get = ixgbe_dev_supported_ptypes_get,
@@ -870,109 +865,31 @@ ixgbe_disable_intr(struct ixgbe_hw *hw)
 }
 
 /*
- * This function resets queue statistics mapping registers.
+ * This function programs the queue statistics mapping registers.
  * From Niantic datasheet, Initialization of Statistics section:
  * "...if software requires the queue counters, the RQSMR and TQSM registers
  * must be re-programmed following a device reset.
+ *
+ * Each register maps four queues, one 8 bit field per queue, of which only
+ * the low four bits select one of the IXGBE_QUEUE_STAT_COUNTERS counters.
+ * Program the identity mapping so that queue N is counted by counter N,
+ * wrapping for queues beyond the number of available counters.
+ *
+ * Note: DCB overrides this with a per traffic class mapping when it is
+ * configured later in ixgbe_dev_rx_init().
  */
 static void
-ixgbe_reset_qstat_mappings(struct ixgbe_hw *hw)
-{
-	uint32_t i;
-
-	for (i = 0; i != IXGBE_NB_STAT_MAPPING_REGS; i++) {
-		IXGBE_WRITE_REG(hw, IXGBE_RQSMR(i), 0);
-		IXGBE_WRITE_REG(hw, IXGBE_TQSM(i), 0);
-	}
-}
-
-
-static int
-ixgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
-				  uint16_t queue_id,
-				  uint8_t stat_idx,
-				  uint8_t is_rx)
-{
-#define QSM_REG_NB_BITS_PER_QMAP_FIELD 8
-#define NB_QMAP_FIELDS_PER_QSM_REG 4
-#define QMAP_FIELD_RESERVED_BITS_MASK 0x0f
-
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
-	struct ixgbe_stat_mapping_registers *stat_mappings =
-		IXGBE_DEV_PRIVATE_TO_STAT_MAPPINGS(eth_dev->data->dev_private);
-	uint32_t qsmr_mask = 0;
-	uint32_t clearing_mask = QMAP_FIELD_RESERVED_BITS_MASK;
-	uint32_t q_map;
-	uint8_t n, offset;
-
-	if ((hw->mac.type != ixgbe_mac_82599EB) &&
-		(hw->mac.type != ixgbe_mac_X540) &&
-		(hw->mac.type != ixgbe_mac_X550) &&
-		(hw->mac.type != ixgbe_mac_X550EM_x) &&
-		(hw->mac.type != ixgbe_mac_X550EM_a) &&
-		(hw->mac.type != ixgbe_mac_E610))
-		return -ENOSYS;
-
-	PMD_INIT_LOG(DEBUG, "Setting port %d, %s queue_id %d to stat index %d",
-		     (int)(eth_dev->data->port_id), is_rx ? "RX" : "TX",
-		     queue_id, stat_idx);
-
-	n = (uint8_t)(queue_id / NB_QMAP_FIELDS_PER_QSM_REG);
-	if (n >= IXGBE_NB_STAT_MAPPING_REGS) {
-		PMD_INIT_LOG(ERR, "Nb of stat mapping registers exceeded");
-		return -EIO;
-	}
-	offset = (uint8_t)(queue_id % NB_QMAP_FIELDS_PER_QSM_REG);
-
-	/* Now clear any previous stat_idx set */
-	clearing_mask <<= (QSM_REG_NB_BITS_PER_QMAP_FIELD * offset);
-	if (!is_rx)
-		stat_mappings->tqsm[n] &= ~clearing_mask;
-	else
-		stat_mappings->rqsmr[n] &= ~clearing_mask;
-
-	q_map = (uint32_t)stat_idx;
-	q_map &= QMAP_FIELD_RESERVED_BITS_MASK;
-	qsmr_mask = q_map << (QSM_REG_NB_BITS_PER_QMAP_FIELD * offset);
-	if (!is_rx)
-		stat_mappings->tqsm[n] |= qsmr_mask;
-	else
-		stat_mappings->rqsmr[n] |= qsmr_mask;
-
-	PMD_INIT_LOG(DEBUG, "Set port %d, %s queue_id %d to stat index %d",
-		     (int)(eth_dev->data->port_id), is_rx ? "RX" : "TX",
-		     queue_id, stat_idx);
-	PMD_INIT_LOG(DEBUG, "%s[%d] = 0x%08x", is_rx ? "RQSMR" : "TQSM", n,
-		     is_rx ? stat_mappings->rqsmr[n] : stat_mappings->tqsm[n]);
-
-	/* Now write the mapping in the appropriate register */
-	if (is_rx) {
-		PMD_INIT_LOG(DEBUG, "Write 0x%x to RX IXGBE stat mapping reg:%d",
-			     stat_mappings->rqsmr[n], n);
-		IXGBE_WRITE_REG(hw, IXGBE_RQSMR(n), stat_mappings->rqsmr[n]);
-	} else {
-		PMD_INIT_LOG(DEBUG, "Write 0x%x to TX IXGBE stat mapping reg:%d",
-			     stat_mappings->tqsm[n], n);
-		IXGBE_WRITE_REG(hw, IXGBE_TQSM(n), stat_mappings->tqsm[n]);
-	}
-	return 0;
-}
-
-static void
-ixgbe_restore_statistics_mapping(struct rte_eth_dev *dev)
+ixgbe_init_qstat_mappings(struct ixgbe_hw *hw)
 {
-	struct ixgbe_stat_mapping_registers *stat_mappings =
-		IXGBE_DEV_PRIVATE_TO_STAT_MAPPINGS(dev->data->dev_private);
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	int i;
+	uint32_t i, reg;
 
-	/* write whatever was in stat mapping table to the NIC */
-	for (i = 0; i < IXGBE_NB_STAT_MAPPING_REGS; i++) {
-		/* rx */
-		IXGBE_WRITE_REG(hw, IXGBE_RQSMR(i), stat_mappings->rqsmr[i]);
+	RTE_BUILD_BUG_ON(RTE_DIM(((struct ixgbe_hw_stats *)0)->qprc) != 16);
 
-		/* tx */
-		IXGBE_WRITE_REG(hw, IXGBE_TQSM(i), stat_mappings->tqsm[i]);
+	for (i = 0; i != IXGBE_NB_STAT_MAPPING_REGS; i++) {
+		/* four queues per register, 8 bits each */
+		reg = 0x03020100 + 0x04040404 * (i % 4);
+		IXGBE_WRITE_REG(hw, IXGBE_RQSMR(i), reg);
+		IXGBE_WRITE_REG(hw, IXGBE_TQSM(i), reg);
 	}
 }
 
@@ -1246,8 +1163,8 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	/* disable interrupt */
 	ixgbe_disable_intr(hw);
 
-	/* reset mappings for queue statistics hw counters*/
-	ixgbe_reset_qstat_mappings(hw);
+	/* program identity mapping for queue statistics hw counters */
+	ixgbe_init_qstat_mappings(hw);
 
 	/* Allocate memory for storing MAC addresses */
 	eth_dev->data->mac_addrs = rte_zmalloc("ixgbe", RTE_ETHER_ADDR_LEN *
@@ -2742,8 +2659,6 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 						RTE_BIT64(idx));
 	}
 
-	ixgbe_restore_statistics_mapping(dev);
-
 	err = ixgbe_flow_ctrl_enable(dev, hw);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, "enable flow ctrl err");
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5d3243cb4d..ba826b6d8d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -216,11 +216,6 @@ struct ixgbe_interrupt {
 	uint32_t mask_original;
 };
 
-struct ixgbe_stat_mapping_registers {
-	uint32_t tqsm[IXGBE_NB_STAT_MAPPING_REGS];
-	uint32_t rqsmr[IXGBE_NB_STAT_MAPPING_REGS];
-};
-
 struct ixgbe_vfta {
 	uint32_t vfta[IXGBE_VFTA_SIZE];
 };
@@ -471,7 +466,6 @@ struct ixgbe_adapter {
 	struct rte_eth_fdir_conf    fdir_conf;
 	struct ixgbe_hw_fdir_info   fdir;
 	struct ixgbe_interrupt      intr;
-	struct ixgbe_stat_mapping_registers stat_mappings;
 	struct ixgbe_vfta           shadow_vfta;
 	struct ixgbe_hwstrip		hwstrip;
 	struct ixgbe_dcb_config     dcb_config;
@@ -546,9 +540,6 @@ uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts
 #define IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->fdir)
 
-#define IXGBE_DEV_PRIVATE_TO_STAT_MAPPINGS(adapter) \
-	(&((struct ixgbe_adapter *)adapter)->stat_mappings)
-
 #define IXGBE_DEV_PRIVATE_TO_VFTA(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->shadow_vfta)
 
-- 
2.53.0

