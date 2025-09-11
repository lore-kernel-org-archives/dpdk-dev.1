Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3EDCAC58D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 10:22:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABFD940652;
	Thu, 11 Sep 2025 12:22:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9D0C740650
 for <dev@dpdk.org>; Thu, 11 Sep 2025 12:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757586158; x=1789122158;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ztJlDe24isP3XPtjfkwpIgTOZ+Lo4f+MdHFXbNsVKS0=;
 b=YfsbW+HqhAM85uvVcRU3NdhYP76iyMbTYnFu4ONNM6dQ5D/DaootdbUe
 UsgL4gzr3FDS6R6xIBCTQprAFQy2eUNNJfcn7N9Ke7N9FRZq+sfGqZgAY
 K6CL9inINggLuYTdOLhvvu6MsdpJjIbl5cTN0wHlC8oFtsmPn5LtjLPl9
 xVNFY2wSW7NGd6wYuYBuZJxUfY2IkI6+ssCvc8ZPWmEl2HZN4WrzD6v0g
 TNWhxf/FzvCca2a39PMwfavoJaGWBkMmhHy5Md8WrLeNg4ryryazifKCa
 BshOYvz+NW8CZREo6iKqY6ZySi5uVy4N2uwie2eSxOCDR4DdTwSNQ1Opt A==;
X-CSE-ConnectionGUID: stxeziz6QwKNLtyqxeKYKQ==
X-CSE-MsgGUID: ndJfxkFySvWG5Qqp+5i6qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="58954267"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="58954267"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 03:22:37 -0700
X-CSE-ConnectionGUID: ivS/D4/7QrCEUEfLroPBvQ==
X-CSE-MsgGUID: LpZ1RNzdQtuNRpUjh1dxLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="174041075"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by fmviesa008.fm.intel.com with ESMTP; 11 Sep 2025 03:22:36 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: kai.ji@intel.com, Radu Nicolau <radu.nicolau@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 2/3] test/crypto: improve CPU mode coverage
Date: Thu, 11 Sep 2025 10:22:28 +0000
Message-ID: <20250911102229.1241141-2-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250911102229.1241141-1-radu.nicolau@intel.com>
References: <20250911102229.1241141-1-radu.nicolau@intel.com>
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

Add crypto CPU mode code path for blockcipher tests.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev.c             |   2 +-
 app/test/test_cryptodev.h             |   1 +
 app/test/test_cryptodev_blockcipher.c | 104 +++++++++++++++++++++-----
 3 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 5229ac2bf6..0773d320d4 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -75,7 +75,7 @@
 
 static int gbl_driver_id;
 
-static enum rte_security_session_action_type gbl_action_type =
+enum rte_security_session_action_type gbl_action_type =
 	RTE_SECURITY_ACTION_TYPE_NONE;
 
 enum cryptodev_api_test_type global_api_test_type = CRYPTODEV_API_TEST;
diff --git a/app/test/test_cryptodev.h b/app/test/test_cryptodev.h
index e243cf945a..e9bea5e793 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -85,6 +85,7 @@ enum cryptodev_api_test_type {
 	CRYPTODEV_RAW_API_TEST
 };
 
+extern enum rte_security_session_action_type gbl_action_type;
 extern enum cryptodev_api_test_type global_api_test_type;
 
 extern struct crypto_testsuite_params *p_testsuite_params;
diff --git a/app/test/test_cryptodev_blockcipher.c b/app/test/test_cryptodev_blockcipher.c
index 5a124bbb5e..85756ab13c 100644
--- a/app/test/test_cryptodev_blockcipher.c
+++ b/app/test/test_cryptodev_blockcipher.c
@@ -11,6 +11,7 @@
 
 #include <rte_crypto.h>
 #include <rte_cryptodev.h>
+#include <rte_security.h>
 
 #include "test.h"
 #include "test_cryptodev.h"
@@ -567,25 +568,95 @@ test_blockcipher_one_case(const struct blockcipher_test_case *t,
 			goto error_exit;
 		}
 	} else {
-		if (rte_cryptodev_enqueue_burst(dev_id, 0, &op, 1) != 1) {
-			snprintf(test_msg, BLOCKCIPHER_TEST_MSG_LEN,
-				"line %u FAILED: %s",
-				__LINE__, "Error sending packet for encryption");
-			status = TEST_FAILED;
-			goto error_exit;
-		}
+		if (gbl_action_type == RTE_SECURITY_ACTION_TYPE_CPU_CRYPTO) {
+			int32_t n_src, n_dst, st, n;
+			struct rte_crypto_sym_op *sop;
+			union rte_crypto_sym_ofs ofs;
+			struct rte_crypto_sgl sgl_src, sgl_dst;
+			struct rte_crypto_sym_vec symvec = {0};
+			struct rte_crypto_va_iova_ptr iv_ptr, digest_ptr;
+			struct rte_crypto_vec vec_src[UINT8_MAX];
+			struct rte_crypto_vec vec_dst[UINT8_MAX];
+			uint32_t cipher_offset, cipher_len, auth_offset, auth_len, max_len;
+			bool is_oop = op->sym->m_dst != NULL;
+
+			if (t->feature_mask & BLOCKCIPHER_TEST_FEATURE_SESSIONLESS) {
+				status = TEST_SKIPPED;
+				goto error_exit;
+			}
+
+			sop = op->sym;
+			cipher_offset = sop->cipher.data.offset;
+			cipher_len = sop->cipher.data.length;
+			auth_offset = sop->auth.data.offset;
+			auth_len = sop->auth.data.length;
+			max_len = RTE_MAX(cipher_offset + cipher_len, auth_offset + auth_len);
+
+			n_src = rte_crypto_mbuf_to_vec(sop->m_src, 0, max_len,
+				vec_src, RTE_DIM(vec_src));
+			if (n_src < 0 || n_src != sop->m_src->nb_segs) {
+				op->status = RTE_CRYPTO_OP_STATUS_ERROR;
+				status = TEST_FAILED;
+				goto error_exit;
+			}
+			sgl_src.vec = vec_src;
+			sgl_src.num = n_src;
+			symvec.src_sgl = &sgl_src;
+			if (is_oop) {
+				n_dst = rte_crypto_mbuf_to_vec(sop->m_dst, 0, max_len,
+					vec_dst, RTE_DIM(vec_dst));
+				sgl_dst.vec = vec_dst;
+				sgl_dst.num = n_dst;
+				symvec.dest_sgl = &sgl_dst;
+			} else {
+				symvec.dest_sgl = NULL;
+			}
+
+			symvec.iv = &iv_ptr;
+			symvec.digest = &digest_ptr;
+			symvec.status = &st;
+			symvec.num = 1;
+			iv_ptr.va = rte_crypto_op_ctod_offset(op, void *, IV_OFFSET);
+			digest_ptr.va = (void *)sop->auth.digest.data;
+			ofs.ofs.cipher.head = cipher_offset;
+			ofs.ofs.cipher.tail = max_len - cipher_offset - cipher_len;
+			ofs.ofs.auth.head = auth_offset;
+			ofs.ofs.auth.tail = max_len - auth_offset - auth_len;
+
+			n = rte_cryptodev_sym_cpu_crypto_process(dev_id, sop->session, ofs,
+				&symvec);
+			if (st == -ENOTSUP) {
+				status = TEST_SKIPPED;
+				goto error_exit;
+			}
+			if (n != 1) {
+				status = TEST_FAILED;
+				op->status = RTE_CRYPTO_OP_STATUS_ERROR;
+				goto error_exit;
+			} else {
+				op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+			}
+		} else {
+			if (rte_cryptodev_enqueue_burst(dev_id, 0, &op, 1) != 1) {
+				snprintf(test_msg, BLOCKCIPHER_TEST_MSG_LEN,
+					"line %u FAILED: %s",
+					__LINE__, "Error sending packet for encryption");
+				status = TEST_FAILED;
+				goto error_exit;
+			}
 
-		op = NULL;
+			op = NULL;
 
-		while (rte_cryptodev_dequeue_burst(dev_id, 0, &op, 1) == 0)
-			rte_pause();
+			while (rte_cryptodev_dequeue_burst(dev_id, 0, &op, 1) == 0)
+				rte_pause();
 
-		if (!op) {
-			snprintf(test_msg, BLOCKCIPHER_TEST_MSG_LEN,
-				"line %u FAILED: %s",
-				__LINE__, "Failed to process sym crypto op");
-			status = TEST_FAILED;
-			goto error_exit;
+			if (!op) {
+				snprintf(test_msg, BLOCKCIPHER_TEST_MSG_LEN,
+					"line %u FAILED: %s",
+					__LINE__, "Failed to process sym crypto op");
+				status = TEST_FAILED;
+				goto error_exit;
+			}
 		}
 	}
 
@@ -649,7 +720,6 @@ test_blockcipher_one_case(const struct blockcipher_test_case *t,
 		if (t->op_mask & BLOCKCIPHER_TEST_OP_AUTH_GEN) {
 			uint8_t *auth_res = pktmbuf_mtod_offset(iobuf,
 						tdata->ciphertext.len);
-
 			if (memcmp(auth_res, tdata->digest.data, digest_len)) {
 				snprintf(test_msg, BLOCKCIPHER_TEST_MSG_LEN, "line %u "
 					"FAILED: %s", __LINE__, "Generated "
-- 
2.50.1

