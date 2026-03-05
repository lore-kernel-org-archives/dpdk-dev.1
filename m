Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E63F47CBD
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 19:33:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69DAB402CC;
	Thu,  5 Mar 2026 20:33:40 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 5917F4029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 20:33:39 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8c70b5594f4so866514885a.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 11:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772739218; x=1773344018; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E68gHKFXXgMPiupO+XRYMqgd1udWZygz8ECaYBJFz3k=;
 b=bXgF++aN7X/FMfTRWoCeZ/5qfmr3DiRSlc+zcA3pqjPT5z+kQ5yY2t/C6LVsDLxYSx
 BLHF23er4y4ZrJsHsoR2PQWwfKPzIEOzh0sXbDIgaXgZDtDTg2DCliry9mZ+JBrZM0P+
 s0Vb1lUZzTgio9GKDm1XoflTYVMX5HqQwr/u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772739218; x=1773344018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E68gHKFXXgMPiupO+XRYMqgd1udWZygz8ECaYBJFz3k=;
 b=mBhRGvgWu6oZ3gx/05rIAsYJENlZAlaEy+HQduvYoUZuby6owwBBCYBdQkAohg2OIK
 Hb7Toxn0ehuxr00TozNDa9jVOsxaZUVflH3hbid9PVC9vIXaVFoSYNIuYyB2bfWWmsPS
 SrwCS43hfmqrOPruxlnvBstDDmMRlr+SlygYabw9vpfH5phoQVJOuQgS0C245nyaW1hJ
 aJjTmrtPTTu7/U1w0s4SZD6l57E1UdjAUF80Ewpx0uRSzifFQgnTNNCraoH3lRLHXyIQ
 ehyc5ASJXUxVpotUQ8jV73C5TfQlBtP1epXawbZwkztIzkiMBnUrmHya55ezCzpskFYz
 IubQ==
X-Gm-Message-State: AOJu0YxmE99Ub5y63ByWCTzmvQUIL4SP1mX1s8o9jHolamDRE4MC/2sC
 9ZjKuXA+t39zOnJ3tTTKRg9cVMr1ahC441IWZ1aFhN3tj/kV8j+8a8ow1veKyuYFabQ=
X-Gm-Gg: ATEYQzw8ASNQ5wSsHPzr9BbuN2Qu2WyahLsupPRTKOVRzW11LdL3/NBL+/oI/KI9J2r
 Wb6JtXzw5JrBZ2oHnMo6YW4nY8xEGYA9pqlhQSrrd/zlzcBqHGxRyVa0RSpPVyZPYrdNZzgDZOH
 oKtLES5M02m7u8ZpDGE5aeYgoeGIXMF9kUAgwU5/jBTtBljSD0ty8aW2uGsphTDBAk88HR67m6F
 FDlWnzM2rOBeZMyffGWnBumF+DaU4nvHeit48Ad3T3MMFNJd2P0egAM1FMtmAqY5zNdI3lmipLX
 I8QddAOOIUSQbqJS5pWVozh6O7Ic50fO41HATXrqjaTtEEA1t1iqq+3dKkdEk7FDephX/5NRfWD
 bU1plAWczKSxHx3o/Vw7XFdmUMWhm5Kd45uJ4c+2y144ybFFTJ2amdN7ErUJwEW593Xxg5eWNA5
 +4g8jE1n/ofcUyaSC01XzrGNCzMfgv5ghA2pSRMRb3FCW/oHO7Y6vnX2p+wYBiSRwx
X-Received: by 2002:a05:620a:25cc:b0:891:7008:f2e0 with SMTP id
 af79cd13be357-8cd63409339mr417485385a.8.1772739218478; 
 Thu, 05 Mar 2026 11:33:38 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a20471119sm44384926d6.40.2026.03.05.11.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 11:33:37 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: update yaml configs
Date: Thu,  5 Mar 2026 14:33:35 -0500
Message-ID: <20260305193335.150598-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226204322.87944-1-abailey@iol.unh.edu>
References: <20260226204322.87944-1-abailey@iol.unh.edu>
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
 dts/configurations/test_run.example.yaml     | 48 +++++++++++++-------
 dts/configurations/tests_config.example.yaml |  7 +++
 3 files changed, 44 insertions(+), 18 deletions(-)

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
index c8035fccf0..707a3104ed 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -2,27 +2,44 @@
 # Copyright 2022-2023 The DPDK contributors
 # Copyright 2023 Arm Limited
 
+# Optional Fields:
+#   `dpdk_tree` & `tarball`:
+#       Either `dpdk_tree` or `tarball` can be defined, but not both. dpdk_tree is
+#       for an uncompressed DPDK directory while tarball is a compressed DPDK.
+#   `remote`:
+#       Optional, Defaults to false. If it's true, the `dpdk_tree` or `tarball`
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
+#       Uncomment to add a specific virtual device to run on the SUT node.
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
@@ -32,12 +49,11 @@ func_traffic_generator:
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
index 64fa630aa0..39e96660a5 100644
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
@@ -15,3 +18,7 @@ hello_world:
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
 #   delta_tolerance: 0.05
+# pmd_rss:
+#   NUM_QUEUES: 4
+#   ACTUAL_KEY_SIZE: 52
+#   ACTUAL_RETA_SIZE: 512
-- 
2.50.1

