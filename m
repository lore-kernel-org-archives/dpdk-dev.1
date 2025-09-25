Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E18CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 10:22:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 014D340665;
	Thu, 25 Sep 2025 12:22:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 4DACF402AB;
 Thu, 25 Sep 2025 12:22:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758795749; x=1790331749;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DwXqARQyxjtDDLnQJFqfZV51dcmTLCbihaPS+vUL4QM=;
 b=S5yka6taITYTFHcQqnNkmAivpihgkV7InJpieH8dnwJpj1PkbUub+yAs
 4mxXhM5NbeCy6Srrb9k3up9Lw6p3Oc7jveua7lvb7+LET78Wv6SOpYkMU
 dRVZxN+dSGgwoJbBQBjtuN8u3ZlzVdnP2R2ZeNrJxSNdsiNJoLBJJfB5U
 KO6bLltTOcT/C+eSi5Z6Ahwn703KnUXI54M/IuBlu3IkGfauwLDah48NS
 luSDoShcg7TXJmZdKXkWNnv0L7jCBRutp01qtn3RDKHV+fH+PFRKqeHOU
 LronAroummKnE8nyTh5DveyelhzeoT8WsJTZ/q2fhcCZB1xQ79pTWbd3t g==;
X-CSE-ConnectionGUID: NwWAq9RxRaq4KY+EWjeJ5A==
X-CSE-MsgGUID: eLhitOYqS+amVtv0IvlU0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="86554124"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="86554124"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 03:22:28 -0700
X-CSE-ConnectionGUID: u2+4ftWaTuW+zGQ3AS6ihA==
X-CSE-MsgGUID: ovsrY0UiRISdOmW96cOIGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="181299826"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by orviesa003.jf.intel.com with ESMTP; 25 Sep 2025 03:22:27 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, stable@dpdk.org,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [dpdk-dev v1] cryptodev: introduce constant-time memory comparison
Date: Thu, 25 Sep 2025 10:22:23 +0000
Message-Id: <20250925102223.145471-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
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

Add rte_consttime_memcmp() to prevent timing attacks in cryptographic
digest verification operations.

Replace memcmp() with rte_consttime_memcmp() in cryptographic
authentication verification operations across multiple crypto drivers:

* ipsec_mb
* scheduler

Note: OpenSSL crypto driver already uses CRYPTO_memcmp() which
provides equivalent timing attack resistance and is left unchanged.

Bugzilla ID: 1773
Cc: stable@dpdk.org

[0] https://bugs.dpdk.org/show_bug.cgi?id=1773

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c       |  4 ++--
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c        |  6 ++---
 drivers/crypto/ipsec_mb/pmd_snow3g.c          |  2 +-
 drivers/crypto/ipsec_mb/pmd_zuc.c             |  2 +-
 .../scheduler/rte_cryptodev_scheduler.c       |  2 +-
 lib/cryptodev/rte_cryptodev.h                 | 23 +++++++++++++++++++
 6 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
index 8d40bd9169..ef8503d904 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -206,7 +206,7 @@ post_process_gcm_crypto_op(struct ipsec_mb_qp *qp,
 				tag, session->req_digest_length);
 #endif
 
-		if (memcmp(tag, digest,	session->req_digest_length) != 0)
+		if (rte_consttime_memcmp(tag, digest, session->req_digest_length) != 0)
 			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 	} else {
 		if (session->req_digest_length != session->gen_digest_length) {
@@ -558,7 +558,7 @@ aesni_gcm_sgl_op_finalize_decryption(const struct aesni_gcm_session *s,
 	ops.finalize_dec(&s->gdata_key, gdata_ctx, tmpdigest,
 			s->gen_digest_length);
 
-	return memcmp(digest, tmpdigest, s->req_digest_length) == 0 ? 0
+	return rte_consttime_memcmp(digest, tmpdigest, s->req_digest_length) == 0 ? 0
 								    : EBADMSG;
 }
 
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index a6c3f09b6f..78fc59c4bf 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1902,7 +1902,7 @@ verify_docsis_sec_crc(IMB_JOB *job, uint8_t *status)
 	crc = job->dst + crc_offset;
 
 	/* Verify CRC (at the end of the message) */
-	if (memcmp(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN) != 0)
+	if (rte_consttime_memcmp(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN) != 0)
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -1910,7 +1910,7 @@ static inline void
 verify_digest(IMB_JOB *job, void *digest, uint16_t len, uint8_t *status)
 {
 	/* Verify digest if required */
-	if (memcmp(job->auth_tag_output, digest, len) != 0)
+	if (rte_consttime_memcmp(job->auth_tag_output, digest, len) != 0)
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -2305,7 +2305,7 @@ verify_sync_dgst(struct rte_crypto_sym_vec *vec,
 
 	for (i = 0, k = 0; i != vec->num; i++) {
 		if (vec->status[i] == 0) {
-			if (memcmp(vec->digest[i].va, dgst[i], len) != 0)
+			if (rte_consttime_memcmp(vec->digest[i].va, dgst[i], len) != 0)
 				vec->status[i] = EBADMSG;
 			else
 				k++;
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 65f0e5c568..7c900d11de 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -269,7 +269,7 @@ process_snow3g_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 					&session->pKeySched_hash,
 					iv, src, length_in_bits, dst);
 			/* Verify digest. */
-			if (memcmp(dst, ops[i]->sym->auth.digest.data,
+			if (rte_consttime_memcmp(dst, ops[i]->sym->auth.digest.data,
 					SNOW3G_DIGEST_LENGTH) != 0)
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
diff --git a/drivers/crypto/ipsec_mb/pmd_zuc.c b/drivers/crypto/ipsec_mb/pmd_zuc.c
index 44781be1d1..c3f109289b 100644
--- a/drivers/crypto/ipsec_mb/pmd_zuc.c
+++ b/drivers/crypto/ipsec_mb/pmd_zuc.c
@@ -185,7 +185,7 @@ process_zuc_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 	 */
 	for (i = 0; i < processed_ops; i++)
 		if (sessions[i]->auth_op == RTE_CRYPTO_AUTH_OP_VERIFY)
-			if (memcmp(dst[i], ops[i]->sym->auth.digest.data,
+			if (rte_consttime_memcmp(dst[i], ops[i]->sym->auth.digest.data,
 					ZUC_DIGEST_LENGTH) != 0)
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
diff --git a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
index 1ca8443431..158d6332b8 100644
--- a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
+++ b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
@@ -100,7 +100,7 @@ check_sec_cap_equal(const struct rte_security_capability *sec_cap1,
 		return 0;
 
 	if (sec_cap1->protocol == RTE_SECURITY_PROTOCOL_DOCSIS)
-		return !memcmp(&sec_cap1->docsis, &sec_cap2->docsis,
+		return !rte_consttime_memcmp(&sec_cap1->docsis, &sec_cap2->docsis,
 				sizeof(sec_cap1->docsis));
 	else
 		return 0;
diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
index eaf0e50d37..77f10fbf88 100644
--- a/lib/cryptodev/rte_cryptodev.h
+++ b/lib/cryptodev/rte_cryptodev.h
@@ -78,6 +78,29 @@ extern int rte_cryptodev_logtype;
 #define rte_crypto_op_ctophys_offset(c, o)	\
 	(rte_iova_t)((c)->phys_addr + (o))
 
+/**
+ * Constant-time memory comparison for cryptographic use.
+ * Returns 0 if the memory regions are equal, nonzero otherwise.
+ * Runs in constant time with respect to the length to prevent timing attacks.
+ *
+ * @param a
+ *   Pointer to the first memory region.
+ * @param b
+ *   Pointer to the second memory region.
+ * @param n
+ *   Number of bytes to compare.
+ * @return
+ *   0 if memory regions are equal, nonzero otherwise.
+ */
+#define rte_consttime_memcmp(a, b, n) __extension__ ({ \
+	const volatile uint8_t *__pa = (const volatile uint8_t *)(a); \
+	const volatile uint8_t *__pb = (const volatile uint8_t *)(b); \
+	uint8_t __result = 0; \
+	for (size_t __i = 0; __i < (n); __i++) \
+		__result |= __pa[__i] ^ __pb[__i]; \
+	__result; \
+})
+
 /**
  * Crypto parameters range description
  */
-- 
2.34.1

