Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85854CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:57:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 377DF42E92;
	Fri,  2 Oct 2026 11:57:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0964C42E5B
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790935022; x=1822471022;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dQV9Ux+HBgXYmIHwtWfsUO++US882SGKczhuuI99gak=;
 b=iTh3Xmcn9TtVp5qE18D1aCkYVz57dBPDtNxgdBm9movh+AqynaLvBdxI
 aDL2pMb3BX5oVCjgdrI1enJ4zGXQ2JZjma5Uaie0EHL7u3GJtqHqgrjjk
 QVnRfnkf6qxXhuMZj9e1xx8POAiYJUWV2QczFw9VqhLahqXHnpoJyO/tm
 aUrNuszq6Caiou3bCKC5Aec/Z7CmqjlmufpoUPLCp5XjexRYM0zO2itla
 X8oCbxQ0EJokUVHqKD5R1rYfgcFPw7JixcgObczWLooHGIdtBUNwbVoeE
 +HA5s8O2ycNxceK/8rF7kntmi4WBMjREBp8LqIW9W/y3llc80g7zLFVnm w==;
X-CSE-ConnectionGUID: 7KzVlv5qTRClE6RBK5TMgA==
X-CSE-MsgGUID: lmyQ7WICRPOdVbeMI5O3mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94581564"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="94581564"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 02:57:02 -0700
X-CSE-ConnectionGUID: a3IXgay+QFKVGpmTuZjKAQ==
X-CSE-MsgGUID: uO/TSCPcS+SNmpKjYlT8Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="274862081"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2026 02:57:01 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 4/4] test/crypto: add asym test suite for AESNI_MB
Date: Fri,  2 Oct 2026 09:56:24 +0000
Message-ID: <20261002095652.1540556-5-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261002095652.1540556-1-radu.nicolau@intel.com>
References: <20261002095652.1540556-1-radu.nicolau@intel.com>
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

