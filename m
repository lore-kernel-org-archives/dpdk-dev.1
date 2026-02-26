Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24E3FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:35:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7749F40DFB;
	Thu, 26 Feb 2026 15:34:23 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id ACA99406B7
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:13 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43770c94dfaso909255f8f.2
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116453; x=1772721253; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkH+hJG/CprY+v0cqL+7FGvP+5TwFJg5qqeWUFV8rA8=;
 b=ZBrGmWZm033t88V2M92o1y5W/tctilVFW+NjqLJVQokYsSHBWDqqIzf37nMFns3tnv
 nHxCunOo2DXkde9agrlMDOvn3Ede/p3mCVwvYuCfnjozZJD2WCbXIRrCc6NlsgA2uDFl
 K1c8GJ3XzKkDADb04ZmUzk682Nkl+JBfdF7gu72DfqntLtCoCIQ1VMHyamWhzMInvf6G
 D6BSjHA0slvA/cs4EW5zBNkw+U3sj2uKI7mK85hEp9Ujlp+vbj1epof+xmxV5isP3iEx
 5+hNQSYGrxnPG3AgQMkmAUaidyOZX2EfIDZHaw0uo9FPVIiY5U/0NRQ+RqPeIVWgw6O+
 vL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116453; x=1772721253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkH+hJG/CprY+v0cqL+7FGvP+5TwFJg5qqeWUFV8rA8=;
 b=jIwJC9W+7Bsqdj/kOtdu01/QJKyV2nGW/s0UZcvWJzbpiXQJh9Co/MoLAcA+Gb9OMT
 kVPm97Wop+FLA/d5sd4evZgCP4DEf9GbMtrUH8Zuon4KVReH2e1WuCThDumtvBZJMPjr
 FnYTXExgLOv40aNT3oV58Nwn8VI2az4tSW/gepDD9VyJApstrG8dQaD/QflcRnfcIEpY
 dHfbFRdfFNIj9ITB9ztK6egC/Ph0zdDpgXFl8fFaAKypEok/V6WLO58FN+EZeasQyJh6
 hfTnvOtAm5XrkNZkuLb0Lo+QazpkEV7YOlib+/dBKH6DDKK7SRdgxIPHs0dbg0CHdbKM
 lR4w==
X-Gm-Message-State: AOJu0YxzJ0lNEant4q7vzqqaQrt3KW6XIeDZ46HWo56wPH3j0KHSqhrj
 Zrrg8L1vc51OeZFMvMD4MJNtHdgVH0/XaKZ1N9Jng4ud9Gg7yTxiBqg73RJbog==
X-Gm-Gg: ATEYQzwfs6vb6E62o/Ko0EYBxn+uhKHcK42ma29k990KDiGxNfm/DnMDM8F0fezDkjR
 jG04TnXPZwFMIdz4e6nSfEb6+/EjWhaQ3tLOuZ/De8R9IWzbL/kXD+AsgkCF21gXo6h8PfLH5kI
 1TopqYWT4pzLvKTNrjTx9YJ8lLMtCXMDhp8zGE9i5ohfXc2axwB6ebJuxi0TiEo87/BA3vQOiig
 TgA8Gu0BnBCIGIw87Pf/DwgXPJavPiGUcmuBfAJk/bH51LA2szaupoUpUQyWrSQ42nuU3015mug
 vtVGX/PVt5e8Ih/n08PYG1E+QjHvJOVG5x9uGAUyKr/eBxZh9H11D+CD1VsLsXurnxAQuBHInJT
 jCpNm1SB0hZres4QtSZLeuWmZ/w9A3CrQGOg5RlioA1NzUs2R793IUAZwe14iQSZIIoevRmeh+B
 yopCliYmobZ7VCyMNilUO3z0NUig==
X-Received: by 2002:a05:6000:420c:b0:436:3536:f698 with SMTP id
 ffacd0b85a97d-43997f37caemr4457047f8f.30.1772116452855; 
 Thu, 26 Feb 2026 06:34:12 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:12 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 12/17] net/dpaa2: fix burst mode info to report active
 burst function
Date: Thu, 26 Feb 2026 15:33:36 +0100
Message-ID: <20260226143341.282188-13-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

