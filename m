Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAEDCD6E49
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA47740662;
	Sat, 30 May 2026 18:12:04 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 4AE0C4065E
 for <dev@dpdk.org>; Sat, 30 May 2026 18:12:01 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1353c2f35cfso9879798c88.1
 for <dev@dpdk.org>; Sat, 30 May 2026 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780157520;
 x=1780762320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlSQRNkBDx64NdxaNpg1YlCQDenxIaIi0jeTX8zdR4U=;
 b=UZsl/xhPCsPgkvxeLMJQ6Vb2AWTo9zTnocQIpLwuEwpIzSBbQ2EKRmXfIcfKpnRkgf
 Eha8ExPcJp2I6MYc5UbDwY6PdqptLaVszkLN5h2Fcw1eqjZ/fMn62PkHnTkdxfvPnqwN
 r/o5ERlTgazYS6tbMrNGgyT0MKg3Zrc7dIKOe1ckdmx0d5FXNjNkPoHJ/ebTrCPVwUqD
 Nd428CIFsQ9v+STs88KrUVwxqX7007O4Z7iKqHJJL8aBUJKlwyuFyChCQEGYZJwGHoYa
 er/Nt+1MlaTXbaYPCSUVyjparbTcvrgeCk54GlKTx3zn396WUtyc1kk4j087kZFG75bF
 MB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780157520; x=1780762320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hlSQRNkBDx64NdxaNpg1YlCQDenxIaIi0jeTX8zdR4U=;
 b=hHnTSYrjTnuxejMw/Xk7cFE8fPnRvA3sH1z9NhdRnqJl60r5gbUScfYELYjTZlbAKP
 RuPmMkOKbVIa6+vQ4PcvHZMYwBCM80lFe9hjcZ9ixPT2zJHHulyAwHUr2nsPq4ufocSQ
 u55lSCc6Wf6c4FxeNF8OUlLBMtaR1bI63c267ljW5SU/1eT1ZI4ue8JvClnsk9YkQgxN
 S35iJk5EBGi3CLul42ECa3d35iUiljFi4T09pZNFJzJqb1JXxmWTrMrBM5kmQ80lC3mu
 YP69NnfhlZOBFRgzsVKKZ/r+2PINkQzOToq8cmPMOxgJIpsOYb06P+5IJCe87Bpicc8L
 SdNA==
X-Gm-Message-State: AOJu0YyQTb+q2r4J/RNbXu7xPCay4mJXHeY4Tsf9bLt3nWR34kFA4Wpn
 P+jvMkFU3os3L0US6H24dD4+hkBGNGd/Z1JQ7V+RSv5eS7H6zJpNl1wXT49/M3cmwVSM/K5w4MU
 EwyHs
X-Gm-Gg: Acq92OF1iPMGM2xWfLZX+SK9bO65oCmVCxaE3z29LtTiBUY+cWum4ACRqOgkQugJeIQ
 rYTU33DPmaGGxf9DgQ9usa2hqIsdJhMubd7F0TxTM7P1vzFCqRZV/dBomxq4M5HhAsB+crOLgCp
 53WtlGHl2J/11kYXJhkt4SwOXC8Z7zIbUf8vtAKzlKFYDuDD/FlwckuPnmFP+N8KjZfuFScphXL
 O0C1kPrI73rrGpmTv0eIZGRTLtAH1534YOBPiI+FN6TlIFZsd77ukIqHYcgP2ghfYlFuPyl3IPv
 8sN4+FQqTjKA1Jq6lIhLbdgac10PQNmZS1TgDxPtTZl61HUkF1KCKtzYp07jB4TNqR17kMbYlug
 V9HtG4E6nPnSoZXHl/Cy8GZr1TSZszL7R9pZ+RLtTOHA68y/5NscKQgPo8NRZBpZ5YmRlyGK9Lu
 QsAcpg8JMgb6T4d1E6e0TNDiXNWM3f8cTdXJb0GL4+2sKL7FEkSO063qA5DIKifA6Nr/kivIV6
X-Received: by 2002:a05:7022:49f:b0:136:e42d:2c20 with SMTP id
 a92af1059eb24-137d3f0d89cmr2263081c88.16.1780157520324; 
 Sat, 30 May 2026 09:12:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69bdfsm3305616c88.9.2026.05.30.09.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 09:11:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [RFC 6/7] net/txgbe: remove queue stats mapping
Date: Sat, 30 May 2026 09:10:01 -0700
Message-ID: <20260530161151.873199-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530161151.873199-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
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
index 5d360f8305..3886a2cbf4 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -391,60 +391,6 @@ txgbe_disable_intr(struct txgbe_hw *hw)
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
@@ -2457,10 +2403,8 @@ txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct txgbe_hw_stats *hw_stats = TXGBE_DEV_STATS(dev);
-	struct txgbe_stat_mappings *stat_mappings =
-			TXGBE_DEV_STAT_MAPPINGS(dev);
 	struct txgbe_tx_queue *txq;
-	uint32_t i, j;
+	unsigned int i;
 
 	txgbe_read_stats_registers(hw, hw_stats);
 
@@ -2474,29 +2418,13 @@ txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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
 
@@ -5987,7 +5915,6 @@ static const struct eth_dev_ops txgbe_eth_dev_ops = {
 	.xstats_reset               = txgbe_dev_xstats_reset,
 	.xstats_get_names           = txgbe_dev_xstats_get_names,
 	.xstats_get_names_by_id     = txgbe_dev_xstats_get_names_by_id,
-	.queue_stats_mapping_set    = txgbe_dev_queue_stats_mapping_set,
 	.fw_version_get             = txgbe_fw_version_get,
 	.dev_supported_ptypes_get   = txgbe_dev_supported_ptypes_get,
 	.mtu_set                    = txgbe_dev_mtu_set,
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 189fbac541..ac977dfc02 100644
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

