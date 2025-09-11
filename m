Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDBECAC58D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 10:22:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E96984065A;
	Thu, 11 Sep 2025 12:22:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 497D040659
 for <dev@dpdk.org>; Thu, 11 Sep 2025 12:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757586160; x=1789122160;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lZNNGMSkPkoNM59HFqR0NMEkp4O/eA5i4DLZg1wiTt4=;
 b=ngE2My8LXFwufXH6Ks+WT7cbqoh0VV8xufphCp/skL/kPi4aR9nH3nYn
 8onEk41LJleLakxNDb+NjDL1S3DV1g+7pGIngi7iWtrtLzlGxffpPhpsK
 VkbRdGPZujfhLhz/GrHC0pj+lVxrF1aMqmj55UK1MzjRh6rcwfdYW9IIT
 mMGJNU3UCyME26oFChlMPA//G7XW43O2ChIfRiW8giZxd68YcpRGdNQi3
 ZFW7GsCX4L+LM59YMacqvAedAkhLYxf5cQPd4DvdIjN9XXYs7KbA8wYe+
 ITXmFzph0g4PmE5mPh70KHDwjfuHbqW+iM1v7uKpB8ilG6i+P7hP/emMt A==;
X-CSE-ConnectionGUID: Yf55x9VATuKlYkv3d4eTvA==
X-CSE-MsgGUID: thtoY1aNQs6xz77EH2NmZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="58954273"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="58954273"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 03:22:40 -0700
X-CSE-ConnectionGUID: tGMLac4sRwKRoiq6S4w2Aw==
X-CSE-MsgGUID: u/NlqjSkQsWalv+96F6s9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="174041086"
Received: from silpixa00401749.ir.intel.com (HELO
 silpixa00401749.ger.corp.intel.com) ([10.237.222.190])
 by fmviesa008.fm.intel.com with ESMTP; 11 Sep 2025 03:22:38 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: kai.ji@intel.com, Radu Nicolau <radu.nicolau@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Marcin Smoczynski <marcinx.smoczynski@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 3/3] test/crypto: fix uninitialised vector fields
Date: Thu, 11 Sep 2025 10:22:29 +0000
Message-ID: <20250911102229.1241141-3-radu.nicolau@intel.com>
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

