Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAD5106B504
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:47:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77B3F427A1;
	Wed, 25 Mar 2026 21:46:24 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 5962A427CC
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:46:21 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso171420f8f.2
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774471581; x=1775076381; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8QhExM7qeoiw+8FXkJyQDKs5WZHaI02Mi6KZyp+/xI=;
 b=hkR6cLCgVRrJYSUzgO/Ct8+cDTFVYq+ds5T4Deq0MYEARpWA3lcg9jxcUbgr0ZBEaH
 E9kTaMslrYo2TdprB8XWP3+2beqOBK/JncPTZog97Dpmeab+zQcGkuE3YJ+bvj06mWH4
 0k5tV3dgIIuz8KyZ+tAK2N46oii+lYE3wq/YTjDkTNSTYbWs1ZiGcqf6huiEzZ8xAvL5
 KaO0oKeGn2cLmEh7ra9nZj0sLwVHiMt50sj2zGr7MB2IPMz5UceaAh3Jwc2Gmg7lkEnL
 qlkxy77eEoe/Y4ZrLxqbtqSiYQeH4ZpjjRIO0EaOHpPK5lU/jEe3LEB8NsrL82hMAgEh
 LHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774471581; x=1775076381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R8QhExM7qeoiw+8FXkJyQDKs5WZHaI02Mi6KZyp+/xI=;
 b=AlnH+ZKwd6Xg67XZO2uC1z6N+sEvjxxCxNdBtJZSVlnuXueBnT2khPt0eEvm4DzxhL
 EbvsVXZxnXTS2AvRcEBu5+1AfnOLLSRiSZB4WkZ5rVSAvalUj82mqIXbERt8ZEKACMYZ
 x74VSEo61EpskR5Iazxf+2KKOGeIxQB1SwjdsJnnZAYFLFbpIxm7BTMTHop5E2I96dSY
 pAT9dUpF4bI7C0CSmwdzw0oBBhv6BTIw/iA1a8iYsaa4OgerK8z6Vi6cFkRA85rbwHXF
 IxugUbZYrTe0H9M+8Cgvu/TsmXX0/t7CIC+QW1QUmGYBnu33Do5mPxLwZNPrwuIn98fh
 JfJg==
X-Gm-Message-State: AOJu0YytQSbZ99cHjmS88FBfrLMmLiNuDYHc9PKzeMGhqBzVVlS1U79B
 LkUsnm/K78Cp8N+93JhbK/2YXD1tU89JRFUJTby/aIp6b4C5h6hF08MLqo8I8pYU
X-Gm-Gg: ATEYQzxa3HOOPmjE0zjlyPiUOhSbiXtwbeF2f7bAFwX4AA0CYLaC2HFEJzgx2g+SLPx
 rh+JlEku9oaBQCjS8BCgnLIIy1VIsy+EMDZYRj4L6B6THvWHATX32RtT1Uz9LO1ZVvwC/U81fcz
 vDRX5zve0uhnfNX1sONVV3/raV2r2TlPDxcifuzhtSW85KDDO1mr34VGuB9NtQUIXSZchNtUhts
 tkGcu1CbWji7kZHklemEFdZnqAx+OoC1z7rIUOWsw3tkHvKojvtBBXvQWTsSRnIQz+TAkB382/M
 s9xBRA6bfWJa9Ni6uVXXSNeSOnpqWDDI65CZqWr18SobTa7YknkSQaRlkE8DOvg4EbVNmBTD3c3
 zzjrR8YBvbjuvXs3Vg78UenUEtsNu59off95WqUwktAEMOWv5JOVWVOKL3hThaM3DmfBUiFZbQR
 R2ylDIUrEVsWcPlu1AitjkQxCFnmg=
X-Received: by 2002:a05:6000:26c1:b0:439:ca85:8848 with SMTP id
 ffacd0b85a97d-43b889a4a75mr6839228f8f.16.1774471580816; 
 Wed, 25 Mar 2026 13:46:20 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:224a:2b64:3d43:500c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df953sm2683203f8f.29.2026.03.25.13.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:46:20 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v4 12/17] net/dpaa2: fix burst mode info report
Date: Wed, 25 Mar 2026 21:45:39 +0100
Message-ID: <20260325204544.101444-13-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325204544.101444-1-maxime@leroys.fr>
References: <20260306133035.179709-1-maxime@leroys.fr>
 <20260325204544.101444-1-maxime@leroys.fr>
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
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 76 +++++++++-----------------------
 1 file changed, 22 insertions(+), 54 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index cae81d3a20..18d8bf5444 100644
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

