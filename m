Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82053C369A8
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 10:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E542A40B9C;
	Fri, 11 Apr 2025 12:14:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id E5EB540B91
 for <dev@dpdk.org>; Fri, 11 Apr 2025 12:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366473; x=1775902473;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gQloSVK3d8dkfCQCSOht9/AEIjdi8Va7CtVqDMxnWck=;
 b=gful8DMUXwC9j5p4r7oxT0M23Kn4sU7PDX5mwWd6+WTGh0ElgZE8h7k3
 F8WTvSm5diE8w7my30m+ZR1qrW2aK9tXbdxwfQnw8ufTO6se54lSWVmyS
 V6z02emKkKR9Ezrj3d5OzBd9OXUlF/Ww8hAXxnpZj5eTQVdCKL2e40Nlp
 4j5UyIdbBXuWUJyqVLngxv9mBNdXRO8ZQlx1+qkG9YzmQiZiRMAgUqAgB
 rLw4gleUvkeIKv5PxvJCDeIk/fK0CBpwLcSzTs0B74kxtG36/y3MR85q1
 /+KJGz7J2pQuZncqwZbyc6bCkGkpu+fPSp7hxGTO8O+LNixnse5DL94PO w==;
X-CSE-ConnectionGUID: jPe7eGEuQy6Y/wtKiM6RRQ==
X-CSE-MsgGUID: Dt8TjpVYRUyx+4tlJ95uEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56896769"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="56896769"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:14:32 -0700
X-CSE-ConnectionGUID: JCucfmf7R7e4vha9W+/AdQ==
X-CSE-MsgGUID: pDZ70+pRRiilIjyfYjVRiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="160130587"
Received: from silpixa00400884.ir.intel.com ([10.243.22.90])
 by orviesa002.jf.intel.com with ESMTP; 11 Apr 2025 03:14:32 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: Akhil Goyal <gakhil@marvell.com>,
	Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org,
	kai.ji@intel.com,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v2 2/5] examples/l2fwd-crypto: add support for SNOW-V
Date: Fri, 11 Apr 2025 11:09:38 +0100
Message-ID: <20250411101425.3041736-3-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411101425.3041736-1-radu.nicolau@intel.com>
References: <20250411101425.3041736-1-radu.nicolau@intel.com>
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

Update l2fwd-crypto to be able to correctly handle SNOW-V

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 examples/l2fwd-crypto/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index a441312f55..f1a6ca8899 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -508,7 +508,8 @@ l2fwd_simple_crypto_enqueue(struct rte_mbuf *m,
 		/* For wireless algorithms, offset/length must be in bits */
 		if (cparams->cipher_algo == RTE_CRYPTO_CIPHER_SNOW3G_UEA2 ||
 				cparams->cipher_algo == RTE_CRYPTO_CIPHER_KASUMI_F8 ||
-				cparams->cipher_algo == RTE_CRYPTO_CIPHER_ZUC_EEA3) {
+				cparams->cipher_algo == RTE_CRYPTO_CIPHER_ZUC_EEA3 ||
+				cparams->cipher_algo == RTE_CRYPTO_CIPHER_SNOW_V) {
 			op->sym->cipher.data.offset = ipdata_offset << 3;
 			op->sym->cipher.data.length = data_len << 3;
 		} else {
-- 
2.43.0

