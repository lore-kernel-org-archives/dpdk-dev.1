Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F0ECAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 14:51:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3141A40696;
	Mon, 29 Sep 2025 16:50:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5C90240696;
 Mon, 29 Sep 2025 16:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759157457; x=1790693457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9DDLa803nVxJbZKmXZ46ItV9A8l9IDhJHAsVdDoST+k=;
 b=GnCy5vCzHje/rVTZmflTYmm/tx67SDn7JQr9vsY0A4rxT/1cwnf76Exl
 4yLGPC5KHonv/7x+odolukSyHEprwmOYFjYF9xnAPx+nxip+cffMbKZNh
 d9z689j2Pc27hpNuS6XOaO2FLJVsQ6vvl7HXfhMGkqb7CHi7TKYC508tq
 +NPu9c5BfeggEFRT8HJY21Gazi/wbIFSHYcNJZqGGuipqTsnzuFfxLRq5
 GanUWaZfYA6pAkxlD3PxmTs75JEX+AF7hHEPoNSWEhsjAZ7sg4uQbxLIW
 EbmLf1e93gxrtoRwpIXMZvRkP9QoYPORWYJhh3cZkCH4czEDpTFdbszwD g==;
X-CSE-ConnectionGUID: 05ptiMueRT6KBNDzQFF3dg==
X-CSE-MsgGUID: 1dQ/5OeUTO2eHCMrQdvnDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72078810"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="72078810"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 07:50:56 -0700
X-CSE-ConnectionGUID: o0iEvw49Q8C4619NWcDHYw==
X-CSE-MsgGUID: 25lcHUXQSECuqnMNFqaKjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="177507203"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by orviesa010.jf.intel.com with ESMTP; 29 Sep 2025 07:50:55 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Kai Ji <kai.ji@intel.com>, stable@dpdk.org
Subject: [dpdk-dev v4 2/2] crypto/ipsec-mb: use constant-time memory comparison
Date: Mon, 29 Sep 2025 14:50:49 +0000
Message-Id: <20250929145049.153078-2-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929145049.153078-1-kai.ji@intel.com>
References: <20250926160209.56496-1-kai.ji@intel.com>
 <20250929145049.153078-1-kai.ji@intel.com>
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

Replace memcmp() with rte_memneq_consttime() in cryptographic
authentication verification operations across iipsec-mb drivers.

Note: OpenSSL crypto driver already uses CRYPTO_memcmp() which
provides equivalent timing attack resistance and is left unchanged.

Note: scheduler driver memcmp stays unchanged as its not secret data
comparison and actually faster with no timing attack risk.

Bugzilla ID: 1773
Cc: stable@dpdk.org

[0] https://bugs.dpdk.org/show_bug.cgi?id=1773

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c | 5 ++---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c  | 6 +++---
 drivers/crypto/ipsec_mb/pmd_snow3g.c    | 4 ++--
 drivers/crypto/ipsec_mb/pmd_zuc.c       | 4 ++--
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
index 8d40bd9169..a3d1d19025 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -206,7 +206,7 @@ post_process_gcm_crypto_op(struct ipsec_mb_qp *qp,
 				tag, session->req_digest_length);
 #endif
 
-		if (memcmp(tag, digest,	session->req_digest_length) != 0)
+		if (rte_memneq_consttime(tag, digest, session->req_digest_length))
 			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 	} else {
 		if (session->req_digest_length != session->gen_digest_length) {
@@ -558,8 +558,7 @@ aesni_gcm_sgl_op_finalize_decryption(const struct aesni_gcm_session *s,
 	ops.finalize_dec(&s->gdata_key, gdata_ctx, tmpdigest,
 			s->gen_digest_length);
 
-	return memcmp(digest, tmpdigest, s->req_digest_length) == 0 ? 0
-								    : EBADMSG;
+	return rte_memneq_consttime(digest, tmpdigest, s->req_digest_length) ? EBADMSG : 0;
 }
 
 static inline void
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index a6c3f09b6f..f0f67faa46 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1902,7 +1902,7 @@ verify_docsis_sec_crc(IMB_JOB *job, uint8_t *status)
 	crc = job->dst + crc_offset;
 
 	/* Verify CRC (at the end of the message) */
-	if (memcmp(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN) != 0)
+	if (rte_memneq_consttime(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN))
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -1910,7 +1910,7 @@ static inline void
 verify_digest(IMB_JOB *job, void *digest, uint16_t len, uint8_t *status)
 {
 	/* Verify digest if required */
-	if (memcmp(job->auth_tag_output, digest, len) != 0)
+	if (rte_memneq_consttime(job->auth_tag_output, digest, len))
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -2305,7 +2305,7 @@ verify_sync_dgst(struct rte_crypto_sym_vec *vec,
 
 	for (i = 0, k = 0; i != vec->num; i++) {
 		if (vec->status[i] == 0) {
-			if (memcmp(vec->digest[i].va, dgst[i], len) != 0)
+			if (rte_memneq_consttime(vec->digest[i].va, dgst[i], len))
 				vec->status[i] = EBADMSG;
 			else
 				k++;
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 65f0e5c568..5d99ea568f 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -269,8 +269,8 @@ process_snow3g_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 					&session->pKeySched_hash,
 					iv, src, length_in_bits, dst);
 			/* Verify digest. */
-			if (memcmp(dst, ops[i]->sym->auth.digest.data,
-					SNOW3G_DIGEST_LENGTH) != 0)
+			if (rte_memneq_consttime(dst, ops[i]->sym->auth.digest.data,
+					SNOW3G_DIGEST_LENGTH))
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 		} else {
diff --git a/drivers/crypto/ipsec_mb/pmd_zuc.c b/drivers/crypto/ipsec_mb/pmd_zuc.c
index 44781be1d1..466f6594e5 100644
--- a/drivers/crypto/ipsec_mb/pmd_zuc.c
+++ b/drivers/crypto/ipsec_mb/pmd_zuc.c
@@ -185,8 +185,8 @@ process_zuc_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 	 */
 	for (i = 0; i < processed_ops; i++)
 		if (sessions[i]->auth_op == RTE_CRYPTO_AUTH_OP_VERIFY)
-			if (memcmp(dst[i], ops[i]->sym->auth.digest.data,
-					ZUC_DIGEST_LENGTH) != 0)
+			if (rte_memneq_consttime(dst[i], ops[i]->sym->auth.digest.data,
+					ZUC_DIGEST_LENGTH))
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 
-- 
2.34.1

