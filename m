Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7610C531D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 20:30:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57FBE40B9A;
	Thu, 23 Jul 2026 22:29:50 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 922E840678
 for <dev@dpdk.org>; Thu, 23 Jul 2026 22:29:47 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38e071ed6aeso865078a91.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784838587;
 x=1785443387; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f+Er6Tnsv7eSTDKoMp7HQ4ICNAnIS35jtxSuwyZP6MM=;
 b=e/26TkF6/qTjGoDeCesikA4Oq1+zy/LxupgdoGJnZQEkcxHLwqZ8dDdmZM+AapSa9a
 7kATSoRLbOBHQU/zdLRzxDFN44hYdegkoCBJOSrSxBFZxKo33Tl5VjsWpjbghXpiVpKq
 IRcOWhuJYYYdTkxWLNzoilD98SF6KptDej/5qxZ4mfXxVyFkCiQVxnrIMz5GGbDdsC/n
 L7V3Fv9aNt3oRt9CkVWRZLZOhw2fmR9UZbSs4vLAfQ5BwMaSUoGXR2Qu+FHMWv2Hyl2P
 rTYYrap5pVntgMhKXq3MXwBXtjekxTXcZ108tLi9IqCvwMRa+zmzoXEXA6Emn3fFkq0h
 FJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838587; x=1785443387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f+Er6Tnsv7eSTDKoMp7HQ4ICNAnIS35jtxSuwyZP6MM=;
 b=p5ye/qrR1fxScOIzwgUGwhqJnusb5Rz9MGXnLkmAc7TmcNniZTQ6jbqsEXxhEKwAaW
 e5MWSRXMSThsvgKiuI6U0wLajxZQHL+kl6PmS7ce1lGuYlf7JBAwvJrCVOxm569HowvY
 IfnKB77RTBebz5pRLbH0sD/7407JmhMRgIdZZniDKZpD0HsDrGSev/FB03p4bZelHvmw
 BeaxLztXuo2FG3Uc8uaCnYlyYh/PAxcw1XQLBkSs3QLRobanmN3vwsL9/GIY2npByESP
 YCrFmjyM6KcsODJF0BOXBsJ0oufAjEXz8fHyiCL14Ve7TyLpVlTfTKVPMxy0FNcFQqsv
 OleA==
X-Gm-Message-State: AOJu0YyXqMgbe/BV+oDbuO+gpVMJ7pKmy4+SQNdQYj5XFLa2CMqz6eJK
 bjoUAIyH1OaOpM3748TQmvtxH3kC6Ek1/H+leBAChHDp3TYopLwQgcljchZExacN6jqrjU9ownp
 l1GYm
X-Gm-Gg: AR+sD11gfPLdWmL973AVGwZHBAa77ozeU4FIc+qrKB48s+gR6vZ6EFzj9NYU/1fdNmu
 IMrTbsowSHDMdrOq6gz5DC4K9xmUq2aCGqjnxvxBYPBm7JegOZlhWl1JT9TBQg5s163v6gZNVHf
 B8Kt/zMU5FVwcRDQDycFwyGGFotD0EOOIU7MHpyEZfW2XTon0A0hYDGpTZAOHq1wM1ynZzlkB9y
 WLrwrhgI6SgafmS8hEN+LtaQp/7lYMO/sDkf0O4Pe7VLf9t49W0md2fFO4YkagMqbwHHjViGP5b
 F4tfDLHobjp6TZrxmyG5H0aI/bYMxhXWHWqhkY4hzhNM13vrwrNbFOqnq2R50oRJEQxYmrkrarn
 Su9I4ubPQa8VgCPGf3LM+5tRs74vE6EYD1iOvu8LCvNAKZVGGrdkQQU2IfZxsOakQyXqJt+NVL3
 LCt640QLYhB28dPlpE0XgQIH8mNOZfDp3YVuf/U+xU
X-Received: by 2002:a17:90b:2e0f:b0:37f:bfa2:1887 with SMTP id
 98e67ed59e1d1-38ec645ef93mr4617762a91.8.1784838586567; 
 Thu, 23 Jul 2026 13:29:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d12f267fdsm18864877c88.0.2026.07.23.13.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:29:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 6/9] net/ixgbe: remove queue stats mapping
Date: Thu, 23 Jul 2026 13:28:11 -0700
Message-ID: <20260723202936.378793-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723202936.378793-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 97 --------------------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  9 ---
 2 files changed, 106 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..3a4ca0c79b 100644
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
@@ -886,96 +881,6 @@ ixgbe_reset_qstat_mappings(struct ixgbe_hw *hw)
 	}
 }
 
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
-{
-	struct ixgbe_stat_mapping_registers *stat_mappings =
-		IXGBE_DEV_PRIVATE_TO_STAT_MAPPINGS(dev->data->dev_private);
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	int i;
-
-	/* write whatever was in stat mapping table to the NIC */
-	for (i = 0; i < IXGBE_NB_STAT_MAPPING_REGS; i++) {
-		/* rx */
-		IXGBE_WRITE_REG(hw, IXGBE_RQSMR(i), stat_mappings->rqsmr[i]);
-
-		/* tx */
-		IXGBE_WRITE_REG(hw, IXGBE_TQSM(i), stat_mappings->tqsm[i]);
-	}
-}
-
 static void
 ixgbe_dcb_init(struct ixgbe_hw *hw, struct ixgbe_dcb_config *dcb_config)
 {
@@ -2742,8 +2647,6 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
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

