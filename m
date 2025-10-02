Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D92CCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 15:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEF144042C;
	Thu,  2 Oct 2025 17:32:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5FC6940268
 for <dev@dpdk.org>; Thu,  2 Oct 2025 17:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759419156; x=1790955156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=svNLDhx5o3rzX7TPzLjOjrRwCeTfEVwhVxtcI0gdnOw=;
 b=ZcYd004tczW5CSiKfidQ5GK3Fhq6EjZDDIyyQVWoBTYV4PNN4j+NW9Mz
 Bof5tY0bvVPrt/OLlibabsNlEjbeE4xJkkCLumNjeIfnPh8SAQJTHObmV
 sfztt8vTa6OMM67OHpkQYCRxvuW5tW+5H7z0yQixyo5laWVt4mOc4Gggt
 xVd+dA9oGiNRQTsZWRsLZtYNoycKZGRtgd9q/a6xO6hPS0YtVp0Xqffob
 g5Rtc/IJ4c/xEsDI2830R6xQAWzoZgprVY/lfdEMh9xsqUkMl2OK4aPoX
 IF/Q56UBVDmBHYVQfF/7dwzpSFtjDmBhscac27j4Tv2INWLz/xt0yp8ad Q==;
X-CSE-ConnectionGUID: YAwp9GAlRYSHprdgXT27Cg==
X-CSE-MsgGUID: USTxk21GT8ufgB94F7VvHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61866733"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="61866733"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 08:32:35 -0700
X-CSE-ConnectionGUID: 4dXgi/neQOWalwcjfY7CDQ==
X-CSE-MsgGUID: 6ShtFadBRvSJELTR9q+60A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="179016173"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2025 08:32:33 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v6 2/2] crypto/ipsec-mb: use constant-time memory comparison
Date: Thu,  2 Oct 2025 15:32:29 +0000
Message-Id: <20251002153229.98158-2-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002153229.98158-1-kai.ji@intel.com>
References: <20251001153242.55987-1-kai.ji@intel.com>
 <20251002153229.98158-1-kai.ji@intel.com>
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

Replace memcmp() with rte_timingsafe_memcmp() in cryptographic
authentication verification operations across iipsec-mb drivers.

Note: OpenSSL crypto driver already uses CRYPTO_memcmp() which
provides equivalent timing attack resistance and is left unchanged.

Note: scheduler driver memcmp stays unchanged as its not secret data
comparison and actually faster with no timing attack risk.

Bugzilla ID: 1773
https://bugs.dpdk.org/show_bug.cgi?id=1773

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c | 5 ++---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c  | 6 +++---
 drivers/crypto/ipsec_mb/pmd_snow3g.c    | 4 ++--
 drivers/crypto/ipsec_mb/pmd_zuc.c       | 4 ++--
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
index 8d40bd9169..8c35820ef7 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -206,7 +206,7 @@ post_process_gcm_crypto_op(struct ipsec_mb_qp *qp,
 				tag, session->req_digest_length);
 #endif
 
-		if (memcmp(tag, digest,	session->req_digest_length) != 0)
+		if (!rte_memeq_timingsafe(tag, digest, session->req_digest_length))
 			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 	} else {
 		if (session->req_digest_length != session->gen_digest_length) {
@@ -558,8 +558,7 @@ aesni_gcm_sgl_op_finalize_decryption(const struct aesni_gcm_session *s,
 	ops.finalize_dec(&s->gdata_key, gdata_ctx, tmpdigest,
 			s->gen_digest_length);
 
-	return memcmp(digest, tmpdigest, s->req_digest_length) == 0 ? 0
-								    : EBADMSG;
+	return rte_memeq_timingsafe(digest, tmpdigest, s->req_digest_length) ? 0 : EBADMSG;
 }
 
 static inline void
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index a6c3f09b6f..251e2b42e2 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1902,7 +1902,7 @@ verify_docsis_sec_crc(IMB_JOB *job, uint8_t *status)
 	crc = job->dst + crc_offset;
 
 	/* Verify CRC (at the end of the message) */
-	if (memcmp(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN) != 0)
+	if (!rte_memeq_timingsafe(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN))
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -1910,7 +1910,7 @@ static inline void
 verify_digest(IMB_JOB *job, void *digest, uint16_t len, uint8_t *status)
 {
 	/* Verify digest if required */
-	if (memcmp(job->auth_tag_output, digest, len) != 0)
+	if (!rte_memeq_timingsafe(job->auth_tag_output, digest, len))
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -2305,7 +2305,7 @@ verify_sync_dgst(struct rte_crypto_sym_vec *vec,
 
 	for (i = 0, k = 0; i != vec->num; i++) {
 		if (vec->status[i] == 0) {
-			if (memcmp(vec->digest[i].va, dgst[i], len) != 0)
+			if (!rte_memeq_timingsafe(vec->digest[i].va, dgst[i], len))
 				vec->status[i] = EBADMSG;
 			else
 				k++;
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 65f0e5c568..b3c3b05a8a 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -269,8 +269,8 @@ process_snow3g_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 					&session->pKeySched_hash,
 					iv, src, length_in_bits, dst);
 			/* Verify digest. */
-			if (memcmp(dst, ops[i]->sym->auth.digest.data,
-					SNOW3G_DIGEST_LENGTH) != 0)
+			if (!rte_memeq_timingsafe(dst, ops[i]->sym->auth.digest.data,
+					SNOW3G_DIGEST_LENGTH))
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 		} else {
diff --git a/drivers/crypto/ipsec_mb/pmd_zuc.c b/drivers/crypto/ipsec_mb/pmd_zuc.c
index 44781be1d1..28ab6982f2 100644
--- a/drivers/crypto/ipsec_mb/pmd_zuc.c
+++ b/drivers/crypto/ipsec_mb/pmd_zuc.c
@@ -185,8 +185,8 @@ process_zuc_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 	 */
 	for (i = 0; i < processed_ops; i++)
 		if (sessions[i]->auth_op == RTE_CRYPTO_AUTH_OP_VERIFY)
-			if (memcmp(dst[i], ops[i]->sym->auth.digest.data,
-					ZUC_DIGEST_LENGTH) != 0)
+			if (!rte_memeq_timingsafe(dst[i], ops[i]->sym->auth.digest.data,
+					ZUC_DIGEST_LENGTH))
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 
-- 
2.34.1

