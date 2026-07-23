Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C731C531D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 20:30:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E41540280;
	Thu, 23 Jul 2026 22:29:48 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3028540280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 22:29:45 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c981c2c37cbso897356a12.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 13:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784838584;
 x=1785443384; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ul2m75f3HrCo0aD5dgYXRI8SlNJKci+vk3sm/CGs2JI=;
 b=JGL3u/soo+VhcCey69rbCaQEodz+LJ4OK/PR7Ad+RSP6yzcSBOVe4qbewOIsZmrx4q
 IVcl2fuSTc/xOb9c8Gpcz8+3yLXD26ZAtjdtdWXYy0grnwD1MrScpkQ4/iRbS3c7QT8u
 e5AbGAhusYcJg7trmZz2nPBTniBhoqVsOMEcEp7C6s3q7x5ylDOs2Oog3y9NYnLcu2v0
 FfMIqMmqLMUOX5ftolQayAWPF217sLXc+n9WtFDVbWMZNhgPuRmaRKjjgHCLeytUCB+4
 os37HZh6a4sGxVxBnLWxYkcqlDdt9vgsDNd6V4j8hMES21mWngf1ANe6KLrw2/Z3GsgG
 WFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838584; x=1785443384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ul2m75f3HrCo0aD5dgYXRI8SlNJKci+vk3sm/CGs2JI=;
 b=WqsskHc//ctUwqpue+5ffVm2u3WkemW6WFQsXFWlIQ6i0zddY9RVk7wUfvcTDrop2F
 FQ6ESszXn04laXQBwbBpyRTUemr495ciJBGu14wFqcOxFU604gPrYPw07Eqvvxx+TyIK
 O+hnPDwXMVa5CIXc3JxJS5kBkkOY+xGXV1mxWE1QHgi/1vwvYWijqJnv0U1293ukOxsQ
 py5nglVZVgMmvLiJu6LTRx7/YbNfZ2q00bHSmZXCpc7IF3ycYRjBrULtmfzbTJA7nLTg
 5y4yKcdCAUKBwPVhOVwj2uEUuEMaYSBV7JbJo6xW/jj37siii4Sr5rQKxWBU44Y/EHwP
 0Crw==
X-Gm-Message-State: AOJu0YwKCGrkTgXRlWL81PalqRrDUuvZSfqWKUm4QhxgP5LNRT0vFhII
 uL4DAoan/xZyoA0AOIznxtLiWpxHQetnvPs7oVVZhYr8QQjpF2Bym/wE70u4s5xjSt+xbr0kKS6
 hUKv7
X-Gm-Gg: AR+sD10bsOe3m0upptoELE9yurmT2Sc9jJVvWikv9/tl/POEeOLRnjP3NZOg3d455gl
 DMr95nTBk8JZUc4toMVoMzoc5ttAwdszyzVZZBY1TTIIg6MsdHs51Qy1yIKjxOY3V1Hr806386g
 E3BQFLRJ+XccIs7niGnrEa13jFWhTxfrwYk5Z5QahcWZjRdhLcIDI2Fo+PVXppp6WxukKmTgdml
 RbF7gs0A3xCRWYVx62GVZT9TRBxBARpxnjtZiwYQyrh4quJ0P0tiYnFIyDePUvF8j1GyDVrEij3
 php8qoS7Gj0PVSSCnCF4BfJdrOXtdFpvIclUNl+22WPG7PtvGIXXfueZnkQvKqHifvtBkl15On/
 ciSkjS0CKhV4lRgjdSMt5t2MVZgd6eSDYpen5+dPHXSk+Gbl3nUg/2kqj4mc2MiGrHzqwespw4o
 /VS2ca9d6IU05qHa1sSnPf9NuRLpB2bQSK+gXOqFrU
X-Received: by 2002:a05:6a21:3204:b0:3c3:c3fb:2473 with SMTP id
 adf61e73a8af0-3c44b006731mr4829416637.20.1784838584333; 
 Thu, 23 Jul 2026 13:29:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d12f267fdsm18864877c88.0.2026.07.23.13.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:29:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 4/9] net/cnxk: remove queue stats mapping
Date: Thu, 23 Jul 2026 13:28:09 -0700
Message-ID: <20260723202936.378793-5-stephen@networkplumber.org>
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

The queue stats mapping feature has been deprecated since 25.11.
Remove support in this driver for stats map.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_ethdev.c |  1 -
 drivers/net/cnxk/cnxk_ethdev.h |  6 ---
 drivers/net/cnxk/cnxk_stats.c  | 76 ++++++++++++++--------------------
 3 files changed, 31 insertions(+), 52 deletions(-)

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

