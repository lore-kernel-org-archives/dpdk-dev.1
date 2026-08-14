Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28338C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B2C140287;
	Fri, 14 Aug 2026 22:20:15 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 133E44013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:14 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2caed617615so20324885ad.3
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738813;
 x=1787343613; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D3rQam7HPhji/AF3sQqOuTR5kO7LR5rh3+Vaxj8ePeQ=;
 b=SvHbSPEei+92Ri4B6aFDQTgrDquXZvBvMirvx+puiJEOd/ilB87uU34ruurmT/iMjP
 VelSjAOAT/r3524tX236ci8N5g9jBoobDWax/6ffKcEXh67b4dbw2fy1Ukic6vBMYHDV
 rHEQ8aQq2JH7hoGmUipYkpnkD+ArKlsAgZkbVZhmLoewdRwM8Hfmfm54sMPqJ5lDt/vZ
 MlczsAAA8N/aQPxyOA1bdQfWeS6+eW5m2vtLMWjwiJ19AFJPLIKrevmdsF8EA8L1Tv5x
 dr3DV2hDw091GFoUnq3YMW+kGXQXRgnJfCbaCOlKCdwv/ZiGmq6L1D4Gevd4M/jfaHFO
 fvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738813; x=1787343613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D3rQam7HPhji/AF3sQqOuTR5kO7LR5rh3+Vaxj8ePeQ=;
 b=g7GKWoW2p2zum3dngpAHB/3hdFYaakbNENA8os4xzLaM2T7FSxThm/VncAuojjyIEn
 zG294QhZYBcsjRDxm2Q2lFF52jyMPhlQKizARnu9yV1rB6mQHuZh5m6d7w4Sm371aVSx
 Xd34H7MMNBbrPcBDHemgtLS5yhxtUGbHh46JzdXedr9SsuKqrsyuk0Ze27XhQxkKlh+9
 LfdfGCKQcSjuIld4pC75IOAJmSvlT7nGMkq5/hvSeWcIq/F53+BILf/dpta6+OhCP/iB
 z2fGyu9dyINeddBUeSx+pPpjYVNcu2z9yGBoico2Wu/dj/pe8aCbhq8oDiSV2Dv166eW
 82+w==
X-Gm-Message-State: AOJu0Yxt5TcQ1bgE/8SbRrahh3EvUyXMMXM8aq1d2Z9ZNqf0qeGPivAv
 YUCc7C8hXLDmbh3AGPHOTiYkm6CBVKQH82W86g115kULKdloUcELMWzSPnEWo6O8+XRIwE9o913
 X8BZV
X-Gm-Gg: AR+sD12RknZitdGlOSSMGIVUUMfDxZf3bcjwcNVI9TQIEHtHHAylv3xasKbwPMqrPUR
 qF2Hw8Lh2eYw6O+kmBLN1VswxKw0r49MEzSLgZ0tTDInqCQkR0SeN9AFVfCEJGONvUeJFR1xAK0
 fu2mTZewwdoWj3XOkdkxCbiyyZ3Ze/jmjQHpl2Lmi7i1yW7oI47tlp+boqivyJL9hFcxl8C0oF6
 gPBuGpQKzOVUfdorH7Wb2r4+4xWw981CpwbxzQr7elK1fkxj4OErSo38bBTEYTX18VQck6/XU3u
 VklcnKvhloVjYnYVil7RHeQZ170KxbESHwgdoLOROKmLWHS9a7WG5tQpk5IVmolL4sa2POUUOJS
 6l1lvgaXpWWAhY+eu/EeX7OGGafzowx4kU5JyRGwGPTqidGVf54un5o0hA3t88DpqS/tdvH94PJ
 YdSPisf4s/V4WG8HZgT0b0TQIGZUhcJtxVHycB0L6rUlyn3FSIdKSwUXq65BEHTVAPquYpQGnEh
 UN8k7Y4E1epm84r7Fj3LD0JhOM=
X-Received: by 2002:a05:6a20:6f8a:b0:3bf:9b3d:61bb with SMTP id
 adf61e73a8af0-3cc71e5c82amr11527195637.16.1786738813147; 
 Fri, 14 Aug 2026 13:20:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v4 05/16] net/cnxk: remove queue stats mapping
Date: Fri, 14 Aug 2026 12:46:01 -0700
Message-ID: <20260814194757.329424-6-stephen@networkplumber.org>
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

The queue stats mapping feature has been deprecated since 25.11.
Remove support in this driver for stats map.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_ethdev.c |  1 -
 drivers/net/cnxk/cnxk_ethdev.h |  6 ---
 drivers/net/cnxk/cnxk_stats.c  | 73 ++++++++++++++--------------------
 3 files changed, 29 insertions(+), 51 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index c41959173b..9a4da870cd 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -2103,7 +2103,6 @@ struct eth_dev_ops cnxk_eth_dev_ops = {
 	.rx_queue_intr_enable = cnxk_nix_rx_queue_intr_enable,
 	.rx_queue_intr_disable = cnxk_nix_rx_queue_intr_disable,
 	.pool_ops_supported = cnxk_nix_pool_ops_supported,
-	.queue_stats_mapping_set = cnxk_nix_queue_stats_mapping,
 	.stats_get = cnxk_nix_stats_get,
 	.stats_reset = cnxk_nix_stats_reset,
 	.xstats_get = cnxk_nix_xstats_get,
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index fc66135c66..5dd74de577 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -423,10 +423,6 @@ struct cnxk_eth_dev {
 	/* LSO Tunnel format indices */
 	uint64_t lso_tun_fmt;
 
-	/* Per queue statistics counters */
-	uint32_t txq_stat_map[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-	uint32_t rxq_stat_map[RTE_ETHDEV_QUEUE_STAT_CNTRS];
-
 	/* Security data */
 	struct cnxk_eth_dev_sec_inb inb;
 	struct cnxk_eth_dev_sec_outb outb;
@@ -700,8 +696,6 @@ void cnxk_eth_dev_link_status_get_cb(struct roc_nix *nix,
 void cnxk_eth_dev_q_err_cb(struct roc_nix *nix, void *data);
 int cnxk_nix_link_info_configure(struct rte_eth_dev *eth_dev);
 int cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete);
-int cnxk_nix_queue_stats_mapping(struct rte_eth_dev *dev, uint16_t queue_id,
-				 uint8_t stat_idx, uint8_t is_rx);
 int cnxk_nix_stats_reset(struct rte_eth_dev *dev);
 int cnxk_nix_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		       struct eth_queue_stats *qstats);
diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.c
index 6c812bd732..469a18f93e 100644
--- a/drivers/net/cnxk/cnxk_stats.c
+++ b/drivers/net/cnxk/cnxk_stats.c
@@ -14,7 +14,7 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct roc_nix *nix = &dev->nix;
 	struct roc_nix_stats nix_stats;
-	int rc = 0, i;
+	int rc, i;
 
 	rc = roc_nix_stats_get(nix, &nix_stats);
 	if (rc)
@@ -33,30 +33,34 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
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
-			}
-
-			if (dev->rxq_stat_map[i] & (1U << 31)) {
-				qidx = dev->rxq_stat_map[i] & 0xFFFF;
-				rc = roc_nix_stats_queue_get(nix, qidx, 1, &qstats_data);
-				if (rc)
-					goto exit;
-				qstats->q_ipackets[i] = qstats_data.rx_pkts;
-				qstats->q_ibytes[i] = qstats_data.rx_octs;
-				qstats->q_errors[i] = qstats_data.rx_drop_pkts;
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
+		qstats->q_errors[i] = qstats_data.rx_drop_pkts;
 	}
 exit:
 	return rc;
@@ -70,25 +74,6 @@ cnxk_nix_stats_reset(struct rte_eth_dev *eth_dev)
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

