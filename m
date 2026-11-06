Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EB606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N2eioGfe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D7EF42E00;
	Fri,  6 Nov 2026 17:14:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id E691F402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 17:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793981687; x=1825517687;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s6a7+W6LWKsdNm1R9UjOt2Cbp+fuRq18PZkPqZg7VkA=;
 b=N2eioGfejCRYQvoPcTQLx5JjmkDyZf4LocBli4//I30I9Co1G7jZtMH2
 HzIS4YLiNmGPXa1bhNY2bZ8p+qljzdRTFQHtrGnmCrz0uLZXOIs1gnKb/
 RG6D5cdNIuBpdJCbwv0kIZ5LifWqym8pWvdP0jLM3vZUc+rOSvk1KE2d5
 t5iEBP2F/UCX6A6u6gdB8EpupJSYMtAQj9KPWq2XZ+q6X38L22sbZaJrQ
 44oJ1ZD609Y2+Gsi9AnbOB7ZackA8OOxhqBAPaJZh0VFk2T1G229cBHc5
 pXHFoJnHH03XNnLvBPi4cnY2DvZJ9c0e2QQiuladv9llqbok1d/1nCvWv w==;
X-CSE-ConnectionGUID: rr/jur8FRZ2Kc9d/Fl24zg==
X-CSE-MsgGUID: qoHcVRnrSRyQOIjnhwQblQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2674525"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2674525"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 08:14:46 -0800
X-CSE-ConnectionGUID: /f0r3mXbQxir5R+8PECKqw==
X-CSE-MsgGUID: pPQTEUEcSEWEGY78Jz8BsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7663881"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by fmviesa006.fm.intel.com with ESMTP; 06 Nov 2026 08:14:45 -0800
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, Thomas Monjalon <thomas@monjalon.net>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [dpdk-dev v11 1/2] app: move FIPS validation under app/
Date: Fri,  6 Nov 2026 16:14:40 +0000
Message-Id: <20261106161441.3818963-2-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106161441.3818963-1-kai.ji@intel.com>
References: <20261105163151.3744179-1-kai.ji@intel.com>
 <20261106161441.3818963-1-kai.ji@intel.com>
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

Rename the sample guide to crypto_validation.rst and make FIPS
validation its first section. Update the app registration and guide
references to match the new location.

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 MAINTAINERS                                   |  6 +-
 .../fips_validation/fips_dev_self_test.c      |  0
 .../fips_validation/fips_dev_self_test.h      |  0
 .../fips_validation/fips_validation.c         |  0
 .../fips_validation/fips_validation.h         |  0
 .../fips_validation/fips_validation_aes.c     |  0
 .../fips_validation/fips_validation_ccm.c     |  0
 .../fips_validation/fips_validation_cmac.c    |  0
 .../fips_validation/fips_validation_ecdsa.c   |  0
 .../fips_validation/fips_validation_eddsa.c   |  0
 .../fips_validation/fips_validation_gcm.c     |  0
 .../fips_validation/fips_validation_hmac.c    |  0
 .../fips_validation/fips_validation_rsa.c     |  0
 .../fips_validation/fips_validation_sha.c     |  0
 .../fips_validation/fips_validation_tdes.c    |  0
 .../fips_validation/fips_validation_xts.c     |  0
 {examples => app}/fips_validation/main.c      |  0
 {examples => app}/fips_validation/meson.build | 12 ++--
 app/meson.build                               |  1 +
 doc/guides/rel_notes/release_22_11.rst        |  2 +-
 ...s_validation.rst => crypto_validation.rst} | 34 ++++++----
 doc/guides/sample_app_ug/index.rst            |  2 +-
 examples/fips_validation/Makefile             | 62 -------------------
 examples/meson.build                          |  1 -
 24 files changed, 34 insertions(+), 86 deletions(-)
 rename {examples => app}/fips_validation/fips_dev_self_test.c (100%)
 rename {examples => app}/fips_validation/fips_dev_self_test.h (100%)
 rename {examples => app}/fips_validation/fips_validation.c (100%)
 rename {examples => app}/fips_validation/fips_validation.h (100%)
 rename {examples => app}/fips_validation/fips_validation_aes.c (100%)
 rename {examples => app}/fips_validation/fips_validation_ccm.c (100%)
 rename {examples => app}/fips_validation/fips_validation_cmac.c (100%)
 rename {examples => app}/fips_validation/fips_validation_ecdsa.c (100%)
 rename {examples => app}/fips_validation/fips_validation_eddsa.c (100%)
 rename {examples => app}/fips_validation/fips_validation_gcm.c (100%)
 rename {examples => app}/fips_validation/fips_validation_hmac.c (100%)
 rename {examples => app}/fips_validation/fips_validation_rsa.c (100%)
 rename {examples => app}/fips_validation/fips_validation_sha.c (100%)
 rename {examples => app}/fips_validation/fips_validation_tdes.c (100%)
 rename {examples => app}/fips_validation/fips_validation_xts.c (100%)
 rename {examples => app}/fips_validation/main.c (100%)
 rename {examples => app}/fips_validation/meson.build (79%)
 rename doc/guides/sample_app_ug/{fips_validation.rst => crypto_validation.rst} (90%)
 delete mode 100644 examples/fips_validation/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d865ffd46..736f39c70e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2040,10 +2040,10 @@ Ethtool example
 F: examples/ethtool/
 F: doc/guides/sample_app_ug/ethtool.rst
 
-FIPS validation example
+FIPS validation application
 M: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
-F: examples/fips_validation/
-F: doc/guides/sample_app_ug/fips_validation.rst
+F: app/fips_validation/
+F: doc/guides/sample_app_ug/crypto_validation.rst
 
 Flow filtering example
 M: Ori Kam <orika@nvidia.com>
diff --git a/examples/fips_validation/fips_dev_self_test.c b/app/fips_validation/fips_dev_self_test.c
similarity index 100%
rename from examples/fips_validation/fips_dev_self_test.c
rename to app/fips_validation/fips_dev_self_test.c
diff --git a/examples/fips_validation/fips_dev_self_test.h b/app/fips_validation/fips_dev_self_test.h
similarity index 100%
rename from examples/fips_validation/fips_dev_self_test.h
rename to app/fips_validation/fips_dev_self_test.h
diff --git a/examples/fips_validation/fips_validation.c b/app/fips_validation/fips_validation.c
similarity index 100%
rename from examples/fips_validation/fips_validation.c
rename to app/fips_validation/fips_validation.c
diff --git a/examples/fips_validation/fips_validation.h b/app/fips_validation/fips_validation.h
similarity index 100%
rename from examples/fips_validation/fips_validation.h
rename to app/fips_validation/fips_validation.h
diff --git a/examples/fips_validation/fips_validation_aes.c b/app/fips_validation/fips_validation_aes.c
similarity index 100%
rename from examples/fips_validation/fips_validation_aes.c
rename to app/fips_validation/fips_validation_aes.c
diff --git a/examples/fips_validation/fips_validation_ccm.c b/app/fips_validation/fips_validation_ccm.c
similarity index 100%
rename from examples/fips_validation/fips_validation_ccm.c
rename to app/fips_validation/fips_validation_ccm.c
diff --git a/examples/fips_validation/fips_validation_cmac.c b/app/fips_validation/fips_validation_cmac.c
similarity index 100%
rename from examples/fips_validation/fips_validation_cmac.c
rename to app/fips_validation/fips_validation_cmac.c
diff --git a/examples/fips_validation/fips_validation_ecdsa.c b/app/fips_validation/fips_validation_ecdsa.c
similarity index 100%
rename from examples/fips_validation/fips_validation_ecdsa.c
rename to app/fips_validation/fips_validation_ecdsa.c
diff --git a/examples/fips_validation/fips_validation_eddsa.c b/app/fips_validation/fips_validation_eddsa.c
similarity index 100%
rename from examples/fips_validation/fips_validation_eddsa.c
rename to app/fips_validation/fips_validation_eddsa.c
diff --git a/examples/fips_validation/fips_validation_gcm.c b/app/fips_validation/fips_validation_gcm.c
similarity index 100%
rename from examples/fips_validation/fips_validation_gcm.c
rename to app/fips_validation/fips_validation_gcm.c
diff --git a/examples/fips_validation/fips_validation_hmac.c b/app/fips_validation/fips_validation_hmac.c
similarity index 100%
rename from examples/fips_validation/fips_validation_hmac.c
rename to app/fips_validation/fips_validation_hmac.c
diff --git a/examples/fips_validation/fips_validation_rsa.c b/app/fips_validation/fips_validation_rsa.c
similarity index 100%
rename from examples/fips_validation/fips_validation_rsa.c
rename to app/fips_validation/fips_validation_rsa.c
diff --git a/examples/fips_validation/fips_validation_sha.c b/app/fips_validation/fips_validation_sha.c
similarity index 100%
rename from examples/fips_validation/fips_validation_sha.c
rename to app/fips_validation/fips_validation_sha.c
diff --git a/examples/fips_validation/fips_validation_tdes.c b/app/fips_validation/fips_validation_tdes.c
similarity index 100%
rename from examples/fips_validation/fips_validation_tdes.c
rename to app/fips_validation/fips_validation_tdes.c
diff --git a/examples/fips_validation/fips_validation_xts.c b/app/fips_validation/fips_validation_xts.c
similarity index 100%
rename from examples/fips_validation/fips_validation_xts.c
rename to app/fips_validation/fips_validation_xts.c
diff --git a/examples/fips_validation/main.c b/app/fips_validation/main.c
similarity index 100%
rename from examples/fips_validation/main.c
rename to app/fips_validation/main.c
diff --git a/examples/fips_validation/meson.build b/app/fips_validation/meson.build
similarity index 79%
rename from examples/fips_validation/meson.build
rename to app/fips_validation/meson.build
index 6c29b535cb..d7055eca64 100644
--- a/examples/fips_validation/meson.build
+++ b/app/fips_validation/meson.build
@@ -1,13 +1,15 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Intel Corporation
 
-# meson file, for building this example as part of a main DPDK build.
-#
-# To build this example as a standalone application with an already-installed
-# DPDK instance, use 'make'
+# meson file, for building this application as part of a main DPDK build.
+
+if is_windows
+    build = false
+    reason = 'not supported on Windows'
+    subdir_done()
+endif
 
 deps += ['cryptodev']
-allow_experimental_apis = true
 sources = files(
         'fips_validation_aes.c',
         'fips_validation.c',
diff --git a/app/meson.build b/app/meson.build
index 24fadc1963..927f79d0b3 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -14,6 +14,7 @@ endif
 
 apps = [
         'dumpcap',
+        'fips_validation',
         'graph',
         'pdump',
         'proc-info',
diff --git a/doc/guides/rel_notes/release_22_11.rst b/doc/guides/rel_notes/release_22_11.rst
index a8d48344c3..f5d47de741 100644
--- a/doc/guides/rel_notes/release_22_11.rst
+++ b/doc/guides/rel_notes/release_22_11.rst
@@ -273,7 +273,7 @@ New Features
 * **Updated FIPS validation sample application.**
 
   Added support for asymmetric crypto algorithms.
-  See the :doc:`/sample_app_ug/fips_validation` for more details.
+  See the :doc:`/sample_app_ug/crypto_validation` for more details.
 
 * **Rewrote pmdinfo script.**
 
diff --git a/doc/guides/sample_app_ug/fips_validation.rst b/doc/guides/sample_app_ug/crypto_validation.rst
similarity index 90%
rename from doc/guides/sample_app_ug/fips_validation.rst
rename to doc/guides/sample_app_ug/crypto_validation.rst
index 613c5afd19..67b9e2d351 100644
--- a/doc/guides/sample_app_ug/fips_validation.rst
+++ b/doc/guides/sample_app_ug/crypto_validation.rst
@@ -1,11 +1,14 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2018 Intel Corporation.
 
-Federal Information Processing Standards (FIPS) CryptoDev Validation
-====================================================================
+Cryptographic Validation Applications
+=====================================
+
+FIPS Validation
+---------------
 
 Overview
---------
+~~~~~~~~
 
 Federal Information Processing Standards (FIPS) are publicly announced standards
 developed by the United States federal government for use in computer systems by
@@ -22,10 +25,10 @@ and FIPS 140-3 (in case of ACVP) and must successfully complete the
 cryptographic algorithm validation process.
 
 Limitations
------------
+~~~~~~~~~~~
 
 CAVP
-----
+^^^^
 
 * The version of request file supported is ``CAVS 21.0``.
 * If the header comment in a ``.req`` file does not contain a Algo tag
@@ -52,7 +55,7 @@ CAVP
       VarText
 
 ACVP
-----
+^^^^
 
 * The application does not supply the test vectors. The user is expected to
   obtain the test vector files from `ACVP  <https://pages.nist.gov/ACVP>`_
@@ -76,7 +79,7 @@ ACVP
 
 
 Application Information
------------------------
+~~~~~~~~~~~~~~~~~~~~~~~
 
 If a ``.req`` is used as the input file after the application is finished
 running it will generate a response file or ``.rsp``. Differences between the
@@ -93,11 +96,16 @@ validating if the application has done the operation correctly.
 
 
 Compiling the Application
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 * Compile Application
 
-    To compile the sample application see :doc:`compiling`.
+    From the DPDK source tree, build the application with Meson:
+
+    .. code-block:: console
+
+       meson setup build -Denable_apps=fips_validation
+       meson compile -C build
 
 *  Run ``dos2unix`` on the request files
 
@@ -112,13 +120,13 @@ Compiling the Application
          dos2unix SHA/req/*
 
 Running the Application
------------------------
+~~~~~~~~~~~~~~~~~~~~~~~
 
 The application requires a number of command line options:
 
     .. code-block:: console
 
-         ./dpdk-fips_validation [EAL options]
+         ./build/app/dpdk-fips_validation [EAL options]
          -- --req-file FILE_PATH/FOLDER_PATH
          --rsp-file FILE_PATH/FOLDER_PATH
          [--cryptodev DEVICE_NAME] [--cryptodev-id ID] [--path-is-folder]
@@ -149,7 +157,7 @@ file for crypto_aesni_mb PMD, issue the command:
 
 .. code-block:: console
 
-    $ ./dpdk-fips_validation --vdev crypto_aesni_mb --
+    $ ./build/app/dpdk-fips_validation --vdev crypto_aesni_mb --
     --req-file /PATH/TO/REQUEST/FILE.req --rsp-file ./PATH/TO/RESPONSE/FILE.rsp
     --cryptodev crypto_aesni_mb
 
@@ -158,7 +166,7 @@ data files in one folder for crypto_aesni_gcm PMD, issue the command:
 
 .. code-block:: console
 
-    $ ./dpdk-fips_validation --vdev crypto_aesni_gcm0 --
+    $ ./build/app/dpdk-fips_validation --vdev crypto_aesni_gcm0 --
     --req-file /PATH/TO/REQUEST/FILE/FOLDER/
     --rsp-file ./PATH/TO/RESPONSE/FILE/FOLDER/
     --cryptodev-id 0 --path-is-folder
diff --git a/doc/guides/sample_app_ug/index.rst b/doc/guides/sample_app_ug/index.rst
index 28c4c9a5b2..a71d14f83f 100644
--- a/doc/guides/sample_app_ug/index.rst
+++ b/doc/guides/sample_app_ug/index.rst
@@ -50,7 +50,7 @@ Sample Applications User Guides
     vm_power_management
     ptpclient
     ptp_tap_relay_sw
-    fips_validation
+    crypto_validation
     ipsec_secgw
     bbdev_app
     ntb
diff --git a/examples/fips_validation/Makefile b/examples/fips_validation/Makefile
deleted file mode 100644
index 4864966e77..0000000000
--- a/examples/fips_validation/Makefile
+++ /dev/null
@@ -1,62 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2018 Intel Corporation
-
-# binary name
-APP = fips_validation
-
-# all source are stored in SRCS-y
-SRCS-y := fips_validation.c
-SRCS-y += fips_validation_aes.c
-SRCS-y += fips_validation_hmac.c
-SRCS-y += fips_validation_tdes.c
-SRCS-y += fips_validation_gcm.c
-SRCS-y += fips_validation_cmac.c
-SRCS-y += fips_validation_ccm.c
-SRCS-y += fips_validation_sha.c
-SRCS-y += fips_dev_self_test.c
-SRCS-y += fips_validation_xts.c
-SRCS-y += fips_validation_rsa.c
-SRCS-y += fips_validation_ecdsa.c
-SRCS-y += fips_validation_eddsa.c
-SRCS-y += main.c
-
-PKGCONF ?= pkg-config
-
-# Build using pkg-config variables if possible
-ifneq ($(shell $(PKGCONF) --exists libdpdk && echo 0),0)
-$(error "no installation of DPDK found")
-endif
-
-all: shared
-.PHONY: shared static
-shared: build/$(APP)-shared
-	ln -sf $(APP)-shared build/$(APP)
-static: build/$(APP)-static
-	ln -sf $(APP)-static build/$(APP)
-
-PC_FILE := $(shell $(PKGCONF) --path libdpdk 2>/dev/null)
-CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
-LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
-LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
-
-JANSSON := $(shell $(PKGCONF) --exists jansson; echo $$?)
-ifeq ($(JANSSON), 0)
-LDFLAGS += $(shell $(PKGCONF) --libs jansson)
-CFLAGS += -DUSE_JANSSON
-endif
-
-CFLAGS += -DALLOW_EXPERIMENTAL_API
-
-build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
-	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_SHARED)
-
-build/$(APP)-static: $(SRCS-y) Makefile $(PC_FILE) | build
-	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_STATIC)
-
-build:
-	@mkdir -p $@
-
-.PHONY: clean
-clean:
-	rm -f build/$(APP) build/$(APP)-static build/$(APP)-shared
-	test -d build && rmdir -p build || true
diff --git a/examples/meson.build b/examples/meson.build
index 544ec5eadd..4b739c9b82 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -15,7 +15,6 @@ all_examples = [
         'dma',
         'ethtool',
         'eventdev_pipeline',
-        'fips_validation',
         'flow_filtering',
         'helloworld',
         'ip_fragmentation',
-- 
2.34.1

