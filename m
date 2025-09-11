Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBDCAC58E
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 13:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5DF040285;
	Thu, 11 Sep 2025 15:14:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5BA57402C4
 for <dev@dpdk.org>; Thu, 11 Sep 2025 15:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757596494; x=1789132494;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6DaDhk0Sw/FyDsXIcx+BAF2o1jE26u0rQ2XaTrqpJUc=;
 b=jfC4Cu1UISTGUhALTCwza1ecjAlKl5blhdkXL9yiIMFDwVyoeFkHU0m3
 QAL19KJ3I7L/tU6XOeEIoB5CHVjl8wfEoLUNGPzFGVbYouRAX8W5xnuo6
 UWjX/zwLXVTOXhFjXzPF2cntJ9gaRXik6YGyZ72V0Dv5gQGNOBZ+RJcYG
 q+7a2aTTduBgI7Zl0m0oBiF4uCnqfHqsGt/jl7Nn5iOG98hkMMaCNJQo5
 1HDfPWvWDWxhwqLVbHYbxeujCfKAt4x2dYaqYCQbZYVepgjBpgcnHR718
 wMPcMIGonr/ZNwuqI7gfTvtzHTnkpEDWpU7/EpE+OOlwaTjgF62JanG30 A==;
X-CSE-ConnectionGUID: jiY5zq27SluujHGCTAxc4A==
X-CSE-MsgGUID: n/wmhCBtSaetA9KxLTLcLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70182727"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="70182727"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 06:14:54 -0700
X-CSE-ConnectionGUID: iIavKeGXSOmirbnPFzFwjA==
X-CSE-MsgGUID: 63emP8kyRvqRircnUNSgfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="172864968"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2025 06:14:51 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v2 2/3] test/crypto: improve CPU mode coverage
Date: Thu, 11 Sep 2025 13:14:37 +0000
Message-ID: <20250911131447.1247417-2-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250911131447.1247417-1-radu.nicolau@intel.com>
References: <20250911131447.1247417-1-radu.nicolau@intel.com>
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
 app/test/test_cryptodev.h             |   2 +
 app/test/test_cryptodev_blockcipher.c | 103 +++++++++++++++++++++-----
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
index e243cf945a..23d12ec961 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -5,6 +5,7 @@
 #define TEST_CRYPTODEV_H_
 
 #include <rte_cryptodev.h>
+#include <rte_security.h>
 
 #define MAX_NUM_OPS_INFLIGHT            (4096)
 #define MIN_NUM_OPS_INFLIGHT            (128)
@@ -85,6 +86,7 @@ enum cryptodev_api_test_type {
 	CRYPTODEV_RAW_API_TEST
 };
 
+extern enum rte_security_session_action_type gbl_action_type;
 extern enum cryptodev_api_test_type global_api_test_type;
 
 extern struct crypto_testsuite_params *p_testsuite_params;
diff --git a/app/test/test_cryptodev_blockcipher.c b/app/test/test_cryptodev_blockcipher.c
index 5a124bbb5e..6b37347789 100644
--- a/app/test/test_cryptodev_blockcipher.c
+++ b/app/test/test_cryptodev_blockcipher.c
@@ -567,25 +567,95 @@ test_blockcipher_one_case(const struct blockcipher_test_case *t,
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
 
@@ -649,7 +719,6 @@ test_blockcipher_one_case(const struct blockcipher_test_case *t,
 		if (t->op_mask & BLOCKCIPHER_TEST_OP_AUTH_GEN) {
 			uint8_t *auth_res = pktmbuf_mtod_offset(iobuf,
 						tdata->ciphertext.len);
-
 			if (memcmp(auth_res, tdata->digest.data, digest_len)) {
 				snprintf(test_msg, BLOCKCIPHER_TEST_MSG_LEN, "line %u "
 					"FAILED: %s", __LINE__, "Generated "
-- 
2.50.1

