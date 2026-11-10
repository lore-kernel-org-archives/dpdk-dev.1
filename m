Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A35606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GnzwkM55
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E14140E26;
	Tue, 10 Nov 2026 13:00:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 3BC2440E54
 for <dev@dpdk.org>; Tue, 10 Nov 2026 13:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794312025; x=1825848025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FhJA/FPLMAqRtcR3+irluXGG4zRo4G57x2CsgqIvIZw=;
 b=GnzwkM552DmOXKW6hVOAu1RoFmMzp6/aQ0KNsfky5TstuFreHcoVBmW3
 3d1vQj5KOQq6aVqa56nt5Hugb2NNZfYPPzFbUzAxzvprem8JZ2V1rHUjr
 UARY56KdFetCitsctGW/VYXLGN14+mYug3dIQhaDE1e5+tp0ja5s2wMif
 5zb7DF/RNBjvWFuM3dXJLBiCos0vnwJnb2k4hroon+k21eTKo9u+rNuRC
 GVcd5si7FRxa89PyLBGWW9odMEZlDVqGIpsVbBTjKB9kaYPGZLiUSnM84
 DKXx2lP8mgJAlV2cSt2j1SeJnKg9WkSjd5Zaz7RcM80t8ypJ2vynFrjl4 w==;
X-CSE-ConnectionGUID: L4dXusEkS6Kv0em1JCjVCQ==
X-CSE-MsgGUID: ROXdgRmOS4++7gIyRvMsmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2953498"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2953498"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 04:00:23 -0800
X-CSE-ConnectionGUID: IVTHZ3iUTmezwIOLtJArAw==
X-CSE-MsgGUID: DQWAGP77S6inZx7RPx2/fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8279523"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa002.fm.intel.com with ESMTP; 10 Nov 2026 04:00:22 -0800
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v6 4/4] test/crypto: add asym test suite for AESNI_MB
Date: Tue, 10 Nov 2026 12:00:14 +0000
Message-ID: <20261110120015.2937289-4-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261110120015.2937289-1-radu.nicolau@intel.com>
References: <20261110120015.2937289-1-radu.nicolau@intel.com>
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

Enable asymmetric crypto unit test suite for AESNI_MB PMD.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
Acked-by: Kai Ji <kai.ji@intel.com>
Acked-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 app/test/test_cryptodev_asym.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index d9807f34e0..0de312b0bf 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -6182,6 +6182,12 @@ test_cryptodev_virtio_user_asym(void)
 	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_VIRTIO_USER_PMD));
 }
 
+static int
+test_cryptodev_aesni_mb_asym(void)
+{
+	return run_cryptodev_asym_testsuite(RTE_STR(CRYPTODEV_NAME_AESNI_MB_PMD));
+}
+
 REGISTER_DRIVER_TEST(cryptodev_openssl_asym_autotest, test_cryptodev_openssl_asym);
 REGISTER_DRIVER_TEST(cryptodev_qat_asym_autotest, test_cryptodev_qat_asym);
 REGISTER_DRIVER_TEST(cryptodev_octeontx_asym_autotest, test_cryptodev_octeontx_asym);
@@ -6190,3 +6196,4 @@ REGISTER_DRIVER_TEST(cryptodev_cn10k_asym_autotest, test_cryptodev_cn10k_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn20k_asym_autotest, test_cryptodev_cn20k_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_asym_autotest, test_cryptodev_virtio_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_user_asym_autotest, test_cryptodev_virtio_user_asym);
+REGISTER_DRIVER_TEST(cryptodev_aesni_mb_asym_autotest, test_cryptodev_aesni_mb_asym);
-- 
2.52.0

