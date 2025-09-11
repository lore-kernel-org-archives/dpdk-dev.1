Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18583CAC58E
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 13:15:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BCEE4065F;
	Thu, 11 Sep 2025 15:14:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 57D7B40285
 for <dev@dpdk.org>; Thu, 11 Sep 2025 15:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757596496; x=1789132496;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lZNNGMSkPkoNM59HFqR0NMEkp4O/eA5i4DLZg1wiTt4=;
 b=PM3tU63qVU3LTYEUREQOivh9D8K/K0dANjAXVYh6+B/Oc2dj4zuEVPDB
 LyMv+Elfng4U8y6a+AjJFBpHJWw5hzeV6hBwGjTbzBBJkivVYYkwFyWCA
 65x0/PAEyCH5fpwnR71X9BneFc76haD1A+QEIPJ0MxqOaRbdZ424l8aKG
 tqk3L6C22L+LkQbvypRF1KQxqhTztu/Y/PjqjKI0eKi1tqsl1EZiZ9WiN
 WFHNSaO0ejmmUJ+6TwioOuTwNhodyJmaRVm9ufdf/2nKvN8f5S8/+4I4D
 z+Ce7cYTYZoAzRJI6YDxtYNiU8/ZVfVPA59d7+KVozT1EZIHMRT4zgJmi A==;
X-CSE-ConnectionGUID: 1Ju1wlRtSE+2Co9YfAoSfA==
X-CSE-MsgGUID: mfpcbQXvR92H6WUeyepTAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70182733"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="70182733"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 06:14:56 -0700
X-CSE-ConnectionGUID: DYG4BCzPQnOnMBhM7T4b7g==
X-CSE-MsgGUID: wA25WLgVQwuP8UV8D1Qcdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="172864974"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2025 06:14:53 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marcin Smoczynski <marcinx.smoczynski@intel.com>
Subject: [PATCH v2 3/3] test/crypto: fix uninitialised vector fields
Date: Thu, 11 Sep 2025 13:14:38 +0000
Message-ID: <20250911131447.1247417-3-radu.nicolau@intel.com>
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

For CPU crypto code path make sure all fields in the
rte_crypto_sym_vec struct are initialised.

Fixes: 2a9f232ce60e ("test/crypto: add CPU crypto mode cases")

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 0773d320d4..32e4e60b60 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -289,7 +289,7 @@ process_sym_raw_dp_op(uint8_t dev_id, uint16_t qp_id,
 	struct rte_crypto_vec data_vec[UINT8_MAX], dest_data_vec[UINT8_MAX];
 	struct rte_crypto_va_iova_ptr cipher_iv, digest, aad_auth_iv;
 	union rte_crypto_sym_ofs ofs;
-	struct rte_crypto_sym_vec vec;
+	struct rte_crypto_sym_vec vec = {0};
 	struct rte_crypto_sgl sgl, dest_sgl;
 	uint32_t max_len;
 	union rte_cryptodev_session_ctx sess;
@@ -526,7 +526,7 @@ process_cpu_aead_op(uint8_t dev_id, struct rte_crypto_op *op)
 	struct rte_crypto_sym_op *sop;
 	union rte_crypto_sym_ofs ofs;
 	struct rte_crypto_sgl sgl;
-	struct rte_crypto_sym_vec symvec;
+	struct rte_crypto_sym_vec symvec = {0};
 	struct rte_crypto_va_iova_ptr iv_ptr, aad_ptr, digest_ptr;
 	struct rte_crypto_vec vec[UINT8_MAX];
 
@@ -572,7 +572,7 @@ process_cpu_crypt_auth_op(uint8_t dev_id, struct rte_crypto_op *op)
 	struct rte_crypto_sym_op *sop;
 	union rte_crypto_sym_ofs ofs;
 	struct rte_crypto_sgl sgl;
-	struct rte_crypto_sym_vec symvec;
+	struct rte_crypto_sym_vec symvec = {0};
 	struct rte_crypto_va_iova_ptr iv_ptr, digest_ptr;
 	struct rte_crypto_vec vec[UINT8_MAX];
 
-- 
2.50.1

