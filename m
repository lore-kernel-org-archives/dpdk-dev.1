Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84994CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:15:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2CF140B94;
	Thu, 15 Oct 2026 16:14:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 17FDE40B94
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792073678; x=1823609678;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vs9Jiw0BReVqkoJppuvGz/wC8Kir2V1q+hpuniktKOU=;
 b=JLYRBoczhz1a1gHfuGCIq+2iACB6mOo9E/dk/RNke/kquxjTluxYxBGA
 cOTeWwNlkektXtP7tGc1/xF8lRHbn5lG7hcZxtqo9AowqZKTeYi4WCsR8
 mjZpMwktX1ILmRCBR6goKcZUj8PmCqHmuAitQxDDp1hna3g2X8h7F/hjf
 36uM5TA9pHKTa2kRyzZtMuSLFKQRVpA5ZgHrk0aNFj0i8HLqHPz5f68iy
 TpRYbIwl8RcWnoR+F2S87Bzw9rvpBzGRntbfIoXPpS3mug+MMZ1gJ86Cs
 28zMENOPGAy2ZLahpfs4r1kC659b/JRD3K/tC5HKw8pP60cso+8z0++uV w==;
X-CSE-ConnectionGUID: J1RUAxAwRK6wL7bklE1U7g==
X-CSE-MsgGUID: 3XmCrfIHTOyMVJK+X9SA9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="716756"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="716756"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:14:37 -0700
X-CSE-ConnectionGUID: SVJMnfA2RDyJ7SYe8Gw47A==
X-CSE-MsgGUID: zOofcpJMThSlKHtOEPffIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2060564"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 07:14:35 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: marcel.d.cornu@intel.com, Radu Nicolau <radu.nicolau@intel.com>,
 Kai Ji <kai.ji@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v5 4/4] test/crypto: add asym test suite for AESNI_MB
Date: Thu, 15 Oct 2026 14:13:58 +0000
Message-ID: <20261015141426.2275568-5-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261015141426.2275568-1-radu.nicolau@intel.com>
References: <20261015141426.2275568-1-radu.nicolau@intel.com>
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

Enable asymmetric crypto unit test suite for AESNI_MB PMD.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
Acked-by: Kai Ji <kai.ji@intel.com>
---
 app/test/test_cryptodev_asym.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 7b8afe5f92..78b4942426 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -5518,6 +5518,12 @@ test_cryptodev_virtio_user_asym(void)
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
@@ -5526,3 +5532,4 @@ REGISTER_DRIVER_TEST(cryptodev_cn10k_asym_autotest, test_cryptodev_cn10k_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn20k_asym_autotest, test_cryptodev_cn20k_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_asym_autotest, test_cryptodev_virtio_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_user_asym_autotest, test_cryptodev_virtio_user_asym);
+REGISTER_DRIVER_TEST(cryptodev_aesni_mb_asym_autotest, test_cryptodev_aesni_mb_asym);
-- 
2.52.0

