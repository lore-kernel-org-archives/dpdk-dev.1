Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530C7CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 09:27:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 761BC402B6;
	Wed,  3 Jun 2026 11:27:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id ED8DB402AB
 for <dev@dpdk.org>; Wed,  3 Jun 2026 11:27:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780478864; x=1812014864;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qbjmOpHcxGXv7wXOjdxHpqPDGOxnyHrSQxBkmgeqzDU=;
 b=lrbvPj88TOOyamO2Is/t8klPU0t2EPPUGI2L9CFczqYIDunaTYSSJZnh
 lne6ByivYyAephmdxMpd1owL5j9VJOGMWmxjmSIFBaR8XRzw8kjS315Lu
 vs+s/2uLIz5amP7TibN520cAJ+gwEJqWLnO4zqpY9ZuwtmBIlAiAD93hg
 l/DWn6tnrlbtAddB3f8GhYFj+Ozhm3479JvgX2/hp8gJaCefA5pTwMqXr
 +QLw8yOd3/Hy+bwn4oTEAKLn506QRQREgFDJbTArMR/xPNTVEhbSucBQ5
 /S4vYCc25KXo4sBjFju+aCjycR0cnzEePIv0qm9OYt1AsQyQ/GFMRaBIi g==;
X-CSE-ConnectionGUID: VbW/fhFKTL+kSJ71wGoWGA==
X-CSE-MsgGUID: vFqj/ooHRQKR3M/ZGuHZAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81311807"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="81311807"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 02:27:43 -0700
X-CSE-ConnectionGUID: Kct/sbHyRKGGnX5W6ENScg==
X-CSE-MsgGUID: o7WltQTPSAiXxuNG14qIMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="248118217"
Received: from silpixa00401749.ir.intel.com ([10.20.224.233])
 by orviesa003.jf.intel.com with ESMTP; 03 Jun 2026 02:27:39 -0700
From: Radu Nicolau <radu.nicolau@intel.com>
To: dev@dpdk.org
Cc: paul.elliott@arm.com, Shebu.VargheseKuriakose@arm.com,
 tomasz.kantecki@intel.com, Islam.Ragimov@arm.com,
 Gowtham.SureshKumar@arm.com, emma.finn@intel.com, marcel.d.cornu@intel.com,
 gakhil@marvell.com, john.mcnamara@intel.com, Jonathan.Wright@arm.com,
 Dhruv.Tripathi@arm.com, wathsala.vithanage@arm.com,
 Radu Nicolau <radu.nicolau@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, Fan Zhang <fanzhang.oss@gmail.com>,
 Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH 1/2] crypto/ipsec_mb: remove chacha-poly and kasumi drivers
Date: Wed,  3 Jun 2026 09:27:34 +0000
Message-ID: <20260603092736.664428-1-radu.nicolau@intel.com>
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

The Chacha20-poly1305 and KASUMI drivers were just wrappers around
the main AESNI_MB driver, hence redundant and removed.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 MAINTAINERS                                   |   4 -
 app/test/test_cryptodev.c                     |  20 ---
 app/test/test_cryptodev.h                     |   2 -
 doc/guides/cryptodevs/aesni_mb.rst            |  14 +-
 doc/guides/cryptodevs/chacha20_poly1305.rst   | 100 -------------
 .../cryptodevs/features/chacha20_poly1305.ini |  42 ------
 doc/guides/cryptodevs/features/kasumi.ini     |  39 ------
 doc/guides/cryptodevs/index.rst               |   2 -
 doc/guides/cryptodevs/kasumi.rst              | 131 ------------------
 doc/guides/rel_notes/release_26_07.rst        |   5 +
 doc/guides/tools/cryptoperf.rst               |   1 -
 drivers/crypto/ipsec_mb/ipsec_mb_private.h    |  14 --
 drivers/crypto/ipsec_mb/meson.build           |   2 -
 drivers/crypto/ipsec_mb/pmd_chacha_poly.c     |  74 ----------
 .../crypto/ipsec_mb/pmd_chacha_poly_priv.h    |  46 ------
 drivers/crypto/ipsec_mb/pmd_kasumi.c          |  76 ----------
 drivers/crypto/ipsec_mb/pmd_kasumi_priv.h     |  61 --------
 17 files changed, 8 insertions(+), 625 deletions(-)
 delete mode 100644 doc/guides/cryptodevs/chacha20_poly1305.rst
 delete mode 100644 doc/guides/cryptodevs/features/chacha20_poly1305.ini
 delete mode 100644 doc/guides/cryptodevs/features/kasumi.ini
 delete mode 100644 doc/guides/cryptodevs/kasumi.rst
 delete mode 100644 drivers/crypto/ipsec_mb/pmd_chacha_poly.c
 delete mode 100644 drivers/crypto/ipsec_mb/pmd_chacha_poly_priv.h
 delete mode 100644 drivers/crypto/ipsec_mb/pmd_kasumi.c
 delete mode 100644 drivers/crypto/ipsec_mb/pmd_kasumi_priv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 72fc12b1f2..567d1c872e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1234,14 +1234,10 @@ M: Pablo de Lara <pablo.de.lara.guarch@intel.com>
 F: drivers/crypto/ipsec_mb/
 F: doc/guides/cryptodevs/aesni_gcm.rst
 F: doc/guides/cryptodevs/aesni_mb.rst
-F: doc/guides/cryptodevs/chacha20_poly1305.rst
-F: doc/guides/cryptodevs/kasumi.rst
 F: doc/guides/cryptodevs/snow3g.rst
 F: doc/guides/cryptodevs/zuc.rst
 F: doc/guides/cryptodevs/features/aesni_gcm.ini
 F: doc/guides/cryptodevs/features/aesni_mb.ini
-F: doc/guides/cryptodevs/features/chacha20_poly1305.ini
-F: doc/guides/cryptodevs/features/kasumi.ini
 F: doc/guides/cryptodevs/features/snow3g.ini
 F: doc/guides/cryptodevs/features/zuc.ini
 
diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index a60983c6b7..b908f10317 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -20602,17 +20602,6 @@ test_cryptodev_cpu_aesni_mb(void)
 	return rc;
 }
 
-static int
-test_cryptodev_chacha_poly_mb(void)
-{
-	int32_t rc;
-	enum rte_security_session_action_type at = gbl_action_type;
-	rc = run_cryptodev_testsuite(
-			RTE_STR(CRYPTODEV_NAME_CHACHA20_POLY1305_PMD));
-	gbl_action_type = at;
-	return rc;
-}
-
 static int
 test_cryptodev_openssl(void)
 {
@@ -20654,12 +20643,6 @@ test_cryptodev_sw_snow3g(void)
 	return run_cryptodev_testsuite(RTE_STR(CRYPTODEV_NAME_SNOW3G_PMD));
 }
 
-static int
-test_cryptodev_sw_kasumi(void)
-{
-	return run_cryptodev_testsuite(RTE_STR(CRYPTODEV_NAME_KASUMI_PMD));
-}
-
 static int
 test_cryptodev_sw_zuc(void)
 {
@@ -20910,8 +20893,6 @@ REGISTER_DRIVER_TEST(cryptodev_qat_autotest, test_cryptodev_qat);
 REGISTER_DRIVER_TEST(cryptodev_aesni_mb_autotest, test_cryptodev_aesni_mb);
 REGISTER_DRIVER_TEST(cryptodev_cpu_aesni_mb_autotest,
 	test_cryptodev_cpu_aesni_mb);
-REGISTER_DRIVER_TEST(cryptodev_chacha_poly_mb_autotest,
-	test_cryptodev_chacha_poly_mb);
 REGISTER_DRIVER_TEST(cryptodev_openssl_autotest, test_cryptodev_openssl);
 REGISTER_DRIVER_TEST(cryptodev_aesni_gcm_autotest, test_cryptodev_aesni_gcm);
 REGISTER_DRIVER_TEST(cryptodev_cpu_aesni_gcm_autotest,
@@ -20919,7 +20900,6 @@ REGISTER_DRIVER_TEST(cryptodev_cpu_aesni_gcm_autotest,
 REGISTER_DRIVER_TEST(cryptodev_mlx5_autotest, test_cryptodev_mlx5);
 REGISTER_DRIVER_TEST(cryptodev_null_autotest, test_cryptodev_null);
 REGISTER_DRIVER_TEST(cryptodev_sw_snow3g_autotest, test_cryptodev_sw_snow3g);
-REGISTER_DRIVER_TEST(cryptodev_sw_kasumi_autotest, test_cryptodev_sw_kasumi);
 REGISTER_DRIVER_TEST(cryptodev_sw_zuc_autotest, test_cryptodev_sw_zuc);
 REGISTER_DRIVER_TEST(cryptodev_sw_armv8_autotest, test_cryptodev_armv8);
 REGISTER_DRIVER_TEST(cryptodev_sw_mvsam_autotest, test_cryptodev_mrvl);
diff --git a/app/test/test_cryptodev.h b/app/test/test_cryptodev.h
index 23d12ec961..49aa45ec17 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -59,9 +59,7 @@
 #define CRYPTODEV_NAME_QAT_SYM_PMD	crypto_qat
 #define CRYPTODEV_NAME_QAT_ASYM_PMD	crypto_qat_asym
 #define CRYPTODEV_NAME_SNOW3G_PMD	crypto_snow3g
-#define CRYPTODEV_NAME_KASUMI_PMD	crypto_kasumi
 #define CRYPTODEV_NAME_ZUC_PMD		crypto_zuc
-#define CRYPTODEV_NAME_CHACHA20_POLY1305_PMD	crypto_chacha20_poly1305
 #define CRYPTODEV_NAME_ARMV8_PMD	crypto_armv8
 #define CRYPTODEV_NAME_DPAA_SEC_PMD	crypto_dpaa_sec
 #define CRYPTODEV_NAME_DPAA2_SEC_PMD	crypto_dpaa2_sec
diff --git a/doc/guides/cryptodevs/aesni_mb.rst b/doc/guides/cryptodevs/aesni_mb.rst
index 7ce92305d1..9d886657f2 100644
--- a/doc/guides/cryptodevs/aesni_mb.rst
+++ b/doc/guides/cryptodevs/aesni_mb.rst
@@ -81,23 +81,15 @@ Limitations
 * RTE_CRYPTO_CIPHER_DES_DOCSISBPI is not supported for combined Crypto-CRC
   DOCSIS security protocol.
 
-AESNI MB PMD selection over SNOW3G/ZUC/KASUMI PMDs
+AESNI MB PMD selection over SNOW3G/ZUC PMDs
 --------------------------------------------------
 
-This PMD supports wireless cipher suite (SNOW3G, ZUC and KASUMI).
+This PMD supports wireless cipher suite (SNOW3G and ZUC).
 On Intel processors, it is recommended to use this PMD
-instead of SNOW3G, ZUC and KASUMI PMDs, as it enables algorithm mixing
+instead of SNOW3G and ZUC PMDs, as it enables algorithm mixing
 (e.g. cipher algorithm SNOW3G-UEA2 with authentication algorithm AES-CMAC-128)
 and performance over IMIX (packet size mix) traffic is significantly higher.
 
-AESNI MB PMD selection over CHACHA20-POLY1305 PMD
--------------------------------------------------
-
-This PMD supports Chacha20-Poly1305 algorithm.
-On Intel processors, it is recommended to use this PMD instead of CHACHA20-POLY1305 PMD,
-as it delivers better performance on single segment buffers.
-For multi-segment buffers, it is still recommended to use CHACHA20-POLY1305 PMD,
-until the new SGL API is introduced in the AESNI MB PMD.
 
 Installation
 ------------
diff --git a/doc/guides/cryptodevs/chacha20_poly1305.rst b/doc/guides/cryptodevs/chacha20_poly1305.rst
deleted file mode 100644
index 37d9d2e8af..0000000000
--- a/doc/guides/cryptodevs/chacha20_poly1305.rst
+++ /dev/null
@@ -1,100 +0,0 @@
-..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright(c) 2021 Intel Corporation.
-
-Chacha20-poly1305 Crypto Poll Mode Driver
-=========================================
-
-The Chacha20-poly1305 PMD provides poll mode crypto driver support for
-utilizing `Intel IPSec Multi-buffer library <https://github.com/01org/intel-ipsec-mb>`_.
-
-Features
---------
-
-Chacha20-poly1305 PMD has support for:
-
-AEAD algorithms:
-
-* RTE_CRYPTO_AEAD_CHACHA20_POLY1305
-
-Chaha20_Poly1305 PMD vs AESNI MB PMD
-------------------------------------
-
-AESNI MB PMD also supports CHACHA20-POLY1305 algorithms.
-It is recommended to use the AESNI MB PMD,
-which offers better performance on Intel processors,
-when single-segment buffers are used.
-Take a look at the PMD documentation (:doc:`aesni_mb`) for more information.
-
-Installation
-------------
-
-To build DPDK with the Chacha20-poly1305 PMD the user is required to download
-the multi-buffer library from `here <https://github.com/01org/intel-ipsec-mb>`_
-and compile it on their user system before building DPDK.
-The latest version of the library supported by this PMD is v1.5, which
-can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
-
-After downloading the library, the user needs to unpack and compile it
-on their system before building DPDK:
-
-.. code-block:: console
-
-    make
-    make install
-
-The library requires NASM to be built. Depending on the library version, it might
-require a minimum NASM version (e.g. v0.54 requires at least NASM 2.14).
-
-NASM is packaged for different OS. However, on some OS the version is too old,
-so a manual installation is required. In that case, NASM can be downloaded from
-`NASM website <https://www.nasm.us/pub/nasm/releasebuilds/?C=M;O=D>`_.
-Once it is downloaded, extract it and follow these steps:
-
-.. code-block:: console
-
-    ./configure
-    make
-    make install
-
-As a reference, the following table shows a mapping between the past DPDK versions
-and the external crypto libraries supported by them:
-
-.. _table_chacha20_poly1305_versions:
-
-.. table:: DPDK and external crypto library version compatibility
-
-   =============  ================================
-   DPDK version   Crypto library version
-   =============  ================================
-   21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4+
-   =============  ================================
-
-Initialization
---------------
-
-In order to enable this virtual crypto PMD, user must:
-
-* Build the multi buffer library (explained in Installation section).
-
-To use the PMD in an application, user must:
-
-* Call rte_vdev_init("crypto_chacha20_poly1305") within the application.
-
-* Use --vdev="crypto_chacha20_poly1305" in the EAL options, which will call
-  rte_vdev_init() internally.
-
-The following parameters (all optional) can be provided in the previous two calls:
-
-* socket_id: Specify the socket where the memory for the device is going to be allocated
-  (by default, socket_id will be the socket where the core that is creating the PMD is running on).
-
-* max_nb_queue_pairs: Specify the maximum number of queue pairs in the device (8 by default).
-
-* max_nb_sessions: Specify the maximum number of sessions that can be created (2048 by default).
-
-Example:
-
-.. code-block:: console
-
-    --vdev="crypto_chacha20_poly1305,socket_id=0,max_nb_sessions=128"
diff --git a/doc/guides/cryptodevs/features/chacha20_poly1305.ini b/doc/guides/cryptodevs/features/chacha20_poly1305.ini
deleted file mode 100644
index b5a7b39bd0..0000000000
--- a/doc/guides/cryptodevs/features/chacha20_poly1305.ini
+++ /dev/null
@@ -1,42 +0,0 @@
-;
-; Supported features of the 'chacha20_poly1305' crypto driver.
-;
-; Refer to default.ini for the full list of available PMD features.
-;
-[Features]
-Symmetric crypto       = Y
-Sym operation chaining = Y
-Symmetric sessionless  = Y
-Non-Byte aligned data  = Y
-In Place SGL           = Y
-OOP SGL In LB  Out     = Y
-OOP LB  In LB  Out     = Y
-CPU crypto             = Y
-
-;
-; Supported crypto algorithms of the 'chacha20_poly1305' crypto driver.
-;
-[Cipher]
-
-;
-; Supported authentication algorithms of the 'chacha20_poly1305' crypto driver.
-;
-[Auth]
-
-;
-; Supported AEAD algorithms of the 'chacha20_poly1305' crypto driver.
-;
-[AEAD]
-CHACHA20-POLY1305 = Y
-
-;
-; Supported Asymmetric algorithms of the 'chacha20_poly1305' crypto driver.
-;
-[Asymmetric]
-
-;
-; Supported Operating systems of the 'chacha20_poly1305' crypto driver.
-;
-[OS]
-Linux = Y
-FreeBSD = Y
diff --git a/doc/guides/cryptodevs/features/kasumi.ini b/doc/guides/cryptodevs/features/kasumi.ini
deleted file mode 100644
index d400a4269d..0000000000
--- a/doc/guides/cryptodevs/features/kasumi.ini
+++ /dev/null
@@ -1,39 +0,0 @@
-;
-; Supported features of the 'kasumi' crypto driver.
-;
-; Refer to default.ini for the full list of available PMD features.
-;
-[Features]
-Symmetric crypto       = Y
-Sym operation chaining = Y
-Symmetric sessionless  = Y
-Non-Byte aligned data  = Y
-OOP LB  In LB  Out     = Y
-
-;
-; Supported crypto algorithms of the 'kasumi' crypto driver.
-;
-[Cipher]
-KASUMI F8 = Y
-;
-; Supported authentication algorithms of the 'kasumi' crypto driver.
-;
-[Auth]
-KASUMI F9 = Y
-
-;
-; Supported AEAD algorithms of the 'kasumi' crypto driver.
-;
-[AEAD]
-
-;
-; Supported Asymmetric algorithms of the 'kasumi' crypto driver.
-;
-[Asymmetric]
-
-;
-; Supported Operating systems of the 'kasumi' crypto driver.
-;
-[OS]
-Linux = Y
-FreeBSD = Y
diff --git a/doc/guides/cryptodevs/index.rst b/doc/guides/cryptodevs/index.rst
index 7c19629e17..cfb6a494bf 100644
--- a/doc/guides/cryptodevs/index.rst
+++ b/doc/guides/cryptodevs/index.rst
@@ -16,12 +16,10 @@ Crypto Device Drivers
     bcmfs
     caam_jr
     ccp
-    chacha20_poly1305
     cnxk
     dpaa2_sec
     dpaa_sec
     ionic
-    kasumi
     octeontx
     openssl
     mlx5
diff --git a/doc/guides/cryptodevs/kasumi.rst b/doc/guides/cryptodevs/kasumi.rst
deleted file mode 100644
index ce1db4e905..0000000000
--- a/doc/guides/cryptodevs/kasumi.rst
+++ /dev/null
@@ -1,131 +0,0 @@
-..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright(c) 2016-2019 Intel Corporation.
-
-KASUMI Crypto Poll Mode Driver
-===============================
-
-The KASUMI PMD (**librte_crypto_kasumi**) provides poll mode crypto driver support for
-utilizing `Intel IPSec Multi-buffer library <https://github.com/01org/intel-ipsec-mb>`_
-which implements F8 and F9 functions for KASUMI UEA1 cipher and UIA1 hash algorithms.
-
-Features
---------
-
-KASUMI PMD has support for:
-
-Cipher algorithm:
-
-* RTE_CRYPTO_CIPHER_KASUMI_F8
-
-Authentication algorithm:
-
-* RTE_CRYPTO_AUTH_KASUMI_F9
-
-Limitations
------------
-
-* Chained mbufs are not supported.
-* KASUMI(F9) supported only if hash offset and length field is byte-aligned.
-* In-place bit-level operations for KASUMI(F8) are not supported
-  (if length and/or offset of data to be ciphered is not byte-aligned).
-
-
-KASUMI PMD vs AESNI MB PMD
---------------------------
-
-AESNI MB PMD also supports KASUMI cipher and authentication algorithms.
-It is recommended to use the AESNI MB PMD,
-which offers better performance on Intel processors.
-Take a look at the PMD documentation (:doc:`aesni_mb`) for more information.
-
-Installation
-------------
-
-To build DPDK with the KASUMI_PMD the user is required to download the multi-buffer
-library from `here <https://github.com/01org/intel-ipsec-mb>`_
-and compile it on their user system before building DPDK.
-The latest version of the library supported by this PMD is v1.5, which
-can be downloaded from `<https://github.com/01org/intel-ipsec-mb/archive/v1.5.zip>`_.
-
-After downloading the library, the user needs to unpack and compile it
-on their system before building DPDK:
-
-.. code-block:: console
-
-    make
-    make install
-
-The library requires NASM to be built. Depending on the library version, it might
-require a minimum NASM version (e.g. v0.54 requires at least NASM 2.14).
-
-NASM is packaged for different OS. However, on some OS the version is too old,
-so a manual installation is required. In that case, NASM can be downloaded from
-`NASM website <https://www.nasm.us/pub/nasm/releasebuilds/?C=M;O=D>`_.
-Once it is downloaded, extract it and follow these steps:
-
-.. code-block:: console
-
-    ./configure
-    make
-    make install
-
-As a reference, the following table shows a mapping between the past DPDK versions
-and the external crypto libraries supported by them:
-
-.. _table_kasumi_versions:
-
-.. table:: DPDK and external crypto library version compatibility
-
-   =============  ================================
-   DPDK version   Crypto library version
-   =============  ================================
-   20.02 - 21.08  Multi-buffer library 0.53 - 1.3
-   21.11 - 24.07  Multi-buffer library 1.0  - 1.5
-   24.11+         Multi-buffer library 1.4  - 1.5
-   =============  ================================
-
-Initialization
---------------
-
-In order to enable this virtual crypto PMD, user must:
-
-* Build the multi buffer library (explained in Installation section).
-
-To use the PMD in an application, user must:
-
-* Call rte_vdev_init("crypto_kasumi") within the application.
-
-* Use --vdev="crypto_kasumi" in the EAL options, which will call rte_vdev_init() internally.
-
-The following parameters (all optional) can be provided in the previous two calls:
-
-* socket_id: Specify the socket where the memory for the device is going to be allocated
-  (by default, socket_id will be the socket where the core that is creating the PMD is running on).
-
-* max_nb_queue_pairs: Specify the maximum number of queue pairs in the device (8 by default).
-
-* max_nb_sessions: Specify the maximum number of sessions that can be created (2048 by default).
-
-Example:
-
-.. code-block:: console
-
-    ./dpdk-l2fwd-crypto -l 1 --vdev="crypto_kasumi,socket_id=0,max_nb_sessions=128" \
-    -- -p 1 --cdev SW --chain CIPHER_ONLY --cipher_algo "kasumi-f8"
-
-Extra notes on KASUMI F9
-------------------------
-
-When using KASUMI F9 authentication algorithm, the input buffer must be
-constructed according to the 3GPP KASUMI specifications (section 4.4, page 13):
-`<http://cryptome.org/3gpp/35201-900.pdf>`_.
-Input buffer has to have COUNT (4 bytes), FRESH (4 bytes), MESSAGE and DIRECTION (1 bit)
-concatenated. After the DIRECTION bit, a single '1' bit is appended, followed by
-between 0 and 7 '0' bits, so that the total length of the buffer is multiple of 8 bits.
-Note that the actual message can be any length, specified in bits.
-
-Once this buffer is passed this way, when creating the crypto operation,
-length of data to authenticate (op.sym.auth.data.length) must be the length
-of all the items described above, including the padding at the end.
-Also, offset of data to authenticate (op.sym.auth.data.offset)
-must be such that points at the start of the COUNT bytes.
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index b8a3e2ced9..64c8b038d1 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -118,6 +118,11 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Removed Chacha20-poly1305 and KASUMI crypto drivers.**
+
+  * The Chacha20-poly1305 and KASUMI drivers were just wrappers around
+    the main AESNI_MB driver.
+
 
 API Changes
 -----------
diff --git a/doc/guides/tools/cryptoperf.rst b/doc/guides/tools/cryptoperf.rst
index 846487c5e6..2ce9bc9a96 100644
--- a/doc/guides/tools/cryptoperf.rst
+++ b/doc/guides/tools/cryptoperf.rst
@@ -153,7 +153,6 @@ The following are the application command-line options:
            crypto_cn10k
            crypto_dpaa_sec
            crypto_dpaa2_sec
-           crypto_kasumi
            crypto_mvsam
            crypto_null
            crypto_octeontx
diff --git a/drivers/crypto/ipsec_mb/ipsec_mb_private.h b/drivers/crypto/ipsec_mb/ipsec_mb_private.h
index 025767cfce..9712bf5b4c 100644
--- a/drivers/crypto/ipsec_mb/ipsec_mb_private.h
+++ b/drivers/crypto/ipsec_mb/ipsec_mb_private.h
@@ -45,18 +45,12 @@ extern RTE_DEFINE_PER_LCORE(IMB_MGR *, mb_mgr);
 #define CRYPTODEV_NAME_AESNI_GCM_PMD crypto_aesni_gcm
 /**< IPSEC Multi buffer PMD aesni_gcm device name */
 
-#define CRYPTODEV_NAME_KASUMI_PMD crypto_kasumi
-/**< IPSEC Multi buffer PMD kasumi device name */
-
 #define CRYPTODEV_NAME_SNOW3G_PMD crypto_snow3g
 /**< IPSEC Multi buffer PMD snow3g device name */
 
 #define CRYPTODEV_NAME_ZUC_PMD crypto_zuc
 /**< IPSEC Multi buffer PMD zuc device name */
 
-#define CRYPTODEV_NAME_CHACHA20_POLY1305_PMD crypto_chacha20_poly1305
-/**< IPSEC Multi buffer PMD chacha20_poly1305 device name */
-
 /** PMD LOGTYPE DRIVER, common to all PMDs */
 extern int ipsec_mb_logtype_driver;
 #define RTE_LOGTYPE_IPSEC_MB ipsec_mb_logtype_driver
@@ -68,10 +62,8 @@ extern int ipsec_mb_logtype_driver;
 enum ipsec_mb_pmd_types {
 	IPSEC_MB_PMD_TYPE_AESNI_MB = 0,
 	IPSEC_MB_PMD_TYPE_AESNI_GCM,
-	IPSEC_MB_PMD_TYPE_KASUMI,
 	IPSEC_MB_PMD_TYPE_SNOW3G,
 	IPSEC_MB_PMD_TYPE_ZUC,
-	IPSEC_MB_PMD_TYPE_CHACHA20_POLY1305,
 	IPSEC_MB_N_PMD_TYPES
 };
 
@@ -92,10 +84,8 @@ enum ipsec_mb_operation {
 
 extern uint8_t pmd_driver_id_aesni_mb;
 extern uint8_t pmd_driver_id_aesni_gcm;
-extern uint8_t pmd_driver_id_kasumi;
 extern uint8_t pmd_driver_id_snow3g;
 extern uint8_t pmd_driver_id_zuc;
-extern uint8_t pmd_driver_id_chacha20_poly1305;
 
 /** Helper function. Gets driver ID based on PMD type */
 static __rte_always_inline uint8_t
@@ -106,14 +96,10 @@ ipsec_mb_get_driver_id(enum ipsec_mb_pmd_types pmd_type)
 		return pmd_driver_id_aesni_mb;
 	case IPSEC_MB_PMD_TYPE_AESNI_GCM:
 		return pmd_driver_id_aesni_gcm;
-	case IPSEC_MB_PMD_TYPE_KASUMI:
-		return pmd_driver_id_kasumi;
 	case IPSEC_MB_PMD_TYPE_SNOW3G:
 		return pmd_driver_id_snow3g;
 	case IPSEC_MB_PMD_TYPE_ZUC:
 		return pmd_driver_id_zuc;
-	case IPSEC_MB_PMD_TYPE_CHACHA20_POLY1305:
-		return pmd_driver_id_chacha20_poly1305;
 	default:
 		break;
 	}
diff --git a/drivers/crypto/ipsec_mb/meson.build b/drivers/crypto/ipsec_mb/meson.build
index 5fcff5b04b..6c5e4e2259 100644
--- a/drivers/crypto/ipsec_mb/meson.build
+++ b/drivers/crypto/ipsec_mb/meson.build
@@ -42,8 +42,6 @@ sources = files(
         'ipsec_mb_ops.c',
         'pmd_aesni_mb.c',
         'pmd_aesni_gcm.c',
-        'pmd_chacha_poly.c',
-        'pmd_kasumi.c',
         'pmd_snow3g.c',
         'pmd_zuc.c',
 )
diff --git a/drivers/crypto/ipsec_mb/pmd_chacha_poly.c b/drivers/crypto/ipsec_mb/pmd_chacha_poly.c
deleted file mode 100644
index 24488d4921..0000000000
--- a/drivers/crypto/ipsec_mb/pmd_chacha_poly.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2021 Intel Corporation
- */
-
-#include "pmd_chacha_poly_priv.h"
-#include "pmd_aesni_mb_priv.h"
-
-struct rte_cryptodev_ops chacha20_poly1305_pmd_ops = {
-	.dev_configure = ipsec_mb_config,
-	.dev_start = ipsec_mb_start,
-	.dev_stop = ipsec_mb_stop,
-	.dev_close = ipsec_mb_close,
-
-	.stats_get = ipsec_mb_stats_get,
-	.stats_reset = ipsec_mb_stats_reset,
-
-	.dev_infos_get = ipsec_mb_info_get,
-
-	.queue_pair_setup = ipsec_mb_qp_setup,
-	.queue_pair_release = ipsec_mb_qp_release,
-
-	.sym_session_get_size = ipsec_mb_sym_session_get_size,
-	.sym_session_configure = ipsec_mb_sym_session_configure,
-	.sym_session_clear = ipsec_mb_sym_session_clear
-};
-
-struct rte_cryptodev_ops *rte_chacha20_poly1305_pmd_ops =
-						&chacha20_poly1305_pmd_ops;
-
-static int
-chacha20_poly1305_probe(struct rte_vdev_device *vdev)
-{
-	return ipsec_mb_create(vdev, IPSEC_MB_PMD_TYPE_CHACHA20_POLY1305);
-}
-
-static struct rte_vdev_driver cryptodev_chacha20_poly1305_pmd_drv = {
-	.probe = chacha20_poly1305_probe,
-	.remove = ipsec_mb_remove
-};
-
-static struct cryptodev_driver chacha20_poly1305_crypto_drv;
-
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_CHACHA20_POLY1305_PMD,
-					cryptodev_chacha20_poly1305_pmd_drv);
-RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_CHACHA20_POLY1305_PMD,
-					cryptodev_chacha20_poly1305_pmd);
-RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_CHACHA20_POLY1305_PMD,
-			       "max_nb_queue_pairs=<int> socket_id=<int>");
-RTE_PMD_REGISTER_CRYPTO_DRIVER(chacha20_poly1305_crypto_drv,
-				cryptodev_chacha20_poly1305_pmd_drv.driver,
-				pmd_driver_id_chacha20_poly1305);
-
-/* Constructor function to register chacha20_poly1305 PMD */
-RTE_INIT(ipsec_mb_register_chacha20_poly1305)
-{
-	struct ipsec_mb_internals *chacha_poly_data
-		= &ipsec_mb_pmds[IPSEC_MB_PMD_TYPE_CHACHA20_POLY1305];
-
-	chacha_poly_data->caps = chacha20_poly1305_capabilities;
-	chacha_poly_data->dequeue_burst = aesni_mb_dequeue_burst;
-	chacha_poly_data->feature_flags =
-		RTE_CRYPTODEV_FF_SYMMETRIC_CRYPTO |
-		RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING |
-		RTE_CRYPTODEV_FF_IN_PLACE_SGL |
-		RTE_CRYPTODEV_FF_OOP_SGL_IN_LB_OUT |
-		RTE_CRYPTODEV_FF_OOP_LB_IN_LB_OUT |
-		RTE_CRYPTODEV_FF_SYM_CPU_CRYPTO |
-		RTE_CRYPTODEV_FF_SYM_SESSIONLESS;
-	chacha_poly_data->internals_priv_size = 0;
-	chacha_poly_data->ops = &chacha20_poly1305_pmd_ops;
-	chacha_poly_data->qp_priv_size = sizeof(struct aesni_mb_qp_data);
-	chacha_poly_data->session_configure = aesni_mb_session_configure;
-	chacha_poly_data->session_priv_size = sizeof(struct aesni_mb_session);
-}
diff --git a/drivers/crypto/ipsec_mb/pmd_chacha_poly_priv.h b/drivers/crypto/ipsec_mb/pmd_chacha_poly_priv.h
deleted file mode 100644
index e668bfe07f..0000000000
--- a/drivers/crypto/ipsec_mb/pmd_chacha_poly_priv.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2021 Intel Corporation
- */
-
-#ifndef _PMD_CHACHA_POLY_PRIV_H_
-#define _PMD_CHACHA_POLY_PRIV_H_
-
-#include "ipsec_mb_private.h"
-
-#define CHACHA20_POLY1305_DIGEST_LENGTH 16
-
-static const
-struct rte_cryptodev_capabilities chacha20_poly1305_capabilities[] = {
-	{/* CHACHA20-POLY1305 */
-	    .op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
-	    {.sym = {
-			.xform_type = RTE_CRYPTO_SYM_XFORM_AEAD,
-		    {.aead = {
-				.algo = RTE_CRYPTO_AEAD_CHACHA20_POLY1305,
-				.block_size = 64,
-				.key_size = {
-					.min = 32,
-					.max = 32,
-					.increment = 0},
-				.digest_size = {
-					.min = 16,
-					.max = 16,
-					.increment = 0},
-				.aad_size = {
-					.min = 0,
-					.max = 240,
-					.increment = 1},
-				.iv_size = {
-					.min = 12,
-					.max = 12,
-					.increment = 0},
-			    },
-			}
-		},}
-	},
-	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
-};
-
-uint8_t pmd_driver_id_chacha20_poly1305;
-
-#endif /* _PMD_CHACHA_POLY_PRIV_H_ */
diff --git a/drivers/crypto/ipsec_mb/pmd_kasumi.c b/drivers/crypto/ipsec_mb/pmd_kasumi.c
deleted file mode 100644
index f83539232d..0000000000
--- a/drivers/crypto/ipsec_mb/pmd_kasumi.c
+++ /dev/null
@@ -1,76 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2016-2021 Intel Corporation
- */
-
-#include <bus_vdev_driver.h>
-#include <rte_common.h>
-#include <rte_cpuflags.h>
-#include <rte_cryptodev.h>
-#include <rte_hexdump.h>
-#include <rte_malloc.h>
-
-#include "pmd_kasumi_priv.h"
-#include "pmd_aesni_mb_priv.h"
-
-struct rte_cryptodev_ops kasumi_pmd_ops = {
-	.dev_configure = ipsec_mb_config,
-	.dev_start = ipsec_mb_start,
-	.dev_stop = ipsec_mb_stop,
-	.dev_close = ipsec_mb_close,
-
-	.stats_get = ipsec_mb_stats_get,
-	.stats_reset = ipsec_mb_stats_reset,
-
-	.dev_infos_get = ipsec_mb_info_get,
-
-	.queue_pair_setup = ipsec_mb_qp_setup,
-	.queue_pair_release = ipsec_mb_qp_release,
-
-	.sym_session_get_size = ipsec_mb_sym_session_get_size,
-	.sym_session_configure = ipsec_mb_sym_session_configure,
-	.sym_session_clear = ipsec_mb_sym_session_clear
-};
-
-struct rte_cryptodev_ops *rte_kasumi_pmd_ops = &kasumi_pmd_ops;
-
-static int
-kasumi_probe(struct rte_vdev_device *vdev)
-{
-	return ipsec_mb_create(vdev, IPSEC_MB_PMD_TYPE_KASUMI);
-}
-
-static struct rte_vdev_driver cryptodev_kasumi_pmd_drv = {
-	.probe = kasumi_probe,
-	.remove = ipsec_mb_remove
-};
-
-static struct cryptodev_driver kasumi_crypto_drv;
-
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_KASUMI_PMD, cryptodev_kasumi_pmd_drv);
-RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_KASUMI_PMD, cryptodev_kasumi_pmd);
-RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_KASUMI_PMD,
-			       "max_nb_queue_pairs=<int> socket_id=<int>");
-RTE_PMD_REGISTER_CRYPTO_DRIVER(kasumi_crypto_drv,
-				cryptodev_kasumi_pmd_drv.driver,
-				pmd_driver_id_kasumi);
-
-/* Constructor function to register kasumi PMD */
-RTE_INIT(ipsec_mb_register_kasumi)
-{
-	struct ipsec_mb_internals *kasumi_data
-	    = &ipsec_mb_pmds[IPSEC_MB_PMD_TYPE_KASUMI];
-
-	kasumi_data->caps = kasumi_capabilities;
-	kasumi_data->dequeue_burst = aesni_mb_dequeue_burst;
-	kasumi_data->feature_flags = RTE_CRYPTODEV_FF_SYMMETRIC_CRYPTO
-				| RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING
-				| RTE_CRYPTODEV_FF_NON_BYTE_ALIGNED_DATA
-				| RTE_CRYPTODEV_FF_OOP_SGL_IN_LB_OUT
-				| RTE_CRYPTODEV_FF_SYM_SESSIONLESS
-				| RTE_CRYPTODEV_FF_OOP_LB_IN_LB_OUT;
-	kasumi_data->internals_priv_size = 0;
-	kasumi_data->ops = &kasumi_pmd_ops;
-	kasumi_data->qp_priv_size = sizeof(struct aesni_mb_qp_data);
-	kasumi_data->session_configure = aesni_mb_session_configure;
-	kasumi_data->session_priv_size = sizeof(struct aesni_mb_session);
-}
diff --git a/drivers/crypto/ipsec_mb/pmd_kasumi_priv.h b/drivers/crypto/ipsec_mb/pmd_kasumi_priv.h
deleted file mode 100644
index 3223cf1a14..0000000000
--- a/drivers/crypto/ipsec_mb/pmd_kasumi_priv.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2016-2021 Intel Corporation
- */
-
-#ifndef _PMD_KASUMI_PRIV_H_
-#define _PMD_KASUMI_PRIV_H_
-
-#include "ipsec_mb_private.h"
-
-#define KASUMI_KEY_LENGTH 16
-#define KASUMI_IV_LENGTH 8
-#define KASUMI_DIGEST_LENGTH 4
-
-uint8_t pmd_driver_id_kasumi;
-
-static const struct rte_cryptodev_capabilities kasumi_capabilities[] = {
-	{	/* KASUMI (F9) */
-		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
-		{.sym = {
-			.xform_type = RTE_CRYPTO_SYM_XFORM_AUTH,
-			{.auth = {
-				.algo = RTE_CRYPTO_AUTH_KASUMI_F9,
-				.block_size = 8,
-				.key_size = {
-					.min = KASUMI_KEY_LENGTH,
-					.max = KASUMI_KEY_LENGTH,
-					.increment = 0
-				},
-				.digest_size = {
-					.min = KASUMI_DIGEST_LENGTH,
-					.max = KASUMI_DIGEST_LENGTH,
-					.increment = 0
-				},
-				.iv_size = { 0 }
-			}, }
-		}, }
-	},
-	{	/* KASUMI (F8) */
-		.op = RTE_CRYPTO_OP_TYPE_SYMMETRIC,
-		{.sym = {
-			.xform_type = RTE_CRYPTO_SYM_XFORM_CIPHER,
-			{.cipher = {
-				.algo = RTE_CRYPTO_CIPHER_KASUMI_F8,
-				.block_size = 8,
-				.key_size = {
-					.min = KASUMI_KEY_LENGTH,
-					.max = KASUMI_KEY_LENGTH,
-					.increment = 0
-				},
-				.iv_size = {
-					.min = KASUMI_IV_LENGTH,
-					.max = KASUMI_IV_LENGTH,
-					.increment = 0
-				}
-			}, }
-		}, }
-	},
-	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
-};
-
-#endif /* _PMD_KASUMI_PRIV_H_ */
-- 
2.52.0

