Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C35FD9E0A
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 20:43:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C86B402B2;
	Thu, 26 Feb 2026 21:43:28 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 44D804026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 21:43:27 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-896f5af3d8aso21228336d6.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 12:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772138606; x=1772743406; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OBfh4oCQ29Y4vnAA97zL2VSk103qV5tK3HlvM9CjORM=;
 b=Z/N8zTKNITqCTJjKkhHx0WF8FVSf0sdhczppRvMquLFn39/Ct7wmvzdgWeEQMmc61a
 IEJaxe+UKBLG6aQ7g93fnahkGqJ1TAozwI6Nf13zxzJYbJSfF/tQVRTlBZF26OFox6wD
 iSkAE4NxwBtL65vyJqRjLybNNcuboIh/ZHrPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772138606; x=1772743406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBfh4oCQ29Y4vnAA97zL2VSk103qV5tK3HlvM9CjORM=;
 b=WoKINFEyDRHP6rAmkugTflJ6+Qq9XRCE0j4qPXUkXH6DcAiAGxYFGuUPrJDrcByZo8
 hDNvKqrPdncPaBFuFR/voF5AHFVKIElGA3nrfYMD35tB97flnbMYl5S4dAdm4dSxLhTp
 IctXQu0VMOq8ga4hJPSi85/vskKjL5gDDgit8pMQ62P/2FaMPMtuNl+azTOmolCLkjKi
 54GSzbV+s/tr+MPaNP/nlFueHvzOY2oN+YMaA21mZJVe/ND1yD3m0JdzjRNt7bDIMomG
 V0g+BPbvzfczfC34hhasoPPVtp6PU5E1lVrmwxVNkQfMHWbpJXO2tfGCOX6GOiYyRiXn
 bt2A==
X-Gm-Message-State: AOJu0YwWCIE6IPuSgxzJm3sBeKi7DQ9uKXkXDxTUqgmrKBLEs2ixw//K
 hrasllu0igvTMMJR7i2aSL1JGMst62j8i1x36TYn1WzTu/+1zvtPrfiOXIzzkb+1Lds33hP4NcP
 +TP5lGJgGI6r1J1b82KrjHYOe17n9adq3UprlNLdo6hDBc89gpMjdn2iwhL/FCYlE5UnvkPnXrX
 109b99o+Z4elpSlkQAqPEy7o6t46k=
X-Gm-Gg: ATEYQzx6cxVqL5XeG2cVpkkHd8BDzESBKARwhNbVbzLUvd9mmFoztTHsYgaUuwqSeRD
 mIF6zRA+JkCBp2+wA+1mCQ7gbqmifWNnp+qjbhmKFEsKSptidgknaD/eMp2SQdr/laGXSYrFqYF
 mzp85FsRgmGWOvX8QMcG7HksOryoUGWjcy5gcDNfT0fdbIaLlhHES5KzrmNA/0r2bD1WQTnBleM
 umvbZzKUn99w0UScoJ8+vaQ7xt8BHkE6POpx3radr3Mhxmla5affPsHmB+jXb6rQFTHfmaA+pLU
 5ODippZ0f2iNUIjsbsnG8fafa2ikGM8RHLRDt4PzzhyrjXckWSEnvCijTGfT2RPKzyBKn3ciVE0
 NF9Y6Ja7nixfCuxZJsi/bVyirGpB0Ace0bmS7+Pq/PMc7phDK5H8Li0rceHHY38+SPmpx9NuGZT
 kQFzHozsB2/rSr7HTstDm2qgAhJGpDzod/P5cOcca7n2+yt1i78RWwYxHe6WgmZvg2
X-Received: by 2002:a05:6214:f25:b0:894:7c8b:1216 with SMTP id
 6a1803df08f44-899d1e1ab6dmr7709706d6.35.1772138606054; 
 Thu, 26 Feb 2026 12:43:26 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c7377b0csm26824756d6.31.2026.02.26.12.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 12:43:25 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org, probb@iol.unh.edu, luca.vizzarro@arm.com, dmarx@iol.unh.edu
Cc: Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: update yaml configs
Date: Thu, 26 Feb 2026 15:43:22 -0500
Message-ID: <20260226204322.87944-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

Previously, optional arguments and the descriptions of them had no clear
format. This patch adds an optional fields section to all yaml
configuration files to improve readability. Additionally, the vdev
argument in the test run config had minimal usage in DTS. This patch
comments the argument out by default.

Bugzilla ID: 1896
Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/configurations/nodes.example.yaml        |  7 ++-
 dts/configurations/test_run.example.yaml     | 47 +++++++++++++-------
 dts/configurations/tests_config.example.yaml |  3 ++
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/dts/configurations/nodes.example.yaml b/dts/configurations/nodes.example.yaml
index 3f23df11ec..4da5585318 100644
--- a/dts/configurations/nodes.example.yaml
+++ b/dts/configurations/nodes.example.yaml
@@ -2,6 +2,9 @@
 # Copyright 2022-2023 The DPDK contributors
 # Copyright 2023 Arm Limited
 
+# Optional Fields:
+#   `hugepages_2mb`: if removed, will use system hugepage configuration
+
 # Define a system under test node, having two network ports physically
 # connected to the corresponding ports in TG 1 (the peer node)
 - name: "SUT 1"
@@ -17,7 +20,7 @@
       pci: "0000:00:08.1"
       os_driver_for_dpdk: vfio-pci
       os_driver: i40e
-  hugepages_2mb: # optional; if removed, will use system hugepage configuration
+  hugepages_2mb: # see 'Optional Fields'
       number_of: 256
       force_first_numa: false
 # Define a Scapy traffic generator node, having two network ports
@@ -35,6 +38,6 @@
       pci: "0000:00:08.1"
       os_driver_for_dpdk: rdma
       os_driver: rdma
-  hugepages_2mb: # optional; if removed, will use system hugepage configuration
+  hugepages_2mb: # see 'Optional Fields'
       number_of: 256
       force_first_numa: false
diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/test_run.example.yaml
index c8035fccf0..1d12ba117f 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -2,27 +2,43 @@
 # Copyright 2022-2023 The DPDK contributors
 # Copyright 2023 Arm Limited
 
+# Optional Fields:
+#   `dpdk_tree` & `tarball`:
+#       Either `dpdk_tree` or `tarball` can be defined, but not both.
+#   `remote`:
+#       Defaults to false. If it's true, the `dpdk_tree` or `tarball`
+#       is located on the SUT node, instead of the execution host.
+#   `precompiled_build_dir` & `build_options`:
+#       If `precompiled_build_dir` is defined, DPDK has been pre-built
+#       and the build directory is in a subdirectory of DPDK tree root directory.
+#       Otherwise, will be using the `build_options` to build the DPDK from source. Either
+#       `precompiled_build_dir` or `build_options` can be defined, but not both.
+#   `compiler_wrapper`:
+#       Optional, adds a compiler wrapper if present.
+#   `func_traffic_generator` & `perf_traffic_generator`:
+#       Define `func_traffic_generator` when `func` set to true.
+#       Define `perf_traffic_generator` when `perf` set to true.
+#   `skip_smoke_tests`:
+#       Defaults to true. If it's false, smoke tests will run.
+#   `test_suites`:
+#       By removing the `test_suites` field, this test run will run every test suite available.
+#   `vdevs`:
+#       Uncomment to use virtual devices in execution.
+
 # Define the test run environment
 dpdk:
   lcores: "" # use all available logical cores (Skips first core)
   memory_channels: 4 # tells DPDK to use 4 memory channels
   build:
     dpdk_location:
-      # dpdk_tree: Commented out because `tarball` is defined.
+      # dpdk_tree: see `Optional Fields`
       tarball: dpdk-tarball.tar.xz
-      # Either `dpdk_tree` or `tarball` can be defined, but not both.
-      remote: false # Optional, defaults to false. If it's true, the `dpdk_tree` or `tarball`
-                    # is located on the SUT node, instead of the execution host.
-
-    # precompiled_build_dir: Commented out because `build_options` is defined.
+      remote: false # see `Optional Fields`
+    # precompiled_build_dir: see `Optional Fields`
     build_options:
       # the combination of the following two makes CC="ccache gcc"
       compiler: gcc
-      compiler_wrapper: ccache # Optional.
-    # If `precompiled_build_dir` is defined, DPDK has been pre-built and the build directory is
-    # in a subdirectory of DPDK tree root directory. Otherwise, will be using the `build_options`
-    # to build the DPDK from source. Either `precompiled_build_dir` or `build_options` can be
-    # defined, but not both.
+      compiler_wrapper: ccache # see `Optional Fields`
 func_traffic_generator:
   type: SCAPY
 # perf_traffic_generator:
@@ -32,12 +48,11 @@ func_traffic_generator:
 perf: false # disable performance testing
 func: true # enable functional testing
 use_virtual_functions: false # use virtual functions (VFs) instead of physical functions
-skip_smoke_tests: true # optional
-# by removing the `test_suites` field, this test run will run every test suite available
-test_suites: # the following test suites will be run in their entirety
+skip_smoke_tests: true # see `Optional Fields`
+test_suites: # see `Optional Fields`; the following test suites will be run in their entirety
   - hello_world
-vdevs: # optional; if removed, vdevs won't be used in the execution
-  - "crypto_openssl"
+# vdevs: # see `Optional Fields`
+#   - "crypto_openssl"
 # The machine running the DPDK test executable
 system_under_test_node: "SUT 1"
 # Traffic generator node to use for this execution environment
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index 64fa630aa0..451fc8827d 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: BSD-3-Clause
 
+# Optional Fields:
+#   All fields are optional, uncomment a test suite to run it with a specific configuration.
+
 # Define the custom test suite configurations
 hello_world:
   msg: A custom hello world to you!
-- 
2.50.1

