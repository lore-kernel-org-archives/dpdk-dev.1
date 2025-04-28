Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE01C36005
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 06:30:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FF604021F;
	Mon, 28 Apr 2025 08:30:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 33C6240156
 for <dev@dpdk.org>; Mon, 28 Apr 2025 08:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745821847; x=1777357847;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E54QbeIV8iXxlwqvN6t8GhTbbWiJz6sfkSQMQodXX3E=;
 b=cJiUwusGRvF57CDju+1cYuNSRdOjPO6aMnUMUs1bn/N1/4m3JA/sLudp
 ztfgxED5mhwaXd89Wihr8noiWzJuZ6C7aeAVpJqPOm9pRg5V4qmDGnfm4
 b982906WDUoE1rSAIc9Huaas6C+Ng+M8foT8hNqcpWr0fN8UXiPNDW0Rg
 vxx5efPhF1aY06umQrhxWI4g9nUXUXnJP0fL1f8ewSe+RrGSWsoXE6sDi
 uRhxXYka/7/vG013JDWdedQf0REmGBYAVPY8NE7mYcZBtJC/6EVdTqEdI
 FVP+vEXZF/3JzfSjez/tn54EbWAUShngkci6EbAoUJsuc6qS1COihUvTQ g==;
X-CSE-ConnectionGUID: aJACFqkASNKraZ2q23Q3ig==
X-CSE-MsgGUID: CZHcFyjATI+KOXlMrHY2xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47105312"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="47105312"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2025 23:30:45 -0700
X-CSE-ConnectionGUID: xhNQOezDRZqWCo7J7PevWg==
X-CSE-MsgGUID: P8JzxDp7TaSIw2P6cdMQMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="134398524"
Received: from silpixa00400465.ir.intel.com ([10.55.129.27])
 by orviesa008.jf.intel.com with ESMTP; 27 Apr 2025 23:30:44 -0700
From: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, kai.ji@intel.com,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Subject: [PATCH] crypto/qat: fix out-of-place chain, cipher and auth headers
Date: Mon, 28 Apr 2025 06:30:41 +0000
Message-ID: <20250428063041.2038193-1-arkadiuszx.kusztal@intel.com>
X-Mailer: git-send-email 2.43.0
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

This commit fixes a problem with overwriting data in the OOP header
in RAW API crypto processing when using chain, cipher and auth algorithms.

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 146 +++++++++++++++++++
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c    |  40 +++--
 2 files changed, 171 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
index 35c1888082..af60b85985 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -146,6 +146,152 @@ qat_cipher_is_len_in_bits(struct qat_sym_session *ctx,
 	return 0;
 }
 
+struct qat_sym_req_mid_info {
+	uint32_t data_len;
+	union rte_crypto_sym_ofs ofs;
+};
+
+static inline
+struct qat_sym_req_mid_info qat_sym_req_mid_set(
+	int *error, struct icp_qat_fw_la_bulk_req *const req,
+	struct qat_sym_op_cookie *const cookie, const void *const opaque,
+	const struct rte_crypto_sgl *sgl_src, const struct rte_crypto_sgl *sgl_dst,
+	const union rte_crypto_sym_ofs ofs)
+{
+	struct qat_sym_req_mid_info info = { };  /* Returned value */
+	uint32_t src_tot_length = 0;
+	uint32_t dst_tot_length = 0; /* Used only for input validity checks */
+	uint32_t src_length = 0;
+	uint32_t dst_length = 0;
+	uint64_t src_data_addr = 0;
+	uint64_t dst_data_addr = 0;
+	union rte_crypto_sym_ofs out_ofs = ofs;
+	const struct rte_crypto_vec * const vec_src = sgl_src->vec;
+	const struct rte_crypto_vec * const vec_dst = sgl_dst->vec;
+	const uint32_t n_src = sgl_src->num;
+	const uint32_t n_dst = sgl_dst->num;
+	const uint16_t offset = RTE_MIN(ofs.ofs.cipher.head, ofs.ofs.auth.head);
+	const uint8_t is_flat = !(n_src > 1 || n_dst > 1); /* Flat buffer or the SGL */
+	const uint8_t is_in_place = !n_dst; /* In-place or out-of-place */
+
+	*error = 0;
+	if (unlikely((n_src < 1 || n_src > QAT_SYM_SGL_MAX_NUMBER) ||
+			n_dst > QAT_SYM_SGL_MAX_NUMBER)) {
+		QAT_LOG(DEBUG,
+			"Invalid number of sgls, source no: %u, dst no: %u, opaque: %p",
+			n_src, n_dst, opaque);
+		*error = -1;
+		return info;
+	}
+
+	/* --- Flat buffer --- */
+	if (is_flat) {
+		src_data_addr = vec_src->iova;
+		dst_data_addr = vec_src->iova;
+		src_length = vec_src->len;
+		dst_length = vec_src->len;
+
+		if (is_in_place)
+			goto done;
+		/* Out-of-place
+		 * If OOP, we need to keep in mind that offset needs to
+		 * start where the aead starts
+		 */
+		dst_length = vec_dst->len;
+		/* Comparision between different types, intentional */
+		if (unlikely(offset > src_length || offset > dst_length)) {
+			QAT_LOG(DEBUG,
+				"Invalid size of the vector parameters, source length: %u, dst length: %u, opaque: %p",
+				src_length, dst_length, opaque);
+			*error = -1;
+			return info;
+		}
+		out_ofs.ofs.cipher.head -= offset;
+		out_ofs.ofs.auth.head -= offset;
+		src_data_addr += offset;
+		dst_data_addr = vec_dst->iova + offset;
+		src_length -= offset;
+		dst_length -= offset;
+		src_tot_length = src_length;
+		dst_tot_length = dst_length;
+		goto check;
+	}
+
+	/* --- Scatter-gather list --- */
+	struct qat_sgl * const qat_sgl_src = (struct qat_sgl *)&cookie->qat_sgl_src;
+	uint16_t i;
+
+	ICP_QAT_FW_COMN_PTR_TYPE_SET(req->comn_hdr.comn_req_flags,
+		QAT_COMN_PTR_TYPE_SGL);
+	qat_sgl_src->num_bufs = n_src;
+	src_data_addr = cookie->qat_sgl_src_phys_addr;
+	/* Fill all the source buffers but the first one */
+	for (i = 1; i < n_src; i++) {
+		qat_sgl_src->buffers[i].len = (vec_src + i)->len;
+		qat_sgl_src->buffers[i].addr = (vec_src + i)->iova;
+		src_tot_length += qat_sgl_src->buffers[i].len;
+	}
+
+	if (is_in_place) {
+		/* SGL source first entry, no OOP */
+		qat_sgl_src->buffers[0].len = vec_src->len;
+		qat_sgl_src->buffers[0].addr = vec_src->iova;
+		dst_data_addr = src_data_addr;
+		goto done;
+	}
+	/* Out-of-place */
+	struct qat_sgl * const qat_sgl_dst =
+			(struct qat_sgl *)&cookie->qat_sgl_dst;
+	/*
+	 * Offset reaching outside of the first buffer is not supported (RAW api).
+	 * Integer promotion here, but it does not bother this time
+	 */
+	if (unlikely(offset > vec_src->len || offset > vec_dst->len)) {
+		QAT_LOG(DEBUG,
+			"Invalid size of the vector parameters, source length: %u, dst length: %u, opaque: %p",
+			vec_src->len, vec_dst->len, opaque);
+		*error = -1;
+		return info;
+	}
+	out_ofs.ofs.cipher.head -= offset;
+	out_ofs.ofs.auth.head -= offset;
+	/* SGL source first entry, adjusted to OOP offsets */
+	qat_sgl_src->buffers[0].addr = vec_src->iova + offset;
+	qat_sgl_src->buffers[0].len = vec_src->len - offset;
+	/* SGL destination first entry, adjusted to OOP offsets */
+	qat_sgl_dst->buffers[0].addr = vec_dst->iova + offset;
+	qat_sgl_dst->buffers[0].len = vec_dst->len - offset;
+	/* Fill the remaining destination buffers */
+	for (i = 1; i < n_dst; i++) {
+		qat_sgl_dst->buffers[i].len = (vec_dst + i)->len;
+		qat_sgl_dst->buffers[i].addr = (vec_dst + i)->iova;
+		dst_tot_length += qat_sgl_dst->buffers[i].len;
+	}
+	dst_tot_length += qat_sgl_dst->buffers[0].len;
+	qat_sgl_dst->num_bufs = n_dst;
+	dst_data_addr = cookie->qat_sgl_dst_phys_addr;
+
+check:	/* If error, return directly. If success, jump to one of these labels */
+	if (src_tot_length != dst_tot_length) {
+		QAT_LOG(DEBUG,
+			"Source length is not equal to the destination length %u, dst no: %u, opaque: %p",
+			src_tot_length, dst_tot_length, opaque);
+		*error = -1;
+		return info;
+	}
+done:
+	req->comn_mid.opaque_data = (uintptr_t)opaque;
+	req->comn_mid.src_data_addr = src_data_addr;
+	req->comn_mid.dest_data_addr = dst_data_addr;
+	req->comn_mid.src_length = src_length;
+	req->comn_mid.dst_length = dst_length;
+
+	info.data_len = src_tot_length;
+	info.ofs = out_ofs;
+
+	return info;
+}
+
 static __rte_always_inline int32_t
 qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_req *req,
 		void *opaque, struct qat_sym_op_cookie *cookie,
diff --git a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
index 24e51a9318..f929eed53f 100644
--- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
@@ -567,16 +567,20 @@ qat_sym_dp_enqueue_cipher_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 	for (i = 0; i < n; i++) {
 		struct qat_sym_op_cookie *cookie =
 			qp->op_cookies[tail >> tx_queue->trailz];
+		struct qat_sym_req_mid_info info = { };
+		union rte_crypto_sym_ofs temp_ofs = ofs;
+		int error = 0;
 
+		temp_ofs.ofs.auth = temp_ofs.ofs.cipher;
 		req  = (struct icp_qat_fw_la_bulk_req *)(
 			(uint8_t *)tx_queue->base_addr + tail);
 		rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 
 		if (vec->dest_sgl) {
-			data_len = qat_sym_build_req_set_data(req,
-				user_data[i], cookie,
-				vec->src_sgl[i].vec, vec->src_sgl[i].num,
-				vec->dest_sgl[i].vec, vec->dest_sgl[i].num);
+			info = qat_sym_req_mid_set(&error, req, cookie, user_data[i],
+				&vec->src_sgl[i], &vec->dest_sgl[i], temp_ofs);
+			data_len = info.data_len;
+			ofs = info.ofs;
 		} else {
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
@@ -584,7 +588,7 @@ qat_sym_dp_enqueue_cipher_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 				vec->src_sgl[i].num, NULL, 0);
 		}
 
-		if (unlikely(data_len < 0))
+		if (unlikely(data_len < 0 || error))
 			break;
 
 		if (ctx->is_zuc256)
@@ -688,16 +692,20 @@ qat_sym_dp_enqueue_auth_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 	for (i = 0; i < n; i++) {
 		struct qat_sym_op_cookie *cookie =
 			qp->op_cookies[tail >> tx_queue->trailz];
+		struct qat_sym_req_mid_info info = { };
+		union rte_crypto_sym_ofs temp_ofs = ofs;
+		int error = 0;
 
+		temp_ofs.ofs.cipher = temp_ofs.ofs.auth;
 		req  = (struct icp_qat_fw_la_bulk_req *)(
 			(uint8_t *)tx_queue->base_addr + tail);
 		rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 
 		if (vec->dest_sgl) {
-			data_len = qat_sym_build_req_set_data(req,
-				user_data[i], cookie,
-				vec->src_sgl[i].vec, vec->src_sgl[i].num,
-				vec->dest_sgl[i].vec, vec->dest_sgl[i].num);
+			info = qat_sym_req_mid_set(&error, req, cookie, user_data[i],
+				&vec->src_sgl[i], &vec->dest_sgl[i], temp_ofs);
+			data_len = info.data_len;
+			ofs = info.ofs;
 		} else {
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
@@ -705,7 +713,7 @@ qat_sym_dp_enqueue_auth_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 				vec->src_sgl[i].num, NULL, 0);
 		}
 
-		if (unlikely(data_len < 0))
+		if (unlikely(data_len < 0 || error))
 			break;
 
 		if (ctx->is_zuc256)
@@ -819,16 +827,18 @@ qat_sym_dp_enqueue_chain_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 	for (i = 0; i < n; i++) {
 		struct qat_sym_op_cookie *cookie =
 			qp->op_cookies[tail >> tx_queue->trailz];
+		struct qat_sym_req_mid_info info = { };
+		int error = 0;
 
 		req  = (struct icp_qat_fw_la_bulk_req *)(
 			(uint8_t *)tx_queue->base_addr + tail);
 		rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 
 		if (vec->dest_sgl) {
-			data_len = qat_sym_build_req_set_data(req,
-				user_data[i], cookie,
-				vec->src_sgl[i].vec, vec->src_sgl[i].num,
-				vec->dest_sgl[i].vec, vec->dest_sgl[i].num);
+			info = qat_sym_req_mid_set(&error, req, cookie, user_data[i],
+				&vec->src_sgl[i], &vec->dest_sgl[i], ofs);
+			data_len = info.data_len;
+			ofs = info.ofs;
 		} else {
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
@@ -836,7 +846,7 @@ qat_sym_dp_enqueue_chain_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 				vec->src_sgl[i].num, NULL, 0);
 		}
 
-		if (unlikely(data_len < 0))
+		if (unlikely(data_len < 0 || error))
 			break;
 
 		if (ctx->is_zuc256) {
-- 
2.43.0

