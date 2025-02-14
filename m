Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920BEC021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:43:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59082406FF;
	Fri, 14 Feb 2025 18:42:44 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 3420F4067E
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:42:41 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fbfe16cc39so4402582a91.3
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739554960;
 x=1740159760; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYSDQybIA/c8C75u3xhr5U/PKuQsBlJMvzforl5sP+I=;
 b=iDHzbtxkLk5tiBNJxexeERg88V8St4WMNtkH4M0UjZT2mz8bAeKp9mQhQZZsu8xdRe
 go/XId+/K+pkxISFe0LaFJ3GwTWJ5VUz78N0CgUtWWCsQ5F33mQOLQ9eD9r6KP+BHsai
 8KhXt6f9Cw8s8lQurbHWfPPaKIWAT1atwvboc+sp/MTCoGFsfiUdkr7yxcq4cAtKeg1F
 U9rQc90L3M5vAS+gmlgsIszoVM9waNreNrVryRMnUbwfD0jvBDZA9cVj91T0CgF3tIVI
 wYPq+f00sIQPklGsqCQmbQM/DhSKxfQgk8idWgwStdmfzmE55VR/6iuo1jA4e1n6gT5d
 dD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739554960; x=1740159760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fYSDQybIA/c8C75u3xhr5U/PKuQsBlJMvzforl5sP+I=;
 b=cnKS7CLDge5hnbHh7I0UItrGhsJtpF7s8GQG7Bas4QmKXLlUkZivWdDVCcpD9gFpGe
 FVoq2JYMiAjDc0qSPis2ELhF2joaGsAYw04XLhT2mBoqDezNqy8Y8y0vUomuaskcyxbp
 UL2Xmg/CrxfLicbujBdNAw1II8/g79Y+GbQZeFUYpAnL0BVdWdIOWSiTus6mkMsUgWRZ
 hAn4xNCFQdYlyo2UJj5ANd1/cvL/MFMgYFCTHFNwIxxQmwyGzlKy3zMej2h91J7f3L8A
 8lffrYhlCggEIoMYTVGYZ+831ZwWPOXETpU6ucgkF+z98eorFUj37S0+8F3yqahHfJQZ
 pmZg==
X-Gm-Message-State: AOJu0Yz/3yZcRKVTvHcoal/IiacfzjAUr4fVh6e9tPQvWZKcEkuHrjpo
 /xJtOtYXCQQwTDQbyqDR085aSfDgbPKLTW0Sa/+95LiKR1WNzPqMtF9iy4Oq5Zm6Ma2HR34Ug7W
 5BS0=
X-Gm-Gg: ASbGncuwXi73gU3QlV8hiS/oAVSWt3tjNoUhCDtwHxH2w0AOxipjplVIVzb0TxvPv/7
 +YR5DWuTGx8Vj/TJ574uxwM5vsSxrIj9jAfkTKKBsRysa1HSx2so2c/5d2sYGNhs58kWePH65lS
 GgpBhGmv4ffWqSXqfHxtpHzDVa0sYbd079/jv29FkeGlH3BYbKLh3g1yw4DeQV40MWhX6ds9gi9
 LDtDrf/BsXkGjlVllwUm/T4XyQ06MwgcX6AWv4b2S1KPwGlAjrEWeDkkIWvGMBJUUX6gnNpG/lA
 xVKbo8hFr6Vk9imqUv4QIL783GloQD/pokvKDNuhGqrK4fejWRGQ11mGG77TOhCDwTAs
X-Google-Smtp-Source: AGHT+IHhAukBf/+XcKja8Nd1Fnruj+PhF901Y3g0kwI2Atv4WLw9QM32xRoJvcyA8u/Vw9ps19DeFA==
X-Received: by 2002:a17:90b:2dc8:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2fbf5bb1d1bmr19283779a91.7.1739554960442; 
 Fri, 14 Feb 2025 09:42:40 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f48eesm5449852a91.22.2025.02.14.09.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:42:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Apeksha Gupta <apeksha.gupta@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 5/6] net/enetfec: remove unneeded deferred start check
Date: Fri, 14 Feb 2025 09:38:58 -0800
Message-ID: <20250214174224.79142-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214174224.79142-1-stephen@networkplumber.org>
References: <20241213214929.817688-1-stephen@networkplumber.org>
 <20250214174224.79142-1-stephen@networkplumber.org>
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

Already checked in ethdev now.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/enetfec/enet_ethdev.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index 0d27b63953..7c2926409e 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -366,7 +366,7 @@ enetfec_tx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_desc,
 			unsigned int socket_id __rte_unused,
-			const struct rte_eth_txconf *tx_conf)
+			const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct enetfec_private *fep = dev->data->dev_private;
 	unsigned int i;
@@ -377,12 +377,6 @@ enetfec_tx_queue_setup(struct rte_eth_dev *dev,
 		sizeof(struct bufdesc);
 	unsigned int dsize_log2 = rte_fls_u64(dsize) - 1;
 
-	/* Tx deferred start is not supported */
-	if (tx_conf->tx_deferred_start) {
-		ENETFEC_PMD_ERR("Tx deferred start not supported");
-		return -EINVAL;
-	}
-
 	/* allocate transmit queue */
 	txq = rte_zmalloc(NULL, sizeof(*txq), RTE_CACHE_LINE_SIZE);
 	if (txq == NULL) {
@@ -442,7 +436,7 @@ enetfec_rx_queue_setup(struct rte_eth_dev *dev,
 			uint16_t queue_idx,
 			uint16_t nb_rx_desc,
 			unsigned int socket_id __rte_unused,
-			const struct rte_eth_rxconf *rx_conf,
+			const struct rte_eth_rxconf *rx_conf __rte_unused,
 			struct rte_mempool *mb_pool)
 {
 	struct enetfec_private *fep = dev->data->dev_private;
@@ -455,12 +449,6 @@ enetfec_rx_queue_setup(struct rte_eth_dev *dev,
 			sizeof(struct bufdesc);
 	unsigned int dsize_log2 = rte_fls_u64(dsize) - 1;
 
-	/* Rx deferred start is not supported */
-	if (rx_conf->rx_deferred_start) {
-		ENETFEC_PMD_ERR("Rx deferred start not supported");
-		return -EINVAL;
-	}
-
 	if (queue_idx >= ENETFEC_MAX_Q) {
 		ENETFEC_PMD_ERR("Invalid queue id %" PRIu16 ", max %d",
 			queue_idx, ENETFEC_MAX_Q);
-- 
2.47.2

