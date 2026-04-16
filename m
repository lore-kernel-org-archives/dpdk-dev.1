Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBFEF8A146
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 10:25:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD98740297;
	Thu, 16 Apr 2026 12:25:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5041440144
 for <dev@dpdk.org>; Thu, 16 Apr 2026 12:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776335151; x=1807871151;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I1cDK8ryCHAvnE7tcJZEVq/nviqCbmPhi+oE9mtvY6k=;
 b=Ockq9womXoM6yi/1sN9T9f8R+ljj0d8M2qsMf4UeAtcY9U0fIGRypCsT
 V0DjO/yYfzITcQo2xzw3/c4Vx2S6/YnYSrdjoVIJQ9XQO5M0ZAevmN4GG
 d34tkAyDBKmGS8kOv8TWg3G3NRm+c1iWZjEDkCvmIPsi12e2c3wcwXLEH
 Y1/P46hXuyEXZ3EHcL5e1pmCzBL1SjoSgPC9yvuAdIncS1rdYtLiRfdE0
 dYElfCIvJF9M/wgWM7pU2AoNbupJpe3byeQw3zl+N+nz6qUPpqZqn5G0/
 yrWGxbOCcHQBA01dPIEuE+LKc0y08QsjzK0mm9mC9SaPGsHKccEcqHqqk g==;
X-CSE-ConnectionGUID: Ge6NZcRfTlOSetN5C+dQQg==
X-CSE-MsgGUID: tVwEEfE1TE6qXpkZExUIFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="88780387"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="88780387"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 03:25:50 -0700
X-CSE-ConnectionGUID: R7F4LATWSGSJbU7rz0aQjA==
X-CSE-MsgGUID: MPXbXHO5QiatCB70y0d54g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="226361708"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by fmviesa010.fm.intel.com with ESMTP; 16 Apr 2026 03:25:47 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: Radu Nicolau <radu.nicolau@intel.com>,
	Kai Ji <kai.ji@intel.com>
Subject: [PATCH] common/qat: add asym crypto disable option
Date: Thu, 16 Apr 2026 10:25:42 +0000
Message-ID: <20260416102543.133175-1-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
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

The Asymmetric crypto QAT PMD can now be disabled independently.

Example:
meson setup build -Ddisable_drivers=crypto/qat/asym

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/common/qat/meson.build                | 23 ++++++++++++++++---
 drivers/crypto/qat/{ => asym}/qat_asym.c      |  0
 drivers/crypto/qat/{ => asym}/qat_asym.h      |  0
 drivers/crypto/qat/dev/qat_asym_pmd_gen1.c    |  2 ++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c  |  2 ++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c  |  2 ++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c  |  6 +++++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c  |  2 ++
 .../crypto/qat/dev/qat_crypto_pmd_gen_lce.c   |  2 ++
 drivers/crypto/qat/qat_crypto.c               |  6 ++++-
 10 files changed, 41 insertions(+), 4 deletions(-)
 rename drivers/crypto/qat/{ => asym}/qat_asym.c (100%)
 rename drivers/crypto/qat/{ => asym}/qat_asym.h (100%)

diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.build
index 31e06f4376..7f12f2b09d 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -13,6 +13,9 @@ qat_crypto_relpath = '../../' + qat_crypto_path
 qat_compress = true
 qat_compress_path = 'compress/qat'
 qat_compress_relpath = '../../' + qat_compress_path
+qat_crypto_asym = true
+qat_crypto_asym_path = 'crypto/qat/asym'
+qat_crypto_asym_relpath = '../../' + qat_crypto_asym_path
 
 if disable_drivers.contains(qat_crypto_path)
     qat_crypto = false
@@ -26,6 +29,12 @@ if disable_drivers.contains(qat_compress_path)
     set_variable('drv_' + qat_compress_path.underscorify() + '_disable_reason',
             'Explicitly disabled via build config')
 endif
+if disable_drivers.contains(qat_crypto_asym_path)
+    qat_crypto_asym = false
+    dpdk_drvs_disabled += qat_crypto_asym_path
+    set_variable('drv_' + qat_crypto_asym_path.underscorify() + '_disable_reason',
+            'Explicitly disabled via build config')
+endif
 
 libcrypto = dependency('libcrypto', required: false, method: 'pkg-config')
 
@@ -88,6 +97,7 @@ sources += files(
 includes += include_directories(
         'qat_adf',
         qat_crypto_relpath,
+        qat_crypto_asym_relpath,
         qat_compress_relpath,
 )
 
@@ -108,9 +118,8 @@ cflags += no_shadow_cflag
 
 if qat_crypto
     foreach f: ['qat_sym.c', 'qat_sym_session.c',
-            'qat_asym.c', 'qat_crypto.c',
+            'qat_crypto.c',
             'dev/qat_sym_pmd_gen1.c',
-            'dev/qat_asym_pmd_gen1.c',
             'dev/qat_crypto_pmd_gen2.c',
             'dev/qat_crypto_pmd_gen3.c',
             'dev/qat_crypto_pmd_gen4.c',
@@ -119,6 +128,14 @@ if qat_crypto
         ]
         sources += files(join_paths(qat_crypto_relpath, f))
     endforeach
+    cflags += '-DBUILD_QAT_SYM'
+    if qat_crypto_asym
+        foreach f: ['asym/qat_asym.c',
+                    'dev/qat_asym_pmd_gen1.c',
+            ]
+            sources += files(join_paths(qat_crypto_relpath, f))
+        endforeach
+        cflags += '-DBUILD_QAT_ASYM'
+    endif
     deps += ['security']
-    cflags += ['-DBUILD_QAT_SYM', '-DBUILD_QAT_ASYM']
 endif
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/asym/qat_asym.c
similarity index 100%
rename from drivers/crypto/qat/qat_asym.c
rename to drivers/crypto/qat/asym/qat_asym.c
diff --git a/drivers/crypto/qat/qat_asym.h b/drivers/crypto/qat/asym/qat_asym.h
similarity index 100%
rename from drivers/crypto/qat/qat_asym.h
rename to drivers/crypto/qat/asym/qat_asym.h
diff --git a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
index 20001bd1cc..c96608dd37 100644
--- a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
@@ -112,6 +112,7 @@ qat_asym_crypto_set_session_gen1(void *cdev __rte_unused,
 	return 0;
 }
 
+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen1_init)
 {
 	qat_asym_gen_dev_ops[QAT_GEN1].cryptodev_ops =
@@ -121,3 +122,4 @@ RTE_INIT(qat_asym_crypto_gen1_init)
 	qat_asym_gen_dev_ops[QAT_GEN1].get_feature_flags =
 			qat_asym_crypto_feature_flags_get_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c
index f20d367404..89c51c8f80 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c
@@ -336,6 +336,7 @@ RTE_INIT(qat_sym_crypto_gen2_init)
 			qat_sym_create_security_gen1;
 }
 
+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen2_init)
 {
 	qat_asym_gen_dev_ops[QAT_GEN2].cryptodev_ops =
@@ -347,3 +348,4 @@ RTE_INIT(qat_asym_crypto_gen2_init)
 	qat_asym_gen_dev_ops[QAT_GEN2].set_session =
 			qat_asym_crypto_set_session_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
index c196cf3cdb..91546046f1 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -800,6 +800,7 @@ RTE_INIT(qat_sym_crypto_gen3_init)
 			qat_sym_create_security_gen1;
 }
 
+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen3_init)
 {
 	qat_asym_gen_dev_ops[QAT_GEN3].cryptodev_ops =
@@ -811,3 +812,4 @@ RTE_INIT(qat_asym_crypto_gen3_init)
 	qat_asym_gen_dev_ops[QAT_GEN3].set_session =
 			qat_asym_crypto_set_session_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
index 52577f6907..41cad29142 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -115,6 +115,7 @@ static struct rte_cryptodev_capabilities qat_sym_crypto_caps_gen4[] = {
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
+#ifdef BUILD_QAT_ASYM
 static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen4[] = {
 	QAT_ASYM_CAP(MODEX,
 		0, 1, 512, 1),
@@ -159,6 +160,7 @@ static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen4[] = {
 			64, 512, 64),
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
+#endif
 
 static int
 qat_sym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
@@ -202,6 +204,7 @@ qat_sym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
 	return 0;
 }
 
+#ifdef BUILD_QAT_ASYM
 static int
 qat_asym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
 			const char *capa_memz_name,
@@ -239,6 +242,7 @@ qat_asym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
 
 	return 0;
 }
+#endif
 
 static __rte_always_inline void
 enqueue_one_aead_job_gen4(struct qat_sym_session *ctx,
@@ -622,6 +626,7 @@ RTE_INIT(qat_sym_crypto_gen4_init)
 			qat_sym_create_security_gen1;
 }
 
+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen4_init)
 {
 	qat_asym_gen_dev_ops[QAT_VQAT].cryptodev_ops =
@@ -637,3 +642,4 @@ RTE_INIT(qat_asym_crypto_gen4_init)
 		qat_asym_gen_dev_ops[QAT_GEN4].set_session =
 			qat_asym_crypto_set_session_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
index 5714420e1e..2680116d6e 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
@@ -224,6 +224,7 @@ RTE_INIT(qat_sym_crypto_gen5_init)
 			qat_sym_create_security_gen1;
 }
 
+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen5_init)
 {
 	qat_asym_gen_dev_ops[QAT_GEN5].cryptodev_ops =
@@ -235,3 +236,4 @@ RTE_INIT(qat_asym_crypto_gen5_init)
 	qat_asym_gen_dev_ops[QAT_GEN5].set_session =
 			qat_asym_crypto_set_session_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c b/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
index 7298916f2a..ec075bbf68 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
@@ -301,6 +301,7 @@ RTE_INIT(qat_sym_crypto_gen_lce_init)
 	qat_sym_gen_dev_ops[QAT_GEN_LCE].get_feature_flags = qat_sym_crypto_feature_flags_get_gen1;
 }
 
+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen_lce_init)
 {
 	qat_asym_gen_dev_ops[QAT_GEN_LCE].cryptodev_ops = NULL;
@@ -308,3 +309,4 @@ RTE_INIT(qat_asym_crypto_gen_lce_init)
 	qat_asym_gen_dev_ops[QAT_GEN_LCE].get_feature_flags = NULL;
 	qat_asym_gen_dev_ops[QAT_GEN_LCE].set_session = NULL;
 }
+#endif
diff --git a/drivers/crypto/qat/qat_crypto.c b/drivers/crypto/qat/qat_crypto.c
index 861679373b..daa36c5eed 100644
--- a/drivers/crypto/qat/qat_crypto.c
+++ b/drivers/crypto/qat/qat_crypto.c
@@ -53,9 +53,11 @@ qat_cryptodev_info_get(struct rte_cryptodev *dev,
 			qat_qps_per_service(qat_dev, service_type);
 		info->feature_flags = dev->feature_flags;
 		info->capabilities = qat_private->qat_dev_capabilities;
+
+#ifdef BUILD_QAT_ASYM
 		if (service_type == QAT_SERVICE_ASYMMETRIC)
 			info->driver_id = qat_asym_driver_id;
-
+#endif
 		if (service_type == QAT_SERVICE_SYMMETRIC)
 			info->driver_id = qat_sym_driver_id;
 		/* No limit of number of sessions */
@@ -168,8 +170,10 @@ qat_cryptodev_qp_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	for (i = 0; i < qp->nb_descriptors; i++) {
 		if (service_type == QAT_SERVICE_SYMMETRIC)
 			qat_sym_init_op_cookie(qp->op_cookies[i]);
+#ifdef BUILD_QAT_ASYM
 		else
 			qat_asym_init_op_cookie(qp->op_cookies[i]);
+#endif
 	}
 
 	if (qat_private->cipher_crc_offload_enable) {
-- 
2.52.0

