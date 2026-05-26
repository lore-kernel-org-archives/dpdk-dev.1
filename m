Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C3FCD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:26:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61D634066D;
	Wed, 27 May 2026 01:25:58 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 63BE640668
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:54 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f7020a928eso16415229eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837953;
 x=1780442753; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJfco4i2nxRVgQndYbbn7k31NbDxSzkNBNUOQswufAI=;
 b=T0MYMy6ADQz8Ltaf2yqBtUq0osqFYK824dDDPcyegrm49fYmzqQHHRLz6+Xzjmzu8X
 MvxNij1thvS+vi1uhUcX7rSo8gHdo2AhFZ0QvuWs4H5xGaKqtT4XmyaLlr21FPZedq+F
 rgh07jvRbRBvR3Gckzjqs5aTsMxLlC0mzIIKFU78xtzRO3FdZndR87R6S3j93bvwDSBj
 WvrpR9aPsTNzPMynEWjQcsjtxy+fL1LEB8amo5kOdew1peM+oxdOVWooAeNSf7iV58UH
 NUwLVkS9Z3kYCAwN3/qiAxTU+DvE6mj4ihL3Pl+krw9L6jRNvTA9jr+05YANCPcRrUCP
 FNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837953; x=1780442753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aJfco4i2nxRVgQndYbbn7k31NbDxSzkNBNUOQswufAI=;
 b=VKnjaWuApZD4hg3rspXmlvht6bdGSllN4RKdj3MyWSw2tDipTBM7o0/1CxM6VCHG/0
 Nh1dT7/1VM8x+O6P/mILQf/PXAM0QTXs/GVLiKB77fFiZcoCobIvvvfZw957yzFX2bpX
 2CxqGwZRQqiAA7qp+zkWi/9Nwl0Yh4aS4IK6tpCX9QKgUG+8HgafbM/Pc+vbMwFWcBm2
 18MdHAqtX0xW6X7TdAJRjH8/vwaBqS5Uj3ISH4toApPskE0Zn8D+DCdBjy0Hws7qWpys
 lodTAdg8Nq4blJj8wXPR29djtLwkrw2sfEy+5Z/6YgU8n2CjAnR294YMKyGk+UWfr1VE
 BRYA==
X-Gm-Message-State: AOJu0Yz/7nb5fGLXNWqStORPg0xCX1L6UY9weUjU1RiHddId8te5JaQB
 dFfHs40il49cLYYoKXBPLAS5hsH79bM8L9XWNIuXE0yeAI4Rws1J+68ZfnukHbJQeaoICYSQt7r
 682Dv
X-Gm-Gg: Acq92OH5/FOedXGlw/btvLwYS1SoSPKI8VL6U9OU0rx2x0P4qnJHMd3Rj/nSXs4fOkd
 BmCHdBtqHkWv+MFCLW/ZGjyaNTSw0gxXRhYQEagF2Rz380j3NLMKadaktCZBGOHeKf91/55XBvB
 25x/LxPvL1Hh/1ZjKmqfV2nQxLWLr7SCsAQg/8gxzfGI/fOAveArcuTwbSOwe9pILyTvJ94LsdN
 +zPLdi30VH+cz48fHxzTekvaAfJ2UeZh9ZpL1nG4+6VzdL5eukpdm/JU0uzIYIyQe3IMU8ZXMKJ
 gdjzdjIjr2CDyoh9MjbqBECBwspQZ8AZiWe5thkk9DDOZ67H8Y2gZxMJKKx3AYlMsapNpgNOPsi
 9UNUpgl18mbvWqqgL4N/qpiGWIiQMF7BhjYxR8xIiRHRe0SLigWiLkRNjvUMtmf5+ts/32b84sF
 oATKkcDpUH8L/zjNzF4R89l+Unrc+3Hi/R6D6RPECVgwLsDmT4X2vUoxJHfXdc7Q==
X-Received: by 2002:a05:7301:2a24:b0:2de:aafb:feff with SMTP id
 5a478bee46e88-3044904e1dbmr9007057eec.2.1779837953445; 
 Tue, 26 May 2026 16:25:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Ron Beider <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 Wajeeh Atrash <atrwajee@amazon.com>
Subject: [PATCH v4 07/27] net/ena: replace use of rte_atomicNN
Date: Tue, 26 May 2026 16:23:57 -0700
Message-ID: <20260526232542.620966-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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
index ea4afbc75d..e9c484456c 100644
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

