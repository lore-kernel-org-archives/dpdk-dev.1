Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81905C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 18:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F14D240615;
	Fri, 16 May 2025 20:53:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BF5E4402B1
 for <dev@dpdk.org>; Fri, 16 May 2025 20:53:43 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF24026BE;
 Fri, 16 May 2025 11:53:30 -0700 (PDT)
Received: from ampere-altra-2-4.usa.Arm.com (unknown [10.118.91.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8F1E3F673;
 Fri, 16 May 2025 11:53:42 -0700 (PDT)
From: Doug Foster <doug.foster@arm.com>
To: 
Cc: dev@dpdk.org, nd@arm.com, Doug Foster <doug.foster@arm.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: [PATCH] doc/linux_gsg: add build instructions for new Arm SoCs
Date: Fri, 16 May 2025 18:53:07 +0000
Message-Id: <20250516185307.1494231-1-doug.foster@arm.com>
X-Mailer: git-send-email 2.34.1
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

Add explanation of recent build configuration changes for Arm SoCs and
instructions for adding a build configuration for a new Arm SoC.

Signed-off-by: Doug Foster <doug.foster@arm.com>
Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
---
 doc/guides/linux_gsg/build_dpdk.rst | 116 ++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index 9c0dd9daf6..aa5b518821 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -149,6 +149,122 @@ When `-Dexamples=all` is set as a meson option, meson will check each example ap
 and add all which can be built to the list of tasks in the ninja build configuration file.
 
 
+.. _building_new_arm_soc:
+
+Building DPDK for a New ARM SoC
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The DPDK build system for ARM platforms has been updated to improve clarity, usability,
+and performance optimization.
+Previously, the ARM build process utilized a mixture of compiler flags (``-mcpu``,
+``-march``, and ``-mtune``), which could inadvertently cause the compiler to fall back
+to older instruction sets, resulting in suboptimal performance.
+Following Arm's official guidance, the recommended practice is to prioritize the
+``-mcpu`` flag whenever the compiler supports the targeted CPU.
+The ``-mcpu`` option specifies the exact CPU, enabling the compiler to optimize code
+generation, select appropriate instruction sets, and fine-tune performance
+characteristics explicitly for the given processor.
+In contrast, ``-march`` defines the general architecture, and ``-mtune`` optimizes
+performance for a specific CPU but does not allow the compiler to make assumptions
+about available instructions.
+Prioritizing ``-mcpu`` ensures the build system generates optimized binaries tailored
+precisely for the intended CPU.
+The changes also include explicit build failures if the compiler does not support the
+specified CPU setting, avoiding unintended fallbacks to lower-performing architectures.
+
+
+**Summary of Changes and Impact**
+
+* For CPUs directly supported by a compiler's ``-mcpu`` option, references to
+  ``-march`` and related features have been eliminated to simplify and improve the
+  build configuration.
+
+* Introduction of Pseudo-CPU Definitions: For CPUs lacking direct compiler support,
+  pseudo-CPU definitions explicitly specify architecture (``march``) and extensions
+  (``march_extensions``) to ensure optimal performance without unintended downgrades.
+
+* Explicit Build Failures: Builds now explicitly fail when unsupported ``-mcpu``,
+  ``march``, or extensions are specified, providing guidance to resolve the issue
+  without silent fallbacks.
+
+
+**Adding Support for a New SoC**
+
+If building DPDK for an ARM SoC that is not already supported, follow the guidelines
+below to add support for a new SoC based on compiler support.
+
+* Compiler ``-mcpu`` option supports the SoC
+
+  #. In the appropriate ``part_number_config`` dictionary (located in
+     ``config/arm/meson.build``), assign to ``mcpu`` the SoC supported by the compiler
+     ``-mcpu`` option.
+     The following example is for SoC *foo* where the compiler supports ``-mcpu=foo``.
+
+     .. code-block:: meson
+
+        '<Part_Number>': {
+            'mcpu': 'foo',
+            'flags': [
+                ['RTE_MACHINE', '"Foo"'],
+                # Additional flags as needed
+            ]
+        },
+
+* Compiler lacks specific ``-mcpu`` support or features (pseudo-CPU required)
+
+  If the compiler does not fully support your SoC, perform the following steps:
+
+  #. Assign a pseudo-CPU name:
+
+     In the appropriate ``part_number_config`` dictionary (located in
+     ``config/arm/meson.build``), assign to ``mcpu`` a unique pseudo-CPU name
+     prefixed with ``mcpu_``.
+     This name should clearly represent your SoC.
+     The following example is for SoC *foo*.
+
+     .. code-block:: meson
+
+        '<Part_Number>': {
+            'mcpu': 'mcpu_foo',
+            'flags': [
+                ['RTE_MACHINE', '"Foo"'],
+                # Additional flags as needed
+            ]
+        },
+
+  #. Define the pseudo-CPU details:
+
+     In the ``mcpu_defs`` dictionary, add your pseudo-CPU definition.
+     Clearly specify the architecture (``march``) and list any compiler-supported
+     extensions (``march_extensions``).
+     Extensions such as ``sve`` or ``crypto`` are examples.
+     It is acceptable to leave ``march_extensions`` empty if no specific extensions
+     are required.
+
+     .. code-block:: meson
+
+        'mcpu_foo': {
+            'march': 'armv8.x-a',
+            'march_extensions': ['sve', 'crypto']
+        },
+
+     Replace ``armv8.x-a`` and the listed extensions with the appropriate ISA and
+     features for your SoC.
+
+* Older compiler without specific ``-mcpu`` support
+
+  #. Upgrade your compiler to a newer version that supports the required CPU.
+
+  #. Alternatively, utilize a generic build configuration:
+
+     .. code-block:: console
+
+        meson setup -Dplatform=generic build
+
+By adhering to these guidelines, you will ensure the most optimized build for
+ARM-based DPDK targets.
+
+
 Building 32-bit DPDK on 64-bit Systems
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

