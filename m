Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A3CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 12:29:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D841040612;
	Mon, 12 Oct 2026 14:28:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 39475402ED
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791808137; x=1823344137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dQV9Ux+HBgXYmIHwtWfsUO++US882SGKczhuuI99gak=;
 b=IBhp+aNWMrIxNnRqvgouRZS/nrCviQxKaNXONSrtEaUtfVIQV1WDHySe
 yS0wPXwaw1S+xzfRuqlxBZdCL455P758gDJ0L746dMaDuEwocrfs1nz3X
 eiuMtz7EdMuNiXIjO3Npgwd5NzRiYF6qSMCYSSmk/2ty10KyDD55tvaDt
 9FYdv9cduSagsB8wXYzSkx9aA61LrGRZy8YeOKmhTUCI+UwzR2m0Xn+bG
 hfAA6K+QsXDvUu9Je6J9gfaF1cXLRBVEjb5Zg0O7HhhLnxYlgcHEVSVGy
 nR6ErX7z/QeHQu3qvaxm9goQf7uy6skUtg4q01W2C67ErXYRSNh1pe62U Q==;
X-CSE-ConnectionGUID: gBsJDxxDTK2V6huWiEiXoA==
X-CSE-MsgGUID: R+Kou2MjStmeXxeQ+V1SDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="400306"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="400306"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 05:28:56 -0700
X-CSE-ConnectionGUID: 7PRDmFcOSF2UECwL/7xOeg==
X-CSE-MsgGUID: j75d19/+Tp23X/bJfC/Fzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="864656"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa001.jf.intel.com with ESMTP; 12 Oct 2026 05:28:56 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v2 4/4] test/crypto: add asym test suite for AESNI_MB
Date: Mon, 12 Oct 2026 12:24:19 +0000
Message-ID: <20261012122841.1887023-5-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012122841.1887023-1-radu.nicolau@intel.com>
References: <20261012122841.1887023-1-radu.nicolau@intel.com>
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
---
 app/test/test_cryptodev_asym.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 4f0408c87a..1870011610 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -6181,6 +6181,12 @@ test_cryptodev_virtio_user_asym(void)
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
@@ -6189,3 +6195,4 @@ REGISTER_DRIVER_TEST(cryptodev_cn10k_asym_autotest, test_cryptodev_cn10k_asym);
 REGISTER_DRIVER_TEST(cryptodev_cn20k_asym_autotest, test_cryptodev_cn20k_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_asym_autotest, test_cryptodev_virtio_asym);
 REGISTER_DRIVER_TEST(cryptodev_virtio_user_asym_autotest, test_cryptodev_virtio_user_asym);
+REGISTER_DRIVER_TEST(cryptodev_aesni_mb_asym_autotest, test_cryptodev_aesni_mb_asym);
-- 
2.52.0

