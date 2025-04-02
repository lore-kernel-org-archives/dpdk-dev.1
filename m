Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10881C36018
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EED7B40672;
	Thu,  3 Apr 2025 01:25:04 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 0030B40672
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:25:02 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-6e8f254b875so3090846d6.1
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636302;
 x=1744241102; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIM/0S9yPTd0Zhh6UmLK87cRYcdx4V4RV67p+4bEF5w=;
 b=Sn8XrvrT7NUGd0zoi8gdSqIi976VQIqUXlCdSzHsVP+70Toz6/fWjAX0IJKZZbcqHL
 biiKN6uIJcmQWLqpiCT7j9NU8zuJybpdsL1/oO9JjSReEdzWoANtwx2lusNWJFR0hmSq
 Ev3npPrmav6hsrJKGvIkYVMl8cIxHyfteH2fPwwXF3SSKa9tclxbZKMWKz4uL5kRN2KD
 irj1KKl0RHSAjNIifYyuC9t7TIR9pe/C+Lx7YocggqdOXLRyUmpg9k0Sdz13agD7Z4M/
 tI+ZUg8v2k2cp3PoNRXOWqoejtwLa3+ZZonVWhJyIxHFQSlxLy0L3yOn4loHeYzi6GtZ
 NmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636302; x=1744241102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GIM/0S9yPTd0Zhh6UmLK87cRYcdx4V4RV67p+4bEF5w=;
 b=u1b3ZX0ZHe2utgdo6jJpqtSFyl6egVBodb61CHVSwDSL6p1EXFfnFWU2x3C5pNbt+1
 XsV0FjOgfI5ZMtAiBpFVGNZ+kPJqubykKUo9B3JDAsYWCw5unCm0h6dHDD4XtJwNWDMM
 ID3gIzC0G8BpwNb6ZFIRKEmXk8212Z7F3ak+ZPcFOSAzEGQ6qf1LS+enR4dyN1a2s3OX
 ntt+3VKf8SQO7cyRoZl5Qgkflj4bdh6y2nbcRwI+qAheBwlEu8GE2sAsCubV/WQlozIn
 gw0hPn3t2H9t17fztC5IDewBiznbFiKrJc21WYJ/6pf+1kFQ/P1/gAYa4mEbu5ck3neG
 OfJg==
X-Gm-Message-State: AOJu0YwvPwi5qdRU4G5HUf8XMamQ1fDTyakHQ7kUbMW1M9Yj+8SII6m/
 TurR8LU4rKedEP/F6/4V88s2MFCdIDWrta5ni8TcSPFLV1zIAHBNQxuXg9jFcnJtcvNeIsjeW1B
 4
X-Gm-Gg: ASbGncv+usyU0tRyeg7w14uqFSl+EOaTJSqgqGNNsR13iLjAgftF/9UbFaPLrVSA3dz
 /tHUnP+vU6BTsmEGCJA3QxKyjW9oAU+f2guM4sd20OemVninjjcW7EDquacwaNBPQs9Zeop8TwJ
 D4ffbrVGsdxj9jk+lxZx9iM5/yC2DmD0CKhkPQIl5L3EPVEmxaMivqWIc+g7Xq0p/mUhOheqNFq
 e/+140ff9jNpJvpu0pvxQCMB7GZKU6WdJHmMkzEQAVnw6jHYl2JyxPNCMH+7pyBZ7FksHRrGxTH
 F4TqxjWp//3TtjyUEzx1O5KtzxVE7Nr1WuPO2u+96JTdEPM9hd0d6J3PdjhR/q8yXEJ9U70WrdA
 oz5VQgzRD4Dl9Wxac+g==
X-Google-Smtp-Source: AGHT+IFC4aPrtxowwXVBedhlsMkaaxeq9TFdnqX3DsMbiCUR3SQeSVkkWlz3YWY1qO52VfxXLpcKwQ==
X-Received: by 2002:a05:6214:2a8a:b0:6e6:5f28:9874 with SMTP id
 6a1803df08f44-6ef02baf819mr65965816d6.2.1743636302139; 
 Wed, 02 Apr 2025 16:25:02 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:25:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v12 09/10] lib: replace use of sanity check in comments and
Date: Wed,  2 Apr 2025 16:23:19 -0700
Message-ID: <20250402232441.440346-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
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

Sanity check is on the Tier 2 non-inclusive list.
Replace or remove it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_timer.c   | 2 +-
 lib/graph/graph.c           | 2 +-
 lib/graph/graph_stats.c     | 2 +-
 lib/graph/node.c            | 2 +-
 lib/jobstats/rte_jobstats.c | 6 +++---
 lib/metrics/rte_metrics.c   | 2 +-
 lib/pcapng/rte_pcapng.c     | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/eal/linux/eal_timer.c b/lib/eal/linux/eal_timer.c
index 489732c116..92514af9f5 100644
--- a/lib/eal/linux/eal_timer.c
+++ b/lib/eal/linux/eal_timer.c
@@ -247,7 +247,7 @@ get_tsc_freq(uint64_t arch_hz)
 		tsc_hz = (uint64_t)((end - start)/secs);
 
 		if (arch_hz) {
-			/* Make sure we're within 1% for sanity check */
+			/* Make sure we're within 1% */
 			if (RTE_MAX(arch_hz, tsc_hz) - RTE_MIN(arch_hz, tsc_hz) > arch_hz / 100)
 				return arch_hz;
 
diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index dff8e690a8..3e76e8f789 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -389,7 +389,7 @@ rte_graph_create(const char *name, struct rte_graph_param *prm)
 
 	graph_spinlock_lock();
 
-	/* Check arguments sanity */
+	/* Check argument validity */
 	if (prm == NULL)
 		SET_ERR_JMP(EINVAL, fail, "Param should not be NULL");
 
diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index 0bbbd9fb7c..4eaf03db69 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -385,7 +385,7 @@ rte_graph_cluster_stats_create(const struct rte_graph_cluster_stats_param *prm)
 	const char *pattern;
 	rte_graph_t i;
 
-	/* Sanity checks */
+	/* Validate arguments */
 	if (!rte_graph_has_stats_feature())
 		SET_ERR_JMP(EINVAL, fail, "Stats feature is not enabled");
 
diff --git a/lib/graph/node.c b/lib/graph/node.c
index 63db629da8..a9a7fffbd9 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -68,7 +68,7 @@ __rte_node_register(const struct rte_node_register *reg)
 
 	graph_spinlock_lock();
 
-	/* Check sanity */
+	/* Check argument validity */
 	if (reg == NULL || reg->process == NULL) {
 		rte_errno = EINVAL;
 		goto fail;
diff --git a/lib/jobstats/rte_jobstats.c b/lib/jobstats/rte_jobstats.c
index af565a14ea..1c4b280c95 100644
--- a/lib/jobstats/rte_jobstats.c
+++ b/lib/jobstats/rte_jobstats.c
@@ -124,7 +124,7 @@ rte_jobstats_start(struct rte_jobstats_context *ctx, struct rte_jobstats *job)
 {
 	uint64_t now;
 
-	/* Some sanity check. */
+	/* Check validity of arguments. */
 	if (unlikely(ctx == NULL || job == NULL || job->context != NULL))
 		return -EINVAL;
 
@@ -144,7 +144,7 @@ rte_jobstats_abort(struct rte_jobstats *job)
 	struct rte_jobstats_context *ctx;
 	uint64_t now, exec_time;
 
-	/* Some sanity check. */
+	/* Check that arguments are valid */
 	if (unlikely(job == NULL || job->context == NULL))
 		return -EINVAL;
 
@@ -165,7 +165,7 @@ rte_jobstats_finish(struct rte_jobstats *job, int64_t job_value)
 	uint64_t now, exec_time;
 	int need_update;
 
-	/* Some sanity check. */
+	/* Check arguments */
 	if (unlikely(job == NULL || job->context == NULL))
 		return -EINVAL;
 
diff --git a/lib/metrics/rte_metrics.c b/lib/metrics/rte_metrics.c
index 0ccdbabc04..f60d4f3f6e 100644
--- a/lib/metrics/rte_metrics.c
+++ b/lib/metrics/rte_metrics.c
@@ -120,7 +120,7 @@ rte_metrics_reg_names(const char * const *names, uint16_t cnt_names)
 	uint16_t idx_name;
 	uint16_t idx_base;
 
-	/* Some sanity checks */
+	/* Some consistency checks */
 	if (cnt_names < 1 || names == NULL)
 		return -EINVAL;
 	for (idx_name = 0; idx_name < cnt_names; idx_name++)
diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 16485b27cb..ec12606291 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -620,7 +620,7 @@ rte_pcapng_write_packets(rte_pcapng_t *self,
 		struct pcapng_enhance_packet_block *epb;
 		uint64_t cycles, timestamp;
 
-		/* sanity check that is really a pcapng mbuf */
+		/* Check that is really a pcapng mbuf */
 		epb = rte_pktmbuf_mtod(m, struct pcapng_enhance_packet_block *);
 		if (unlikely(epb->block_type != PCAPNG_ENHANCED_PACKET_BLOCK ||
 			     epb->block_length != rte_pktmbuf_pkt_len(m))) {
-- 
2.47.2

