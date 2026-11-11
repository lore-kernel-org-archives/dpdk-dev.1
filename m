Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB84606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NiUhqf8z
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD3B54029E;
	Wed, 11 Nov 2026 12:14:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id B45FB40297;
 Wed, 11 Nov 2026 12:14:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794395696; x=1825931696;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ryCp8Q2Cn6bAlurYsD6ghnvSkwaQpxZnFuXwpv2G3Nk=;
 b=NiUhqf8zQAQiSNw6JCqLO9Tc8J9jKdxnSfUV1WFoqd9fhufyQ25aJN0d
 dtFj1IJ8PyRJsygjbZFdXh1ZVMjH3TIdN6vrk8iCycC45QedrNHADllu9
 gRWfkljJB4EIu6XjlAJc9PnXgeL6PG/UkWpHdsP3MsDSUJUKhazHoNRUe
 US6jrtCOsIEH17+oGaoNQvDtLqWF+xX9lWBn9RIyXxNwwgI/RNijygBjU
 +1nJInfLbL48TMgClgXQOxvwY8GKzjf0UwCay4pXxVPT7gSKGCRd2UhD/
 B2X2LB5LfQmESvAc924Ep60uIJxJHNEEEw+cCJlKDia3KJB1D6n1Lb3NJ w==;
X-CSE-ConnectionGUID: eT/Tu5sNRjKgiNFTiJZVmA==
X-CSE-MsgGUID: OSdhvKEDR9y+tPy/26nBDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3208995"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3208995"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 03:14:54 -0800
X-CSE-ConnectionGUID: yKu4/66tToKYcOcKmRc/pA==
X-CSE-MsgGUID: v3+oI1AdSEOmuhNz399iRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; d="scan'208";a="10186566"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa011.fm.intel.com with ESMTP; 11 Nov 2026 03:14:52 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, stable@dpdk.org,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ganapati Kundapura <ganapati.kundapura@intel.com>
Subject: [PATCH] test/crypto: fix callback test case
Date: Wed, 11 Nov 2026 11:14:41 +0000
Message-ID: <20261111111441.3031123-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix test_enqdeq_callback_null_cipher function to
match its name by removing the chained ops.

Fixes: 4ad17a1c8fb3 ("test/crypto: fix enqueue/dequeue callback case")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 app/test/test_cryptodev.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index fd02107baf..d8c64a13ae 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -15191,21 +15191,14 @@ test_enqdeq_callback_null_cipher(void)
 
 	/* Setup Cipher Parameters */
 	ut_params->cipher_xform.type = RTE_CRYPTO_SYM_XFORM_CIPHER;
-	ut_params->cipher_xform.next = &ut_params->auth_xform;
+	ut_params->cipher_xform.next = NULL;
 
 	ut_params->cipher_xform.cipher.algo = RTE_CRYPTO_CIPHER_NULL;
 	ut_params->cipher_xform.cipher.op = RTE_CRYPTO_CIPHER_OP_ENCRYPT;
 
-	/* Setup Auth Parameters */
-	ut_params->auth_xform.type = RTE_CRYPTO_SYM_XFORM_AUTH;
-	ut_params->auth_xform.next = NULL;
-
-	ut_params->auth_xform.auth.algo = RTE_CRYPTO_AUTH_NULL;
-	ut_params->auth_xform.auth.op = RTE_CRYPTO_AUTH_OP_GENERATE;
-
 	/* Create Crypto session */
 	ut_params->sess = rte_cryptodev_sym_session_create(ts_params->valid_devs[0],
-				&ut_params->auth_xform, ts_params->session_mpool);
+				&ut_params->cipher_xform, ts_params->session_mpool);
 	if (ut_params->sess == NULL && rte_errno == ENOTSUP)
 		return TEST_SKIPPED;
 	TEST_ASSERT_NOT_NULL(ut_params->sess, "Session creation failed");
-- 
2.52.0

