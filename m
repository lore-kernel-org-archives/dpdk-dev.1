Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAF9CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 15:49:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82B5340695;
	Fri, 26 Sep 2025 17:49:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id DEF1C40695;
 Fri, 26 Sep 2025 17:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758901755; x=1790437755;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L8gfBKP40HVTlnjABHMp8Xs+6z85ILKDIHm7Qb7Nr/k=;
 b=ep7iS6tj2+kI02nmsR3u9uFMT6+tKts/1tL2/GgclB1NfsD8BCCBJpoU
 MvBQwa/7kdNySovgPCPe+I76hvhikmExj2BteT3/SKDajqbJzrYZLvUnz
 1QuUiC4EwuO8meehYFI1ffcYxe7X0aTkKByfNdy7J4s39brUUgp0PS+47
 1fxenV5VzH5P/pmPxr+FiIvQjY4+OvdZxW94OrUewSNup0c31rPSfrr9o
 Lpa4M36ePwrMguCyFAq3Di43GUc/B1NCxkQp5/3CGU3OWBjHdYYqGwE9l
 ufYzeB8tXMYpH4Z7/YyIq02oGNbmTNr048+GgZxnJ+gx8gn23X/hr8SOy g==;
X-CSE-ConnectionGUID: pfkEicz7TleHaQCXenhQKQ==
X-CSE-MsgGUID: cXrwNxpCQ9OpbW6uzQ14Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61405469"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="61405469"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 08:49:14 -0700
X-CSE-ConnectionGUID: qOuCjL5uTW2PkdYQts5O2g==
X-CSE-MsgGUID: OEjszFp0Q46CM0Nx9HzKAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; d="scan'208";a="177694261"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by orviesa008.jf.intel.com with ESMTP; 26 Sep 2025 08:49:12 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, Kai Ji <kai.ji@intel.com>, stable@dpdk.org
Subject: [dpdk-dev v2 2/2] crypto/ipsec-mb: use constant-time memory comparison
Date: Fri, 26 Sep 2025 15:49:05 +0000
Message-Id: <20250926154905.54416-2-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926154905.54416-1-kai.ji@intel.com>
References: <20250925102223.145471-1-kai.ji@intel.com>
 <20250926154905.54416-1-kai.ji@intel.com>
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

Replace memcmp() with rte_consttime_memsq() in cryptographic
authentication verification operations across multiple crypto drivers:

* ipsec_mb

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
index 8d40bd9169..bfe119bf77 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -206,7 +206,7 @@ post_process_gcm_crypto_op(struct ipsec_mb_qp *qp,
 				tag, session->req_digest_length);
 #endif
 
-		if (memcmp(tag, digest,	session->req_digest_length) != 0)
+		if (rte_consttime_memneq(tag, digest, session->req_digest_length))
 			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 	} else {
 		if (session->req_digest_length != session->gen_digest_length) {
@@ -558,8 +558,7 @@ aesni_gcm_sgl_op_finalize_decryption(const struct aesni_gcm_session *s,
 	ops.finalize_dec(&s->gdata_key, gdata_ctx, tmpdigest,
 			s->gen_digest_length);
 
-	return memcmp(digest, tmpdigest, s->req_digest_length) == 0 ? 0
-								    : EBADMSG;
+	return rte_consttime_memneq(digest, tmpdigest, s->req_digest_length) ? EBADMSG : 0;
 }
 
 static inline void
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index a6c3f09b6f..f23a09376e 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1902,7 +1902,7 @@ verify_docsis_sec_crc(IMB_JOB *job, uint8_t *status)
 	crc = job->dst + crc_offset;
 
 	/* Verify CRC (at the end of the message) */
-	if (memcmp(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN) != 0)
+	if (rte_consttime_memneq(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN))
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -1910,7 +1910,7 @@ static inline void
 verify_digest(IMB_JOB *job, void *digest, uint16_t len, uint8_t *status)
 {
 	/* Verify digest if required */
-	if (memcmp(job->auth_tag_output, digest, len) != 0)
+	if (rte_consttime_memneq(job->auth_tag_output, digest, len))
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -2305,7 +2305,7 @@ verify_sync_dgst(struct rte_crypto_sym_vec *vec,
 
 	for (i = 0, k = 0; i != vec->num; i++) {
 		if (vec->status[i] == 0) {
-			if (memcmp(vec->digest[i].va, dgst[i], len) != 0)
+			if (rte_consttime_memneq(vec->digest[i].va, dgst[i], len))
 				vec->status[i] = EBADMSG;
 			else
 				k++;
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 65f0e5c568..befb60e473 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -269,8 +269,8 @@ process_snow3g_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 					&session->pKeySched_hash,
 					iv, src, length_in_bits, dst);
 			/* Verify digest. */
-			if (memcmp(dst, ops[i]->sym->auth.digest.data,
-					SNOW3G_DIGEST_LENGTH) != 0)
+			if (rte_consttime_memneq(dst, ops[i]->sym->auth.digest.data,
+					SNOW3G_DIGEST_LENGTH))
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 		} else {
diff --git a/drivers/crypto/ipsec_mb/pmd_zuc.c b/drivers/crypto/ipsec_mb/pmd_zuc.c
index 44781be1d1..8f0be0465a 100644
--- a/drivers/crypto/ipsec_mb/pmd_zuc.c
+++ b/drivers/crypto/ipsec_mb/pmd_zuc.c
@@ -185,8 +185,8 @@ process_zuc_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 	 */
 	for (i = 0; i < processed_ops; i++)
 		if (sessions[i]->auth_op == RTE_CRYPTO_AUTH_OP_VERIFY)
-			if (memcmp(dst[i], ops[i]->sym->auth.digest.data,
-					ZUC_DIGEST_LENGTH) != 0)
+			if (rte_consttime_memneq(dst[i], ops[i]->sym->auth.digest.data,
+					ZUC_DIGEST_LENGTH))
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 
-- 
2.34.1

