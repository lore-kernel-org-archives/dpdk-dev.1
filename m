Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF206CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 15:48:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB9C240657;
	Thu, 23 Oct 2025 17:48:01 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 6DAE94042C
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:47:56 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-290ab379d48so9683455ad.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761234475;
 x=1761839275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iORO6NuMiYQ6NqWFf/Ov8D+OrYfNmUPOp07oEqQOf5o=;
 b=0Tw21ga+e+PwyPvq8CLqScwG77NdQ0k3gO9EgCnK4G30PuR5M2/BdTTZWqe4dnup3B
 35XTWm1MNOSCE4qD7QMVk8Ppug9SWGseuy/7X8SG82acSX3hj47xxQ9wRq8WsDfhV03Z
 XWo2DkWrKo28JjWMy/tHA+M483HdFO2iud/+skt/utr5kLkgiDvNgkqwXvmaGsZpN7ie
 Pn8qUGwsi3R9UzVvr1YZWsPYLtDkH8W+X3SpKltPYONkl0vHqKkA3DlIdnRJ3dxJ35jS
 5VSG6YvLM7LF8BagiLDVw8LBn+jNFzI8756zUbrjKl7wOVPAu/VI3sHVA3CAz1AX/xUE
 4PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761234475; x=1761839275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iORO6NuMiYQ6NqWFf/Ov8D+OrYfNmUPOp07oEqQOf5o=;
 b=gmcfQBDTnRHeJLi4LhLBw81zLkVUEPUgepU6JcH9KdGlB6WSCQoWCD74AWeHrP0+Yv
 GZ+oR84XOwipqAAYUttUQwtiGNF2MmbghOxDjK5Townzio8eY9Ry9cM/RCvfxn7nr4CX
 gYG96DbKhSfdaNBaqnykgFBrRuzSi62iVBkSvdm/CiffcEs5dynM0krDEeVDp1UAlIPZ
 3SQIc9I84QGO9McbXxrJWXWgXn3e9dBf1wFCjUvRHE5G+MMqdJidM+tlTwlURHLu9k0e
 G68L7+LRq1tEB4JUBI3SsI/xe3fsR4wxF1jrYBR6SSlEhIFASHWHrKAJkZ1B8a77eB/e
 Orbg==
X-Gm-Message-State: AOJu0YyKBYmdNlXaC2fowMOR4QkufxfNONIFTQ7EMxMj9pG+JZ56V+C3
 8rnA26JEusm9mtl/qNFhExLbBCtO7i1q5RDBIaha9n0qtGu1PQ1dRctNRSpfiMJ6qqSBzIRd90+
 kRjDjyZw=
X-Gm-Gg: ASbGncvjjHcKh+HZIgUPCEgdkPFDTekb+WuL0awhgBWkTDua3JrKni3epX6uE9neQfC
 jCvDgUUtmZI6Yah6XGQEOnaNm0fDMjD7N1YSCPA0/0s9gx4S9KK9gz/1AYUTt5RiI/ogPpqaGuv
 e9cvxZyJLnAGPQP1PV/GIq9WPeiOpz1m3bclbvFL9yXmBCnB79P6SrKnN2UX1ppH8vzqzQTLXlj
 0+T/Ok+uuGzuDShBCzBQ1Y7VeCyPEZdHXKlpnqZdjVDCStHywD1vyd5iWEDFYkr3kHC9eUSP8vi
 QRKs9YTjyUdeflkCBgpHDrYdkm0+Wot3W1+7wTHEkmXeAxuxnuAp8Mk+B8zQZXBrXx8qdkGtuF+
 RHy+IO4a5cDrifsdoVX+vv1GCROPhZC1A7ltS9HUaEGmePwfOjYThdv8+zWwXjdC+flSfkMdKTE
 jOVvzN1ZiGid+qWvZZA1rTCiscvjmMIjGJpv9Z9w==
X-Google-Smtp-Source: AGHT+IE2B0/2hnqZYEh4JHE7EOQ3RDwEzsdvcnuKl4N+WzVaVieqyQ8IpBDOlukLS+wDWF5dYoT+Xg==
X-Received: by 2002:a17:902:cec7:b0:290:c09f:a48b with SMTP id
 d9443c01a7336-290c9ca3225mr351401865ad.16.1761234475543; 
 Thu, 23 Oct 2025 08:47:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dddc0e4sm27906065ad.8.2025.10.23.08.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 08:47:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 7/8] pdump: remove use of VLA
Date: Thu, 23 Oct 2025 08:46:28 -0700
Message-ID: <20251023154748.38535-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023154748.38535-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
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

burstit
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
index 305325847c..1ab605972a 100644
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
+	unsigned int offs = 0;
+
+	do {
+		unsigned int n = RTE_MIN(nb_pkts - offs, PDUMP_BURST_SIZE);
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

