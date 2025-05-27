Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6242C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 22:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50F254066E;
	Wed, 28 May 2025 00:36:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 807324027A
 for <dev@dpdk.org>; Wed, 28 May 2025 00:36:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748385394; x=1779921394;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y1PkHZwBYYNkSOG9U/ZmHYa0rkP5coVPWVsGL4/3RfM=;
 b=RIKrW66azfl9SYRvpc8mwFyzaGTgO2jrmSJ68MuqVWq6UFPd16uaS5Il
 ALpHaHFb9QFs/TIrEtTDF7aXCdDPNnQeOFEIPJpYfOTUSIBCpyZC93yBZ
 tWyQv4CAe9v3+LqawPOW7aLnETgcQ7syZcZDlfGdXHf81GsaM90FDmJSh
 FqJpUc2F6f9eL7sC6ZF/GkhChv4UYmT3flMDHhUtVMXXLqy3vedc91N+P
 iOjKoIGYlWMCFvgPLX9POMMxv6SOYQDbG8uU9ZRzOhJMGwSo7YSxR1d7N
 wg2BXi0JudMwTnB9I3b02HpNvKEd+m0uowNlRMvOzD7sXM/NG3W2mTnac g==;
X-CSE-ConnectionGUID: hVqmei0iRu+xIQ4NUwMDkA==
X-CSE-MsgGUID: TZEjgm6FScyYp0F+OJlnYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50322738"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="50322738"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 15:36:32 -0700
X-CSE-ConnectionGUID: 9lssM7gWTbej1pxBZxhsIA==
X-CSE-MsgGUID: EMNrOUDGRLa9zP293wn+jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="143973152"
Received: from spr-npg-bds1-eec2.sn.intel.com (HELO spr-npg-bds1-eec2..)
 ([10.233.181.123])
 by fmviesa009.fm.intel.com with ESMTP; 27 May 2025 15:36:31 -0700
From: Nicolas Chautru <nicolas.chautru@intel.com>
To: dev@dpdk.org,
	maxime.coquelin@redhat.com
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v1 1/2] bbdev: add trace points per operation
Date: Tue, 27 May 2025 15:36:41 -0700
Message-Id: <20250527223642.31577-2-nicolas.chautru@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250527223642.31577-1-nicolas.chautru@intel.com>
References: <20250527223642.31577-1-nicolas.chautru@intel.com>
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

Adds trace points for rte_bbdev for each operation
type set of input parameters.
---
 lib/bbdev/bbdev_trace.h        | 113 +++++++++++++++++++++++++++++++++
 lib/bbdev/bbdev_trace_points.c |  12 ++++
 lib/bbdev/rte_bbdev.c          |  24 +++++++
 lib/bbdev/rte_bbdev.h          |  14 ++++
 4 files changed, 163 insertions(+)

diff --git a/lib/bbdev/bbdev_trace.h b/lib/bbdev/bbdev_trace.h
index 7256d6b703..dbef6efa3b 100644
--- a/lib/bbdev/bbdev_trace.h
+++ b/lib/bbdev/bbdev_trace.h
@@ -62,6 +62,119 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_u16(queue_id);
 )
 
+
+RTE_TRACE_POINT(
+	rte_bbdev_trace_op_ldpc_dec,
+	RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_ldpc_dec ldpc_dec),
+	rte_trace_point_emit_u8(ldpc_dec.code_block_mode);
+	rte_trace_point_emit_u8(ldpc_dec.tb_params.c);
+	rte_trace_point_emit_u8(ldpc_dec.tb_params.cab);
+	rte_trace_point_emit_u32(ldpc_dec.tb_params.ea);
+	rte_trace_point_emit_u32(ldpc_dec.tb_params.eb);
+	rte_trace_point_emit_u8(ldpc_dec.tb_params.r);
+	rte_trace_point_emit_u32(ldpc_dec.cb_params.e);
+	rte_trace_point_emit_u32(ldpc_dec.op_flags);
+	rte_trace_point_emit_u8(ldpc_dec.basegraph);
+	rte_trace_point_emit_u16(ldpc_dec.z_c);
+	rte_trace_point_emit_u16(ldpc_dec.n_cb);
+	rte_trace_point_emit_u8(ldpc_dec.q_m);
+	rte_trace_point_emit_u16(ldpc_dec.n_filler);
+	rte_trace_point_emit_u8(ldpc_dec.rv_index);
+	rte_trace_point_emit_u8(ldpc_dec.iter_max);
+	rte_trace_point_emit_u8(ldpc_dec.iter_count);
+	rte_trace_point_emit_u32(ldpc_dec.harq_combined_input.length);
+)
+
+RTE_TRACE_POINT(
+	rte_bbdev_trace_op_ldpc_enc,
+	RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_ldpc_enc ldpc_enc),
+	rte_trace_point_emit_u8(ldpc_enc.code_block_mode);
+	rte_trace_point_emit_u8(ldpc_enc.tb_params.c);
+	rte_trace_point_emit_u8(ldpc_enc.tb_params.cab);
+	rte_trace_point_emit_u32(ldpc_enc.tb_params.ea);
+	rte_trace_point_emit_u32(ldpc_enc.tb_params.eb);
+	rte_trace_point_emit_u8(ldpc_enc.tb_params.r);
+	rte_trace_point_emit_u32(ldpc_enc.cb_params.e);
+	rte_trace_point_emit_u32(ldpc_enc.op_flags);
+	rte_trace_point_emit_u8(ldpc_enc.basegraph);
+	rte_trace_point_emit_u16(ldpc_enc.z_c);
+	rte_trace_point_emit_u16(ldpc_enc.n_cb);
+	rte_trace_point_emit_u8(ldpc_enc.q_m);
+	rte_trace_point_emit_u16(ldpc_enc.n_filler);
+	rte_trace_point_emit_u8(ldpc_enc.rv_index);
+)
+
+RTE_TRACE_POINT(
+	rte_bbdev_trace_op_turbo_enc,
+	RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_turbo_enc turbo_enc),
+	rte_trace_point_emit_u8(turbo_enc.code_block_mode);
+	rte_trace_point_emit_u32(turbo_enc.op_flags);
+	rte_trace_point_emit_u8(turbo_enc.rv_index);
+	rte_trace_point_emit_u16(turbo_enc.tb_params.k_neg);
+	rte_trace_point_emit_u16(turbo_enc.tb_params.k_pos);
+	rte_trace_point_emit_u8(turbo_enc.tb_params.c_neg);
+	rte_trace_point_emit_u8(turbo_enc.tb_params.c);
+	rte_trace_point_emit_u8(turbo_enc.tb_params.cab);
+	rte_trace_point_emit_u32(turbo_enc.tb_params.ea);
+	rte_trace_point_emit_u32(turbo_enc.tb_params.eb);
+	rte_trace_point_emit_u8(turbo_enc.tb_params.r);
+	rte_trace_point_emit_u32(turbo_enc.cb_params.e);
+	rte_trace_point_emit_u16(turbo_enc.cb_params.k);
+)
+
+RTE_TRACE_POINT(
+	rte_bbdev_trace_op_turbo_dec,
+	RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_turbo_dec turbo_dec),
+	rte_trace_point_emit_u8(turbo_dec.code_block_mode);
+	rte_trace_point_emit_u32(turbo_dec.op_flags);
+	rte_trace_point_emit_u8(turbo_dec.rv_index);
+	rte_trace_point_emit_u8(turbo_dec.iter_count);
+	rte_trace_point_emit_u8(turbo_dec.ext_scale);
+	rte_trace_point_emit_u8(turbo_dec.num_maps);
+	rte_trace_point_emit_u16(turbo_dec.tb_params.k_neg);
+	rte_trace_point_emit_u16(turbo_dec.tb_params.k_pos);
+	rte_trace_point_emit_u8(turbo_dec.tb_params.c_neg);
+	rte_trace_point_emit_u8(turbo_dec.tb_params.c);
+	rte_trace_point_emit_u8(turbo_dec.tb_params.cab);
+	rte_trace_point_emit_u32(turbo_dec.tb_params.ea);
+	rte_trace_point_emit_u32(turbo_dec.tb_params.eb);
+	rte_trace_point_emit_u8(turbo_dec.tb_params.r);
+	rte_trace_point_emit_u32(turbo_dec.cb_params.e);
+	rte_trace_point_emit_u16(turbo_dec.cb_params.k);
+)
+
+RTE_TRACE_POINT(
+	rte_bbdev_trace_op_fft,
+	RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_fft fft),
+	rte_trace_point_emit_u32(fft.op_flags);
+	rte_trace_point_emit_u16(fft.input_sequence_size);
+	rte_trace_point_emit_u16(fft.input_leading_padding);
+	rte_trace_point_emit_u16(fft.output_sequence_size);
+	rte_trace_point_emit_u16(fft.output_leading_depadding);
+	rte_trace_point_emit_u16(fft.cs_bitmap);
+	rte_trace_point_emit_u8(fft.num_antennas_log2);
+	rte_trace_point_emit_u8(fft.idft_log2);
+	rte_trace_point_emit_u8(fft.dft_log2);
+	rte_trace_point_emit_u8(fft.cs_time_adjustment);
+	rte_trace_point_emit_u8(fft.idft_shift);
+	rte_trace_point_emit_u8(fft.dft_shift);
+	rte_trace_point_emit_u16(fft.ncs_reciprocal);
+	rte_trace_point_emit_u16(fft.power_shift);
+	rte_trace_point_emit_u16(fft.fp16_exp_adjust);
+	rte_trace_point_emit_u8(fft.freq_resample_mode);
+	rte_trace_point_emit_u16(fft.output_depadded_size);
+)
+
+RTE_TRACE_POINT(
+	rte_bbdev_trace_op_mldts,
+	RTE_TRACE_POINT_ARGS(const struct rte_bbdev_op_mldts mldts),
+	rte_trace_point_emit_u32(mldts.op_flags);
+	rte_trace_point_emit_u16(mldts.num_rbs);
+	rte_trace_point_emit_u16(mldts.num_layers);
+	rte_trace_point_emit_u8(mldts.r_rep);
+	rte_trace_point_emit_u8(mldts.c_rep);
+)
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/bbdev/bbdev_trace_points.c b/lib/bbdev/bbdev_trace_points.c
index 942c7be819..23d1164e7d 100644
--- a/lib/bbdev/bbdev_trace_points.c
+++ b/lib/bbdev/bbdev_trace_points.c
@@ -21,6 +21,18 @@ RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_start,
 	lib.bbdev.queue.start)
 RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_stop,
 	lib.bbdev.queue.stop)
+RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_ldpc_dec,
+	lib.bbdev.op.ldpc_dec);
+RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_ldpc_enc,
+	lib.bbdev.op.ldpc_enc);
+RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_turbo_dec,
+	lib.bbdev.op.turbo_dec);
+RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_turbo_enc,
+	lib.bbdev.op.turbo_enc);
+RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_fft,
+	lib.bbdev.op.fft);
+RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_op_mldts,
+	lib.bbdev.op.mldts);
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_bbdev_trace_enqueue, 25.03)
 RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_enqueue,
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index e0f8c8eb0d..4958a87646 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -1281,6 +1281,30 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 	return dev->dev_ops->queue_ops_dump(dev, queue_id, f);
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_ops_trace, 25.03)
+void
+rte_bbdev_ops_trace(void *op, enum rte_bbdev_op_type op_type)
+{
+	struct rte_bbdev_dec_op *op_dec = op;
+	struct rte_bbdev_enc_op *op_enc = op;
+	struct rte_bbdev_fft_op *op_fft = op;
+	struct rte_bbdev_mldts_op *op_mldts = op;
+
+	if (op_type == RTE_BBDEV_OP_LDPC_DEC) {
+		rte_bbdev_trace_op_ldpc_dec(op_dec->ldpc_dec);
+	} else if (op_type == RTE_BBDEV_OP_LDPC_ENC) {
+		rte_bbdev_trace_op_ldpc_enc(op_enc->ldpc_enc);
+	} else if (op_type == RTE_BBDEV_OP_FFT) {
+		rte_bbdev_trace_op_fft(op_fft->fft);
+	} else if (op_type == RTE_BBDEV_OP_MLDTS) {
+		rte_bbdev_trace_op_mldts(op_mldts->mldts);
+	} else if (op_type == RTE_BBDEV_OP_TURBO_DEC) {
+		rte_bbdev_trace_op_turbo_dec(op_dec->turbo_dec);
+	} else if (op_type == RTE_BBDEV_OP_TURBO_ENC) {
+		rte_bbdev_trace_op_turbo_enc(op_enc->turbo_enc);
+	}
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bbdev_ops_param_string, 24.11)
 char *
 rte_bbdev_ops_param_string(void *op, enum rte_bbdev_op_type op_type, char *str, uint32_t len)
diff --git a/lib/bbdev/rte_bbdev.h b/lib/bbdev/rte_bbdev.h
index 710280f0df..4912bc7b6f 100644
--- a/lib/bbdev/rte_bbdev.h
+++ b/lib/bbdev/rte_bbdev.h
@@ -1147,6 +1147,20 @@ __rte_experimental
 char *
 rte_bbdev_ops_param_string(void *op, enum rte_bbdev_op_type op_type, char *str, uint32_t len);
 
+/**
+ * Add a trace with detail of operation.
+ *
+ *  @param op
+ *    Pointer to an operation.
+ *
+ *  @param op_type
+ *    Operation type enum.
+ *
+ */
+__rte_experimental
+void
+rte_bbdev_ops_trace(void *op, enum rte_bbdev_op_type op_type);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.34.1

