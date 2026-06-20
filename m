Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61757CD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5506340679;
	Sat, 20 Jun 2026 04:31:46 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id 927364064C
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:44 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-7fe8bc0a01bso25789867b3.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922704;
 x=1782527504; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hraQ4IxZ5IoxEIrc1bfyi+WvtZ2RM1Y3cDQByR5DwFU=;
 b=civGmnUfgclhNiVOmH/OLqtnSJIEj2LRhID/psl+k5f17TPmTS4MSeR2+5IRPRs9nZ
 /3cj2ppTmrDMO9r0SE0zT5kv31GPOOs6luuZkDZ/mlx66F3EQ5n7E17QS+w7O+yTneaH
 Xq/vx1/bPXuskn3rUz5Ti/pN9o2PEc2fn7vawpcbtjyFl1e7BrCTS2bILTT9v+rdNkRy
 dOp5s7/3/uOwxZWQQbNRpObw0NwVeIc4nx6jkOtEF71L/RD0f7ERAyI5XAaH8Zv+Oij0
 IcwXQv6cNTtVWmpfJ9wXeS3Vt/PjRQRLdIDG1dQbhIo00EWyBqhajrO0TV3//zRXq2um
 iGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922704; x=1782527504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hraQ4IxZ5IoxEIrc1bfyi+WvtZ2RM1Y3cDQByR5DwFU=;
 b=GGiQrM1mOi3zfPKzZDyb33eCsoleIPkOkCvZQzaSDjq3PGXpIwdPis85Mu+eTGnJFT
 6kwzSDReiMwQ/MMp4KIyaQv6X4IB/3KgZMnJg463j/vQcYEX/G3A/nRZVC7cBaaPUtVe
 YD+nmQZwrJg8qapMOr4j/vzQ2elsfYXI7L3BW2BCZZRJvzsM2T7TqrzJnw0DmKGhJ0ia
 QSC7SoEI/CidXy4zDaxu3SI9+JetqcXcvzN7swihBPVuHaenU8CS22EagmKlDRFfiYas
 KxJQJEIA4p2QsVK7e0mwMAetR2Dwdfci3AVwLiZwMv83zHuKSXOAKDdN973Oq45bqB8d
 eppA==
X-Gm-Message-State: AOJu0Yzs5OyLPW0yyLHfd7tSfELGCb8rjzYniqE4VocbY+IrxUNsQK3w
 gx82vOB0Y5OlbXV7gqzMw9h5s5BIfBeiFzVgXWCgD8zrbtQqNPph6pjCUjPflAoWHbQI0kLcdD0
 gDlmw
X-Gm-Gg: AfdE7ck4ACOUUpae24fSb2zghCeQYOQ3l/pDWmW2H1YwNq+hRvhyx2ZQ07mDKFaUgIj
 aAuiHGzgRPxZ4LMjWQx4hnUSS86mDuyZwFKbbWTRN8pFOhoZrXo6XIMYZwU46lqMp3NhZqWdqru
 YZRSziRI2gVsibvHVofrM4l8aszqrMaaTM6tKulZEQt9ZGCxAJC0d+FJIK+zwDSoe996B3tvSq0
 kWc/HInOekgTVBixEt5r+dJf2ZyFhqCTul+LT56bwbnaLe3PzvEpPMsAV6nTqkX3TNCjDQ8ReEe
 u7+lfGqP8CPmXaUNo6TfsCZURNon6G8oe0rR5hUVi5mM/zt3d1f3lcGOH6odej3a2aCsOlv2ayT
 eyrg6baxjC/82WiaM4w/dl32e6tpAaZxf6aYnu7fM+fOWN9nO8Fh+JTzUu9d7b9s4bTi+EVBUp9
 YxZlwk0+fX6IjIbCYRGF1laWzRyxMXGBNHAH+wWwzxaByyXi+ceUtCtrFwiwKfLg==
X-Received: by 2002:a05:690c:b01:b0:7fe:bd7:9ca5 with SMTP id
 00721157ae682-80138e0f260mr56369087b3.48.1781922703859; 
 Fri, 19 Jun 2026 19:31:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Ron Beider <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 Wajeeh Atrash <atrwajee@amazon.com>
Subject: [PATCH v5 04/24] net/ena: replace use of rte_atomicNN
Date: Fri, 19 Jun 2026 19:28:29 -0700
Message-ID: <20260620023134.42877-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

Convert the legacy rte_atomicNN operations to stdatomic.
* Remove variable ena_alloc_cnt is defined by not used.
  It is a leftover from previous memzone naming scheme.

* Convert the legacy rte_atomic32_t and rte_atomic32_{inc,dec,set,read}
  macros to C11 stdatomic equivalents.
  Memory ordering is kept at seq_cst,
  matching the implicit ordering of the legacy API.

* Do not use rte_atomic for statistics
 The DPDK PMD model is that statistics do not have to be exact
 in face of contention.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ena/base/ena_plat_dpdk.h | 14 +++++++++-----
 drivers/net/ena/ena_ethdev.c         | 21 ++++++---------------
 drivers/net/ena/ena_ethdev.h         |  7 +++----
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index c84420de22..83b354d9da 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -40,7 +40,7 @@ typedef uint64_t dma_addr_t;
 #endif
 
 #define ENA_PRIu64 PRIu64
-#define ena_atomic32_t rte_atomic32_t
+typedef RTE_ATOMIC(int32_t) ena_atomic32_t;
 #define ena_mem_handle_t const struct rte_memzone *
 
 #define SZ_256 (256U)
@@ -267,10 +267,14 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 #define ENA_REG_READ32(bus, reg)					       \
 	__extension__ ({ (void)(bus); rte_read32_relaxed((reg)); })
 
-#define ATOMIC32_INC(i32_ptr) rte_atomic32_inc(i32_ptr)
-#define ATOMIC32_DEC(i32_ptr) rte_atomic32_dec(i32_ptr)
-#define ATOMIC32_SET(i32_ptr, val) rte_atomic32_set(i32_ptr, val)
-#define ATOMIC32_READ(i32_ptr) rte_atomic32_read(i32_ptr)
+#define ATOMIC32_INC(i32_ptr)							\
+	rte_atomic_fetch_add_explicit((i32_ptr), 1, rte_memory_order_seq_cst)
+#define ATOMIC32_DEC(i32_ptr)							\
+	rte_atomic_fetch_sub_explicit((i32_ptr), 1, rte_memory_order_seq_cst)
+#define ATOMIC32_SET(i32_ptr, val)						\
+	rte_atomic_store_explicit((i32_ptr), (val), rte_memory_order_seq_cst)
+#define ATOMIC32_READ(i32_ptr)							\
+	rte_atomic_load_explicit((i32_ptr), rte_memory_order_seq_cst)
 
 #define msleep(x) rte_delay_us(x * 1000)
 #define udelay(x) rte_delay_us(x)
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index ad2ac6dbbf..e874f264b4 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -121,12 +121,6 @@ struct ena_stats {
  */
 #define ENA_DEVARG_ENABLE_FRAG_BYPASS "enable_frag_bypass"
 
-/*
- * Each rte_memzone should have unique name.
- * To satisfy it, count number of allocation and add it to name.
- */
-rte_atomic64_t ena_alloc_cnt;
-
 static const struct ena_stats ena_stats_global_strings[] = {
 	ENA_STAT_GLOBAL_ENTRY(wd_expired),
 	ENA_STAT_GLOBAL_ENTRY(dev_start),
@@ -1249,10 +1243,7 @@ static void ena_stats_restart(struct rte_eth_dev *dev)
 {
 	struct ena_adapter *adapter = dev->data->dev_private;
 
-	rte_atomic64_init(&adapter->drv_stats->ierrors);
-	rte_atomic64_init(&adapter->drv_stats->oerrors);
-	rte_atomic64_init(&adapter->drv_stats->rx_nombuf);
-	adapter->drv_stats->rx_drops = 0;
+	memset(adapter->drv_stats, 0, sizeof(struct ena_driver_stats));
 }
 
 static int ena_stats_get(struct rte_eth_dev *dev,
@@ -1289,9 +1280,9 @@ static int ena_stats_get(struct rte_eth_dev *dev,
 
 	/* Driver related stats */
 	stats->imissed = adapter->drv_stats->rx_drops;
-	stats->ierrors = rte_atomic64_read(&adapter->drv_stats->ierrors);
-	stats->oerrors = rte_atomic64_read(&adapter->drv_stats->oerrors);
-	stats->rx_nombuf = rte_atomic64_read(&adapter->drv_stats->rx_nombuf);
+	stats->ierrors = adapter->drv_stats->ierrors;
+	stats->oerrors = adapter->drv_stats->oerrors;
+	stats->rx_nombuf = adapter->drv_stats->rx_nombuf;
 
 	/* Queue statistics */
 	if (qstats) {
@@ -1887,7 +1878,7 @@ static int ena_populate_rx_queue(struct ena_ring *rxq, unsigned int count)
 	/* get resources for incoming packets */
 	rc = rte_pktmbuf_alloc_bulk(rxq->mb_pool, mbufs, count);
 	if (unlikely(rc < 0)) {
-		rte_atomic64_inc(&rxq->adapter->drv_stats->rx_nombuf);
+		++rxq->adapter->drv_stats->rx_nombuf;
 		++rxq->rx_stats.mbuf_alloc_fail;
 		PMD_RX_LOG_LINE(DEBUG, "There are not enough free buffers");
 		return 0;
@@ -3014,7 +3005,7 @@ static uint16_t eth_ena_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		if (unlikely(mbuf->ol_flags &
 				(RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD)))
-			rte_atomic64_inc(&rx_ring->adapter->drv_stats->ierrors);
+			++rx_ring->adapter->drv_stats->ierrors;
 
 		rx_pkts[completed] = mbuf;
 		rx_ring->rx_stats.bytes += mbuf->pkt_len;
diff --git a/drivers/net/ena/ena_ethdev.h b/drivers/net/ena/ena_ethdev.h
index 3a66d79384..b204b07767 100644
--- a/drivers/net/ena/ena_ethdev.h
+++ b/drivers/net/ena/ena_ethdev.h
@@ -6,7 +6,6 @@
 #ifndef _ENA_ETHDEV_H_
 #define _ENA_ETHDEV_H_
 
-#include <rte_atomic.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
@@ -225,9 +224,9 @@ enum ena_adapter_state {
 };
 
 struct ena_driver_stats {
-	rte_atomic64_t ierrors;
-	rte_atomic64_t oerrors;
-	rte_atomic64_t rx_nombuf;
+	u64 ierrors;
+	u64 oerrors;
+	u64 rx_nombuf;
 	u64 rx_drops;
 };
 
-- 
2.53.0

