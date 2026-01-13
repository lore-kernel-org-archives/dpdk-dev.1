Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF6D2F346
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 17:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72A964064E;
	Tue, 13 Jan 2026 18:01:53 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 904614064C
 for <dev@dpdk.org>; Tue, 13 Jan 2026 18:01:52 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so58286965e9.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768323712;
 x=1768928512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyLHgjrgYG0DvX0RySoTb+bn1T9cMmX2MbsEenEzbZo=;
 b=ehq5baNKFybGKIpSV9WG7rVYrhkT2c2MQmdN2fz8hAp8zFhuXRtL97B89FIc5fB8aF
 nYiZ5VgTADxgwIxBAHw/G7igZ3h+eoprUtc8jQsH0mqbVbolwQxTpwxV98g4Q0oXkxsI
 dkcqWJbD/ystt7gOPEdkSbu3U75NCdk57Xb4jlda+4puBOop91T6bUDGyKEhXvCsrLl7
 yWhYAlg6ltUgR5UfkfP4BWuh0JExn55sNosZPgu7NJvCF8sRPUFDTW7HNtjnl4C+P9LB
 cPRVWB8RHSFqzjZdtn9L2qHbQXX6dRV34HLSzuFImMKcR0gKb0SwXxFzQhrtvAZtQQUi
 70Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768323712; x=1768928512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xyLHgjrgYG0DvX0RySoTb+bn1T9cMmX2MbsEenEzbZo=;
 b=Ca0uPc6kZG9Es3clenpoN/MIcKzk7EGSNxHDEnfp5nciVoSTG8Qs5bqXnnRsFNdGs6
 q0rhPkoOCJ8EJ/VF1+373rUM2Y7YxyKjWbw3W5e2QiDmj1FoDQpZpN5TdoOzgq69/wNc
 OayRA7QUjFftsuEw8qdVKHOhUu+nXXsDa5rNs9c+muwDwfozSHwsn0R5mODXJ8koxE+K
 +by91rwhrL39Ui3OlbHjNqy0VOQhl7G8puLOUxJzegRHt9YA+HmmKKAvtsI1SH5QP5gt
 M8VdcJHXFAhdkFUT9N+MORj+Fizr5w61A7M/aMI73CVlOHAvxwF3wqGL2lWfoHyu4JGy
 7vng==
X-Gm-Message-State: AOJu0YwV6fQtyrVtqaAb7zb6gDObxOxtIqOW0S2dphI15sUAAagYN50x
 pjI77ZIpKuJxUWuN7VYlstrd8vvZyMeMHT6b1uukUkVOQ9xpS4BKaCCc5UE7x9V5KvfHmWl8gwS
 cVVcb
X-Gm-Gg: AY/fxX5z7RrPv1QIgBP/NEg6AKWf9+UKiIyHt9dtUSonWhKwwierXklYC/ydsjjXf4q
 zj8GfU5HizpqnltzK7r6qMevFNgFh+gAfAU/jgRBrGtFbALp0RyYqs/bEzmDfnMlkf9DhFRezL4
 BKLDfGqDnPHSjFp88kWDYIBmKYQLObYYqWDUVCUl8dyPBCghyX6oocfGesSF17gJQgkGevS/l7O
 XTdxFq/rdpheu8CziuLdK0vnXD4/cEtVnR7tObWCkKQkuWi3HOYEpt7LiP+HCbfBF2HX3SzzUD9
 nLCZMujN2ERiYBkeVeO8e8cnFKv1hfncWaNIhY08NOcLvYunoF21+g6ysf83JgXg7RTCZUf5a7C
 Ny/Li6xsk1dPvKGvSxNjJyLGfeZzkdvxtMQ9ZNqvwgYXc8d9N3qb4kWKMQBj61ov542JWIGmN/q
 kn65fgTDsKE1TVnXJt3QDqYQieDkpTu0z/4U0WFec7gSd2hZjKrg==
X-Google-Smtp-Source: AGHT+IFtw9BF7X2qa/1F1f0hYDUc0Z8ItH21FOrwLYcykxKYJQt8I58bnSJairGk/IRwQoecszxp+A==
X-Received: by 2002:a05:600c:8b58:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-47d84b369a2mr224541965e9.22.1768323712048; 
 Tue, 13 Jan 2026 09:01:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee117e607sm4282985e9.3.2026.01.13.09.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 09:01:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Madhuker Mythri <madhukar.mythri@gmail.com>
Subject: [RFT 1/2] net/netvsc: fix RNDIS command concurrency issue
Date: Tue, 13 Jan 2026 08:58:06 -0800
Message-ID: <20260113170143.70873-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113170143.70873-1-stephen@networkplumber.org>
References: <20260113101820.60611-1-madhukar.mythri@gmail.com>
 <20260113170143.70873-1-stephen@networkplumber.org>
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

When multiple threads issue RNDIS command requests (such as device
info queries) simultaneously, command failures can occur due to
concurrent access to shared resources in the RNDIS execution path.
The RNDIS layer only supports one pending request at a time, and
hn_rndis_exec1() returns -EBUSY if a request is already in progress.

Functions like hn_rndis_get_offload(), hn_rndis_conf_offload(), and
hn_rndis_get_ptypes() were querying hardware capabilities on each
call, which could race with other RNDIS commands from different
threads.

Fix this by querying the hardware offload capabilities once during
device attach in hn_rndis_attach() and caching the result in the
hn_data structure. All subsequent accesses use the cached value,
eliminating the race condition.

If the hwcaps query fails during attach, the device initialization
fails entirely. This matches the behavior of the Linux netvsc driver
(see rndis_netdev_set_hwcaps in rndis_filter.c).

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org

Reported-by: Madhuker Mythri <madhukar.mythri@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_rndis.c | 110 ++++++++++++++++------------------
 drivers/net/netvsc/hn_var.h   |   4 ++
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c
index 7c54eebcef..ed053ee905 100644
--- a/drivers/net/netvsc/hn_rndis.c
+++ b/drivers/net/netvsc/hn_rndis.c
@@ -781,15 +781,9 @@ int hn_rndis_conf_offload(struct hn_data *hv,
 			  uint64_t tx_offloads, uint64_t rx_offloads)
 {
 	struct ndis_offload_params params;
-	struct ndis_offload hwcaps;
+	const struct ndis_offload *hwcaps = &hv->hwcaps;
 	int error;
 
-	error = hn_rndis_query_hwcaps(hv, &hwcaps);
-	if (error) {
-		PMD_DRV_LOG(ERR, "hwcaps query failed: %d", error);
-		return error;
-	}
-
 	/* NOTE: 0 means "no change" */
 	memset(&params, 0, sizeof(params));
 
@@ -803,25 +797,25 @@ int hn_rndis_conf_offload(struct hn_data *hv,
 	}
 
 	if (tx_offloads & RTE_ETH_TX_OFFLOAD_TCP_CKSUM) {
-		if (hwcaps.ndis_csum.ndis_ip4_txcsum & NDIS_TXCSUM_CAP_TCP4)
+		if (hwcaps->ndis_csum.ndis_ip4_txcsum & NDIS_TXCSUM_CAP_TCP4)
 			params.ndis_tcp4csum = NDIS_OFFLOAD_PARAM_TX;
 		else
 			goto unsupported;
 
-		if (hwcaps.ndis_csum.ndis_ip6_txcsum & NDIS_TXCSUM_CAP_TCP6)
+		if (hwcaps->ndis_csum.ndis_ip6_txcsum & NDIS_TXCSUM_CAP_TCP6)
 			params.ndis_tcp6csum = NDIS_OFFLOAD_PARAM_TX;
 		else
 			goto unsupported;
 	}
 
 	if (rx_offloads & RTE_ETH_RX_OFFLOAD_TCP_CKSUM) {
-		if ((hwcaps.ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_TCP4)
+		if ((hwcaps->ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_TCP4)
 		    == NDIS_RXCSUM_CAP_TCP4)
 			params.ndis_tcp4csum |= NDIS_OFFLOAD_PARAM_RX;
 		else
 			goto unsupported;
 
-		if ((hwcaps.ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_TCP6)
+		if ((hwcaps->ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_TCP6)
 		    == NDIS_RXCSUM_CAP_TCP6)
 			params.ndis_tcp6csum |= NDIS_OFFLOAD_PARAM_RX;
 		else
@@ -829,12 +823,12 @@ int hn_rndis_conf_offload(struct hn_data *hv,
 	}
 
 	if (tx_offloads & RTE_ETH_TX_OFFLOAD_UDP_CKSUM) {
-		if (hwcaps.ndis_csum.ndis_ip4_txcsum & NDIS_TXCSUM_CAP_UDP4)
+		if (hwcaps->ndis_csum.ndis_ip4_txcsum & NDIS_TXCSUM_CAP_UDP4)
 			params.ndis_udp4csum = NDIS_OFFLOAD_PARAM_TX;
 		else
 			goto unsupported;
 
-		if ((hwcaps.ndis_csum.ndis_ip6_txcsum & NDIS_TXCSUM_CAP_UDP6)
+		if ((hwcaps->ndis_csum.ndis_ip6_txcsum & NDIS_TXCSUM_CAP_UDP6)
 		    == NDIS_TXCSUM_CAP_UDP6)
 			params.ndis_udp6csum = NDIS_OFFLOAD_PARAM_TX;
 		else
@@ -842,38 +836,38 @@ int hn_rndis_conf_offload(struct hn_data *hv,
 	}
 
 	if (rx_offloads & RTE_ETH_TX_OFFLOAD_UDP_CKSUM) {
-		if (hwcaps.ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_UDP4)
+		if (hwcaps->ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_UDP4)
 			params.ndis_udp4csum |= NDIS_OFFLOAD_PARAM_RX;
 		else
 			goto unsupported;
 
-		if (hwcaps.ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_UDP6)
+		if (hwcaps->ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_UDP6)
 			params.ndis_udp6csum |= NDIS_OFFLOAD_PARAM_RX;
 		else
 			goto unsupported;
 	}
 
 	if (tx_offloads & RTE_ETH_TX_OFFLOAD_IPV4_CKSUM) {
-		if ((hwcaps.ndis_csum.ndis_ip4_txcsum & NDIS_TXCSUM_CAP_IP4)
+		if ((hwcaps->ndis_csum.ndis_ip4_txcsum & NDIS_TXCSUM_CAP_IP4)
 		    == NDIS_TXCSUM_CAP_IP4)
 			params.ndis_ip4csum = NDIS_OFFLOAD_PARAM_TX;
 		else
 			goto unsupported;
 	}
 	if (rx_offloads & RTE_ETH_RX_OFFLOAD_IPV4_CKSUM) {
-		if (hwcaps.ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_IP4)
+		if (hwcaps->ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_IP4)
 			params.ndis_ip4csum |= NDIS_OFFLOAD_PARAM_RX;
 		else
 			goto unsupported;
 	}
 
 	if (tx_offloads & RTE_ETH_TX_OFFLOAD_TCP_TSO) {
-		if (hwcaps.ndis_lsov2.ndis_ip4_encap & NDIS_OFFLOAD_ENCAP_8023)
+		if (hwcaps->ndis_lsov2.ndis_ip4_encap & NDIS_OFFLOAD_ENCAP_8023)
 			params.ndis_lsov2_ip4 = NDIS_OFFLOAD_LSOV2_ON;
 		else
 			goto unsupported;
 
-		if ((hwcaps.ndis_lsov2.ndis_ip6_opts & HN_NDIS_LSOV2_CAP_IP6)
+		if ((hwcaps->ndis_lsov2.ndis_ip6_opts & HN_NDIS_LSOV2_CAP_IP6)
 		    == HN_NDIS_LSOV2_CAP_IP6)
 			params.ndis_lsov2_ip6 = NDIS_OFFLOAD_LSOV2_ON;
 		else
@@ -898,51 +892,42 @@ int hn_rndis_conf_offload(struct hn_data *hv,
 int hn_rndis_get_offload(struct hn_data *hv,
 			 struct rte_eth_dev_info *dev_info)
 {
-	struct ndis_offload hwcaps;
-	int error;
-
-	memset(&hwcaps, 0, sizeof(hwcaps));
-
-	error = hn_rndis_query_hwcaps(hv, &hwcaps);
-	if (error) {
-		PMD_DRV_LOG(ERR, "hwcaps query failed: %d", error);
-		return error;
-	}
+	const struct ndis_offload *hwcaps = &hv->hwcaps;
 
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 				    RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 
-	if ((hwcaps.ndis_csum.ndis_ip4_txcsum & HN_NDIS_TXCSUM_CAP_IP4)
+	if ((hwcaps->ndis_csum.ndis_ip4_txcsum & HN_NDIS_TXCSUM_CAP_IP4)
 	    == HN_NDIS_TXCSUM_CAP_IP4)
 		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_IPV4_CKSUM;
 
-	if ((hwcaps.ndis_csum.ndis_ip4_txcsum & HN_NDIS_TXCSUM_CAP_TCP4)
+	if ((hwcaps->ndis_csum.ndis_ip4_txcsum & HN_NDIS_TXCSUM_CAP_TCP4)
 	    == HN_NDIS_TXCSUM_CAP_TCP4 &&
-	    (hwcaps.ndis_csum.ndis_ip6_txcsum & HN_NDIS_TXCSUM_CAP_TCP6)
+	    (hwcaps->ndis_csum.ndis_ip6_txcsum & HN_NDIS_TXCSUM_CAP_TCP6)
 	    == HN_NDIS_TXCSUM_CAP_TCP6)
 		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_TCP_CKSUM;
 
-	if ((hwcaps.ndis_csum.ndis_ip4_txcsum & NDIS_TXCSUM_CAP_UDP4) &&
-	    (hwcaps.ndis_csum.ndis_ip6_txcsum & NDIS_TXCSUM_CAP_UDP6))
+	if ((hwcaps->ndis_csum.ndis_ip4_txcsum & NDIS_TXCSUM_CAP_UDP4) &&
+	    (hwcaps->ndis_csum.ndis_ip6_txcsum & NDIS_TXCSUM_CAP_UDP6))
 		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_UDP_CKSUM;
 
-	if ((hwcaps.ndis_lsov2.ndis_ip4_encap & NDIS_OFFLOAD_ENCAP_8023) &&
-	    (hwcaps.ndis_lsov2.ndis_ip6_opts & HN_NDIS_LSOV2_CAP_IP6)
+	if ((hwcaps->ndis_lsov2.ndis_ip4_encap & NDIS_OFFLOAD_ENCAP_8023) &&
+	    (hwcaps->ndis_lsov2.ndis_ip6_opts & HN_NDIS_LSOV2_CAP_IP6)
 	    == HN_NDIS_LSOV2_CAP_IP6)
 		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_TCP_TSO;
 
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 				    RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
-	if (hwcaps.ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_IP4)
+	if (hwcaps->ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_IP4)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_IPV4_CKSUM;
 
-	if ((hwcaps.ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_TCP4) &&
-	    (hwcaps.ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_TCP6))
+	if ((hwcaps->ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_TCP4) &&
+	    (hwcaps->ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_TCP6))
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TCP_CKSUM;
 
-	if ((hwcaps.ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_UDP4) &&
-	    (hwcaps.ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_UDP6))
+	if ((hwcaps->ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_UDP4) &&
+	    (hwcaps->ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_UDP6))
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_UDP_CKSUM;
 
 	return 0;
@@ -951,29 +936,20 @@ int hn_rndis_get_offload(struct hn_data *hv,
 uint32_t
 hn_rndis_get_ptypes(struct hn_data *hv)
 {
-	struct ndis_offload hwcaps;
+	const struct ndis_offload *hwcaps = &hv->hwcaps;
 	uint32_t ptypes;
-	int error;
-
-	memset(&hwcaps, 0, sizeof(hwcaps));
-
-	error = hn_rndis_query_hwcaps(hv, &hwcaps);
-	if (error) {
-		PMD_DRV_LOG(ERR, "hwcaps query failed: %d", error);
-		return RTE_PTYPE_L2_ETHER;
-	}
 
 	ptypes = RTE_PTYPE_L2_ETHER;
 
-	if (hwcaps.ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_IP4)
+	if (hwcaps->ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_IP4)
 		ptypes |= RTE_PTYPE_L3_IPV4;
 
-	if ((hwcaps.ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_TCP4) ||
-	    (hwcaps.ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_TCP6))
+	if ((hwcaps->ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_TCP4) ||
+	    (hwcaps->ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_TCP6))
 		ptypes |= RTE_PTYPE_L4_TCP;
 
-	if ((hwcaps.ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_UDP4) ||
-	    (hwcaps.ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_UDP6))
+	if ((hwcaps->ndis_csum.ndis_ip4_rxcsum & NDIS_RXCSUM_CAP_UDP4) ||
+	    (hwcaps->ndis_csum.ndis_ip6_rxcsum & NDIS_RXCSUM_CAP_UDP6))
 		ptypes |= RTE_PTYPE_L4_UDP;
 
 	return ptypes;
@@ -1136,8 +1112,28 @@ hn_rndis_get_linkspeed(struct hn_data *hv)
 int
 hn_rndis_attach(struct hn_data *hv)
 {
+	int error;
+
 	/* Initialize RNDIS. */
-	return hn_rndis_init(hv);
+	error = hn_rndis_init(hv);
+	if (error)
+		return error;
+
+	/*
+	 * Query and cache hardware offload capabilities.
+	 * This avoids the need to query hwcaps on each call to
+	 * hn_rndis_get_offload(), hn_rndis_conf_offload(), or
+	 * hn_rndis_get_ptypes(), which can cause failures if
+	 * multiple threads try to query simultaneously.
+	 */
+	memset(&hv->hwcaps, 0, sizeof(hv->hwcaps));
+	error = hn_rndis_query_hwcaps(hv, &hv->hwcaps);
+	if (error) {
+		PMD_DRV_LOG(ERR, "failed to query hwcaps: %d", error);
+		return error;
+	}
+
+	return 0;
 }
 
 void
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index 17c1d5d07b..ae7f41dc94 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -9,6 +9,8 @@
 #include <rte_eal_paging.h>
 #include <ethdev_driver.h>
 
+#include "ndis.h"
+
 /*
  * Tunable ethdev params
  */
@@ -151,6 +153,8 @@ struct hn_data {
 	uint16_t	num_queues;
 	uint64_t	rss_offloads;
 
+	struct ndis_offload	hwcaps;		/* Cached hardware offload caps */
+
 	rte_spinlock_t	chim_lock;
 	struct rte_mem_resource chim_res;	/* UIO resource for Tx */
 	struct rte_bitmap *chim_bmap;		/* Send buffer map */
-- 
2.51.0

