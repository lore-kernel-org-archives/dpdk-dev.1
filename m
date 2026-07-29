Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72135C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A54840A70;
	Wed, 29 Jul 2026 19:57:30 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id ABB584064C
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:25 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cf452def93so1186765ad.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347845;
 x=1785952645; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jUdvw/U5e8KhTA0gWCBv8RzkGn53vupjqanCigbccV8=;
 b=v4cFlfhzquExwKkO/5EbTqEnJukV1yBpeoIhE3XZBiZZT1N6lbkt+c8aWfwPhH+Wuc
 2jJjoKPQgpEEf+/JT9OoZAXNe/5NJsuCUYQwQfQWC5H/Ke0yDaR9RBPY7wdJuGiKdkwX
 EPPBvqgnEUw5a6vtJQkB3Va1h/S8ftQjFgIMJYYgbptF5Onb05rjyYidjyZ+WaV2xmOs
 7kcw/x4DRDZoTVSnRMBTzzgauoOlcemVZhyZ9Lq1yf6lsvtnfqHjrZ9RnxC4lxCru7+Q
 q8fgCdQ5bClNSX01Xy4dvpG8jXiNjavpWWZFAHanm8izL/Q8eLvcaoyLMANIgKXqHVD5
 n4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347845; x=1785952645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jUdvw/U5e8KhTA0gWCBv8RzkGn53vupjqanCigbccV8=;
 b=gn/W8epKjWhR3Dy33l2ZUPC1bW//esw29kIjhnU4vdvtTQu3vGcNziKb6EAy4ccw0K
 wg+BoIrzvPqM/az6jplUy3FHouNg9vS6ngQIKLkO3ORFDYTE6OqKLcJWpnECFzHJCnp+
 2cGUtVC48oJb4sSrheppw68Q2ExYNj3MNB6i2OiJzXftnHY9mR8J/C58ojFXZs9uU41Y
 diX3O/VK2+1I9lUBYocvZbe3cq+8vj5bYYikAWj3Nz9Tsi7yjz+0HF7Fp4rLJguuH2AU
 d91qceYUs6/xmRFTT242hYCeZ6jAJQ1K2xh/I6b37kcBoe5cgTwSgMpvjmRD0lFSyrez
 3RDw==
X-Gm-Message-State: AOJu0Yykjq3F7shfI6t9pqbSqd4OP7cjiuUynvgyFshBdN27AOsBPVWX
 voP3u9tZn40WSbZ8WrWPPOGU5M1sy/HGJQ8ZakeUW5Er2LQtAQrqAVgoC8/fJ/pZPCViVOll4WI
 LzP4n
X-Gm-Gg: AR+sD11HTREC5FyXMx4rEC1l3bWVJUt4G1CF5E6j0NNLFIzrFIB4V6mKbHIBkXtTX47
 arUmFmFpxetiPTu1SzLq9JjVMbzDKhMN5McVJtKTEZaINOu+n9jg4o1kkQn86P/TCA3fPryo9th
 A5AlPkvbQlnpr8tXJ11yt4ts/27ri13P7CPB1aUvzshW72oVd/05OMn3bwvPxkdzI6YR16IfBNC
 1RnQFDbJmv+ZyzierPuXbWK9iKA31bvqO49KHm5fctIe/JWiwzAWqNx5J+czDd3y/n8FeXqGacS
 LM2Y0M5wgx3/+HuYTlMyvki5l29KQ3TqAo9mGjtAYZNJE1us6F8gFOdI5MftT4pI7L13vfLdve5
 Y7U9w7+SAjOr5pAjQM9MSb4f4bbt/8x1BZlImGAqFrYTPugMc8nbnrIcwx4ZxQ7PTk6Zoe8IsAf
 hh9gIwnyOm7cpaab4HH1qxevB/Un3JfO+wSHXaDFOqlVUYX1CDaqTNvZbiwqtTgU/RSZsr+r9tn
 kC49VWAEB4TKwUWNRnpKY0VQp7Rj2KflhJR2Q==
X-Received: by 2002:a05:6300:97:b0:3c6:6f25:594 with SMTP id
 adf61e73a8af0-3c8e4934b2bmr3779242637.38.1785347844824; 
 Wed, 29 Jul 2026 10:57:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [RFC 06/32] baseband: convert rte_smp_rmb to fence
Date: Wed, 29 Jul 2026 10:53:59 -0700
Message-ID: <20260729175715.165120-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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
te_atomic_thread_fence(rte_memory_order_acquire).

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

