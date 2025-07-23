Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3559EC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 18:53:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0026F402D4;
	Wed, 23 Jul 2025 20:53:58 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6AFB040267
 for <dev@dpdk.org>; Wed, 23 Jul 2025 20:53:57 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B551BCA;
 Wed, 23 Jul 2025 11:53:50 -0700 (PDT)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 847963F66E;
 Wed, 23 Jul 2025 11:53:56 -0700 (PDT)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com, nd@arm.com,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: [PATCH] config/arm: add Microsoft Azure Cobalt-100 SoC
Date: Wed, 23 Jul 2025 18:53:49 +0000
Message-ID: <20250723185349.4116573-1-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
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

Add Microsoft Azure Cobalt-100 to arm build.

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
---
 config/arm/meson.build | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 35b7553e74..1cd5bc1a5a 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -288,6 +288,22 @@ implementer_ionic = {
     }
 }
 
+implementer_microsoft = {
+    'description': 'Microsoft Corporation',
+    'flags': [],
+    'part_number_config': {
+        '0xd49': {
+            'mcpu': 'mcpu_cobalt100',
+            'flags': [
+                ['RTE_MACHINE', '"neoverse-n2"'],
+                ['RTE_ARM_FEATURE_ATOMICS', true],
+                ['RTE_MAX_LCORE', 128],
+                ['RTE_MAX_NUMA_NODES', 2]
+            ]
+        },
+    }
+}
+
 implementer_phytium = {
     'description': 'Phytium',
     'flags': [
@@ -344,6 +360,7 @@ implementers = {
     '0x48': implementer_hisilicon,
     '0x50': implementer_ampere,
     '0x51': implementer_qualcomm,
+    '0x6d': implementer_microsoft,
     '0x70': implementer_phytium,
     '0x75': implementer_ionic,
     '0xc0': implementer_ampere,
@@ -464,6 +481,13 @@ soc_cn10k = {
     'sve_acle': false
 }
 
+soc_cobalt100 = {
+    'description' : 'Microsot Azure Cobalt 100',
+    'implementer' : '0x6d',
+    'part_number': '0xd49',
+    'numa': true
+}
+
 soc_dpaa = {
     'description': 'NXP DPAA',
     'implementer': '0x41',
@@ -653,6 +677,10 @@ mcpu_defs = {
         'march': 'armv8-a',
         'march_extensions': ['crc']
     },
+    'mcpu_cobalt100': {
+        'march': 'armv9-a',
+        'march_extensions': ['crypto', 'sve', 'sve2']
+    },
     'mcpu_ft2000plus': {
         'march': 'armv8-a',
         'march_extensions': ['crc']
@@ -706,6 +734,7 @@ cdx:             AMD CDX
 centriq2400:     Qualcomm Centriq 2400
 cn9k:            Marvell OCTEON 9
 cn10k:           Marvell OCTEON 10
+cobalt100:       Microsoft Azure Cobalt 100
 dpaa:            NXP DPAA
 elba:            AMD Pensando Elba
 emag:            Ampere eMAG
@@ -747,6 +776,7 @@ socs = {
     'centriq2400': soc_centriq2400,
     'cn9k': soc_cn9k,
     'cn10k' : soc_cn10k,
+    'cobalt100' : soc_cobalt100,
     'dpaa': soc_dpaa,
     'elba': soc_elba,
     'emag': soc_emag,
-- 
2.43.0

