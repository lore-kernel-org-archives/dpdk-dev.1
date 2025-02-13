Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22D7C021A8
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 07:32:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5A1C42EB3;
	Thu, 13 Feb 2025 08:32:10 +0100 (CET)
Received: from smtp.cecloud.com (unknown [1.203.97.240])
 by mails.dpdk.org (Postfix) with ESMTP id 2C18A4028C
 for <dev@dpdk.org>; Thu, 13 Feb 2025 08:15:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by smtp.cecloud.com (Postfix) with ESMTP id 16218900113;
 Thu, 13 Feb 2025 15:15:40 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.48.58.10])
 by smtp.cecloud.com (postfix) whith ESMTP id
 P3907747T281458896793968S1739430923169192_; 
 Thu, 13 Feb 2025 15:15:39 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: luzhipeng@cestc.cn
X-SENDER: luzhipeng@cestc.cn
X-LOGIN-NAME: luzhipeng@cestc.cn
X-FST-TO: dev@dpdk.org
X-RCPT-COUNT: 3
X-LOCAL-RCPT-COUNT: 1
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.58.10
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <802befeeb1bd23010dedc1bda1c25046>
X-System-Flag: 0
From: luzhipeng <luzhipeng@cestc.cn>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
	luzhipeng <luzhipeng@cestc.cn>
Subject: [PATCH] config/arm: add Phytium TengYun S5000c
Date: Thu, 13 Feb 2025 15:14:59 +0800
Message-Id: <20250213071459.458-2-luzhipeng@cestc.cn>
X-Mailer: git-send-email 2.34.0.windows.1
In-Reply-To: <20250213071459.458-1-luzhipeng@cestc.cn>
References: <20250213071459.458-1-luzhipeng@cestc.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Feb 2025 08:32:07 +0100
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

add support for Phytium tengyunS5000c

Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
---
 config/arm/arm64_fts5000c_linux_gcc | 16 ++++++++++++++++
 config/arm/meson.build              | 20 ++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 config/arm/arm64_fts5000c_linux_gcc

diff --git a/config/arm/arm64_fts5000c_linux_gcc b/config/arm/arm64_fts5000c_linux_gcc
new file mode 100644
index 0000000000..1f3b920b1a
--- /dev/null
+++ b/config/arm/arm64_fts5000c_linux_gcc
@@ -0,0 +1,16 @@
+[binaries]
+c = 'aarch64-linux-gnu-gcc'
+cpp = 'aarch64-linux-gnu-g++'
+ar = 'aarch64-linux-gnu-gcc-ar'
+strip = 'aarch64-linux-gnu-strip'
+pkgconfig = 'aarch64-linux-gnu-pkg-config'
+pcap-config = ''
+
+[host_machine]
+system = 'linux'
+cpu_family = 'aarch64'
+cpu = 'armv8-a'
+endian = 'little'
+
+[properties]
+platform = 'fts5000c'
diff --git a/config/arm/meson.build b/config/arm/meson.build
index 5302861e2c..086985d7b6 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -304,6 +304,13 @@ implementer_phytium = {
                 ['RTE_MAX_LCORE', 256],
                 ['RTE_MAX_NUMA_NODES', 32]
             ]
+        },
+        '0x862': {
+            'mcpu': 'mcpu_tys5000c',
+            'flags': [
+                ['RTE_MAX_LCORE', 256],
+                ['RTE_MAX_NUMA_NODES', 32]
+            ]
         }
     }
 }
@@ -614,6 +621,13 @@ soc_tys2500 = {
     'numa': true
 }
 
+soc_tys5000c = {
+    'description': 'Phytium TengYun S5000c',
+    'implementer': '0x70',
+    'part_number': '0x862',
+    'numa': true
+}
+
 soc_v2 = {
     'description': 'Arm Neoverse V2',
     'implementer': '0x41',
@@ -650,6 +664,10 @@ mcpu_defs = {
         'march': 'armv8-a',
         'march_extensions': ['crc']
     },
+    'mcpu_tys5000c': {
+        'march': 'armv8-a',
+        'march_extensions': ['crc']
+    },
     'mcpu_generic': {
         'march': 'armv8-a',
         'march_extensions': ['crc'],
@@ -694,6 +712,7 @@ thunderx2:       Marvell ThunderX2 T99
 thunderxt83:     Marvell ThunderX T83
 thunderxt88:     Marvell ThunderX T88
 tys2500:         Phytium TengYun S2500
+tys5000c:        Phytium TengYun S5000c
 v2:              Arm Neoverse V2
 End of SoCs list
 '''
@@ -733,6 +752,7 @@ socs = {
     'thunderxt83': soc_thunderxt83,
     'thunderxt88': soc_thunderxt88,
     'tys2500': soc_tys2500,
+    'tys5000c': soc_tys5000c,
     'v2': soc_v2,
 }
 
-- 
2.34.0.windows.1



