Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3AECD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:07:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFF6340685;
	Thu, 21 May 2026 20:07:20 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 62BFA40661
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:17 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2ee990e8597so15863269eec.1
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386836;
 x=1779991636; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOmExLjL+6cV+iXIJ06whzf1CVFH6WrVfDf+TJ0hwxY=;
 b=ffITP1piB+bz3DLUQpnVcuwweaZnWwUiEmKLPgKps7HkrCET41wtIvUpmRG0PrHCQD
 kuDRdEjU8gkjB26Sz07ShSs/gag8UCoqTfbgkUSTnCNGlfQAiMZVVE0nooumd990GVf8
 ltC1NvV6tQygDCvG3M8qeHca8tG/rUSnmrbHJKcRG87o2bfI2jM4HOqiBQMPT953rHHH
 Ren8vOTSi4YTJ36cGsjLt/OTCOBsT4exLZqp/UC/oj53/zq/wLRKfxuQKaFDqN+aBEWM
 sKu9Z2Qfu3NkX6lH9HVLuZdPZCcydq1fkLsC7QmeRjCmbig1YB4tnUNvtS5R3mf68tdC
 c3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386836; x=1779991636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bOmExLjL+6cV+iXIJ06whzf1CVFH6WrVfDf+TJ0hwxY=;
 b=Uvy1t2/EtMyJ9c8bDNa5t78ycalZuxP/DNA7VsMLy8h/62UVWum6nxQdkaFKkAqWfc
 Z/WGQL7X2Tfq61nj2MNh5dMD5JLRgUGihhHft6M0RK0p1DepsyoMn62AFa7oRBX2eg2n
 dji4ZKSnjaKNubRbB+JpAxX2qc+3gs9Fv2Dv3nj4JXYJ9wB+iiFFwSmKXo56EivmFoC8
 6bDAy2itbyqLZX5NeU1F+V63vEpvYLmBfNgc8CCu5F9rUaYyDaupUFhZqSalTcCRSlvo
 4PNwTtJxmtknB/d3q20mvw52xkhp/5KB9vPrHxEP/AWhUeK9uDJeS2x9qF2y/lMcWifw
 Bj3g==
X-Gm-Message-State: AOJu0YwgxXJp6Cg5u65+HJdYXbrIPM0S2lBEq0z7AIjwD0rf4hUUCzP9
 k75IO6RmILGrQpX1eE0DCHAN/Vl+SPg8/dL60qJZVv/9GERucnR1dVZRb43+I2K9AlXBeIJJHhY
 CRsDj
X-Gm-Gg: Acq92OGWnd2446A8/9/F2VjcDvj2nS8dxxGRgIj+Uy/g7RVP4lU3zkTP16P67yJ7n/S
 iRtaqF6rO03jS+dpbf+UufHGZnMh+EK352cbioj+N5lcPkTexkp0uoQFyt9oYpNEBnrsPItordR
 m4dyAD56MVjUC3hXi+qSgQ0VYF7HbysJUOTN2FHRt51p4QLEOtyp4Qxzj5A2WTlIBgSt3f4EhS8
 EWoqosjUG9i9QikzrWKqfI2Zmo034vtyzBTXkfwKb6Kx9htfITJVxMf/d/geOnXvotMu23ahpki
 3CeduYcrUHjV+QAZ2rOFLGsCC4mAGcDgaZxq5uDM0uMV0EUDn6xIToKYQFN8Ealo/aMdF2moVrX
 bBK8hJCnJfx6PcoQs1IfwVdxrOg6b/TEpiibrILsx8qQXU4Sz40zFQHs7961fIo7LvjrkQCfsJS
 6iRRjSgz4xgqa4K9HD7YlrlTimmED6aDMNefqR748tVzh7iBsLAcDv0auHLa90dw==
X-Received: by 2002:a05:7300:bb0a:b0:2ed:e15:c922 with SMTP id
 5a478bee46e88-304491425fcmr114553eec.30.1779386836442; 
 Thu, 21 May 2026 11:07:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Ron Beider <rbeider@amazon.com>, Amit Bernstein <amitbern@amazon.com>,
 Wajeeh Atrash <atrwajee@amazon.com>
Subject: [RFC v2 06/11] net/ena: replace use of rte_atomicNN
Date: Thu, 21 May 2026 11:04:18 -0700
Message-ID: <20260521180706.678377-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521180706.678377-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
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
  Unnecessary overhead to use atomic operations for error counts.

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

