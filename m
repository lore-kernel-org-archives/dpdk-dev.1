Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA084C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E40440E20;
	Fri, 21 Aug 2026 21:31:31 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 9838040E20
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:28 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-848761b5897so572807b3a.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340688;
 x=1787945488; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=stRrWZoQEX4kr1F3klxIwmXy5/C++KOH3Lkgvgd4s2I=;
 b=O57xgF0oIa2QFqDWZgz/ZjnlvcXfCd8OkKJ5NdZ3WBBVl9qv/vFt3owcxxJgKzlrzy
 8IjxrbQZa1rboNZOLRAHd3jRU8hQPUw7xmw/l4ZTrIVrhDVFHBnwD0VB2goNdNoaXK5/
 fS9aWISAZ5/25STS78+/3FMu0lBn74A+RUFwtDgAtN4WFNKhQFC4M8NuGzl2gxp6h6OK
 Gv2pa33DJsfv0hWgwx8wIWF2XfV8x558xR9xgC+gjVjHlIppimrBnX1vlp6SlSKIB6LQ
 HF64DJxEhv8CvSm1ZUerM4doZK2B5vuE28HH3eqgYn1dk29paIvVlVo4HtxNgEfBz7yl
 AGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340688; x=1787945488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=stRrWZoQEX4kr1F3klxIwmXy5/C++KOH3Lkgvgd4s2I=;
 b=fNZ0ZuYlKVPWgE3qYQ2aHRvABKpJS7wnBRemv/AXBM8i+ooAJy8DprGsF9VTa7Q2Do
 y9UtgoNUaDis3VS1AHoxTaCmJAn6f7YL4zpMh+V87zHt1iowefOGc5dSsFlFwXPmhDKI
 yKnmXV1CdsjXV4NFH/dzp0HS6MqiGtE9sXEot2+wJwnVy45Mr2oNi1ctCA3Gd7ngvcgc
 eVqq7zW7/9r+IWVv3787kZjsMei61XSSGOu/A8uBkPW2UiuH6qEL6IVE8r4wAGvDIDjL
 f+1toES+C6Kgmjis/8Qw7WByZCxTtwRR7HkVvHoK7LbUkR3AOrXekeVavnthcwyQI7Z/
 6xdQ==
X-Gm-Message-State: AFuF++lJ9sEQLKvLMeKNQC5M179wyCVHGcXwfG4sGcG1yNMU00juo8hF
 JCOg4ej4n0BMFWoFVyTkKMjLkTtPfnTgYyQOyxjJy39d0WRXxRwfXH3L3szJ1S4I153ygcaX46+
 L+7dMMH4=
X-Gm-Gg: AR+sD12xeaZubOz+oXhXDrael+4uxmDrgsLK7oFBH1NNo6egD6cmP66Cr8UrZyzmviA
 rj9ZkIlKqEJqbK/o04ibWSZu2k9mN3cqFCHkmWYOcoJU2SQcLiZ+M0kKo893sTPitv6DQfgaygI
 aW89Lhwl+F9XOIgSW1PyxZ3waIC7yxZBrsoN+ZnCjmrSzAA46laE5o971Bd8NOEUerIPVFTWeiE
 UbIuo8qiLkfKVMSg5un5LP90dTT+4cw4WwJIWg7qcJfGD3Yd+QW/R0iDka0CLaiZIeiJVZs2B2+
 eHP/wDSCku5UTJiZyxrPw5D90H8vrG0r9UG65rbbiSXFyIM9PIVfS9SI5YwnhqIrPThG5Z/axG0
 DCM8VWEePS4UaBWMFE/QwbKx2QzkmoO4u5PLaONUjPKmrBJgAminw6igeXGZDeAEcIBKPWrqo33
 To5ICVn78iy7fuNZpDS4+hsLTTBmUavg4BVrudg4OlOzHEPUZIiX7uXuFgDoYF8KzRFOiGKaHNB
 zreyxaGwspC2Hpy49ZGegWlnCA=
X-Received: by 2002:a05:6a21:a96:b0:3c3:954d:278d with SMTP id
 adf61e73a8af0-3cd3009cf0emr18107258637.9.1787340687744; 
 Fri, 21 Aug 2026 12:31:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v2 60/68] baseband/acc: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:55 -0700
Message-ID: <20260821192646.146382-61-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Using rte_memcpy is not needed here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/baseband/acc/rte_acc100_pmd.c |  7 ++++---
 drivers/baseband/acc/rte_vrb_pmd.c    | 21 ++++++++++-----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
index cbcacc7aa3..7261ac937d 100644
--- a/drivers/baseband/acc/rte_acc100_pmd.c
+++ b/drivers/baseband/acc/rte_acc100_pmd.c
@@ -2890,7 +2890,7 @@ enqueue_ldpc_dec_one_op_cb(struct acc_queue *q, struct rte_bbdev_dec_op *op,
 		dec->q_m = 1;
 		dec->cb_params.e = dec->n_cb - dec->n_filler;
 		dec->rv_index = 0;
-		rte_memcpy(in, q->derm_buffer, dec->cb_params.e);
+		memcpy(in, q->derm_buffer, dec->cb_params.e);
 		/* Capture counter when pre-processing is used */
 		q_data->queue_stats.enqueue_warn_count++;
 		#else
@@ -2988,7 +2988,8 @@ enqueue_ldpc_dec_one_op_tb(struct acc_queue *q, struct rte_bbdev_dec_op *op,
 		desc = acc_desc(q, total_enqueued_cbs);
 		desc->req.data_ptrs[0].address = q->ring_addr_iova + fcw_offset;
 		desc->req.data_ptrs[0].blen = ACC_FCW_LD_BLEN;
-		rte_memcpy(&desc->req.fcw_ld, &desc_first->req.fcw_ld, ACC_FCW_LD_BLEN);
+		memcpy(&desc->req.fcw_ld, &desc_first->req.fcw_ld,
+		       ACC_FCW_LD_BLEN);
 		ret = acc100_dma_desc_ld_fill(op, &desc->req, &input,
 				h_output, &in_offset, &h_out_offset,
 				&h_out_length,
@@ -4266,7 +4267,7 @@ acc100_configure(const char *dev_name, struct rte_acc_conf *conf)
 	struct acc_device *d = bbdev->data->dev_private;
 
 	/* Store configuration */
-	rte_memcpy(&d->acc_conf, conf, sizeof(d->acc_conf));
+	memcpy(&d->acc_conf, conf, sizeof(d->acc_conf));
 
 	value = acc_reg_read(d, HwPfPcieGpexBridgeControl);
 	bool firstCfg = (value != ACC100_CFG_PCI_BRIDGE);
diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index 1f85e33462..cb3ef51fcb 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -2593,15 +2593,13 @@ vrb_enqueue_ldpc_dec_one_op_cb(struct acc_queue *q, struct rte_bbdev_dec_op *op,
 		uint8_t *prev_ptr = (uint8_t *) prev_desc;
 		uint8_t *new_ptr = (uint8_t *) desc;
 		/* Copy first 4 words and BDESCs. */
-		rte_memcpy(new_ptr, prev_ptr, ACC_5GUL_SIZE_0);
-		rte_memcpy(new_ptr + ACC_5GUL_OFFSET_0,
-				prev_ptr + ACC_5GUL_OFFSET_0,
-				ACC_5GUL_SIZE_1);
+		memcpy(new_ptr, prev_ptr, ACC_5GUL_SIZE_0);
+		memcpy(new_ptr + ACC_5GUL_OFFSET_0,
+		       prev_ptr + ACC_5GUL_OFFSET_0, ACC_5GUL_SIZE_1);
 		desc->req.op_addr = prev_desc->req.op_addr;
 		/* Copy FCW. */
-		rte_memcpy(new_ptr + ACC_DESC_FCW_OFFSET,
-				prev_ptr + ACC_DESC_FCW_OFFSET,
-				ACC_FCW_LD_BLEN);
+		memcpy(new_ptr + ACC_DESC_FCW_OFFSET,
+		       prev_ptr + ACC_DESC_FCW_OFFSET, ACC_FCW_LD_BLEN);
 		vrb_dma_desc_ld_update(op, &desc->req, input, h_output,
 				&in_offset, &h_out_offset,
 				&h_out_length, harq_layout);
@@ -2709,7 +2707,8 @@ vrb_enqueue_ldpc_dec_one_op_tb(struct acc_queue *q, struct rte_bbdev_dec_op *op,
 		fcw_offset = (desc_idx << 8) + ACC_DESC_FCW_OFFSET;
 		desc->req.data_ptrs[0].address = q->ring_addr_iova + fcw_offset;
 		desc->req.data_ptrs[0].blen = ACC_FCW_LD_BLEN;
-		rte_memcpy(&desc->req.fcw_ld, &desc_first->req.fcw_ld, ACC_FCW_LD_BLEN);
+		memcpy(&desc->req.fcw_ld, &desc_first->req.fcw_ld,
+		       ACC_FCW_LD_BLEN);
 		desc->req.fcw_ld.tb_trailer_size = (c - r - 1) * trail_len;
 		ret = vrb_dma_desc_ld_fill(op, &desc->req, &input,
 				h_output, &in_offset, &h_out_offset,
@@ -4140,7 +4139,7 @@ enqueue_mldts_split_op(struct acc_queue *q, struct rte_bbdev_mldts_op *op,
 		if (symb == 0)
 			desc->req.cbs_in_tb = num_syms;
 		else
-			rte_memcpy(&desc->req.fcw_mldts, fcw, ACC_FCW_MLDTS_BLEN);
+			memcpy(&desc->req.fcw_mldts, fcw, ACC_FCW_MLDTS_BLEN);
 		desc->req.data_ptrs[1].address = rte_pktmbuf_iova_offset(input_q, in_offset);
 		desc->req.data_ptrs[1].blen = q_size;
 		in_offset += q_size;
@@ -4490,7 +4489,7 @@ vrb1_configure(const char *dev_name, struct rte_acc_conf *conf)
 	struct acc_device *d = bbdev->data->dev_private;
 
 	/* Store configuration. */
-	rte_memcpy(&d->acc_conf, conf, sizeof(d->acc_conf));
+	memcpy(&d->acc_conf, conf, sizeof(d->acc_conf));
 
 	/* Check we are already out of PG. */
 	status = acc_reg_read(d, VRB1_PfHiSectionPowerGatingAck);
@@ -4897,7 +4896,7 @@ vrb2_configure(const char *dev_name, struct rte_acc_conf *conf)
 	struct acc_device *d = bbdev->data->dev_private;
 
 	/* Store configuration. */
-	rte_memcpy(&d->acc_conf, conf, sizeof(d->acc_conf));
+	memcpy(&d->acc_conf, conf, sizeof(d->acc_conf));
 
 	/* Explicitly releasing AXI as this may be stopped after PF FLR/BME. */
 	address = VRB2_PfDmaAxiControl;
-- 
2.53.0

