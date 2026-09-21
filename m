Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA987C982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2418B4278C;
	Mon, 21 Sep 2026 05:05:56 +0200 (CEST)
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com
 [209.85.217.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3BBB340EE1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 05:05:54 +0200 (CEST)
Received: by mail-vs1-f100.google.com with SMTP id
 ada2fe7eead31-7a5e4d366a5so178312137.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959954; x=1790564754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ogoOLzgC2e3gOfFoAba+iUg5sn0f24bU7TZHW7vbI5Q=;
 b=YRRhCrgJO5gW55jFUqFSXIRHO7Wm8zXZjR69t4rDRJDCU+hdRTJ5vbw4fNp73htmXf
 lCH8LAdVnQNSJdezSYJOMyVsQbzQET/rMUpY7ptlbyVVQcnc2fasqNwMR25Q2p7szdNE
 pHdGOTe6V7XDVA1TzSC3nYMpdmHV5zgc7HvaNqAdMh5KZ+wGlWbUnWxa1FPeU4o8MXZP
 qxTNkeMw2I7Ii97vX+ol9/QezHbkBhjAcGHTJdvPhLXIAKAIYhCvkrVnwFXGnGNNE80T
 nbf5dG/F7jkPipw2Miaal0npbfWlv+nZ0jsyWm21276HqaFP/aABWBEsurFlu3nOdr9Y
 x/9A==
X-Gm-Message-State: AFuF++l61/as768i9jcODnx/kzI23qLIshUJhRc/B57dwNyDZaqd1GDJ
 y1odjOe8Z7jkR1vChfiEjuAWbYE47Zh22qrFpl4ey8nMNgQbk5lokALVr15FwnTkaKvvmAV9UPS
 djxhP3pFquVS9v4DtRgy6fk3a+EzOzZPNqy0GI7Q+FLp/84VEXhBeZ51QOQoBa9pJMWTAfz8Dht
 FTF5JVu4UlISacChGyZ+eV4whkAalc/JE2A1NQ64pkbPKpFn9sXWXKcBkSJ4MlW+XeGQyJggMyp
 kCGk2Mkq/tT
X-Gm-Gg: AYBFou3cARGhVSiasGzyEZmpSiTfK4fHxGaNJ5qwKP8RsiERDbAytB/5vMV1XMaqkF2
 4/+axKvegeQe+x/y+6q61ZSHVcaS5jIb8ZUyFafc6xoUKD28PvkJkJCIMSX+/aq8SR8E3fXhSWd
 65jajnglsIkGkgqHkcqAg9MrYTDadhR0rrCoCZc/KC/nw+BQibqdx36VAEKVmyoS+fA6Gq9R8MZ
 KianrY9/UqCR4dvfX7HUvykxBhcLLL9h9PFQHbSwr7YWuh6k0KCwbxYrSPpHNcDR/SQMa3Kacmq
 Hl8mpOlOdY1QqrtzZ5tTkE0wmdCfL9yhWZCn6Xht+y/y5XrI1be3JEKBrPy8SzyH6zpVF6Su7dh
 tjRSR7+3FDl5HfMd3Fy5eEzGw3pXGqic9Kb7AXhK8ClrpoQHep1oT0FtNm00IeUCGQ/OuPLWS4m
 Pl3wn4VQi1dKHpy9Zy3BlGXsgWho/Bn76/jIQ2FNmofMm1JILk1F2n
X-Received: by 2002:a05:6102:5cc5:b0:79a:21f6:20fc with SMTP id
 ada2fe7eead31-7a55a524c55mr2930865137.10.1789959953382; 
 Sun, 20 Sep 2026 20:05:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-984c774467fsm1515161241.3.2026.09.20.20.05.52
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 20:05:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d959904658so46527175ad.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959952; x=1790564752; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ogoOLzgC2e3gOfFoAba+iUg5sn0f24bU7TZHW7vbI5Q=;
 b=eiwtzcDoPrdrX4Xg3nDy9dgC/rXhUeyVvVxz6AYGSxG3B/a2huBvQRwODbckF+f+S0
 UqZFywS51sQq20Zuo52vltTNOnjwIjJN2XOEX1btuCh6MvpgOeyA/PXs7AWT5Ecjcm3h
 PQRP9WHf2ZS2bPYeqm65rMUHoUyr92pYrRPpY=
X-Received: by 2002:a17:903:17d0:b0:2dd:c053:e665 with SMTP id
 d9443c01a7336-2ddc053e6damr80819075ad.43.1789959951798; 
 Sun, 20 Sep 2026 20:05:51 -0700 (PDT)
X-Received: by 2002:ac8:5d4f:0:b0:531:1e27:b40b with SMTP id
 d75a77b69052e-532b7343a2bmr85469621cf.40.1789959549829; 
 Sun, 20 Sep 2026 19:59:09 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532ae614009sm52101421cf.13.2026.09.20.19.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:59:08 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org, Dakota Sicher <dakota.sicher@broadcom.com>
Subject: [PATCH] net/bnxt: fix forcing of mbuf fast free
Date: Sun, 20 Sep 2026 21:02:13 -0600
Message-ID: <20260921030213.1034773-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

bnxt_dev_start_op() unconditionally enabled
RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE on every Tx queue that wasn't in
the PTP/1588 path, overriding any offload configuration the
application had explicitly requested via rte_eth_dev_configure()/
rte_eth_tx_queue_setup(). Applications that need mbuf refcnt tracking
(and therefore must keep this offload disabled) had no way to do so.

Track whether the offload was actually requested at queue-setup time
and only re-enable it in bnxt_dev_start_op() when it was.

Fixes: 5722ed1aafd2 ("net/bnxt: support timestamp parsing in Tx")
Cc: stable@dpdk.org

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 3 ++-
 drivers/net/bnxt/bnxt_txq.c    | 3 +++
 drivers/net/bnxt/bnxt_txq.h    | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 8e8ead8f61..9f5be8e24b 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1939,7 +1939,8 @@ int bnxt_dev_start_op(struct rte_eth_dev *eth_dev)
 					RTE_MIN(rte_align32pow2(txq->nb_tx_desc) / 4,
 						RTE_BNXT_MAX_TX_BURST);
 		} else {
-			txq->offloads |= RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+			if (txq->fast_free_requested)
+				txq->offloads |= RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
 			txq->tx_free_thresh =
 				RTE_MIN(rte_align32pow2(txq->nb_tx_desc) / 4,
 					RTE_BNXT_MAX_TX_BURST);
diff --git a/drivers/net/bnxt/bnxt_txq.c b/drivers/net/bnxt/bnxt_txq.c
index 03407c556a..f6b858c15b 100644
--- a/drivers/net/bnxt/bnxt_txq.c
+++ b/drivers/net/bnxt/bnxt_txq.c
@@ -177,6 +177,9 @@ int bnxt_tx_queue_setup_op(struct rte_eth_dev *eth_dev,
 		txq->tx_free_thresh = RTE_BNXT_MIN_TX_BURST;
 	txq->offloads = eth_dev->data->dev_conf.txmode.offloads |
 			tx_conf->offloads;
+	txq->fast_free_requested =
+		(txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) != 0;
+
 	/* mbuf fast free not supported for the following. Reset the bit */
 	if (bp->ieee_1588)
 		txq->offloads &= ~RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
diff --git a/drivers/net/bnxt/bnxt_txq.h b/drivers/net/bnxt/bnxt_txq.h
index ac8af91c57..ffaac986c7 100644
--- a/drivers/net/bnxt/bnxt_txq.h
+++ b/drivers/net/bnxt/bnxt_txq.h
@@ -22,6 +22,7 @@ struct bnxt_tx_queue {
 	uint8_t			wthresh; /* Write-back threshold reg */
 	uint8_t			tx_deferred_start; /* not in global dev start */
 	uint8_t			tx_started; /* TX queue is started */
+	bool			fast_free_requested;
 
 	struct bnxt		*bp;
 	int			index;
-- 
2.47.3

