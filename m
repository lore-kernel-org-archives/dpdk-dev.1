Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F2C28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 16:57:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0DEF40615;
	Thu, 20 Mar 2025 17:57:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6F185402AF;
 Thu, 20 Mar 2025 17:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742489829; x=1774025829;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Reuktz5Zb813ewmjQ98tW4baP9APyduDIJVEcH/4RqI=;
 b=UBkw4/mE8M//YaxzyXaqZG9sYhlKNB4NZh+W55Im5dSCGJS9BF7oLsJn
 Aw5DY9tpvoo85bs2WTTL4JFwH7qiAvFh3hoXGWUURB+c9OfbV5aPRw9M7
 bnyZotL6hyIx3vzECOufG16iw5kqgosfnG7ZCMFG0XceG7R5bEmmOvocr
 sdcGGremHy8v3jPG/raqs9mbcY7K4/TC04LpGsMT4Jif7CbJjrZ68KP8/
 Yscj4tBoxD3l79xKL4elSHc6kaSEBTmA1I0zSsixdKH5XiCj6XiAYQSBK
 KaaiKoXA5R0oAc+pUVP0zlWaOQA9RT6HgQLyy5DhGE6DjL7ddajtL3wZQ Q==;
X-CSE-ConnectionGUID: yZKsRnR6TuKZlboK5agwFQ==
X-CSE-MsgGUID: X3GGDNMTTw28FBTSr559/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47615750"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; d="scan'208";a="47615750"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 09:57:07 -0700
X-CSE-ConnectionGUID: xmacGIv4QsmuMfZx0/rI6w==
X-CSE-MsgGUID: F6uyyLuwSZGqrfWAYFQbGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; d="scan'208";a="123166765"
Received: from silpixa00400465.ir.intel.com ([10.55.129.27])
 by orviesa006.jf.intel.com with ESMTP; 20 Mar 2025 09:57:06 -0700
From: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, kai.ji@intel.com, brian.dooley@intel.com,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, stable@dpdk.org
Subject: [PATCH] crypto/qat: fix out-of-place header bytes in aead raw api
Date: Thu, 20 Mar 2025 16:57:02 +0000
Message-ID: <20250320165702.1439228-1-arkadiuszx.kusztal@intel.com>
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
in RAW API crypto processing when using AEAD algorithms.

Fixes: 85fec6fd9674 ("crypto/qat: unify raw data path functions")
Cc: stable@dpdk.org

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 134 +++++++++++++++++++
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c    |  13 +-
 2 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
index 35c1888082..c447f2cb45 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -6,9 +6,12 @@
 #define _QAT_CRYPTO_PMD_GENS_H_
 
 #include <rte_cryptodev.h>
+#include <rte_common.h>
+#include <rte_branch_prediction.h>
 #include "qat_crypto.h"
 #include "qat_sym_session.h"
 #include "qat_sym.h"
+#include "icp_qat_fw_la.h"
 
 #define AES_OR_3DES_MISALIGNED (ctx->qat_mode == ICP_QAT_HW_CIPHER_CBC_MODE && \
 			((((ctx->qat_cipher_alg == ICP_QAT_HW_CIPHER_ALGO_AES128) || \
@@ -146,6 +149,137 @@ qat_cipher_is_len_in_bits(struct qat_sym_session *ctx,
 	return 0;
 }
 
+static inline
+uint32_t qat_reqs_mid_set(int *error, struct icp_qat_fw_la_bulk_req *const req,
+	struct qat_sym_op_cookie *const cookie, const void *const opaque,
+	const struct rte_crypto_sgl *sgl_src, const struct rte_crypto_sgl *sgl_dst,
+	const union rte_crypto_sym_ofs ofs)
+{
+	uint32_t src_tot_length = 0; /* Returned value */
+	uint32_t dst_tot_length = 0; /* Used only for input validity checks */
+	uint32_t src_length = 0;
+	uint32_t dst_length = 0;
+	uint64_t src_data_addr = 0;
+	uint64_t dst_data_addr = 0;
+	const struct rte_crypto_vec * const vec_src = sgl_src->vec;
+	const struct rte_crypto_vec * const vec_dst = sgl_dst->vec;
+	const uint32_t n_src = sgl_src->num;
+	const uint32_t n_dst = sgl_dst->num;
+	const uint16_t offset = RTE_MAX(ofs.ofs.cipher.head, ofs.ofs.auth.head);
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
+		return 0;
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
+		/* Integer promotion here, but it does not bother this time */
+		if (unlikely(offset > src_length || offset > dst_length)) {
+			QAT_LOG(DEBUG,
+				"Invalid size of the vector parameters, source length: %u, dst length: %u, opaque: %p",
+				src_length, dst_length, opaque);
+			*error = -1;
+			return 0;
+		}
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
+		return 0;
+	}
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
+		return 0;
+	}
+done:
+	req->comn_mid.opaque_data = (uintptr_t)opaque;
+	req->comn_mid.src_data_addr = src_data_addr;
+	req->comn_mid.dest_data_addr = dst_data_addr;
+	req->comn_mid.src_length = src_length;
+	req->comn_mid.dst_length = dst_length;
+
+	return src_tot_length;
+}
+
 static __rte_always_inline int32_t
 qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_req *req,
 		void *opaque, struct qat_sym_op_cookie *cookie,
diff --git a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
index 24e51a9318..3976d03179 100644
--- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
@@ -942,16 +942,19 @@ qat_sym_dp_enqueue_aead_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 	for (i = 0; i < n; i++) {
 		struct qat_sym_op_cookie *cookie =
 			qp->op_cookies[tail >> tx_queue->trailz];
+		int error = 0;
 
 		req  = (struct icp_qat_fw_la_bulk_req *)(
 			(uint8_t *)tx_queue->base_addr + tail);
 		rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 
 		if (vec->dest_sgl) {
-			data_len = qat_sym_build_req_set_data(req,
-				user_data[i], cookie,
-				vec->src_sgl[i].vec, vec->src_sgl[i].num,
-				vec->dest_sgl[i].vec, vec->dest_sgl[i].num);
+			data_len = qat_reqs_mid_set(&error, req, cookie, user_data[i],
+					&vec->src_sgl[i], &vec->dest_sgl[i], ofs);
+			/* In oop there is no offset, src/dst addresses are moved
+			 * to avoid overwriting the dst header
+			 */
+			ofs.ofs.cipher.head = 0;
 		} else {
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
@@ -959,7 +962,7 @@ qat_sym_dp_enqueue_aead_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 				vec->src_sgl[i].num, NULL, 0);
 		}
 
-		if (unlikely(data_len < 0))
+		if (unlikely(data_len < 0) || error)
 			break;
 
 		enqueue_one_aead_job_gen1(ctx, req, &vec->iv[i],
-- 
2.43.0

