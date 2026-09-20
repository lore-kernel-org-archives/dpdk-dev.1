Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E07EC982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E34240E0F;
	Sun, 20 Sep 2026 20:14:06 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 44E5940A80
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:13:59 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso1639449a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928038;
 x=1790532838; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dq8fwxWFx7ME5Y7mnaha+89/+ISBqPtoVOwxmiagM9o=;
 b=F527Dq8TEhEXV30wAsn45lITLhUT8JqGR73rzPHjOJW6/csNGEyMTh1JmF20rHsvbG
 Y/UZy4MW+ojHDrb6O8VODJIY60bFu+x4dnCsUMYFUxpFyTa6lohvtABUR9AFvVwn2s2D
 nMaT+k9Jn/s64KAo2dMAhs/PRraJqpDvXyxvxUikb1NosD8wJjBIShh5+lewyCPuVVHW
 7pMwZbZ3TWXn3mUlREklPjlikRN/riQ1fVzHMiHYl7VszG3oT/LoisGs1EXjrhA2e7ed
 LvYJEATuuzx2sURQIpMH1cf3opZYNal1z/28Vps5nGvSyvkrvWnA1G2WLDFA0Tdj4F4Y
 kEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928038; x=1790532838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dq8fwxWFx7ME5Y7mnaha+89/+ISBqPtoVOwxmiagM9o=;
 b=FsI0Zhz26gCu66mUozvHLldXuXW1PL/IV5qRI/rYxLvHOuuRg0XEtLPFAUvJvWitig
 PismA/T8ziTeYhmVezuGrgN0tW+7oGN1CzfAtnU3SoMkQG0pR3O/Bfo6UsnDjSV8SxLV
 uR1E+ZK2eIv2fxOqsBwg/5CkslwjbstiDLJtVoB+un/m4vrt+uotgVe6FzHbWYBUpKmp
 GBm3uco+MSnENAtfDLuqMEPqq9XN/k5PTVgRktHxFIA2Gi+lZ9ji9JAveitdTsbxMCo9
 KjSnMxOjFbQP/FXpgi6gB8w8N2qqwp6WUkZF+fsuj1OhTznbEpYSz2PH9ZeiX5a2+lyB
 j79A==
X-Gm-Message-State: AFuF++lfdTBdoX9xq7gVySb+6XA8MDXDF76WJRZDuIFRuFvNxmVX28nV
 PXcafnrtb55RUfUwIxfmMzZh3QvFeWxVfEfXFHz+FockUrVGUwphyJwZwWVSHygrBXBkBULrx+O
 DhiTl
X-Gm-Gg: AYBFou2KY+KglBaCtDvUuLrBuFPZX455gET5xvWIeEuJvx2w+s+jrGHMQrweQIWhjdK
 EUdSMjREWujG+flMGAC84IFF7smBuotYhKiQW7xydATlJCaRHWu74X9dzI0XXwRG72IVhufn26W
 KKuCOe0gQC/DCBJ8Wqeo5Vd6dEaYtxKU/eS0/l3SuLL5e2cNGYREBoF+RV8bNXFh8LmxWDlyn1W
 H6eu/QGTCaaN3HXFs/uIzVEZ9QwglbO6F8VHzO8m9r9UMzqAAnq+6Ce+jbqN25fdT6FssK0+N9h
 fojUknsab0EUxNhlka/iW1ljtlgT13faGSTkCILE7SB7jJ+ELkxdMVMA57n17fp29/RxJj2BCHg
 KehLD30iE1PgeNoPW7+uONI1vdJXhQBRWSvQ7vFltphWl9CpODblCJfOG4sLmQ6dX/00VG5okpX
 trBqFlMa7FF223MQeHIVMEYdKaW9ID8prEsXLgF66K/pqF3jlMAYr4w8YBgKFnJokYSwbtx4npO
 TAyVeGsx5JCBjf/Su/sKQspR6JX5gU0BjmE8+c=
X-Received: by 2002:a17:90b:3909:b0:39e:359f:8539 with SMTP id
 98e67ed59e1d1-39e54f35cf7mr18757517a91.15.1789928038356; 
 Sun, 20 Sep 2026 11:13:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:13:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v2 06/33] drivers/baseband: convert rte_smp_rmb to fence
Date: Sun, 20 Sep 2026 11:09:58 -0700
Message-ID: <20260920181347.747210-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

