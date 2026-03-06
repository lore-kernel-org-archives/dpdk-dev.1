Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E16F01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:32:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10E08427BA;
	Fri,  6 Mar 2026 14:31:13 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 325C1427B7
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:11 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-439b9b190easo3739605f8f.2
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803871; x=1773408671; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkH+hJG/CprY+v0cqL+7FGvP+5TwFJg5qqeWUFV8rA8=;
 b=jgZWc61e5q1ymFtEi48/GfKZtrI0BRxUsN89G3HwJ0kwr7AWazQR4PJMKogA1xRwOc
 IFXKzi4brAxZmnaTBAKagTvaVHXSLe/tuMXhhIBU4Cc0ioLXBX+kMMIrXcDmQlxzEY9n
 xrg4DUZRe9FJDHtt5593RrPl2gus7dysDiXWO6ygFXNjRVGFgsKdJo/WaqPbOysKasw1
 LVHv3CimTXL4u/MPgxnhicyk8qBUuu8MZS7ORHsG3VXnRUIvSxb6RaXqOMt47d3MK6GB
 aFzgufvpOemJjnyHvbKYHAI6jL/kCaEiqdcCp1g+/sDfRyjV50vSG2FmhIpo8QSMlkxv
 DJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803871; x=1773408671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkH+hJG/CprY+v0cqL+7FGvP+5TwFJg5qqeWUFV8rA8=;
 b=AMTeRnwNLNaeeLdKQWd2frriLw0h62bONHOiefr1rsasTk8syzjd1QUBePcuKZz3ii
 bTtigowca+1pkjOnLdNdhRM0vfbdq2OCsAt08w5qABKI6dQaQkG2BABlkXImieNFBkOV
 IW9wTDbNpBTN0acTuUKoniB/ikhqs3VW/ub5SO61gQYMkTzdRd4Q+TGppO6L8gaQ2i1L
 KdV+0Z3R1F7f84NBYLgCR8BABVAS8nRbkzxOdcUmvyt/ubHj10mZ9bjnPtWOM69i63px
 gAteiuIZ6BlCfhZTaOhJ9ATHa/xSMisZQ5cqrMfKmGSL2KHETQRrdTkTtddOt11tAqUG
 gOLg==
X-Gm-Message-State: AOJu0YzON6L57tMbfnrEMRLpuY80sMZClpY5AinAw9scCVf3as+PIuAB
 WOTGNfvmewqPHMvsLq5RMl5DCw8W7EmK0cNiTd0LukIsXQUY8NwFGmokXWl8YjkP
X-Gm-Gg: ATEYQzy79WbSeAb1mpbrqAjNT/UO36CyXuuiWKB7ivl9TA4RSwtUUpvkBVR2kaIJdgY
 M0ljMfbY5k0IFcwYYXlhCR1Pmj/zWsMbMm2P+KyL+5/QdobQs61pgBHjbJmDpMFI/7QNMcslwzI
 nyJzsZXTE705jmAXm2pDds2HJwR0WykTOpcSFGWaToc21n1Q6K3sJ5To3kG4lTAnD2cLQGgjtLP
 zeHLpkZTs9huTLKli9Oo5GkEccmj0/E1HHuIV5Eor8Qoy/lHzNoMpXhvlHm9tNQW3FB78UEcCkb
 0k1NJxdjGpLtHFG9At4Mh3tpGf/eUzQaY75j5JAGcBerkLWQ3swyQHxsOrqevJdiFGrlzeL2Qku
 BecyJiCM9EI0aJvsP8r5AQoCSsLbqQE09ZpaysvyA4IoGphYMr7eLXqEBHWdZ11l0ZSQpO9WQZZ
 CtMQcD29COQ4ocr7FKG7cVZw4xI/eq04y9ApXQeA==
X-Received: by 2002:a5d:64c9:0:b0:439:d8e2:9a40 with SMTP id
 ffacd0b85a97d-439da86ef84mr3588538f8f.55.1772803870560; 
 Fri, 06 Mar 2026 05:31:10 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9ccsm4607696f8f.19.2026.03.06.05.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:10 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 12/17] net/dpaa2: fix burst mode info report
Date: Fri,  6 Mar 2026 14:30:30 +0100
Message-ID: <20260306133035.179709-13-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

The burst_mode_get functions were incorrectly listing configured
offload flags instead of reporting the active burst function, unlike
every other PMD (i40e, mlx5, ixgbe, hns3) which match on the burst
function pointer. On top of that, snprintf + break meant only the
first matching offload was ever shown.

Rewrite both functions to match on the actual rx_pkt_burst/tx_pkt_burst
function pointer, consistent with the rest of the codebase.

Not tested, found by code review.

Fixes: ddbc2b6658d0 ("net/dpaa2: add Tx/Rx burst mode info")
Cc: stable@dpdk.org

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 76 +++++++++-----------------------
 1 file changed, 22 insertions(+), 54 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index e58b93c564..3875164794 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -443,34 +443,18 @@ dpaa2_dev_rx_burst_mode_get(struct rte_eth_dev *dev,
 	__rte_unused uint16_t queue_id,
 	struct rte_eth_burst_mode *mode)
 {
-	struct rte_eth_conf *eth_conf = &dev->data->dev_conf;
-	int ret = -EINVAL;
-	unsigned int i;
-	const struct burst_info {
-		uint64_t flags;
-		const char *output;
-	} rx_offload_map[] = {
-			{RTE_ETH_RX_OFFLOAD_CHECKSUM, " Checksum,"},
-			{RTE_ETH_RX_OFFLOAD_SCTP_CKSUM, " SCTP csum,"},
-			{RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM, " Outer IPV4 csum,"},
-			{RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM, " Outer UDP csum,"},
-			{RTE_ETH_RX_OFFLOAD_VLAN_STRIP, " VLAN strip,"},
-			{RTE_ETH_RX_OFFLOAD_VLAN_FILTER, " VLAN filter,"},
-			{RTE_ETH_RX_OFFLOAD_TIMESTAMP, " Timestamp,"},
-			{RTE_ETH_RX_OFFLOAD_RSS_HASH, " RSS,"},
-			{RTE_ETH_RX_OFFLOAD_SCATTER, " Scattered,"}
-	};
+	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
+
+	if (pkt_burst == dpaa2_dev_prefetch_rx)
+		snprintf(mode->info, sizeof(mode->info), "%s", "Scalar Prefetch");
+	else if (pkt_burst == dpaa2_dev_rx)
+		snprintf(mode->info, sizeof(mode->info), "%s", "Scalar");
+	else if (pkt_burst == dpaa2_dev_loopback_rx)
+		snprintf(mode->info, sizeof(mode->info), "%s", "Loopback");
+	else
+		return -EINVAL;
 
-	/* Update Rx offload info */
-	for (i = 0; i < RTE_DIM(rx_offload_map); i++) {
-		if (eth_conf->rxmode.offloads & rx_offload_map[i].flags) {
-			snprintf(mode->info, sizeof(mode->info), "%s",
-				rx_offload_map[i].output);
-			ret = 0;
-			break;
-		}
-	}
-	return ret;
+	return 0;
 }
 
 static int
@@ -478,34 +462,18 @@ dpaa2_dev_tx_burst_mode_get(struct rte_eth_dev *dev,
 			__rte_unused uint16_t queue_id,
 			struct rte_eth_burst_mode *mode)
 {
-	struct rte_eth_conf *eth_conf = &dev->data->dev_conf;
-	int ret = -EINVAL;
-	unsigned int i;
-	const struct burst_info {
-		uint64_t flags;
-		const char *output;
-	} tx_offload_map[] = {
-			{RTE_ETH_TX_OFFLOAD_VLAN_INSERT, " VLAN Insert,"},
-			{RTE_ETH_TX_OFFLOAD_IPV4_CKSUM, " IPV4 csum,"},
-			{RTE_ETH_TX_OFFLOAD_UDP_CKSUM, " UDP csum,"},
-			{RTE_ETH_TX_OFFLOAD_TCP_CKSUM, " TCP csum,"},
-			{RTE_ETH_TX_OFFLOAD_SCTP_CKSUM, " SCTP csum,"},
-			{RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM, " Outer IPV4 csum,"},
-			{RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, " MT lockfree,"},
-			{RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE, " MBUF free disable,"},
-			{RTE_ETH_TX_OFFLOAD_MULTI_SEGS, " Scattered,"}
-	};
+	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
+
+	if (pkt_burst == dpaa2_dev_tx)
+		snprintf(mode->info, sizeof(mode->info), "%s", "Scalar");
+	else if (pkt_burst == dpaa2_dev_tx_ordered)
+		snprintf(mode->info, sizeof(mode->info), "%s", "Ordered");
+	else if (pkt_burst == rte_eth_pkt_burst_dummy)
+		snprintf(mode->info, sizeof(mode->info), "%s", "Dummy");
+	else
+		return -EINVAL;
 
-	/* Update Tx offload info */
-	for (i = 0; i < RTE_DIM(tx_offload_map); i++) {
-		if (eth_conf->txmode.offloads & tx_offload_map[i].flags) {
-			snprintf(mode->info, sizeof(mode->info), "%s",
-				tx_offload_map[i].output);
-			ret = 0;
-			break;
-		}
-	}
-	return ret;
+	return 0;
 }
 
 static int
-- 
2.43.0

