Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF44FCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 21:55:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7426F4067B;
	Fri, 24 Oct 2025 23:55:11 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 4B272402AB
 for <dev@dpdk.org>; Fri, 24 Oct 2025 23:55:06 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso3230714b3a.3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761342905;
 x=1761947705; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/lPW3U3BhZbQgPNwMqODB2Xc556jbnYCR/4Oiikgqo=;
 b=DHuYMmk/wWg+gVZOS5y/lYsNXfNGqMJJzdR3wvO9EDwWuRtWWFJizuHT0eJNEHJKjQ
 wQuivKwZ18rbqrcYAFNADCdiEF+7wMIKJ+Cumeu0YBNDzxYmE/0IqEGCxThV6/Sng8U8
 dO22hlc9trff+Z+kV0xBOQjQDS1XlFpOu9qB+9wE5Vn3CE+CNOQbVC0BHOlDUU+EURK0
 obgaYB9m6YD6Q9P1y2gP7i7Rnxfps2i0Ci872pDSblp38VttSI8IKpayQ4YXQ5puLq/w
 nrk8NPC45dqaxGblixrUE1B5WMhIi2eWXjb14X+37s96S9GbIcPxsCvdGmMUOBDp/k3z
 Cl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761342905; x=1761947705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/lPW3U3BhZbQgPNwMqODB2Xc556jbnYCR/4Oiikgqo=;
 b=v/fg+FmolplDNpAIlpiLxaLy67Bc3d6tZAViejLYP+D8ez8ixxBOH66yD1KRlyfXT1
 V2WwMYB1XvNZTxjwaxOBENonyXOFPecPe4TSZfe3p1sWktqDlWkXIxvZ9hifVR89/IVq
 p7MfFiweKXQoIE30qV2bgdnC4rwUDJqSXXATEcWs+L3LCTSFLd3Z8Fr21lqU703Z8j0d
 bNolFLe/l0EbNF//CIX4Z9UqVSRBPpJQzV7V09iQzUsxTw2k3QkruCdWjjoek1zPwr7R
 IAc+Zzp9UXc9per25mNi56IC99HJt0tHFqR58ugWU/4JmfFGKwYMg9LIx1LdY64xk2xR
 /7RA==
X-Gm-Message-State: AOJu0YxSJYrhxU4v/oolg+YMgzo0z2O4dE3jg7VB5b11m6AplmUK8IUS
 evpHBSeLiAAXoxP5MFplaRK27KHdI5Bx+MwYw6SarQc9/IzOm8GywZ8Ctx6PZdKjfbfaIwkplzI
 RjdO1
X-Gm-Gg: ASbGncsxIyOOsXLADhbruc5Tpk82c8LRXm/DIvFRYszM031TtD0bSEWFvRmJR84Vxey
 fcTLuhnRLzUEpN/VDxHmzbEYRJL3YyYrpSNMgCe7Fexl7D4nzIshzi3k4upPZuzJSz78lbdU5XH
 6FT92CeuvJ0APuAGSzyOaywybeV5eyN2IYCWwhLjyMP7CGd5SDX34JLJFsVO8x6+w/l60xC2fdo
 i865jWX0+qSXG8AGxhU2JYMwhL+wEuCXH+nHL2Xpv3PfW5JRQ8k4IJUg/OtV0p/4y9KyCjsk2Lz
 JeigOwrzaBgRPqC+kIkTXVhQ8OdC7eCnTnZBbbwARjrfmho9fKKK2yADMxjy4drEaun2ts8CB+S
 lwPauFvHj/Gxnza9L+OD68icVGi3KJ3VYYmbYzQoZO48bnojz64cPh/NYakHjS/aS9x5pPt0xIW
 kRxMaNZ23825bBj5E8bOZ/Pm0Qa5VST7jkvJRmqvQsJig1Xx7DNQ==
X-Google-Smtp-Source: AGHT+IEzNSWae/A7AQNmujTdP+/vb4fpIGp7vlIrMXt/d4UCruEIX0ijDvspPCR4Fx51AsA8oS9ZMw==
X-Received: by 2002:a05:6a20:9392:b0:32b:7000:9ed with SMTP id
 adf61e73a8af0-334a8638358mr34999165637.48.1761342905453; 
 Fri, 24 Oct 2025 14:55:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a414012de3sm252530b3a.2.2025.10.24.14.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 14:55:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v5 7/8] pdump: remove use of VLA
Date: Fri, 24 Oct 2025 14:54:02 -0700
Message-ID: <20251024215456.282171-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024215456.282171-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251024215456.282171-1-stephen@networkplumber.org>
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

Replace variable length array with refactored loop so that
packets are processed in bursts of up to 32.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 lib/pdump/meson.build |  2 --
 lib/pdump/rte_pdump.c | 59 ++++++++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/lib/pdump/meson.build b/lib/pdump/meson.build
index 553dfdd5e6..da8d51b616 100644
--- a/lib/pdump/meson.build
+++ b/lib/pdump/meson.build
@@ -7,8 +7,6 @@ if is_windows
     subdir_done()
 endif
 
-cflags += no_wvla_cflag
-
 sources = files('rte_pdump.c')
 headers = files('rte_pdump.h')
 deps += ['ethdev', 'bpf', 'pcapng']
diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 305325847c..33914d8745 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -27,6 +27,8 @@ RTE_LOG_REGISTER_DEFAULT(pdump_logtype, NOTICE);
 /* Used for the multi-process communication */
 #define PDUMP_MP	"mp_pdump"
 
+#define PDUMP_BURST_SIZE	32
+
 /* Overly generous timeout for secondary to respond */
 #define MP_TIMEOUT_S 5
 
@@ -135,27 +137,22 @@ pdump_cb_release(struct pdump_rxtx_cbs *cbs)
 
 /* Create a clone of mbuf to be placed into ring. */
 static void
-pdump_copy(uint16_t port_id, uint16_t queue,
-	   enum rte_pcapng_direction direction,
-	   struct rte_mbuf **pkts, uint16_t nb_pkts,
-	   const struct pdump_rxtx_cbs *cbs,
-	   struct rte_pdump_stats *stats)
+pdump_copy_burst(uint16_t port_id, uint16_t queue_id,
+		 enum rte_pcapng_direction direction,
+		 struct rte_mbuf **pkts, uint16_t nb_pkts,
+		 const struct pdump_rxtx_cbs *cbs,
+		 struct rte_pdump_stats *stats)
 {
-	unsigned int i;
-	int ring_enq;
-	uint16_t d_pkts = 0;
-	struct rte_mbuf *dup_bufs[nb_pkts];
-	struct rte_ring *ring;
-	struct rte_mempool *mp;
-	struct rte_mbuf *p;
-	uint64_t rcs[nb_pkts];
+	uint16_t d_pkts = 0;                         /* number of duplicated packets */
+	struct rte_mbuf *dup_bufs[PDUMP_BURST_SIZE]; /* duplicated packets */
+	uint64_t rcs[PDUMP_BURST_SIZE];		     /* filter result */
+
+	RTE_ASSERT(nb_pkts <= PDUMP_BURST_SIZE);
 
 	if (cbs->filter)
 		rte_bpf_exec_burst(cbs->filter, (void **)pkts, rcs, nb_pkts);
 
-	ring = cbs->ring;
-	mp = cbs->mp;
-	for (i = 0; i < nb_pkts; i++) {
+	for (unsigned int i = 0; i < nb_pkts; i++) {
 		/*
 		 * This uses same BPF return value convention as socket filter
 		 * and pcap_offline_filter.
@@ -172,12 +169,12 @@ pdump_copy(uint16_t port_id, uint16_t queue,
 		 * If using pcapng then want to wrap packets
 		 * otherwise a simple copy.
 		 */
+		struct rte_mbuf *p;
 		if (cbs->ver == V2)
-			p = rte_pcapng_copy(port_id, queue,
-					    pkts[i], mp, cbs->snaplen,
+			p = rte_pcapng_copy(port_id, queue_id, pkts[i], cbs->mp, cbs->snaplen,
 					    direction, NULL);
 		else
-			p = rte_pktmbuf_copy(pkts[i], mp, 0, cbs->snaplen);
+			p = rte_pktmbuf_copy(pkts[i], cbs->mp, 0, cbs->snaplen);
 
 		if (unlikely(p == NULL))
 			rte_atomic_fetch_add_explicit(&stats->nombuf, 1, rte_memory_order_relaxed);
@@ -185,9 +182,13 @@ pdump_copy(uint16_t port_id, uint16_t queue,
 			dup_bufs[d_pkts++] = p;
 	}
 
+	if (d_pkts == 0)
+		return;
+
 	rte_atomic_fetch_add_explicit(&stats->accepted, d_pkts, rte_memory_order_relaxed);
 
-	ring_enq = rte_ring_enqueue_burst(ring, (void *)&dup_bufs[0], d_pkts, NULL);
+	unsigned int ring_enq
+		= rte_ring_enqueue_burst(cbs->ring, (void *)&dup_bufs[0], d_pkts, NULL);
 	if (unlikely(ring_enq < d_pkts)) {
 		unsigned int drops = d_pkts - ring_enq;
 
@@ -196,6 +197,24 @@ pdump_copy(uint16_t port_id, uint16_t queue,
 	}
 }
 
+/* Create a clone of mbuf to be placed into ring. */
+static void
+pdump_copy(uint16_t port_id, uint16_t queue_id,
+	   enum rte_pcapng_direction direction,
+	   struct rte_mbuf **pkts, uint16_t nb_pkts,
+	   const struct pdump_rxtx_cbs *cbs,
+	   struct rte_pdump_stats *stats)
+{
+	uint16_t offs = 0;
+
+	do {
+		uint16_t n = RTE_MIN(nb_pkts - offs, PDUMP_BURST_SIZE);
+
+		pdump_copy_burst(port_id, queue_id, direction, &pkts[offs], n, cbs, stats);
+		offs += n;
+	} while (offs < nb_pkts);
+}
+
 static uint16_t
 pdump_rx(uint16_t port, uint16_t queue,
 	struct rte_mbuf **pkts, uint16_t nb_pkts,
-- 
2.51.0

