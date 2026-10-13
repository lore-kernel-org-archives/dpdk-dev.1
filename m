Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D852CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF105406B7;
	Wed, 14 Oct 2026 00:35:03 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 45BB040682
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:01 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so1867019a91.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930900;
 x=1792535700; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dq8fwxWFx7ME5Y7mnaha+89/+ISBqPtoVOwxmiagM9o=;
 b=epgXNJM0SiIyZUPBUfyUIwnzfV1gYBN9c11MaFoRm3Z48wm5SaPwsGI+fUloRd33N8
 TaGYNu/Fe+fIq+snBHGNPRKbea6yTsx0P6XXlJcPOTSq6+RX/6B3vgEOfi9JVXF2LfCg
 YkqvHh34yGaHbqFKpatb5IY5ZRaMpHjDahcgkotRJQKlgziachYThZK/DCTY34RmpP7q
 vAYFIA3vLCcgZqm8BWH0xxqDL/Z4LRZOMfAX3MMqrf66ivcgofhgtnywWWpZdBliAVg5
 60Y5bFYXjUJykfK6/sqBXNjW0yTqR0JkYnYjY8ifhEpVAeQtR2NNKoaS5FtesH+tQLgA
 lhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930900; x=1792535700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dq8fwxWFx7ME5Y7mnaha+89/+ISBqPtoVOwxmiagM9o=;
 b=0JJeNutZQyuG8GGNNPQEOxJykFfCMJlIvDojSOuQH8mz77+Qo/S+IU2onTqtWDUiKH
 qAucn6l7LMDDn1BRO+dFHkTsLt5v55RF+ABI1Fic90CiKMEhaNbqC/ZdHyqyJmwXze5/
 nOo7LK7SwvqkiIovH7iGkJKZo9ZinQfHA7pe69JyZwhM8xZxlXbbdRXkw6dye2PdDWWk
 dO1Upet/KekcE+Qrz7/9l83jbw9H5Av/vQFUEKyU7WI1mKZiPDjO/l8cGldSSqWi1DQa
 hsrwVjE7s2rIWh9bgxGItRVBHRSrVIeq1PsNLIb3/Vf7rVbN9Ww+aF+BBwpnMJBYLVEE
 mQJQ==
X-Gm-Message-State: AFq9FYKa2z7u0Vn2eg0Fm6eKemPfGyd0ypHqc6CqH0WYFT+XlJrQ6FYS
 zHYQKDzx1zG6BrIS/tNzzIv+rNua1AhmnUyv9MiPV5k284J3HHzZyC4UfzscLCwBIKVrJS4k8iB
 vssAZ
X-Gm-Gg: AYBFou2IPjdw/H/KnKR3tp1vOybtahTJRa48PStOIQVsxTNgzNjwIrbHyBemGsm96Cm
 5Vf62I56pz1h7aCw1XPTSF6r5RnxFHlKqhSg++wOzS9rWPaH9iUepciO5ivOdq5llUI0wwbpBbN
 yjLr3zEzTtniTWlvK995weh3U6PnMNtwvDfxsyve1uMYCxMaUc1Xusuf4YGBKazy+LyaFEhi5w2
 VTmSzBQ+f9ZAzB8wnecgg9QKy7j48dHGl6zcznosXRlPukDb0JDqfMjHMblGFA+glUl4eqvnu0K
 r/vXKxV/xTFOAFfZX2TlBqgX6yRYvEqqWTDNOtZ2KhTY7i+gV2F3GPNvQ63UG7XRH4yx6cO8rcq
 fOn5Z0ejtElvyGqXIjbJRFsJ6IfLgrEu+mslOh4ADN/8wm5fbFmD07S81CIDCeeC9/dlkZd+e4f
 v5lMz2kgTv1xHDG85nsd1zxYZXLrva64PNP0ZfeklUPh4szk2JZCF+DExOBeQtPs0TXHH4trKu6
 1VOP4v01Uoxnt19R6WInf0FJ9V46GhIfp/Zymw=
X-Received: by 2002:a17:90b:2e4e:b0:39e:59a0:46b5 with SMTP id
 98e67ed59e1d1-3ab3ac9c833mr10873317a91.24.1791930900330; 
 Tue, 13 Oct 2026 15:35:00 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:34:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v4 06/29] drivers/baseband: convert rte_smp_rmb to fence
Date: Tue, 13 Oct 2026 15:22:19 -0700
Message-ID: <20261013222410.2257622-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

Replace deprecated rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c |  8 ++++----
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c       | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
index 45bd171ca7..e804be4cea 100644
--- a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
+++ b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
@@ -2662,7 +2662,7 @@ vc_5gnr_dequeue_ldpc_enc_one_op_cb(struct fpga_5gnr_queue *q, struct rte_bbdev_e
 		return -1;
 
 	/* make sure the response is read atomically */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	rte_bbdev_log_debug("DMA response desc %p", desc);
 
@@ -2691,7 +2691,7 @@ agx100_dequeue_ldpc_enc_one_op_cb(struct fpga_5gnr_queue *q, struct rte_bbdev_en
 		return -1;
 
 	/* make sure the response is read atomically. */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	rte_bbdev_log_debug("DMA response desc %p", desc);
 
@@ -2723,7 +2723,7 @@ vc_5gnr_dequeue_ldpc_dec_one_op_cb(struct fpga_5gnr_queue *q, struct rte_bbdev_d
 		return -1;
 
 	/* make sure the response is read atomically */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 #ifdef RTE_LIBRTE_BBDEV_DEBUG
 	vc_5gnr_print_dma_dec_desc_debug_info(desc);
@@ -2769,7 +2769,7 @@ agx100_dequeue_ldpc_dec_one_op_cb(struct fpga_5gnr_queue *q, struct rte_bbdev_de
 		return -1;
 
 	/* make sure the response is read atomically. */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 #ifdef RTE_LIBRTE_BBDEV_DEBUG
 	agx100_print_dma_dec_desc_debug_info(desc);
diff --git a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
index 04ac445820..cb3f29c10b 100644
--- a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
+++ b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
@@ -2093,7 +2093,7 @@ dequeue_enc_one_op_cb(struct fpga_queue *q, struct rte_bbdev_enc_op **op,
 		return -1;
 
 	/* make sure the response is read atomically */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	rte_bbdev_log_debug("DMA response desc %p", desc);
 
@@ -2123,7 +2123,7 @@ dequeue_enc_one_op_tb(struct fpga_queue *q, struct rte_bbdev_enc_op **op,
 		return -1;
 
 	/* Make sure the response is read atomically */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	/* Verify if done bit in all CBs is set */
 	cbs_in_op = desc->enc_req.cbs_in_op;
@@ -2135,7 +2135,7 @@ dequeue_enc_one_op_tb(struct fpga_queue *q, struct rte_bbdev_enc_op **op,
 	}
 
 	/* Make sure the response is read atomically */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	for (cb_idx = 0; cb_idx < cbs_in_op; ++cb_idx) {
 		desc = q->ring_addr + ((q->head_free_desc + desc_offset +
@@ -2166,7 +2166,7 @@ dequeue_dec_one_op_cb(struct fpga_queue *q, struct rte_bbdev_dec_op **op,
 		return -1;
 
 	/* make sure the response is read atomically */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 #ifdef RTE_LIBRTE_BBDEV_DEBUG
 	print_dma_dec_desc_debug_info(desc);
@@ -2201,7 +2201,7 @@ dequeue_dec_one_op_tb(struct fpga_queue *q, struct rte_bbdev_dec_op **op,
 		return -1;
 
 	/* Make sure the response is read atomically */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	/* Verify if done bit in all CBs is set */
 	cbs_in_op = desc->dec_req.cbs_in_op;
@@ -2213,7 +2213,7 @@ dequeue_dec_one_op_tb(struct fpga_queue *q, struct rte_bbdev_dec_op **op,
 	}
 
 	/* Make sure the response is read atomically */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	for (cb_idx = 0; cb_idx < cbs_in_op; ++cb_idx) {
 		desc = q->ring_addr + ((q->head_free_desc + desc_offset +
-- 
2.53.0

