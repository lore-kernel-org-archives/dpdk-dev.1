Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53C0CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 19:07:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F38B840280;
	Tue, 11 Nov 2025 20:07:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DB91A4026D
 for <dev@dpdk.org>; Tue, 11 Nov 2025 20:07:33 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6C3497;
 Tue, 11 Nov 2025 11:07:25 -0800 (PST)
Received: from ampere-altra-2-2.usa.arm.com (unknown [10.118.91.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1ADA33F63F;
 Tue, 11 Nov 2025 11:07:33 -0800 (PST)
From: Doug Foster <doug.foster@arm.com>
To: dev@dpdk.org
Cc: nd@arm.com, Doug Foster <doug.foster@arm.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH] config/arm: update mcpu for Cobalt-100 SoC
Date: Tue, 11 Nov 2025 19:06:38 +0000
Message-Id: <20251111190639.3470596-1-doug.foster@arm.com>
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

Update the build configuration for Microsoft Azure Cobalt 100 SoC to
use a CPU-specific mcpu value supported by GCC 14+.

Signed-off-by: Doug Foster <doug.foster@arm.com>
Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 config/arm/meson.build | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index c0aa21b57d..523b0fc0ed 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -300,7 +300,7 @@ implementer_microsoft = {
     'flags': [],
     'part_number_config': {
         '0xd49': {
-            'mcpu': 'mcpu_cobalt100',
+            'mcpu': 'cobalt-100',
             'flags': [
                 ['RTE_MACHINE', '"neoverse-n2"'],
                 ['RTE_ARM_FEATURE_ATOMICS', true],
@@ -492,6 +492,7 @@ soc_cobalt100 = {
     'description' : 'Microsoft Azure Cobalt 100',
     'implementer' : '0x6d',
     'part_number': '0xd49',
+    'extra_march_features': ['crypto'],
     'numa': true
 }
 
@@ -703,10 +704,6 @@ mcpu_defs = {
         'march': 'armv8-a',
         'march_extensions': ['crc']
     },
-    'mcpu_cobalt100': {
-        'march': 'armv9-a',
-        'march_extensions': ['crypto', 'sve', 'sve2']
-    },
     'mcpu_cortex-a78ae': {
         'march': 'armv8.4-a',
         'march_extensions': ['crypto']
-- 
2.34.1

