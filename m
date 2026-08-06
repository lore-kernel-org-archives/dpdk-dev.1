Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB3BC55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF504064F;
	Thu,  6 Aug 2026 05:25:55 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 0794A40647
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:53 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so26095855ad.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986752;
 x=1786591552; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hraQ4IxZ5IoxEIrc1bfyi+WvtZ2RM1Y3cDQByR5DwFU=;
 b=Pj2muNRxg1P2C3dxKjAm4YkzOGg/upGWh9UPxe5M2PPJAaD5vKT4NGAL1YEzgs5smu
 2IP8TexYGBzfqDkOCk3MGbVCYZxlXZAt/7zMcOXyDFYukmRSHzpzNHeS0rmQdvcOYWFc
 ECDqi8zpUBc7RLYzwK4YdDlHTa6jssc0f3JGfAMUatZxhW2zn9bUfjFoGhiyqixYgnQs
 9A9XakxSjTr6QUQze9z3+UqlPDjzrihzMWk5UoCZIPsL8nRb0TDvXN0y7jLAO5YRzEoe
 gZ2IUKB6DkbKL6HUqKl1i7q0wBNh9EbMFy83mxJg96PNyY8hqB/ijGJU+2gSODX4seCg
 jfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986752; x=1786591552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hraQ4IxZ5IoxEIrc1bfyi+WvtZ2RM1Y3cDQByR5DwFU=;
 b=r2jn1txaATVRw0eyiIy9WMm52HMwPIY6s+vJkUbvY4u5qQmMjhFepM3SELncUvSzC+
 grFGKj9FMMShHihAYdo9JY8SFA7aWPRiSy4NOxbec7UQ/kNhBE9dCKc6etdUp2K58bMy
 i9T5MJW0YN7wyb5euPkmZycAw4c0qXM3ZMgM/pYVVhkKcD4RTYd4IwRP/X1RByBsGVFJ
 rPVWCGQ8fAoOq1JBmQ7gvOWnorBXwFFo8x8m3djSYvY81wsTQBwdVswAuqBm37jMGRrx
 9sflh+ObyoG+VgDBaXEEmUHb4eYIWh++VAow/v89JH0Id7zdYvJMPZ5CRxI6/PLocKpY
 /y+A==
X-Gm-Message-State: AOJu0Yzke5WMShDt79/FbGXWG2/heC0L7bRt+lwwT9AAicFPtKUGhxM1
 mH/qgIj2lZ/aOaCAE2dif/YUoKAVIsZmezYzND8FA0dAL4PKV94kd2bmZygdXyIjNZs5ks9avjv
 PyzqdVa4=
X-Gm-Gg: AR+sD10Uvnkk27JtTBwmNjdpDv/fYOQ2JgjnUfGc73+/gmdtCCn4uiCONcnipIlPkon
 T8jlN7T8tbnXUyB3w67tjnuHCE0m3QN426107CCD1uT9ThdtJwEmfCEdwfPk2aQhH1fpkm+tJtC
 fTErE3nCQSHEZzG1k6/rmLjSbbaY7C/uXm1MGQzoPDV0tzOdRZDLKQ3PO2zdBY4YkUISUvDD+wx
 hy9xngR/6PbGkvL9K7NsYdaTf8a06iRs4Qrl2VhUuu+vKm/IyT6Qi//hL0ErWdr247gsAm47Mxe
 fLUrLmkEhxPgYnLk3DuQAKH+lp32xNJuxGs52pMU6S1gwUsh7+zvAg2zdGp5XSsiWHDF4qDFiPV
 KGmKjq1H2nOaDORIy9Mb6AnnCn8xfUZ2qRtHI05nZJPrSs2NOvN53lqi/flrCXB5Hd8zZSqVoF+
 kW1sLp2U1Q+pj9nz6x1H5HuG7DVj9lbJbhjFsX/Qd/JMP2vrFyiqZnWfksCQppXvi7Wu5CM9omn
 +N0sPAH+jCiVS7fKG9mt21FuZo=
X-Received: by 2002:a05:6a20:93a1:b0:3af:6704:18ca with SMTP id
 adf61e73a8af0-3cb85f5050emr14467759637.35.1785986752198; 
 Wed, 05 Aug 2026 20:25:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>
Subject: [PATCH v7 04/24] net/ena: replace use of rte_atomicNN
Date: Wed,  5 Aug 2026 20:22:56 -0700
Message-ID: <20260806032544.21337-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

