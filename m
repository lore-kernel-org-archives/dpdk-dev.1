Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DBAC5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE0F340658;
	Fri, 14 Aug 2026 22:20:25 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 5C303402E1
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:24 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cbeea240819so803064a12.1
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738823;
 x=1787343623; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B7t3JwOTcCPQSflZiua8bZ4piKmkfyLLn8DAEZwayWA=;
 b=L3JWhFsKJug3UmYiF4uFYiLxWQMWCcR5gGalOVJaPgD+p951HCYYZcEhMkp4ysf+7O
 0v7fmG8wH968Jc5uu0Qb6RST13nnJwTl+1aQVqP7MGD57JfNmdUldlbD9uwnhadYMMzt
 Oc4HND4FgWESlCYJtdnBPdTnNeZbaodAMK/cPXBY4XG5hAyDnLLuMzclhgqXUE7uNepb
 zH6xyZmwqBPnGotXtmgLHKdODFc4Qf0Tbe8pBSs9mJIUb1npD8f0EOSEMFTgHndV40Ix
 kf+jgGjOFym6YZkvFlXH0VoWc209QS1d8swlbzTD5aHKAqyTWC9bb5pUDgOpLlZRQwIj
 8hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738823; x=1787343623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B7t3JwOTcCPQSflZiua8bZ4piKmkfyLLn8DAEZwayWA=;
 b=MBnZtdV32SQgYbqzqjtLjrm3E+SVCzhx6/xfn76ab9Qdylr+w55S8iEopTC3vZX8Ro
 d5tTN2ZGy8xArazIrvyy872L0sgf9v85q6DJ0UfQp3UelSGe2vBbaMAZo+d7TKqlBm43
 3l8MWy2DnQPX5myfLCbAPrLmE0e2u9L/LTSWcpHVPlZqQ7rwf+4rmPis1R5dqP6cHZSH
 Itl2T6y+/lN68WXadwKFqD7TqhQUqtCWxE4Te2N1OgH8kakkqt+uv91SEp+14OuaLRHP
 1Rz1cGk1s5QnDmSZSDUvTtKiySGaNHn4TrvJwLESTSkfYhAS8cMSP9p4dDb8aYEHjhdV
 q+Mw==
X-Gm-Message-State: AOJu0Yy8GIhESJDmAE6s8gBl7pShzt5v5djUbE1XfwdTC7j1OZy1IbLU
 fhdLd/vyGcjzB3lBBEnJwL0DaPH2hUdAwM392aqvaKLCGNHy/C6LjJhFWyyPL1+nuIKUCjyDLOX
 D06uf
X-Gm-Gg: AR+sD10Uoe57zQCbSugj4W1QbTg5rG1NNPqvfTMmgZXEAQ5ktkvYfXNHKWbElmnPvZS
 DYTRwUpttU47E/X5sUPBc1Chfu1YlgvqQsBEZ4D/9p7QFS86N73pa2RsVBbKuvwF/0IXHf8bm5f
 tyL4L2MMmBTsUCjE2xEJ/7Z6MgE6cD3eIcizYfU4B6kqKn3TFD/e0j80XOy7ayXBezgfSN6eLu3
 GMp63P4ALxCJ8GByIhbeIxrfKyMyMDeGuGhv3w8E3APZIVEKF9jaPJbO3FOMfKs9qQZU7A23r4n
 J67HDaYnDzDsp+OycgQHDsKXWqqWxD9k2nVajEVQxY3JEwWDT6zypa2aQ2Y/wqG1bNgh0FQg/oN
 J00VvdX+ge8xkcEBo1hCxz1+8t+sa25787Db8EyIQEXDY1GosPrN/BApHWtznY3TQWOY5hDmciL
 Bp1YnEwAmu4hTlElf+xj5oKtaVMRX4BwkfveKe38ZvQdTCqQG3eo1mR0EmPw+Idu5tsLl8XSt0t
 /OiFDqxLsblL/5eNBwAdagqIPI=
X-Received: by 2002:a05:6a20:7343:b0:3c3:a722:59cc with SMTP id
 adf61e73a8af0-3cc71cc65camr9455592637.22.1786738823295; 
 Fri, 14 Aug 2026 13:20:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v4 08/16] net/txgbe: remove queue stats mapping
Date: Fri, 14 Aug 2026 12:46:04 -0700
Message-ID: <20260814194757.329424-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

Support for queue stats mapping has been deprecated since 25.11.
Remove support for this ethdev op in txgbe driver.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/txgbe/txgbe_ethdev.c | 87 +++-----------------------------
 drivers/net/txgbe/txgbe_ethdev.h | 13 -----
 2 files changed, 7 insertions(+), 93 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 4d2746371b..6349aca90f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -386,60 +386,6 @@ txgbe_disable_intr(struct txgbe_hw *hw)
 	txgbe_flush(hw);
 }
 
-static int
-txgbe_dev_queue_stats_mapping_set(struct rte_eth_dev *eth_dev,
-				  uint16_t queue_id,
-				  uint8_t stat_idx,
-				  uint8_t is_rx)
-{
-	struct txgbe_hw *hw = TXGBE_DEV_HW(eth_dev);
-	struct txgbe_stat_mappings *stat_mappings =
-		TXGBE_DEV_STAT_MAPPINGS(eth_dev);
-	uint32_t qsmr_mask = 0;
-	uint32_t clearing_mask = QMAP_FIELD_RESERVED_BITS_MASK;
-	uint32_t q_map;
-	uint8_t n, offset;
-
-	if (!txgbe_is_pf(hw))
-		return -ENOSYS;
-
-	if (stat_idx & ~QMAP_FIELD_RESERVED_BITS_MASK)
-		return -EIO;
-
-	PMD_INIT_LOG(DEBUG, "Setting port %d, %s queue_id %d to stat index %d",
-		     (int)(eth_dev->data->port_id), is_rx ? "RX" : "TX",
-		     queue_id, stat_idx);
-
-	n = (uint8_t)(queue_id / NB_QMAP_FIELDS_PER_QSM_REG);
-	if (n >= TXGBE_NB_STAT_MAPPING) {
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
-		stat_mappings->rqsm[n] &= ~clearing_mask;
-
-	q_map = (uint32_t)stat_idx;
-	q_map &= QMAP_FIELD_RESERVED_BITS_MASK;
-	qsmr_mask = q_map << (QSM_REG_NB_BITS_PER_QMAP_FIELD * offset);
-	if (!is_rx)
-		stat_mappings->tqsm[n] |= qsmr_mask;
-	else
-		stat_mappings->rqsm[n] |= qsmr_mask;
-
-	PMD_INIT_LOG(DEBUG, "Set port %d, %s queue_id %d to stat index %d",
-		     (int)(eth_dev->data->port_id), is_rx ? "RX" : "TX",
-		     queue_id, stat_idx);
-	PMD_INIT_LOG(DEBUG, "%s[%d] = 0x%08x", is_rx ? "RQSMR" : "TQSM", n,
-		     is_rx ? stat_mappings->rqsm[n] : stat_mappings->tqsm[n]);
-	return 0;
-}
-
 static void
 txgbe_dcb_init(struct txgbe_hw *hw, struct txgbe_dcb_config *dcb_config)
 {
@@ -2491,10 +2437,8 @@ txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct txgbe_hw_stats *hw_stats = TXGBE_DEV_STATS(dev);
-	struct txgbe_stat_mappings *stat_mappings =
-			TXGBE_DEV_STAT_MAPPINGS(dev);
 	struct txgbe_tx_queue *txq;
-	uint32_t i, j;
+	unsigned int i;
 
 	txgbe_read_stats_registers(hw, hw_stats);
 
@@ -2508,29 +2452,13 @@ txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	stats->obytes = hw_stats->tx_bytes;
 
 	if (qstats != NULL) {
-		memset(&qstats->q_ipackets, 0, sizeof(qstats->q_ipackets));
-		memset(&qstats->q_opackets, 0, sizeof(qstats->q_opackets));
-		memset(&qstats->q_ibytes, 0, sizeof(qstats->q_ibytes));
-		memset(&qstats->q_obytes, 0, sizeof(qstats->q_obytes));
-		memset(&qstats->q_errors, 0, sizeof(qstats->q_errors));
 		for (i = 0; i < TXGBE_MAX_QP; i++) {
-			uint32_t n = i / NB_QMAP_FIELDS_PER_QSM_REG;
-			uint32_t offset = (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;
-			uint32_t q_map;
-
-			q_map = (stat_mappings->rqsm[n] >> offset)
-					& QMAP_FIELD_RESERVED_BITS_MASK;
-			j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-			     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-			qstats->q_ipackets[j] += hw_stats->qp[i].rx_qp_packets;
-			qstats->q_ibytes[j] += hw_stats->qp[i].rx_qp_bytes;
-
-			q_map = (stat_mappings->tqsm[n] >> offset)
-					& QMAP_FIELD_RESERVED_BITS_MASK;
-			j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-			     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-			qstats->q_opackets[j] += hw_stats->qp[i].tx_qp_packets;
-			qstats->q_obytes[j] += hw_stats->qp[i].tx_qp_bytes;
+			if (i >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
+				break;
+			qstats->q_ipackets[i] += hw_stats->qp[i].rx_qp_packets;
+			qstats->q_ibytes[i] += hw_stats->qp[i].rx_qp_bytes;
+			qstats->q_opackets[i] += hw_stats->qp[i].tx_qp_packets;
+			qstats->q_obytes[i] += hw_stats->qp[i].tx_qp_bytes;
 		}
 	}
 
@@ -6365,7 +6293,6 @@ static const struct eth_dev_ops txgbe_eth_dev_ops = {
 	.xstats_reset               = txgbe_dev_xstats_reset,
 	.xstats_get_names           = txgbe_dev_xstats_get_names,
 	.xstats_get_names_by_id     = txgbe_dev_xstats_get_names_by_id,
-	.queue_stats_mapping_set    = txgbe_dev_queue_stats_mapping_set,
 	.fw_version_get             = txgbe_fw_version_get,
 	.dev_supported_ptypes_get   = txgbe_dev_supported_ptypes_get,
 	.mtu_set                    = txgbe_dev_mtu_set,
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index c32c61d8bf..a617b70e3c 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -153,15 +153,6 @@ struct txgbe_interrupt {
 	uint64_t mask_orig; /* save mask during delayed handler */
 };
 
-#define TXGBE_NB_STAT_MAPPING  32
-#define QSM_REG_NB_BITS_PER_QMAP_FIELD 8
-#define NB_QMAP_FIELDS_PER_QSM_REG 4
-#define QMAP_FIELD_RESERVED_BITS_MASK 0x0f
-struct txgbe_stat_mappings {
-	uint32_t tqsm[TXGBE_NB_STAT_MAPPING];
-	uint32_t rqsm[TXGBE_NB_STAT_MAPPING];
-};
-
 struct txgbe_vfta {
 	uint32_t vfta[TXGBE_VFTA_SIZE];
 };
@@ -355,7 +346,6 @@ struct txgbe_adapter {
 	struct rte_eth_fdir_conf    fdir_conf;
 	struct txgbe_hw_fdir_info   fdir;
 	struct txgbe_interrupt      intr;
-	struct txgbe_stat_mappings  stat_mappings;
 	struct txgbe_vfta           shadow_vfta;
 	struct txgbe_hwstrip        hwstrip;
 	struct txgbe_dcb_config     dcb_config;
@@ -398,9 +388,6 @@ struct txgbe_adapter {
 #define TXGBE_DEV_FDIR(dev) \
 	(&((struct txgbe_adapter *)(dev)->data->dev_private)->fdir)
 
-#define TXGBE_DEV_STAT_MAPPINGS(dev) \
-	(&((struct txgbe_adapter *)(dev)->data->dev_private)->stat_mappings)
-
 #define TXGBE_DEV_VFTA(dev) \
 	(&((struct txgbe_adapter *)(dev)->data->dev_private)->shadow_vfta)
 
-- 
2.53.0

