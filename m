Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB64C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 16:17:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6862F402ED;
	Fri, 16 May 2025 18:17:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DBFB5402CD
 for <dev@dpdk.org>; Fri, 16 May 2025 18:17:01 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D688169C;
 Fri, 16 May 2025 09:16:49 -0700 (PDT)
Received: from ampere-altra-2-4.usa.Arm.com (unknown [10.118.91.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 250C53F5A1;
 Fri, 16 May 2025 09:17:01 -0700 (PDT)
From: Doug Foster <doug.foster@arm.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, nd@arm.com, Doug Foster <doug.foster@arm.com>,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: [PATCH] config/arm: update neoverse n3 SoC and add neoverse V3
Date: Fri, 16 May 2025 16:15:58 +0000
Message-Id: <20250516161558.1482246-1-doug.foster@arm.com>
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

Arm Neoverse N3 build configuration is updated to include mcpu that
aligns with latest GCC. Also, add Arm Neoverse V3 build configuration.

Signed-off-by: Doug Foster <doug.foster@arm.com>
Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
---
 config/arm/meson.build | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index f971ed3c1b..2f510c3a6c 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -110,17 +110,7 @@ part_number_config_arm = {
         ]
     },
     '0xd8e': {
-        # Only when -march=armv9-a+wfxt is used will the WFET
-        # feature be compiled with armv9 instructions.
-        # However, +wfxt is not supported by GCC at the moment.
-        # Although armv9-a is the fitting version of Arm ISA for
-        # Neoverse N3, it cannot be used when enabling wfxt for
-        # the above reasons.
-        # The workaround for this is to use armv8.7-a, which
-        # doesn't require +wfxt for binutils version 2.36 or greater.
-        'march': 'armv8.7-a',
-        'march_features': ['sve2'],
-        'fallback_march': 'armv8.5-a',
+        'mcpu' : 'neoverse-n3',
         'flags': [
             ['RTE_MACHINE', '"neoverse-n3"'],
             ['RTE_ARM_FEATURE_ATOMICS', true],
@@ -128,6 +118,16 @@ part_number_config_arm = {
             ['RTE_MAX_LCORE', 192],
             ['RTE_MAX_NUMA_NODES', 2]
         ]
+    },
+    '0xd84': {
+        'mcpu' : 'neoverse-v3',
+        'flags': [
+            ['RTE_MACHINE', '"neoverse-v3"'],
+            ['RTE_ARM_FEATURE_ATOMICS', true],
+            ['RTE_ARM_FEATURE_WFXT', true],
+            ['RTE_MAX_LCORE', 128],
+            ['RTE_MAX_NUMA_NODES', 2]
+        ]
     }
 }
 implementer_arm = {
@@ -641,6 +641,13 @@ soc_v2 = {
     'numa': true
 }
 
+soc_v3 = {
+    'description': 'Arm Neoverse V3',
+    'implementer': '0x41',
+    'part_number': '0xd84',
+    'numa': true
+}
+
 mcpu_defs = {
     'mcpu_centriq2400': {
         'march': 'armv8-a',
@@ -712,6 +719,7 @@ kunpeng920:      HiSilicon Kunpeng 920
 kunpeng930:      HiSilicon Kunpeng 930
 n1sdp:           Arm Neoverse N1SDP
 n2:              Arm Neoverse N2
+n3:              Arm Neoverse N3
 odyssey:         Marvell Odyssey
 stingray:        Broadcom Stingray
 thunderx2:       Marvell ThunderX2 T99
@@ -720,6 +728,7 @@ thunderxt88:     Marvell ThunderX T88
 tys2500:         Phytium TengYun S2500
 tys5000c:        Phytium TengYun S5000c
 v2:              Arm Neoverse V2
+v3:              Arm Neoverse V3
 End of SoCs list
 '''
 # The string above is included in the documentation, keep it in sync with the
@@ -760,6 +769,7 @@ socs = {
     'tys2500': soc_tys2500,
     'tys5000c': soc_tys5000c,
     'v2': soc_v2,
+    'v3': soc_v3
 }
 
 dpdk_conf.set('RTE_ARCH_ARM', 1)
-- 
2.34.1

