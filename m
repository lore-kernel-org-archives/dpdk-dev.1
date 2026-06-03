Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B61CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 09:27:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B95774065A;
	Wed,  3 Jun 2026 11:27:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id D36614042C
 for <dev@dpdk.org>; Wed,  3 Jun 2026 11:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780478867; x=1812014867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zDSrCb2hrKBKodW3u1miK/QEq6en0IgSbjJitTHWn+I=;
 b=FS44ZX7SZMRcdXqaN3QN6pit+sr2ofaMr1koqKp0RTU96eYoYCLDqSPI
 O9MXQmm/PFbwzCH8o3g5c1dEO8ctQWCUva611/aHcqw+Hs/qigXutOU+c
 9kfvycBKsgbtveYCUeqDwSP1LExzlkHmMAtdicVNCNn4qBFyQn5vThADv
 PRH9apgABIdX/YSuCsFwnH2pT1yC/PWfK+zWhrhRBIMR9Fb8MFLqXrlln
 DfwnPgT56y/cXHPBilJTaoLGmQTDRECU4xpRT4Sfo8vzqByFAInYM1yAC
 xhRNRChEgHG9SnN8yccy7E9M+SLhQpS5YPSPexAJE73xkKIVeQNge2San g==;
X-CSE-ConnectionGUID: RbI3f2t8RZmy+94LPHGMGA==
X-CSE-MsgGUID: Qr2h2dkXQ5KGO1cGvJn9pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81311815"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="81311815"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 02:27:46 -0700
X-CSE-ConnectionGUID: foLhFm2ASlyXZzn2dxUUpQ==
X-CSE-MsgGUID: 995aqOFiQwi134adVOtMQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="248118223"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa003.jf.intel.com with ESMTP; 03 Jun 2026 02:27:43 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: paul.elliott@arm.com, Shebu.VargheseKuriakose@arm.com,
 tomasz.kantecki@intel.com, Islam.Ragimov@arm.com,
 Gowtham.SureshKumar@arm.com, emma.finn@intel.com, marcel.d.cornu@intel.com,
 gakhil@marvell.com, john.mcnamara@intel.com, Jonathan.Wright@arm.com,
 Dhruv.Tripathi@arm.com, wathsala.vithanage@arm.com,
 Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH 2/2] crypto/ipsec_mb: remove ZUC and SNOW 3G drivers from x86
 build
Date: Wed,  3 Jun 2026 09:27:35 +0000
Message-ID: <20260603092736.664428-2-radu.nicolau@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603092736.664428-1-radu.nicolau@intel.com>
References: <20260603092736.664428-1-radu.nicolau@intel.com>
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

The ZUC and SNOW 3G crypto drivers are using APIs that are now
deprecated in the Intel IPsec Multi-Buffer library.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 doc/guides/cryptodevs/aesni_mb.rst         |  2 +-
 doc/guides/cryptodevs/snow3g.rst           | 15 ++++-----------
 doc/guides/cryptodevs/zuc.rst              | 13 +++----------
 doc/guides/rel_notes/release_26_07.rst     |  5 +++++
 drivers/crypto/ipsec_mb/ipsec_mb_private.h |  6 ++++++
 drivers/crypto/ipsec_mb/meson.build        |  9 +++++++--
 6 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 9d886657f2..5efbadb8d1 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -82,7 +82,7 @@ Limitations
   DOCSIS security protocol.
 
 AESNI MB PMD selection over SNOW3G/ZUC PMDs
---------------------------------------------------
+-------------------------------------------
 
 This PMD supports wireless cipher suite (SNOW3G and ZUC).
 On Intel processors, it is recommended to use this PMD
diff --git a/doc/guides/cryptodevs/snow3g.rst b/doc/guides/cryptodevs/snow3g.rst
index 0fe914ffd3..d7f494a963 100644
--- a/doc/guides/cryptodevs/snow3g.rst
+++ b/doc/guides/cryptodevs/snow3g.rst
@@ -5,8 +5,8 @@ SNOW 3G Crypto Poll Mode Driver
 ===============================
 
 The SNOW3G PMD (**librte_crypto_snow3g**) provides poll mode crypto driver support for
-utilizing `Intel IPSec Multi-buffer library <https://github.com/01org/intel-ipsec-mb>`_
-which implements F8 and F8 functions for SNOW 3G UEA2 cipher and UIA2 hash algorithms.
+utilizing the ARM64 port of `Intel IPSec Multi-buffer library <https://gitlab.arm.com/arm-reference-solutions/ipsec-mb>`_
+which implements F8 and F9 functions for SNOW 3G UEA2 cipher and UIA2 hash algorithms.
 
 Features
 --------
@@ -36,9 +36,7 @@ Limitations
 SNOW3G PMD vs AESNI MB PMD
 --------------------------
 
-AESNI MB PMD also supports SNOW3G cipher and authentication algorithms.
-It is recommended to use the AESNI MB PMD,
-which offers better performance on Intel processors.
+On Intel processors this PMD is no longer supported, please use the AESNI MB PMD.
 Take a look at the PMD documentation (:doc:`aesni_mb`) for more information.
 
 Installation
@@ -47,12 +45,7 @@ Installation
 To build DPDK with the SNOW3G_PMD the user is required to download the multi-buffer
 library and compile it on their user system before building DPDK.
 
-For x86 system, the multi-buffer library is available
-`here <https://github.com/01org/intel-ipsec-mb>`_.
-The latest version of the library supported by this PMD is v1.5, which
-can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
-
-For Arm system, ARM64 port of the multi-buffer library can be downloaded from
+The ARM64 port of the multi-buffer library can be downloaded from
 `<https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/>`_. The
 latest version of the library supported by this PMD is tagged as SECLIB-IPSEC-2024.07.08.
 
diff --git a/doc/guides/cryptodevs/zuc.rst b/doc/guides/cryptodevs/zuc.rst
index 7c6b83e7eb..e4c86814f1 100644
--- a/doc/guides/cryptodevs/zuc.rst
+++ b/doc/guides/cryptodevs/zuc.rst
@@ -5,7 +5,7 @@ ZUC Crypto Poll Mode Driver
 ===========================
 
 The ZUC PMD (**librte_crypto_zuc**) provides poll mode crypto driver support for
-utilizing `Intel IPSec Multi-buffer library <https://github.com/01org/intel-ipsec-mb>`_
+utilizing the ARM64 port of `Intel IPSec Multi-buffer library <https://gitlab.arm.com/arm-reference-solutions/ipsec-mb>`_
 which implements F8 and F9 functions for ZUC EEA3 cipher and EIA3 hash algorithms.
 
 Features
@@ -35,9 +35,7 @@ Limitations
 ZUC PMD vs AESNI MB PMD
 -----------------------
 
-AESNI MB PMD also supports ZUC cipher and authentication algorithms.
-It is recommended to use the AESNI MB PMD,
-which offers better performance on Intel processors.
+On Intel processors this PMD is no longer supported, please use the AESNI MB PMD.
 Take a look at the PMD documentation (:doc:`aesni_mb`) for more information.
 
 Installation
@@ -46,12 +44,7 @@ Installation
 To build DPDK with the ZUC_PMD the user is required to download the multi-buffer
 library and compile it on their user system before building DPDK.
 
-For x86 system, the multi-buffer library is available
-`here <https://github.com/01org/intel-ipsec-mb>`_.
-The latest version of the library supported by this PMD is v1.5, which
-can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
-
-For Arm system, ARM64 port of the multi-buffer library can be downloaded from
+The ARM64 port of the multi-buffer library can be downloaded from
 `<https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/>`_. The
 latest version of the library supported by this PMD is tagged as SECLIB-IPSEC-2024.07.08.
 
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 64c8b038d1..388642851a 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -123,6 +123,11 @@ Removed Items
   * The Chacha20-poly1305 and KASUMI drivers were just wrappers around
     the main AESNI_MB driver.
 
+* **Removed ZUC and SNOW 3G crypto drivers from the x86 release.**
+
+  * The ZUC and SNOW 3G crypto drivers are using APIs that are now
+    deprecated in the Intel IPsec Multi-Buffer library.
+
 
 API Changes
 -----------
diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_private.h b/drivers/crypto/ipsec_mb/ipsec_mb_private.h
index 9712bf5b4c..fc7d6f5f06 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_private.h
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_private.h
@@ -45,11 +45,13 @@ extern RTE_DEFINE_PER_LCORE(IMB_MGR *, mb_mgr);
 #define CRYPTODEV_NAME_AESNI_GCM_PMD crypto_aesni_gcm
 /**< IPSEC Multi buffer PMD aesni_gcm device name */
 
+#if defined(RTE_ARCH_ARM)
 #define CRYPTODEV_NAME_SNOW3G_PMD crypto_snow3g
 /**< IPSEC Multi buffer PMD snow3g device name */
 
 #define CRYPTODEV_NAME_ZUC_PMD crypto_zuc
 /**< IPSEC Multi buffer PMD zuc device name */
+#endif
 
 /** PMD LOGTYPE DRIVER, common to all PMDs */
 extern int ipsec_mb_logtype_driver;
@@ -62,8 +64,10 @@ extern int ipsec_mb_logtype_driver;
 enum ipsec_mb_pmd_types {
 	IPSEC_MB_PMD_TYPE_AESNI_MB = 0,
 	IPSEC_MB_PMD_TYPE_AESNI_GCM,
+#if defined(RTE_ARCH_ARM)
 	IPSEC_MB_PMD_TYPE_SNOW3G,
 	IPSEC_MB_PMD_TYPE_ZUC,
+#endif
 	IPSEC_MB_N_PMD_TYPES
 };
 
@@ -96,10 +100,12 @@ ipsec_mb_get_driver_id(enum ipsec_mb_pmd_types pmd_type)
 		return pmd_driver_id_aesni_mb;
 	case IPSEC_MB_PMD_TYPE_AESNI_GCM:
 		return pmd_driver_id_aesni_gcm;
+#if defined(RTE_ARCH_ARM)
 	case IPSEC_MB_PMD_TYPE_SNOW3G:
 		return pmd_driver_id_snow3g;
 	case IPSEC_MB_PMD_TYPE_ZUC:
 		return pmd_driver_id_zuc;
+#endif
 	default:
 		break;
 	}
diff --git a/drivers/crypto/ipsec_mb/meson.build b/drivers/crypto/ipsec_mb/meson.build
index 6c5e4e2259..eb2085725b 100644
--- a/drivers/crypto/ipsec_mb/meson.build
+++ b/drivers/crypto/ipsec_mb/meson.build
@@ -42,8 +42,13 @@ sources = files(
         'ipsec_mb_ops.c',
         'pmd_aesni_mb.c',
         'pmd_aesni_gcm.c',
-        'pmd_snow3g.c',
-        'pmd_zuc.c',
 )
+# PMDs supported only on ARM build
+if arch_subdir == 'arm'
+    sources += files(
+            'pmd_snow3g.c',
+            'pmd_zuc.c',
+    )
+endif
 deps += ['bus_vdev', 'net', 'security']
 require_iova_in_mbuf = false
-- 
2.52.0

