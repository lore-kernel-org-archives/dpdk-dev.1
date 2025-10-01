Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8785CCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:32:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0EF340E01;
	Wed,  1 Oct 2025 17:32:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id EC251402E7
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759332770; x=1790868770;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BgFdfgHbEBp27QTo/uHtztND1VCLyRW0yWQTjRjFAS0=;
 b=KtHDECVlQvWmeYaLW05wxEQ1uGjffPJkBJTJlIjB320sCQf4VbMjkvOx
 bi2KaRo+ATYqQ0beQyJVPGEUUnXGHxQpz8r4mSuLM1+jbp87sagfOmVXI
 THql/QWlRW/ZZrj1cGqWY1tUhkvYpR/OjCiNqCqmCB2BojFw0VklWxRmW
 sihbGejaDCfVWBQ+gaTElYWb0JMJ8CgVP9B8NmDIwql6p6AlYJ33/qcjT
 VcYRXnv9UwhoH4CIJwXlal3q/ucHJ6N1w9qW/N+XOM2SeQ9WgG4yraunN
 Sz8AkkdQdnWHtEJWkp+jLMQYeXW2k5n7CqW/Y2wt67zEwZXNLrtMYllsk Q==;
X-CSE-ConnectionGUID: S5UxK7VBQFygf0y/kxAYqg==
X-CSE-MsgGUID: P6qcCDnwRF6g/rN7h9L0tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61648710"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; d="scan'208";a="61648710"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 08:32:49 -0700
X-CSE-ConnectionGUID: /8fsnKAyR0aC544Hj9hBWg==
X-CSE-MsgGUID: gRsTZytcQNuqTRaMMzJPFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; d="scan'208";a="215939840"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by orviesa001.jf.intel.com with ESMTP; 01 Oct 2025 08:32:48 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, konstantin.ananyev@huawei.com,
 bruce.richardson@intel.com, thomas@monjalon.net,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Kai Ji <kai.ji@intel.com>
Subject: [dpdk-dev v5 2/2] crypto/ipsec-mb: use constant-time memory comparison
Date: Wed,  1 Oct 2025 15:32:42 +0000
Message-Id: <20251001153242.55987-2-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001153242.55987-1-kai.ji@intel.com>
References: <20250929145049.153078-1-kai.ji@intel.com>
 <20251001153242.55987-1-kai.ji@intel.com>
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
 drivers/crypto/ipsec_mb/pmd_snow3g.c    | 2 +-
 drivers/crypto/ipsec_mb/pmd_zuc.c       | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
index 8d40bd9169..56670f3b81 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -206,7 +206,7 @@ post_process_gcm_crypto_op(struct ipsec_mb_qp *qp,
 				tag, session->req_digest_length);
 #endif
 
-		if (memcmp(tag, digest,	session->req_digest_length) != 0)
+		if (rte_timingsafe_memcmp(tag, digest, session->req_digest_length) != 0)
 			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 	} else {
 		if (session->req_digest_length != session->gen_digest_length) {
@@ -558,8 +558,7 @@ aesni_gcm_sgl_op_finalize_decryption(const struct aesni_gcm_session *s,
 	ops.finalize_dec(&s->gdata_key, gdata_ctx, tmpdigest,
 			s->gen_digest_length);
 
-	return memcmp(digest, tmpdigest, s->req_digest_length) == 0 ? 0
-								    : EBADMSG;
+	return rte_timingsafe_memcmp(digest, tmpdigest, s->req_digest_length) != 0 ? EBADMSG : 0;
 }
 
 static inline void
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index a6c3f09b6f..81169e3518 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1902,7 +1902,7 @@ verify_docsis_sec_crc(IMB_JOB *job, uint8_t *status)
 	crc = job->dst + crc_offset;
 
 	/* Verify CRC (at the end of the message) */
-	if (memcmp(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN) != 0)
+	if (rte_timingsafe_memcmp(job->auth_tag_output, crc, RTE_ETHER_CRC_LEN) != 0)
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -1910,7 +1910,7 @@ static inline void
 verify_digest(IMB_JOB *job, void *digest, uint16_t len, uint8_t *status)
 {
 	/* Verify digest if required */
-	if (memcmp(job->auth_tag_output, digest, len) != 0)
+	if (rte_timingsafe_memcmp(job->auth_tag_output, digest, len) != 0)
 		*status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 }
 
@@ -2305,7 +2305,7 @@ verify_sync_dgst(struct rte_crypto_sym_vec *vec,
 
 	for (i = 0, k = 0; i != vec->num; i++) {
 		if (vec->status[i] == 0) {
-			if (memcmp(vec->digest[i].va, dgst[i], len) != 0)
+			if (rte_timingsafe_memcmp(vec->digest[i].va, dgst[i], len) != 0)
 				vec->status[i] = EBADMSG;
 			else
 				k++;
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 65f0e5c568..79daf28119 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -269,7 +269,7 @@ process_snow3g_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 					&session->pKeySched_hash,
 					iv, src, length_in_bits, dst);
 			/* Verify digest. */
-			if (memcmp(dst, ops[i]->sym->auth.digest.data,
+			if (rte_timingsafe_memcmp(dst, ops[i]->sym->auth.digest.data,
 					SNOW3G_DIGEST_LENGTH) != 0)
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
diff --git a/drivers/crypto/ipsec_mb/pmd_zuc.c b/drivers/crypto/ipsec_mb/pmd_zuc.c
index 44781be1d1..b466d4178d 100644
--- a/drivers/crypto/ipsec_mb/pmd_zuc.c
+++ b/drivers/crypto/ipsec_mb/pmd_zuc.c
@@ -185,7 +185,7 @@ process_zuc_hash_op(struct ipsec_mb_qp *qp, struct rte_crypto_op **ops,
 	 */
 	for (i = 0; i < processed_ops; i++)
 		if (sessions[i]->auth_op == RTE_CRYPTO_AUTH_OP_VERIFY)
-			if (memcmp(dst[i], ops[i]->sym->auth.digest.data,
+			if (rte_timingsafe_memcmp(dst[i], ops[i]->sym->auth.digest.data,
 					ZUC_DIGEST_LENGTH) != 0)
 				ops[i]->status =
 					RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
-- 
2.34.1

