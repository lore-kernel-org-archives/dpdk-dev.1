Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311D2CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 01:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27D154028D;
	Wed, 29 Oct 2025 02:16:36 +0100 (CET)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 4664C40262
 for <dev@dpdk.org>; Wed, 29 Oct 2025 02:16:34 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=S67iyJQnntlBJSFmOkvPPzyoPHFo1FvMmXKPAn/GOw0=;
 b=GzY8uXylUwuZJnvXc8esGfQPY/Qu9r2wR7ELWtR15JOYBUyRGz5E9K2oKE+v8LZsQWmoc4v7C
 UPK3wOXa8BwrfeYgOeRNOHPcFVxsnEnXKZ1hg2Q9A+GUm+SU2Me5fAUpTUtEpfpf3besU+tEzeU
 Svec7TuUYoESrnGnDmelszw=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cx8Sz5VnrzmV6g;
 Wed, 29 Oct 2025 09:16:03 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 6005E1800B2;
 Wed, 29 Oct 2025 09:16:32 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 09:16:31 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH v2] config/arm: add HiSilicon HIP12
Date: Wed, 29 Oct 2025 09:16:26 +0800
Message-ID: <20251029011626.9298-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251028084259.4925-1-fengchengwen@huawei.com>
References: <20251028084259.4925-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Adding support for HiSilicon HIP12 platform.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 config/arm/arm64_hip12_linux_gcc | 17 +++++++++++++++++
 config/arm/meson.build           | 22 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 config/arm/arm64_hip12_linux_gcc

---
v2: try to fix meson build error "Expecting eof got rcurl"

diff --git a/config/arm/arm64_hip12_linux_gcc b/config/arm/arm64_hip12_linux_gcc
new file mode 100644
index 0000000000..949093d67b
--- /dev/null
+++ b/config/arm/arm64_hip12_linux_gcc
@@ -0,0 +1,17 @@
+[binaries]
+c = ['ccache', 'aarch64-linux-gnu-gcc']
+cpp = ['ccache', 'aarch64-linux-gnu-g++']
+ar = 'aarch64-linux-gnu-gcc-ar'
+strip = 'aarch64-linux-gnu-strip'
+pkgconfig = 'aarch64-linux-gnu-pkg-config'
+pkg-config = 'aarch64-linux-gnu-pkg-config'
+pcap-config = ''
+
+[host_machine]
+system = 'linux'
+cpu_family = 'aarch64'
+cpu = 'armv8.5-a'
+endian = 'little'
+
+[properties]
+platform = 'hip12'
diff --git a/config/arm/meson.build b/config/arm/meson.build
index ec9e08cb5e..c0aa21b57d 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -255,6 +255,15 @@ implementer_hisilicon = {
                 ['RTE_MAX_LCORE', 1280],
                 ['RTE_MAX_NUMA_NODES', 16]
             ]
+        },
+        '0xd06': {
+            'mcpu': 'mcpu_hip12',
+            'flags': [
+                ['RTE_MACHINE', '"hip12"'],
+                ['RTE_ARM_FEATURE_ATOMICS', true],
+                ['RTE_MAX_LCORE', 1280],
+                ['RTE_MAX_NUMA_NODES', 16]
+            ]
         }
     }
 }
@@ -562,6 +571,13 @@ soc_hip10 = {
     'numa': true
 }
 
+soc_hip12 = {
+    'description': 'HiSilicon HIP12',
+    'implementer': '0x48',
+    'part_number': '0xd06',
+    'numa': true
+}
+
 soc_imx = {
     'description': 'NXP IMX',
     'implementer': '0x41',
@@ -703,6 +719,10 @@ mcpu_defs = {
         'march': 'armv8.5-a',
         'march_extensions': ['crypto', 'sve']
     },
+    'mcpu_hip12': {
+        'march': 'armv8.5-a',
+        'march_extensions': ['crypto', 'sve']
+    },
     'mcpu_kunpeng930': {
         'march': 'armv8.2-a',
         'march_extensions': ['crypto', 'sve']
@@ -758,6 +778,7 @@ graviton2:       AWS Graviton2
 graviton3:       AWS Graviton3
 graviton4:       AWS Graviton4
 hip10:           HiSilicon HIP10
+hip12:           HiSilicon HIP12
 imx:             NXP IMX
 kunpeng920:      HiSilicon Kunpeng 920
 kunpeng930:      HiSilicon Kunpeng 930
@@ -801,6 +822,7 @@ socs = {
     'graviton3': soc_graviton3,
     'graviton4': soc_graviton4,
     'hip10': soc_hip10,
+    'hip12': soc_hip12,
     'imx': soc_imx,
     'kunpeng920': soc_kunpeng920,
     'kunpeng930': soc_kunpeng930,
-- 
2.17.1

