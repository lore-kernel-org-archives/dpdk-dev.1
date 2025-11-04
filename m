Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35954CCFA0C
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 18:10:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0C2140A77;
	Tue,  4 Nov 2025 19:09:41 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id EDEE3406B8
 for <dev@dpdk.org>; Tue,  4 Nov 2025 19:09:39 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso4054222a12.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 10:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762279779;
 x=1762884579; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXogDDOvmK+qm2LPMaadzZxaHZp7cU7catOjpOE0zJg=;
 b=CrJUk2pSu27Iy16BdlLEdNOLZsPpN2kICFaBCvIk0plaMB1eQYEpQRi6BDLCv+TJck
 nekjwb+KDyjZmAY80Fkh7yo0ynpf4LrGN5mIQutOsD+hc8bWlbcNVntI2oqQYb2vd94Z
 pMRQHzLst3eiBK2vzT6U4tcQmSDi5S9z+gFgKIRaKerV9MeYYKz/Enp0rKnDXjg9JUA9
 oHYin//l8eBUjAKKD1PiBvLlGv50+mnZ+7o2w9kfziACG4lhTuz5yNqqbS+cFEGTU/O8
 MuEwMWBg/LWF7UGG2TN/MloTiRpSlBKrVZ+Ir6BdBH1umTjFfGjgFjghu9MQh7fFVBa0
 dzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279779; x=1762884579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXogDDOvmK+qm2LPMaadzZxaHZp7cU7catOjpOE0zJg=;
 b=OLvdstqaQu27vjN7me3aFeajav8jZUi24vUDGUOFQbiTh+d8y4k8KDf9otVN2oK33A
 XF6DR8oY6dCpN9E1UdEEHpfDMpguWCmnKaX4DHApJ5zUA4oTaZGYk2etdXDWgwlfgCOW
 Sjs1MZ2I/Z4Asy18VP6VZo1BUj6tl4dw8Ow7J6YJyoL3vp1Mh0uCnOeDm/85MjiaryY7
 OMz+JwsaIRHH1MINqF01vLL7obnWV77v6TZoSGx923DQn9dzEb26uJ2HkLm+mahPCrG2
 n0cnr9QK8sksuIY3rEzOQmvE5I6AKLHLekfH9Rmt7/fCfARvuApiI8l8LqR8eJTCF7oc
 9WnA==
X-Gm-Message-State: AOJu0YwQtBHNLtGeos66crrTdotx6DV/bmju8gzReVvQ7zWAFq3WzB6E
 29tF0H5zB7SsrwVhPYE5jx8rsUR0om+oG4rjzNd29CDpwPnqHVTI54GMjTjHuXKrPLoaE90exSe
 bMjhy
X-Gm-Gg: ASbGnctrhdlJs4CmeQ2W4nChu/x7gJ0tSCO8WabP4JcmP0icOasarVuCk5RTTNyzbX1
 kpbcaDCtH2brrn/wCXhidBrQvG6FVlgVFi+slJJc1qKxuQo7ZO8qpkv3qsfTUtAr7GeU8y3QOSA
 JhjSH5J96+Yhh0wr1qcN5bsiCpuWrF5FUHHaBtuzXaVAAOcql/9KBn9okMmUO42roEwSjbWKEos
 +x5M9vSDG3+wZcN/yfgO634Vrt2p6r7DIaXeYzAN+k9Chcc49BncUIXeB6Wjj/athadq7qlCg76
 sQHPrWiQR8/SmS2GPKoUAp8q7wQzJvIWVfLN9WOT4LJw/g5HQVGg7FwEnmVkw4d2MQDD5WvTMcQ
 Q4384/uExfFz0sZk4cv7rth5q0aVzFgMoERYbWO2islDtCG7l9RASFXFjKJHA9rYJDaU5djzgQF
 daFqm7ZpNsCgB1Kie3xLncdAGvmDyQXOiF9t1SNAw=
X-Google-Smtp-Source: AGHT+IEbrZctFLQrUsHgz7yj0H2NDIy2LbcciJLjvFYzhe/2DQoZxg/1eX4dw/MZfR4Z6RkuVYOfxw==
X-Received: by 2002:a05:6a21:6d82:b0:342:a261:e2c3 with SMTP id
 adf61e73a8af0-34f836ef191mr271069637.6.1762279778920; 
 Tue, 04 Nov 2025 10:09:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f86b0688sm3035988a12.28.2025.11.04.10.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:09:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 7/8] pdump: remove use of VLA
Date: Tue,  4 Nov 2025 10:07:11 -0800
Message-ID: <20251104180927.403355-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104180927.403355-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20251104180927.403355-1-stephen@networkplumber.org>
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
 lib/pdump/rte_pdump.c | 42 +++++++++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 11 deletions(-)

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
index 305325847c..039a4013dd 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -27,6 +27,8 @@ RTE_LOG_REGISTER_DEFAULT(pdump_logtype, NOTICE);
 /* Used for the multi-process communication */
 #define PDUMP_MP	"mp_pdump"
 
+#define PDUMP_BURST_SIZE	32
+
 /* Overly generous timeout for secondary to respond */
 #define MP_TIMEOUT_S 5
 
@@ -135,20 +137,22 @@ pdump_cb_release(struct pdump_rxtx_cbs *cbs)
 
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
 	unsigned int i;
 	int ring_enq;
 	uint16_t d_pkts = 0;
-	struct rte_mbuf *dup_bufs[nb_pkts];
+	struct rte_mbuf *dup_bufs[PDUMP_BURST_SIZE]; /* duplicated packets */
 	struct rte_ring *ring;
 	struct rte_mempool *mp;
 	struct rte_mbuf *p;
-	uint64_t rcs[nb_pkts];
+	uint64_t rcs[PDUMP_BURST_SIZE];		     /* filter result */
+
+	RTE_ASSERT(nb_pkts <= PDUMP_BURST_SIZE);
 
 	if (cbs->filter)
 		rte_bpf_exec_burst(cbs->filter, (void **)pkts, rcs, nb_pkts);
@@ -173,8 +177,7 @@ pdump_copy(uint16_t port_id, uint16_t queue,
 		 * otherwise a simple copy.
 		 */
 		if (cbs->ver == V2)
-			p = rte_pcapng_copy(port_id, queue,
-					    pkts[i], mp, cbs->snaplen,
+			p = rte_pcapng_copy(port_id, queue_id, pkts[i], mp, cbs->snaplen,
 					    direction, NULL);
 		else
 			p = rte_pktmbuf_copy(pkts[i], mp, 0, cbs->snaplen);
@@ -185,6 +188,9 @@ pdump_copy(uint16_t port_id, uint16_t queue,
 			dup_bufs[d_pkts++] = p;
 	}
 
+	if (unlikely(d_pkts == 0))
+		return;
+
 	rte_atomic_fetch_add_explicit(&stats->accepted, d_pkts, rte_memory_order_relaxed);
 
 	ring_enq = rte_ring_enqueue_burst(ring, (void *)&dup_bufs[0], d_pkts, NULL);
@@ -196,6 +202,24 @@ pdump_copy(uint16_t port_id, uint16_t queue,
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

