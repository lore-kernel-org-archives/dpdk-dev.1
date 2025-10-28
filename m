Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5210CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 08:43:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31AB240262;
	Tue, 28 Oct 2025 09:43:11 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id C22794021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 09:43:09 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=yYi/lwIDOEPOFAyiEZuBxUYJE47Uj2pqGwJkJb4IGaA=;
 b=hJW3X7fNGNIDUlFzlqNFOfh0c37euRINHj1Ch5w2D1dTzXigZ44l4MIlgzQ7OnJE8hkopqwpK
 fI/NXa6sRmscynzC6QFZxrJ6xGIvo5Rf0nOav5FwMsF0ML9d3iQlVqnxA6b9jeopXgKtmjE+LBS
 3K1zjVBPxEHj1rvo2DdMFKo=
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cwkQl5Bfkz1cyVm;
 Tue, 28 Oct 2025 16:42:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id E47801402A5;
 Tue, 28 Oct 2025 16:43:07 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 16:43:07 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] config/arm: add HiSilicon HIP12
Date: Tue, 28 Oct 2025 16:42:59 +0800
Message-ID: <20251028084259.4925-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
@@ -257,0 +258,9 @@ implementer_hisilicon = {
+        },
+        '0xd06': {
+            'mcpu': 'mcpu_hip12',
+            'flags': [
+                ['RTE_MACHINE', '"hip12"'],
+                ['RTE_ARM_FEATURE_ATOMICS', true],
+                ['RTE_MAX_LCORE', 1280],
+                ['RTE_MAX_NUMA_NODES', 16]
+            ]
@@ -564,0 +574,7 @@ soc_hip10 = {
+soc_hip12 = {
+    'description': 'HiSilicon HIP12',
+    'implementer': '0x48',
+    'part_number': '0xd06',
+    'numa': true
+}
+
@@ -705,0 +722,4 @@ mcpu_defs = {
+    'mcpu_hip12': {
+        'march': 'armv8.5-a',
+        'march_extensions': ['crypto', 'sve']
+    },
@@ -760,0 +781 @@ hip10:           HiSilicon HIP10
+hip12:           HiSilicon HIP12
@@ -803,0 +825 @@ socs = {
+    'hip12': soc_hip12,
-- 
2.17.1

