Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C8ECA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ABA640653;
	Fri,  9 Oct 2026 01:37:02 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0AD4F4042F
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:36:59 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-88b8f0a1bcdso2783850b3a.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502618;
 x=1792107418; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dq8fwxWFx7ME5Y7mnaha+89/+ISBqPtoVOwxmiagM9o=;
 b=BgFIaQdL5FVPTL1QUnfK3jQ5tQsQiDHMaUEDSih6dKVNBRAzVEZtucyNVFqdAp4eBP
 xcqgHkOhld0ViXC7e6EcgXRF5lZk/DzyRvapRtEyXfwSeKDZrjRfZa9UldcjU+YhbcMu
 SKcejZq8FnnLNRDqGpWjF07ebHpS8d37W+RKUisiplkpshJq4A5oP84+gzs1/kQLOGwR
 nucrDchD6zax/v0jaQ90lzWztOMIZk0dfcQkI8C+2Ti3iZNVY6AJNuhXu8PW5bwTRErk
 BWWON2b4lAGwL8Jnhck4FC+5YG1s7dYGFnS7HOnDveKpw7yp8t/49rlSVortxbSP4UN8
 eKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502618; x=1792107418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dq8fwxWFx7ME5Y7mnaha+89/+ISBqPtoVOwxmiagM9o=;
 b=1m64W59ex2RMWaOYkm7srvbUeJINvJWkRkYp2nt9k1ZIOoRzrt/9gT9g5L4Q9L563n
 a23BImdkpbmxCdJoGfOkEEPPwneIrnRIj33SgeVTjByJwIVThEvkm70q14c04J3E2gWf
 U5ZcWPRzuHUXM1i0t+4vcq0ZPVEUE7uRE2yJZvJhCOq2cwJqfrd8Uaclsgk/EjJikU4b
 FvDvhUzXmz6qDluPAjCshGpHGBQSW7DPsosuJWAHKQes8agAbVtiV1cBw7nL3/dOeF2d
 K7BpTEJ2/1xK6Guuz4nYaOXxsZFcGRwR+Z6F/2rQ6zUTa/HL42TjWOP1sr9E458CWbMV
 U04g==
X-Gm-Message-State: AFq9FYKjJmlxeFmagypRkZqT9CmhCtMjXK/tv3M//UcY42wKJfoZLy+o
 s5bVvVHZbx21X79fRcMFodfDYrn+Tu/3MIWtN6ypzrk8Z3m39ccwlwa/bg79qNnmUk0V/ylUhLZ
 hm1LFVzk=
X-Gm-Gg: AYBFou2Q7GjNUIKerJe0GIhUAcE4GTprnTTBUrlqjdd16sPUdrYqcueJ0mq23G+XUwF
 dj96g3y2OO6lL0etZys77qJSwBvs3aIaGHfcGTg0AlG69I7IJ22/EeOEnNw03OwNVu6Oz5WPPXj
 S1lamoWC/2lsRmrEUFH4EElGo5GHBAtHbFXFLLlPY6SLcOxOP8gzD536TF8pLbei4Xt4gLrvcoG
 l10vcG2OAqQ+4+ENM0r4Gs0PMzGflvTZfwzvQ5w1/bQkv5wdrWCs003u3JBCyhHIaCpFIcgOArn
 IfBcYy4xJB94WgOzrE3Ehp0lSgjWjEJB2ay+uk+dhCO4sBz2i2hPHOb/4MacMX0ICSMw1q4y4dz
 Chlraihqcd6HPZZ+tgUz1rxa0ZnFRWYpIi8iJJ+LX71PgNeW1xjNASJZ1+QI1MDZg/I2GY65eNT
 j4WzCPuXoE2/b8iS7QD/ELBz+O6yDEiFlAr4Yr1sIa37MNDYLDzFIWSsyGAK8A5uCCQNIAAe/y7
 4Zf5Sroi9EUx+b8VCxp9pL0ucjebzx7rUu5Mw==
X-Received: by 2002:a05:6a00:368f:b0:888:1627:51f9 with SMTP id
 d2e1a72fcca58-897c49b28c6mr76912b3a.6.1791502618181; 
 Thu, 08 Oct 2026 16:36:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:36:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v3 06/29] drivers/baseband: convert rte_smp_rmb to fence
Date: Thu,  8 Oct 2026 16:34:59 -0700
Message-ID: <20261008233649.1260843-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

