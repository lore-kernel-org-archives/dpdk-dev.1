Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A08C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 14:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B2B7402D2;
	Wed,  6 Aug 2025 16:48:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2B49D40291;
 Wed,  6 Aug 2025 16:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754491719; x=1786027719;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=a4+BMnuo4qjCzO0X/bI6LllPk2wTQtCLAczfWa/5iSU=;
 b=cdJA4eIKVB431DSS2OAbP2ex/cglrsji9hjjud3vKkj/C0w5q+ItT331
 Hzcop/wo+Aw2afKfwp6Wu0kp3eV1EdSAu4BhkiPaK9MtNtUYD00HAyl7z
 fqit+wymugQCqWjQ1UVa/3GYed5VWNJtjavhWylsAHMNn6cpNGNFnj08r
 vkrkJDUC+YJIaVLvVmhWb4POvz5af4V16WtzeZJHMEPlr9Wd5D0VQNkoA
 K16g/sXrLsrD8S2I4VzpRv2BiLEMTxNyi8zToeSed5a3AWultxHY8cEr1
 Yzf6DLKaWwn2Hxwbvg03XPypDBrJo1KVS968vgLRX182SysylyBDQYQ6+ Q==;
X-CSE-ConnectionGUID: tinRGVJcQou8eK11mSr0lg==
X-CSE-MsgGUID: lJtb1NMYQOqusmOnz6yydw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67078472"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="67078472"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2025 07:48:37 -0700
X-CSE-ConnectionGUID: bduL4hm1TvO6HoyZa209oQ==
X-CSE-MsgGUID: kpSdk4SbRiSJt2sMKh9ygg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; d="scan'208";a="165566960"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by fmviesa010.fm.intel.com with ESMTP; 06 Aug 2025 07:48:35 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 Kai Ji <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH] crypto/qat: fix source buffer alignment
Date: Wed,  6 Aug 2025 14:48:32 +0000
Message-ID: <20250806144832.3507786-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
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

Fix performance regression resulting from using non cache-aligned
source buffers when using cryptodev API.

Fixes: fb3b9f492205 ("crypto/qat: rework burst data path")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 14 ++++++------
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c |  6 ++---
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 21 ++++++++++++++++-
 drivers/crypto/qat/dev/qat_sym_pmd_gen1.c    | 24 ++++++++++----------
 4 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
index 0dcb5a7cb4..c196cf3cdb 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -422,7 +422,7 @@ qat_sym_build_op_aead_gen3(void *in_op, struct qat_sym_session *ctx,
 	}
 
 	total_len = qat_sym_build_req_set_data(req, in_op, cookie,
-			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &ofs, op);
 	if (unlikely(total_len < 0)) {
 		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		return -EINVAL;
@@ -466,7 +466,7 @@ qat_sym_build_op_auth_gen3(void *in_op, struct qat_sym_session *ctx,
 	}
 
 	total_len = qat_sym_build_req_set_data(req, in_op, cookie,
-			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &ofs, op);
 	if (unlikely(total_len < 0)) {
 		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		return -EINVAL;
@@ -564,7 +564,7 @@ qat_sym_dp_enqueue_single_aead_gen3(void *qp_data, uint8_t *drv_ctx,
 	rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 	rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
 	data_len = qat_sym_build_req_set_data(req, user_data, cookie,
-			data, n_data_vecs, NULL, 0);
+			data, n_data_vecs, NULL, 0, NULL, NULL);
 	if (unlikely(data_len < 0))
 		return -1;
 
@@ -623,7 +623,7 @@ qat_sym_dp_enqueue_aead_jobs_gen3(void *qp_data, uint8_t *drv_ctx,
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
 				vec->src_sgl[i].vec,
-				vec->src_sgl[i].num, NULL, 0);
+				vec->src_sgl[i].num, NULL, 0, NULL, NULL);
 		}
 
 		if (unlikely(data_len < 0) || error)
@@ -677,7 +677,7 @@ qat_sym_dp_enqueue_single_auth_gen3(void *qp_data, uint8_t *drv_ctx,
 	rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 	rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
 	data_len = qat_sym_build_req_set_data(req, user_data, cookie,
-			data, n_data_vecs, NULL, 0);
+			data, n_data_vecs, NULL, 0, NULL, NULL);
 	if (unlikely(data_len < 0))
 		return -1;
 
@@ -732,12 +732,12 @@ qat_sym_dp_enqueue_auth_jobs_gen3(void *qp_data, uint8_t *drv_ctx,
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
 				vec->src_sgl[i].vec, vec->src_sgl[i].num,
-				vec->dest_sgl[i].vec, vec->dest_sgl[i].num);
+				vec->dest_sgl[i].vec, vec->dest_sgl[i].num, NULL, NULL);
 		} else {
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
 				vec->src_sgl[i].vec,
-				vec->src_sgl[i].num, NULL, 0);
+				vec->src_sgl[i].num, NULL, 0, NULL, NULL);
 		}
 
 		if (unlikely(data_len < 0))
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
index 638da1a173..f42ce7c178 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -219,7 +219,7 @@ qat_sym_build_op_aead_gen4(void *in_op, struct qat_sym_session *ctx,
 	}
 
 	total_len = qat_sym_build_req_set_data(qat_req, in_op, cookie,
-			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &ofs, op);
 	if (unlikely(total_len < 0)) {
 		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		return -EINVAL;
@@ -376,7 +376,7 @@ qat_sym_dp_enqueue_single_aead_gen4(void *qp_data, uint8_t *drv_ctx,
 	rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 	rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
 	data_len = qat_sym_build_req_set_data(req, user_data, cookie,
-			data, n_data_vecs, NULL, 0);
+			data, n_data_vecs, NULL, 0, NULL, NULL);
 	if (unlikely(data_len < 0))
 		return -1;
 
@@ -435,7 +435,7 @@ qat_sym_dp_enqueue_aead_jobs_gen4(void *qp_data, uint8_t *drv_ctx,
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
 				vec->src_sgl[i].vec,
-				vec->src_sgl[i].num, NULL, 0);
+				vec->src_sgl[i].num, NULL, 0, NULL, NULL);
 		}
 
 		if (unlikely(data_len < 0) || error)
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
index 1f19c69f88..67dc889b50 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -430,7 +430,8 @@ static __rte_always_inline int32_t
 qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_req *req,
 		void *opaque, struct qat_sym_op_cookie *cookie,
 		struct rte_crypto_vec *src_vec, uint16_t n_src,
-		struct rte_crypto_vec *dst_vec, uint16_t n_dst)
+		struct rte_crypto_vec *dst_vec, uint16_t n_dst,
+		union rte_crypto_sym_ofs *ofs, struct rte_crypto_op *op)
 {
 	struct qat_sgl *list;
 	uint32_t i;
@@ -502,6 +503,24 @@ qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_req *req,
 			dst_data_start = src_data_start;
 	}
 
+	/* For crypto API only try to align the in-place buffers*/
+	if (op != NULL && likely(n_dst == 0)) {
+		uint16_t offset = src_data_start & RTE_CACHE_LINE_MASK;
+		if (offset) {
+			rte_iova_t buff_addr = rte_mbuf_iova_get(op->sym->m_src);
+			/* make sure src_data_start is still within the buffer */
+			if (src_data_start - offset >= buff_addr) {
+				src_data_start -= offset;
+				dst_data_start = src_data_start;
+				ofs->ofs.auth.head += offset;
+				ofs->ofs.cipher.head += offset;
+				tl_src += offset;
+				total_len_src = tl_src;
+				total_len_dst = tl_src;
+			}
+		}
+	}
+
 	req->comn_mid.src_data_addr = src_data_start;
 	req->comn_mid.dest_data_addr = dst_data_start;
 	req->comn_mid.src_length = total_len_src;
diff --git a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
index 8cb85fd8df..6da0f6c645 100644
--- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
@@ -242,7 +242,7 @@ qat_sym_build_op_cipher_gen1(void *in_op, struct qat_sym_session *ctx,
 	}
 
 	total_len = qat_sym_build_req_set_data(req, in_op, cookie,
-			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &ofs, op);
 	if (unlikely(total_len < 0)) {
 		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		return -EINVAL;
@@ -294,7 +294,7 @@ qat_sym_build_op_auth_gen1(void *in_op, struct qat_sym_session *ctx,
 				req->comn_hdr.serv_specif_flags, 0);
 
 	total_len = qat_sym_build_req_set_data(req, in_op, cookie,
-			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &ofs, op);
 	if (unlikely(total_len < 0)) {
 		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		return -EINVAL;
@@ -339,7 +339,7 @@ qat_sym_build_op_aead_gen1(void *in_op, struct qat_sym_session *ctx,
 	}
 
 	total_len = qat_sym_build_req_set_data(req, in_op, cookie,
-			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &ofs, op);
 	if (unlikely(total_len < 0)) {
 		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		return -EINVAL;
@@ -384,7 +384,7 @@ qat_sym_build_op_chain_gen1(void *in_op, struct qat_sym_session *ctx,
 	}
 
 	total_len = qat_sym_build_req_set_data(req, in_op, cookie,
-			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num);
+			in_sgl.vec, in_sgl.num, out_sgl.vec, out_sgl.num, &ofs, op);
 	if (unlikely(total_len < 0)) {
 		op->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
 		return -EINVAL;
@@ -512,7 +512,7 @@ qat_sym_dp_enqueue_single_cipher_gen1(void *qp_data, uint8_t *drv_ctx,
 	rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
 
 	data_len = qat_sym_build_req_set_data(req, user_data, cookie,
-			data, n_data_vecs, NULL, 0);
+			data, n_data_vecs, NULL, 0, NULL, NULL);
 	if (unlikely(data_len < 0))
 		return -1;
 
@@ -571,7 +571,7 @@ qat_sym_dp_enqueue_cipher_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
 				vec->src_sgl[i].vec,
-				vec->src_sgl[i].num, NULL, 0);
+				vec->src_sgl[i].num, NULL, 0, NULL, NULL);
 		}
 
 		if (unlikely(data_len < 0 || error))
@@ -623,7 +623,7 @@ qat_sym_dp_enqueue_single_auth_gen1(void *qp_data, uint8_t *drv_ctx,
 	rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 	rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
 	data_len = qat_sym_build_req_set_data(req, user_data, cookie,
-			data, n_data_vecs, NULL, 0);
+			data, n_data_vecs, NULL, 0, NULL, NULL);
 	if (unlikely(data_len < 0))
 		return -1;
 
@@ -690,7 +690,7 @@ qat_sym_dp_enqueue_auth_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
 				vec->src_sgl[i].vec,
-				vec->src_sgl[i].num, NULL, 0);
+				vec->src_sgl[i].num, NULL, 0, NULL, NULL);
 		}
 
 		if (unlikely(data_len < 0 || error))
@@ -747,7 +747,7 @@ qat_sym_dp_enqueue_single_chain_gen1(void *qp_data, uint8_t *drv_ctx,
 	rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 	rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
 	data_len = qat_sym_build_req_set_data(req, user_data, cookie,
-			data, n_data_vecs, NULL, 0);
+			data, n_data_vecs, NULL, 0, NULL, NULL);
 	if (unlikely(data_len < 0))
 		return -1;
 
@@ -815,7 +815,7 @@ qat_sym_dp_enqueue_chain_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
 				vec->src_sgl[i].vec,
-				vec->src_sgl[i].num, NULL, 0);
+				vec->src_sgl[i].num, NULL, 0, NULL, NULL);
 		}
 
 		if (unlikely(data_len < 0 || error))
@@ -877,7 +877,7 @@ qat_sym_dp_enqueue_single_aead_gen1(void *qp_data, uint8_t *drv_ctx,
 	rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
 	rte_prefetch0((uint8_t *)tx_queue->base_addr + tail);
 	data_len = qat_sym_build_req_set_data(req, user_data, cookie,
-			data, n_data_vecs, NULL, 0);
+			data, n_data_vecs, NULL, 0, NULL, NULL);
 	if (unlikely(data_len < 0))
 		return -1;
 
@@ -936,7 +936,7 @@ qat_sym_dp_enqueue_aead_jobs_gen1(void *qp_data, uint8_t *drv_ctx,
 			data_len = qat_sym_build_req_set_data(req,
 				user_data[i], cookie,
 				vec->src_sgl[i].vec,
-				vec->src_sgl[i].num, NULL, 0);
+				vec->src_sgl[i].num, NULL, 0, NULL, NULL);
 		}
 
 		if (unlikely(data_len < 0) || error)
-- 
2.50.1

