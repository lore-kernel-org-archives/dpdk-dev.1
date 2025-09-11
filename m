Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD68CAC587
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 13:14:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDC0C402D3;
	Thu, 11 Sep 2025 15:14:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8B7E9402C4
 for <dev@dpdk.org>; Thu, 11 Sep 2025 15:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757596493; x=1789132493;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ppPYDJlHwGxJgyxIJqTkBcENR7hEY5+82Ap053BRY3s=;
 b=muOjRwstSLIfvn+MZCRm4blDZPaZWJH1BYSv/PGKKLXYn8TW8Q7RnznL
 BS1zefZ/bV/BfBjnUXp6uSWD3Xu0rBxNMkWXnWCOn+XaUPphZrr1gLUDx
 CNXiiqRTGCJSljpbDwkPfEdN7l/bJI9fiBJA5CYtSOzibQbU6ZZR5/PFO
 Q/ylfoK6fqBvirGu42miAjOcwpfe1YJz4ITQaSJz+W34kX5bsq6vGbyUy
 i/N022gKc1LvNr94NO39sL7ffyMtUNfSWJH9RtW8maNG7Ns6AWL935J1b
 iPPU7cRQXH26Td8qBcRHPrE4PVfICtER8DWoWLat0sd5IKf/eQyeBt7uY Q==;
X-CSE-ConnectionGUID: 70uyXQp/RrmsKJ1WSxmjGQ==
X-CSE-MsgGUID: GkVdupGLTg29LS3uA0q+og==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70182721"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="70182721"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 06:14:52 -0700
X-CSE-ConnectionGUID: Quv4huUXSKSZY5i82K5SrQ==
X-CSE-MsgGUID: fOMDEN2ARcK6AR4ujrdNgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="172864962"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2025 06:14:49 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v2 1/3] crypto/ipsec_mb: improve CPU code path
Date: Thu, 11 Sep 2025 13:14:36 +0000
Message-ID: <20250911131447.1247417-1-radu.nicolau@intel.com>
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

Improve CPU code path with support for OOP and various small fixes.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 124 +++++++++++++++++--------
 1 file changed, 86 insertions(+), 38 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index a6c3f09b6f..356e6cd4a0 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -975,14 +975,24 @@ aesni_mb_set_docsis_sec_session_parameters(
 	return ret;
 }
 
+static inline uint8_t *get_src_buf(struct rte_crypto_op *op)
+{
+	return op->sym->m_src ?
+	rte_pktmbuf_mtod(op->sym->m_src, uint8_t *) : NULL;
+}
+static inline uint8_t *get_dst_buf(struct rte_crypto_op *op)
+{
+	return op->sym->m_dst ?
+	rte_pktmbuf_mtod(op->sym->m_dst, uint8_t *) : NULL;
+}
+
 static inline uint64_t
-auth_start_offset(struct rte_crypto_op *op, struct aesni_mb_session *session,
+auth_start_offset(uint8_t *p_src, uint8_t *p_dst,
+		struct aesni_mb_session *session,
 		uint32_t oop, const uint32_t auth_offset,
 		const uint32_t cipher_offset, const uint32_t auth_length,
 		const uint32_t cipher_length, uint8_t lb_sgl)
 {
-	struct rte_mbuf *m_src, *m_dst;
-	uint8_t *p_src, *p_dst;
 	uintptr_t u_src, u_dst;
 	uint32_t cipher_end, auth_end;
 
@@ -990,11 +1000,6 @@ auth_start_offset(struct rte_crypto_op *op, struct aesni_mb_session *session,
 	if (!oop || session->template_job.chain_order != IMB_ORDER_CIPHER_HASH || lb_sgl)
 		return auth_offset;
 
-	m_src = op->sym->m_src;
-	m_dst = op->sym->m_dst;
-
-	p_src = rte_pktmbuf_mtod(m_src, uint8_t *);
-	p_dst = rte_pktmbuf_mtod(m_dst, uint8_t *);
 	u_src = (uintptr_t)p_src;
 	u_dst = (uintptr_t)p_dst + auth_offset;
 
@@ -1029,9 +1034,11 @@ auth_start_offset(struct rte_crypto_op *op, struct aesni_mb_session *session,
 
 static inline void
 set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
-		union rte_crypto_sym_ofs sofs, void *buf, uint32_t len,
-		struct rte_crypto_va_iova_ptr *iv,
-		struct rte_crypto_va_iova_ptr *aad, void *digest, void *udata)
+		union rte_crypto_sym_ofs sofs, void *src_buf, void *dst_buf,
+		uint32_t len, struct rte_crypto_va_iova_ptr *iv,
+		struct rte_crypto_va_iova_ptr *aad,
+		void **digest, struct rte_crypto_va_iova_ptr *vec_digest,
+		void *udata)
 {
 	memcpy(job, &session->template_job, sizeof(IMB_JOB));
 
@@ -1065,10 +1072,7 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
 #endif
 
 	default:
-		job->u.HMAC._hashed_auth_key_xor_ipad =
-				session->auth.pads.inner;
-		job->u.HMAC._hashed_auth_key_xor_opad =
-				session->auth.pads.outer;
+		break;
 	}
 
 	/*
@@ -1076,20 +1080,48 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
 	 * digest length as specified in the relevant IPsec RFCs
 	 */
 
-	/* Set digest location and length */
-	job->auth_tag_output = digest;
-
 	/* Data Parameters */
-	job->src = buf;
-	job->dst = (uint8_t *)buf + sofs.ofs.cipher.head;
+	job->src = src_buf;
+	if (dst_buf)
+		job->dst = (uint8_t *)dst_buf + sofs.ofs.cipher.head;
+	else
+		job->dst = (uint8_t *)src_buf + sofs.ofs.cipher.head;
 	job->cipher_start_src_offset_in_bytes = sofs.ofs.cipher.head;
-	job->hash_start_src_offset_in_bytes = sofs.ofs.auth.head;
 	job->msg_len_to_hash_in_bytes = len - sofs.ofs.auth.head -
 		sofs.ofs.auth.tail;
 	job->msg_len_to_cipher_in_bytes = len - sofs.ofs.cipher.head -
 		sofs.ofs.cipher.tail;
+	job->hash_start_src_offset_in_bytes = auth_start_offset(
+				src_buf, dst_buf,
+				session, dst_buf != NULL,
+				sofs.ofs.auth.head,
+				sofs.ofs.cipher.head,
+				job->msg_len_to_hash_in_bytes,
+				job->msg_len_to_cipher_in_bytes, 0);
 
 	job->user_data = udata;
+
+	/** Check if conditions are met for digest-appended operations */
+	if (job->cipher_mode != IMB_CIPHER_NULL && job->chain_order == IMB_ORDER_HASH_CIPHER) {
+		uintptr_t end_cipher, start_cipher;
+		if (dst_buf == NULL) {
+			end_cipher = (uintptr_t)src_buf + job->msg_len_to_cipher_in_bytes;
+			start_cipher = (uintptr_t)src_buf;
+		} else {
+			end_cipher = (uintptr_t)dst_buf + job->msg_len_to_cipher_in_bytes;
+			start_cipher = (uintptr_t)dst_buf;
+		}
+		if (start_cipher < (uintptr_t)vec_digest->va &&
+			(uintptr_t)vec_digest->va < end_cipher)
+			*digest = (void *)((uintptr_t)src_buf + job->msg_len_to_hash_in_bytes);
+	}
+	job->auth_tag_output = *digest;
+
+	if (job->cipher_mode == IMB_CIPHER_NULL && dst_buf) {
+		memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
+			job->src + job->cipher_start_src_offset_in_bytes,
+			job->msg_len_to_cipher_in_bytes);
+	}
 }
 
 static int
@@ -1693,7 +1725,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		auth_len_in_bytes = op->sym->auth.data.length >> 3;
 		ciph_len_in_bytes = op->sym->cipher.data.length >> 3;
 
-		job->hash_start_src_offset_in_bytes = auth_start_offset(op,
+		job->hash_start_src_offset_in_bytes = auth_start_offset(
+				get_src_buf(op), get_dst_buf(op),
 				session, oop, auth_off_in_bytes,
 				ciph_off_in_bytes, auth_len_in_bytes,
 				ciph_len_in_bytes, lb_sgl);
@@ -1710,7 +1743,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		auth_len_in_bytes = op->sym->auth.data.length >> 3;
 		ciph_len_in_bytes = op->sym->cipher.data.length >> 3;
 
-		job->hash_start_src_offset_in_bytes = auth_start_offset(op,
+		job->hash_start_src_offset_in_bytes = auth_start_offset(
+				get_src_buf(op), get_dst_buf(op),
 				session, oop, auth_off_in_bytes,
 				ciph_off_in_bytes, auth_len_in_bytes,
 				ciph_len_in_bytes, lb_sgl);
@@ -1735,7 +1769,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 #endif
 
 	default:
-		job->hash_start_src_offset_in_bytes = auth_start_offset(op,
+		job->hash_start_src_offset_in_bytes = auth_start_offset(
+				get_src_buf(op), get_dst_buf(op),
 				session, oop, op->sym->auth.data.offset,
 				op->sym->cipher.data.offset,
 				op->sym->auth.data.length,
@@ -2261,12 +2296,16 @@ aesni_mb_dequeue_burst(void *queue_pair, struct rte_crypto_op **ops,
 }
 
 static inline int
-check_crypto_sgl(union rte_crypto_sym_ofs so, const struct rte_crypto_sgl *sgl)
+check_crypto_sgl(union rte_crypto_sym_ofs so,
+	const struct rte_crypto_sym_vec *vec, uint32_t idx)
 {
+	const struct rte_crypto_sgl *sgl_src = vec->src_sgl + idx;
+	const struct rte_crypto_sgl *sgl_dst = vec->dest_sgl ?
+		vec->dest_sgl + idx : NULL;
 	/* no multi-seg support with current AESNI-MB PMD */
-	if (sgl->num != 1)
+	if (sgl_src->num != 1 || (sgl_dst && sgl_dst->num != 1))
 		return -ENOTSUP;
-	else if (so.ofs.cipher.head + so.ofs.cipher.tail > sgl->vec[0].len)
+	else if (so.ofs.cipher.head + so.ofs.cipher.tail > sgl_src->vec[0].len)
 		return -EINVAL;
 	return 0;
 }
@@ -2275,7 +2314,11 @@ static inline IMB_JOB *
 submit_sync_job(IMB_MGR *mb_mgr)
 {
 #ifdef RTE_LIBRTE_PMD_AESNI_MB_DEBUG
-	return IMB_SUBMIT_JOB(mb_mgr);
+	IMB_JOB *job = IMB_SUBMIT_JOB(mb_mgr);
+	int err = imb_get_errno(mb_mgr);
+	if (err)
+		IPSEC_MB_LOG(ERR, "%s", imb_get_strerror(err));
+	return job;
 #else
 	return IMB_SUBMIT_JOB_NOCHECK(mb_mgr);
 #endif
@@ -2283,7 +2326,7 @@ submit_sync_job(IMB_MGR *mb_mgr)
 
 static inline uint32_t
 generate_sync_dgst(struct rte_crypto_sym_vec *vec,
-	const uint8_t dgst[][DIGEST_LENGTH_MAX], uint32_t len)
+	uint8_t *dgst[], uint32_t len)
 {
 	uint32_t i, k;
 
@@ -2299,7 +2342,7 @@ generate_sync_dgst(struct rte_crypto_sym_vec *vec,
 
 static inline uint32_t
 verify_sync_dgst(struct rte_crypto_sym_vec *vec,
-	const uint8_t dgst[][DIGEST_LENGTH_MAX], uint32_t len)
+	uint8_t *dgst[], uint32_t len)
 {
 	uint32_t i, k;
 
@@ -2322,11 +2365,12 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __rte_unused,
 {
 	int32_t ret;
 	uint32_t i, j, k, len;
-	void *buf;
+	void *src_buf, *dst_buf = NULL;
 	IMB_JOB *job;
 	IMB_MGR *mb_mgr;
 	struct aesni_mb_session *s = CRYPTODEV_GET_SYM_SESS_PRIV(sess);
 	uint8_t tmp_dgst[vec->num][DIGEST_LENGTH_MAX];
+	uint8_t *tmp_dgst_ptr[vec->num];
 
 	/* get per-thread MB MGR, create one if needed */
 	mb_mgr = get_per_thread_mb_mgr();
@@ -2334,13 +2378,15 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __rte_unused,
 		return 0;
 
 	for (i = 0, j = 0, k = 0; i != vec->num; i++) {
-		ret = check_crypto_sgl(sofs, vec->src_sgl + i);
+		ret = check_crypto_sgl(sofs, vec, i);
 		if (ret != 0) {
 			vec->status[i] = ret;
 			continue;
 		}
 
-		buf = vec->src_sgl[i].vec[0].base;
+		src_buf = vec->src_sgl[i].vec[0].base;
+		if (vec->dest_sgl != NULL && vec->dest_sgl[i].vec[0].base != NULL)
+			dst_buf = vec->dest_sgl[i].vec[0].base;
 		len = vec->src_sgl[i].vec[0].len;
 
 		job = IMB_GET_NEXT_JOB(mb_mgr);
@@ -2351,8 +2397,10 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __rte_unused,
 		}
 
 		/* Submit job for processing */
-		set_cpu_mb_job_params(job, s, sofs, buf, len, &vec->iv[i],
-			&vec->aad[i], tmp_dgst[i], &vec->status[i]);
+		tmp_dgst_ptr[i] = tmp_dgst[i];
+		set_cpu_mb_job_params(job, s, sofs, src_buf, dst_buf, len, &vec->iv[i],
+			&vec->aad[i], (void **)&tmp_dgst_ptr[i], &vec->digest[i],
+			&vec->status[i]);
 		job = submit_sync_job(mb_mgr);
 		j++;
 
@@ -2365,14 +2413,14 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __rte_unused,
 		k += flush_mb_sync_mgr(mb_mgr);
 
 	/* finish processing for successful jobs: check/update digest */
-	if (k != 0) {
+	if (k != 0 && s->template_job.hash_alg != IMB_AUTH_NULL) {
 		if (s->auth.operation == RTE_CRYPTO_AUTH_OP_VERIFY)
 			k = verify_sync_dgst(vec,
-				(const uint8_t (*)[DIGEST_LENGTH_MAX])tmp_dgst,
+				tmp_dgst_ptr,
 				s->auth.req_digest_len);
 		else
 			k = generate_sync_dgst(vec,
-				(const uint8_t (*)[DIGEST_LENGTH_MAX])tmp_dgst,
+				tmp_dgst_ptr,
 				s->auth.req_digest_len);
 	}
 
-- 
2.50.1

