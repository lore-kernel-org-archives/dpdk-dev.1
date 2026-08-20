Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CFBC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 699A840E8A;
	Thu, 20 Aug 2026 07:26:17 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 374D840E11
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:16 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d530328efbso15631505ad.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203575;
 x=1787808375; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=stRrWZoQEX4kr1F3klxIwmXy5/C++KOH3Lkgvgd4s2I=;
 b=fB1mgu3MOpQ0pUZBAgoFC9RqiSrzpLvYbaH2kw9Yks3z2TI1qgM3p1asG8MVxEy8J8
 cmS6LcrN3M+nf63raJ4LcrSwQI3icQVjsg7u5oEKkVTPmol/Pq6HbRIU6i37Rdyyev27
 TXzamFQQqui+wwPqcR8dqLtWr19N/T117mw2zExYsGETBp0pmb/vk6iU+BchR3fKL6ee
 mCdR14yqTUsehOn/eD2gWY0M5IH4muLv495hCYkqhAmmVaLsIZk7xole/yxADjBFNVP0
 HfXv2Gs8KQ1C5Wo3E42JjHxyLjU6h62kCkIf/fu9Z/UppBEfADyN530tSwbVj6um166h
 5Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203575; x=1787808375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=stRrWZoQEX4kr1F3klxIwmXy5/C++KOH3Lkgvgd4s2I=;
 b=YbfaoO+oCc9TAKF8KRbCsY6dBhvPNt44cNn8Jtsosx44g0zR1tHAuAUF7mwWS1m5w2
 tI8HQn9xF7tqSZlE0w7XEAGXcAruENyK5A8QyaMQmsTzlr/J43Ox7LnZR1YiDSSXS5t4
 x6burKpv504/hcdPi4IsTLLBwojYt/JcPJs7FWtU5lwbOeCmDOPv1wZ78GOFmQOm67H/
 a4xi9+FyrCHrkLZtQvUvSrC3u+xcTtTdNQftu2pUuzCzhA6pMZiDpvbxRk7Ie9T+MEOa
 9rfBxOvRvud0Yokd9BkqQrgWhdxqszUZSZhez/jfzGviE5dq4EbngSYKnCd+bxWGar13
 czDw==
X-Gm-Message-State: AFuF++lYnQoVKwL+Fzs1razfzhqtDBuczexEl25DOAmbguf8aZ4RGULO
 kfAnnTQXChlFQ8h6Js0AL/Kqb0Z4cxsArbBUSt9T6IAJwA0gkF4K0kAkXpCbUS1ZjK8VXlKepvv
 9PwMM
X-Gm-Gg: AR+sD11P6ig012OOegVVLqZLoEdnAgGDS7llIeZSVqyAVczOrE4s0rBAFHT1pFqDllT
 WCOyq7fABxsRkqTxMC5ilWxRJ40wtWA0E/7pD5a5ePPuz1OtYR+nhj+4pOGGLBNEspH6tnuWFGP
 rbEVHt2nk5DXAPwqVca3aCQUKTfMYqWSWkugAWXFwxZSr4qX1A19OHaNeS2BdjTCQL2x+kDgYAa
 Ax/vadoBcx+Teft9h02k1Gifjc7Oc2TnD9F4sifKZDT1q2GRbm8sPtBZPfLVdzXAIqnahSeVsGg
 1REzoSk1ufU+4G1ipTrxd9PyWcckk3P1FhN54k37P66LV5X0VVObeCm7aSXNKWEC9bubX8YLGTN
 bcRkB/30mSw3lBAXfSL6TDn0ntdJNwWktS+x5YY6rz1yL0JnGPWB1+Z1J6kypG0K6IhBbxLfQ7Y
 RocGT7UUBVqHeG5pwXk9ZxmIi29buxugVt/i/osdFWiqyX+X/+9bgXdVU7AUMrsyrs/eViNlPux
 5jWeody0j5lMChkImlNv7k3mcJJHP8q9BtflQ==
X-Received: by 2002:a17:90b:5624:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-39580a7c3dbmr19945233a91.6.1787203575213; 
 Wed, 19 Aug 2026 22:26:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH 53/61] baseband/acc: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:43 -0700
Message-ID: <20260820052251.1453273-54-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

