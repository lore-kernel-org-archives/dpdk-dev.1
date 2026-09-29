Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485B8C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03BAA42DD5;
	Tue, 29 Sep 2026 16:04:23 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id D7AC542D97
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:16 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-8686f46e4adso2696484b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690656;
 x=1791295456; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bjQT5y7kdX+1ecizQDeaDjceYklMurgNhSlhlgApKyo=;
 b=WJf/ciCRv5vQabv5icDLo0V0rgVIhWmm22BBDPo4dwBrMCGIhlOgoYUy+u/EWkhJjk
 bGgVhZXNq7YzbZ9DTkeT6QODLFBplI9T58xc5K1bUwisCMuPvQgMbcfkMHFZtC5MaduM
 wEk+U8OhvIw5giaBbOWsr9iyJgEFbryIPQS9hRdBnbg6obG7HD1+Fb9US6X9yZQcQoGQ
 T79WfKve/QdPffnEXuFp/Gqjc/YfPV1f/JPbYVATXikR/LlZRDXy4vBCjRSdorFyY7dq
 S10shMhumADOUiVyg4XXQeSYCF1Nt46AfWeLozzT+rkc618GFA6Vb87YRY1DSEJvpb9G
 pxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690656; x=1791295456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bjQT5y7kdX+1ecizQDeaDjceYklMurgNhSlhlgApKyo=;
 b=fnbcwQkV9E2Wr0njtVvJYXVw3EsTBdK4f0so8OdsMIu6q9IAYZR7bsn/MxRCH3rHdp
 nzlkzkJmlzmFX9+QFeGyMG9K9yOoOW8MR35FJHHsVLk53bp6RsTOjsrw3P1rd2K6XpDL
 /K/FoFPeIPTCuwt18zuhkcOnPusEW4QRNEFHClCjHF30RiBl0tTLJptYLoIfpL5JQcfS
 Zd142dXMQM7dt9fqZhvvFggKp9UWMh9lFWcmWqJ/Ke7faryWSBMJkUBsQaYfbpd1BAHp
 m0AIqVyPo9d4+aHeSv8CTW1DH71cqCUdFfuC6ompw7oYgjwRvDYAxZKXebWot7HkKPNb
 GOdg==
X-Gm-Message-State: AFuF++ltFeb/Z4G8nXQViDbcdauSpRAOgFqb9xsJumpzKNP0FX09cGd0
 j6waU0OKNbmtKbky+LRnlUKD3x0pZMkgPCZ057vMaye64aaAnvq6Ta6Qofzq1ThNapNKfbG7JWX
 Wv9N6hCM=
X-Gm-Gg: AYBFou1Tr1Fv0+5nKUgDejg4bCCAQftZSJfJfGtjBjAjJwOZYHaGtu2RioBWdPtqfVu
 2h2NIl8GCUO/A6S/3qjrdl2lHg5bCZfHGzdBlvWqRmrxEUmOvVasUBETpZZ+Q1UmA6J4C64Ucbg
 HsK4wZSyLIjCWyteB0F+i5nZw/tQ1Fg+idDsanb3kAYoGtvJTaXDZho5QGVnJV5LnCQdVkKwWFn
 NCFHJWg04B5JkwAFEpeQq1Usmpq8QGyF+abPqSzX83Zzh6UOZbq6kt6eD1mm5h680TnLzPBqFyO
 kzjTu0S4vlrUM5GZmZEkWyb4xzudSxO1wUV3cEn3JJUblMYf70A/e6NaiAvhwWZwiUce+W3dXXC
 e7ngOONwYmll33rWhASiSpPFWfhxmXbe2ML3+W9IQlYXGisgkrsGRXtoaFYFFPjKrFKP2w6x80K
 m/625gFNIItR0kYzAv7GG4F8Kzu305dh0dEJOB4qhQBJrPAfVCWMwh4cB8FGhmph2rN2STFV2nY
 TJSKP511rgr8roG9rZObk7FX6N17Dc4mbRuBw==
X-Received: by 2002:a05:6a00:13a9:b0:882:956c:58e2 with SMTP id
 d2e1a72fcca58-882956c77b4mr6893274b3a.17.1790690655971; 
 Tue, 29 Sep 2026 07:04:15 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>
Subject: [PATCH v9 04/25] net/ena: replace use of rte_atomicNN
Date: Tue, 29 Sep 2026 07:01:50 -0700
Message-ID: <20260929140409.234453-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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
index ae48afcfdc..9725f77b43 100644
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
@@ -1288,9 +1279,9 @@ static int ena_stats_get(struct rte_eth_dev *dev,
 
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
@@ -1878,7 +1869,7 @@ static int ena_populate_rx_queue(struct ena_ring *rxq, unsigned int count)
 	/* get resources for incoming packets */
 	rc = rte_pktmbuf_alloc_bulk(rxq->mb_pool, mbufs, count);
 	if (unlikely(rc < 0)) {
-		rte_atomic64_inc(&rxq->adapter->drv_stats->rx_nombuf);
+		++rxq->adapter->drv_stats->rx_nombuf;
 		++rxq->rx_stats.mbuf_alloc_fail;
 		PMD_RX_LOG_LINE(DEBUG, "There are not enough free buffers");
 		return 0;
@@ -3005,7 +2996,7 @@ static uint16_t eth_ena_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
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

