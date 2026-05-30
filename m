Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C747CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:12:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2BEE40654;
	Sat, 30 May 2026 18:12:00 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 67807402F1
 for <dev@dpdk.org>; Sat, 30 May 2026 18:11:58 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1334825de43so13424252c88.0
 for <dev@dpdk.org>; Sat, 30 May 2026 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780157517;
 x=1780762317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDXKpxKvV2g3nuShx4dppsAocyCN6YxQbIFq9B5/Cb8=;
 b=iFrgjLdYX1x5VakIKwGZRKkwMcI3D6d4Ue+i1Al+vyW3E6OPbMbYlhZBILmZKm+RKU
 yL2bOb4SD/tl58aJYy7pkku9qnXKrBythQlzcqS/ExqyFzAcprHv573OP86625gQpZj6
 LuaTCZE08uUeD3CE6SXj9FY89BXLX/GB7/vD757/VMvcQU31Ob0Y1iCPveQX51LjD8Yt
 9nzag9K+Plmb4eW7M7kLkwjDucBPjlNi5nGjlR8TflM+agW0fX9jhlt6WCGn4Ew2eFm6
 tFE+Wrshfp1xw+wtIAKE5TSsfieINNssWLAsoCJZFeIzq8BiU3cQwuac8aMlBkzy1dvq
 xITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780157517; x=1780762317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yDXKpxKvV2g3nuShx4dppsAocyCN6YxQbIFq9B5/Cb8=;
 b=TgCWiveVQkq/rnfiyvMM/NPTZVKagM2jBs6s/ztXZgzV/g+R7IDhHmEqKgzcz8gypW
 TSxWz5bvuZifA+IcigRYPvV8PExixgL2uLyss3mPH9G9svBIHxNE99+MWYUI8BrMAHHO
 g3uHtI3u4WnBAyotLQKbBG0/hki/UXTpZcp4y30+2r/RG2aXeumweEl1y7hKldar614c
 nhkZeOkDL3YdxDqjEMcg2FMraN/6CrWzQh6eovyRRmvFEZl2rW9w6IyYOWKBW4Chbqbx
 7SZ/NVtvbJvSMGJmgEOcG7eqM1VaQZGK0rvXIDbTrgj9ebmvhHAYPKRKgU5dpqM5j7Q4
 qqTg==
X-Gm-Message-State: AOJu0YwoYUUBkmdHbcyFj/sD9eg+mpGFU6RXAnu7yYZchavO2o8z60IZ
 MhhU8ZMSMxM06rw4Kke/srYJpJkqV72ergUWLcC9Bk8zRmQj7Lqvhz2IYhpd1ZMGi7wfoMyCm+8
 skDHz
X-Gm-Gg: Acq92OHBkJgz5BT88E/3pBj+4s6+zYErIlSMO+hYxwFdloPHt23wBJLa0kS7Idn1Nvf
 MgN6SjIw2NNS7NYglB6XcvKJsURSFH8aoWlmXfxsshlEdn/2VRrazMvWDVTPmlD/m2Bth840TRw
 q+dkjvvgRe4JYSmj+42Lf+uxZ1iwis9y5opQEy4b/Ur9bO/eYRTYjgG0Cr+J8uz2wBmid+UvljU
 fuODfnKi1N0tNv05JXgoYsDW8ESgHhZKyYvkTBe//Rr1ALDIqdTv9ULGSJG8ay25XU3Jw8Xeurg
 pUpu10qXTdlw4cGhjIEKbq8VazNZGGlIfeHxE0JLMASHqCKqIHeV/qeVTP1WmnxvWeF1MGBrck9
 /7eNun4YLpArJRRmLwe6X0N72+/+2iPlGDWsUR49+zeaemr5b2iL6dgF6G1gS952Q8v/nC+ECXX
 +4g5JginfnE9aeVk9/MYHNd5K5aIZwcKVAdCfsW3seqdGPpeCqwxCpbX3UEVeEjrvlw8xUSQuY
X-Received: by 2002:a05:7022:1283:b0:135:5d4b:2096 with SMTP id
 a92af1059eb24-137d4248a37mr1522921c88.36.1780157517411; 
 Sat, 30 May 2026 09:11:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69bdfsm3305616c88.9.2026.05.30.09.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 09:11:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC 3/7] net/cnxk: remove queue stats mapping
Date: Sat, 30 May 2026 09:09:58 -0700
Message-ID: <20260530161151.873199-4-stephen@networkplumber.org>
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

The queue stats mapping feature has been deprecated since 25.11.
Remove support in this driver for stats map.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_ethdev.c |  1 -
 drivers/net/cnxk/cnxk_ethdev.h |  6 ---
 drivers/net/cnxk/cnxk_stats.c  | 76 ++++++++++++++--------------------
 3 files changed, 31 insertions(+), 52 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 06d1c9b362..c8e7d70c2a 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -2104,7 +2104,6 @@ struct eth_dev_ops cnxk_eth_dev_ops = {
 	.rx_queue_intr_enable = cnxk_nix_rx_queue_intr_enable,
 	.rx_queue_intr_disable = cnxk_nix_rx_queue_intr_disable,
 	.pool_ops_supported = cnxk_nix_pool_ops_supported,
-	.queue_stats_mapping_set = cnxk_nix_queue_stats_mapping,
 	.stats_get = cnxk_nix_stats_get,
 	.stats_reset = cnxk_nix_stats_reset,
 	.xstats_get = cnxk_nix_xstats_get,
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 8691acc642..d73a4ff3d3 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -416,10 +416,6 @@ struct cnxk_eth_dev {
 	/* LSO Tunnel format indices */
 	uint64_t lso_tun_fmt;
 
-	/* Per queue statistics counters */
-	uint32_t txq_stat_map[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	uint32_t rxq_stat_map[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-
 	/* Security data */
 	struct cnxk_eth_dev_sec_inb inb;
 	struct cnxk_eth_dev_sec_outb outb;
@@ -687,8 +683,6 @@ void cnxk_eth_dev_link_status_get_cb(struct roc_nix *nix,
 void cnxk_eth_dev_q_err_cb(struct roc_nix *nix, void *data);
 int cnxk_nix_link_info_configure(struct rte_eth_dev *eth_dev);
 int cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete);
-int cnxk_nix_queue_stats_mapping(struct rte_eth_dev *dev, uint16_t queue_id,
-				 uint8_t stat_idx, uint8_t is_rx);
 int cnxk_nix_stats_reset(struct rte_eth_dev *dev);
 int cnxk_nix_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		       struct eth_queue_stats *qstats);
diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.c
index d57659ef51..e5d29a78b3 100644
--- a/drivers/net/cnxk/cnxk_stats.c
+++ b/drivers/net/cnxk/cnxk_stats.c
@@ -14,7 +14,8 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct roc_nix *nix = &dev->nix;
 	struct roc_nix_stats nix_stats;
-	int rc = 0, i;
+	unsigned int i;
+	int rc = 0;
 
 	rc = roc_nix_stats_get(nix, &nix_stats);
 	if (rc)
@@ -33,31 +34,35 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 	stats->ibytes = nix_stats.rx_octs;
 	stats->ierrors = nix_stats.rx_err;
 
-	if (qstats != NULL) {
-		for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-			struct roc_nix_stats_queue qstats_data;
-			uint16_t qidx;
-
-			if (dev->txq_stat_map[i] & (1U << 31)) {
-				qidx = dev->txq_stat_map[i] & 0xFFFF;
-				rc = roc_nix_stats_queue_get(nix, qidx, 0, &qstats_data);
-				if (rc)
-					goto exit;
-				qstats->q_opackets[i] = qstats_data.tx_pkts;
-				qstats->q_obytes[i] = qstats_data.tx_octs;
-				qstats->q_errors[i] = qstats_data.tx_drop_pkts;
-			}
-
-			if (dev->rxq_stat_map[i] & (1U << 31)) {
-				qidx = dev->rxq_stat_map[i] & 0xFFFF;
-				rc = roc_nix_stats_queue_get(nix, qidx, 1, &qstats_data);
-				if (rc)
-					goto exit;
-				qstats->q_ipackets[i] = qstats_data.rx_pkts;
-				qstats->q_ibytes[i] = qstats_data.rx_octs;
-				qstats->q_errors[i] += qstats_data.rx_drop_pkts;
-			}
-		}
+	if (qstats == NULL)
+		goto exit;
+
+	for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
+		struct roc_nix_stats_queue qstats_data;
+
+		if (i >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
+			break;
+
+		rc = roc_nix_stats_queue_get(nix, i, 0, &qstats_data);
+		if (rc)
+			goto exit;
+		qstats->q_opackets[i] = qstats_data.tx_pkts;
+		qstats->q_obytes[i] = qstats_data.tx_octs;
+		qstats->q_errors[i] = qstats_data.tx_drop_pkts;
+	}
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		struct roc_nix_stats_queue qstats_data;
+
+		if (i >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
+			break;
+
+		rc = roc_nix_stats_queue_get(nix, i, 1, &qstats_data);
+		if (rc)
+			goto exit;
+		qstats->q_ipackets[i] = qstats_data.rx_pkts;
+		qstats->q_ibytes[i] = qstats_data.rx_octs;
+		qstats->q_errors[i] += qstats_data.rx_drop_pkts;
 	}
 exit:
 	return rc;
@@ -71,25 +76,6 @@ cnxk_nix_stats_reset(struct rte_eth_dev *eth_dev)
 	return roc_nix_stats_reset(&dev->nix);
 }
 
-int
-cnxk_nix_queue_stats_mapping(struct rte_eth_dev *eth_dev, uint16_t queue_id,
-			     uint8_t stat_idx, uint8_t is_rx)
-{
-	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
-
-	if (is_rx) {
-		if (queue_id >= dev->nb_rxq)
-			return -EINVAL;
-		dev->rxq_stat_map[stat_idx] = ((1U << 31) | queue_id);
-	} else {
-		if (queue_id >= dev->nb_txq)
-			return -EINVAL;
-		dev->txq_stat_map[stat_idx] = ((1U << 31) | queue_id);
-	}
-
-	return 0;
-}
-
 int
 cnxk_nix_xstats_get(struct rte_eth_dev *eth_dev, struct rte_eth_xstat *xstats,
 		    unsigned int n)
-- 
2.53.0

