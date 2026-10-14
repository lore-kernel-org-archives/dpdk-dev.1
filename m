Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23A5CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 14:22:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADEF44067B;
	Wed, 14 Oct 2026 16:22:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 08C9240616
 for <dev@dpdk.org>; Wed, 14 Oct 2026 16:22:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791987748; x=1823523748;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vs9Jiw0BReVqkoJppuvGz/wC8Kir2V1q+hpuniktKOU=;
 b=huI6q+T1c5pAGTKYTWcpOz/csAID8cBa7Bh0j2r0RCaVtYPHl9GIpaKf
 1sSh4oVLL4olKO5+ChNCKObuy4dxlCSCC3sEoOSkBA1NkHTeLeXGowe8a
 +DYDlcPX8NrB2yBMeish7wmHb8HGgKEfWPxgidijUnqdXzkQAJ0D2dN+V
 1lu5h/TJt4WcXGC/m4UxSno49kDQdwSXwdQ2SG8kURy7p+JcGjVrqIKpY
 f9vmU3V3+R+LE/2SechO5T/5zoyNY1niI2LVPG6eisxAWvWPrexq8lYdc
 dAqbYIlnLJYcAhKjqu3lx4i31iimlybcM8OgstzPjWFTa2P6LTOMNMeya A==;
X-CSE-ConnectionGUID: qHRpFr2BTJ2G7IrRX3SuLA==
X-CSE-MsgGUID: 6SIdmoYzQuGj29tHSrwlNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="766342"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="766342"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 07:22:27 -0700
X-CSE-ConnectionGUID: EWaR7AjDRMOTGq4PJVauTQ==
X-CSE-MsgGUID: eaBy+6h6RXWxmMFDXHqEkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1403591"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa001.jf.intel.com with ESMTP; 14 Oct 2026 07:22:25 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v4 4/4] test/crypto: add asym test suite for AESNI_MB
Date: Wed, 14 Oct 2026 14:21:37 +0000
Message-ID: <20261014142217.2117229-5-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261014142217.2117229-1-radu.nicolau@intel.com>
References: <20261014142217.2117229-1-radu.nicolau@intel.com>
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

