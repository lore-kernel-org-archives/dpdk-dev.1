Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D759606A323
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HBmh0jjv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 096DF4029E;
	Tue, 17 Nov 2026 15:51:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 084704026F
 for <dev@dpdk.org>; Tue, 17 Nov 2026 15:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794927070; x=1826463070;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BAEo3IYdEzPkukJD7flCC3pdBnUdzS8s7TFt5ok3zfo=;
 b=HBmh0jjv+hH0f4WiZt4mVWtiPNVLl9yHdzssog2M0aJtqtvpsTQvjTN+
 XyUJWpXHX841moWKQkL99jNgR/TFSDosI7VaYfKSQRme25YMndufa+aU4
 E2yy4G2eZbQVxUehUsvy1z6OOPpoXmTGE+Ro2TcfLnlv6agZwakZ2+3gN
 Y52fduiW2r4NuGdrab9QuLBDV2BOEVKeGiUR0vaRa9v9l71AcsV9XgZQ0
 zpURF0XVotJ2F4Bc8FwdqyqLtGjmon4Lk2WJ3G1eEklyCMixlUTKz0Zz9
 vq39nCmJQ4N67AfA4AUkxOUiV58o8T6ht+IuAoQn4wf8YO1lomO/LDRbH A==;
X-CSE-ConnectionGUID: FcFd5hVXQzGoV/Ac62V3cQ==
X-CSE-MsgGUID: lGcmsgjRTZu9ANunqXbxuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3591405"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3591405"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 06:51:08 -0800
X-CSE-ConnectionGUID: Eo2U5C4rSXSzDsThA5gXbw==
X-CSE-MsgGUID: DriGQrn+Q5e27rK1pD0gBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9857360"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by orviesa006.jf.intel.com with ESMTP; 17 Nov 2026 06:51:06 -0800
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH] test/crypto: use standard memory copy for wireless cipher IV
Date: Tue, 17 Nov 2026 14:51:04 +0000
Message-Id: <20261117145104.4140295-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
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

Coverity reports an out-of-bounds read of the ZUC cipher IV when tracing
the optimized rte_memcpy() implementation. The ZUC test vectors use
16-byte or 25-byte IVs, which fit in the 64-byte source buffer.

Use memcpy() for IV copies in both the in-place and out-of-place
wireless cipher operation helpers. These small test setup copies do
not need the optimized packet data copy routine. The copy lengths
and operation layout remain unchanged.

Coverity issue: 507468

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 app/test/test_cryptodev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index fd02107baf..312fb61189 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -3007,7 +3007,7 @@ create_wireless_algo_cipher_operation(const uint8_t *iv, uint8_t iv_len,
 	sym_op->m_src = ut_params->ibuf;
 
 	/* iv */
-	rte_memcpy(rte_crypto_op_ctod_offset(ut_params->op, uint8_t *, IV_OFFSET),
+	memcpy(rte_crypto_op_ctod_offset(ut_params->op, uint8_t *, IV_OFFSET),
 			iv, iv_len);
 	sym_op->cipher.data.length = cipher_len;
 	sym_op->cipher.data.offset = cipher_offset;
@@ -3038,7 +3038,7 @@ create_wireless_algo_cipher_operation_oop(const uint8_t *iv, uint8_t iv_len,
 	sym_op->m_dst = ut_params->obuf;
 
 	/* iv */
-	rte_memcpy(rte_crypto_op_ctod_offset(ut_params->op, uint8_t *, IV_OFFSET),
+	memcpy(rte_crypto_op_ctod_offset(ut_params->op, uint8_t *, IV_OFFSET),
 			iv, iv_len);
 	sym_op->cipher.data.length = cipher_len;
 	sym_op->cipher.data.offset = cipher_offset;
-- 
2.34.1

