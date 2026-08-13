Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33ADC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:04:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2D5C42E3A;
	Thu, 13 Aug 2026 20:04:43 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8E9F14026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:42 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso3371975ad.3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644282;
 x=1787249082; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B7t3JwOTcCPQSflZiua8bZ4piKmkfyLLn8DAEZwayWA=;
 b=hTNE89V0M6nW8AGFSwntG2ebK1NCA7+RXrjgkfmWtA7UXBxX5De5DqqIglqJaoM6GX
 L7wjbHH3aZhoLPix2IA9iJ4cspXIb1d0thYMEuaNyN9krNiNYwcIfDnINNBshx/0i6/w
 Re8Q++LYKr8Cb9PM1JfslsvRnYUToAcvzmqa6SEdwr4wE47K0q+v3SqmM7GFahm2NIRv
 tpZZdVOxeIRtQkEWB7ZsFkIbWrXQtz2zPWPAAeluy8vSwKB+L90ybIjLiD0qt/21ufBK
 d5Tr9FlLb94WWYnPzdAyPLaGLngNmqi9aQF1crBhhezJVUF7nBFDXkD2/GrbYD4pMxmF
 cpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644282; x=1787249082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B7t3JwOTcCPQSflZiua8bZ4piKmkfyLLn8DAEZwayWA=;
 b=M3ov+U/OJ8Ars+hqBWWZhDVYKpssX1aU5pT1Pfzc+I6UMVs85uwnTAJWXhCiOJ9jY7
 jg1kYAvQcXK9UzkEfp+yhA2+OQk3Q/uL87M8xJB0LPnwWMU+ZKecsBD8itFylxK7Pfx6
 KTUkX1OnS9Gr0pvTbh7PSpAvJb+90NzZfHjW5lWp7SbJHDl/h1npAQ8P1HKKOd2OuiE0
 03K/w2JA5Lp0O1tWrebQZAol5auZvlcp5yDoWk+279WG5aS47gwg0tlnDhINU3fDGTop
 hPf9aU5vrloGA4Mek/RiVElZvhDdZn8UeNLu9jigwrtWKIgABn+7fSo05PlIHBTchod4
 utJw==
X-Gm-Message-State: AOJu0YzNEEvB584RU7xUa41YAL4jAenvbH5q4GDyDITHmt79emJOz2ZV
 CLEhXh3ESFc0T8Gex84hA+AVaCTWSNm/TIn1Ia//uyTpfWEW8am5QGMhkjVmNAxHtnV8BvwTJoR
 OQCNs
X-Gm-Gg: AR+sD12NMF76XlTEymtCPVUb3NzubFZHFsdkwpGBF2yLxgACxE4kMmz0aFV9TsJCak3
 QtDU9qVRDC0clHmTw8P/JLhfs2fT44UUzcbzfmA0Pj62Dr/aG0VZarmVqBaNTQu0jUSlWanBRLN
 prtD1WXNFR5yaHJtbuA3kgEwhoo2iRM2i2VlI3X2R6huSh3U6fMCZ9ILSfF6MU7j5XLnlOENzxG
 lqgupT/amrApso6X6B3vMBd2zMF6U9e+Yj5MKjzGOQguF+ISq/8fkhK8RZ7SrGJ6I/4HE5xn/wi
 cEzXEZNF/gujqcTxfawaLwTFAt0zQkuPYzqk1ewVRfT8WQhk5RxIhaGSyi3eQ0ueVFfne8eMlKq
 ahuDaJQwBhcSskHO+a/5LMnjvBbYhFaDqQi+0WPFZXadXBGm69VIpdaJfC8pjfM+DpO4dEYsHhz
 p1x+eHWggkdBMLNLt9gOm54QtKumcFSCcECScGqOka72xPOBGt9OcQiph5JJ2/jpOL1GhysSDiA
 JwPNX+cYsfkLmkZcdUduM1m3Ic=
X-Received: by 2002:a05:6a21:6f01:b0:3c3:7179:a640 with SMTP id
 adf61e73a8af0-3cc54f4b5femr10607927637.3.1786644281589; 
 Thu, 13 Aug 2026 11:04:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 08/16] net/txgbe: remove queue stats mapping
Date: Thu, 13 Aug 2026 10:55:07 -0700
Message-ID: <20260813180402.622784-9-stephen@networkplumber.org>
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

