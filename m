Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAC1C3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 12:52:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B32BA40E18;
	Mon,  5 May 2025 14:51:16 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 7F93A400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 09:04:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:Subject:Date:Message-ID:
 MIME-Version; bh=cMUet+Nv//nH4B3Wr8uTxoP+VGoJA9c/IKt2iqBRRwY=;
 b=CFNJZJqdMBbnXDGbsmb92xNaGc/fBq6gLTQrTe3zuLBPrYPbdM2OJpqpes7Uwq
 nrqImiT658SIISaHE7AppInw2jT0mKtVA9xlD26KqmhGwC64U/tPrH3FOVbaBvMf
 JXFzfjNAUIWPI7UKa7L7N9GK9Ns69ccRs7Wz6UY02BnhM=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgA3M_dJ+QFobKvFAg--.64861S22;
 Fri, 18 Apr 2025 15:03:59 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [RFC 18/18] drivers/net: add hinic3 PMD build and doc files
Date: Fri, 18 Apr 2025 15:02:56 +0800
Message-ID: <20250418070306.9290-19-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418070306.9290-1-wff_light@vip.163.com>
References: <20250418070306.9290-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgA3M_dJ+QFobKvFAg--.64861S22
X-Coremail-Antispam: 1Uf129KBjvJXoWxCry7tr1UGw17KrW7Aw4fXwb_yoWrXrW8pa
 18Ga4S9r48Xr4xt3Z3A3WxAF4Fya18Ca4jkw13Ca4rZryDAFy5A3y8KFW8Kr97tw1IyF1f
 uFnxu3sxKFs8tw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSXdUUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAQszCmgB4QVfBQAAsk
X-Mailman-Approved-At: Mon, 05 May 2025 14:51:04 +0200
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

From: Yi Chen <chenyi221@huawei.com>

The meson.build file is added to this patch to enable
the hinic3 compilation function.

Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
---
 doc/guides/nics/features/hinic3.ini |  9 ++++++
 drivers/net/hinic3/base/meson.build | 50 +++++++++++++++++++++++++++++
 drivers/net/hinic3/meson.build      | 44 +++++++++++++++++++++++++
 drivers/net/meson.build             |  1 +
 4 files changed, 104 insertions(+)
 create mode 100644 doc/guides/nics/features/hinic3.ini
 create mode 100644 drivers/net/hinic3/base/meson.build
 create mode 100644 drivers/net/hinic3/meson.build

diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
new file mode 100644
index 0000000000..8bafd49090
--- /dev/null
+++ b/doc/guides/nics/features/hinic3.ini
@@ -0,0 +1,9 @@
+;
+; Supported features of the 'hinic3' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Linux                = Y
+x86-64               = Y
+ARMv8                = Y
diff --git a/drivers/net/hinic3/base/meson.build b/drivers/net/hinic3/base/meson.build
new file mode 100644
index 0000000000..948f5efac2
--- /dev/null
+++ b/drivers/net/hinic3/base/meson.build
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Huawei Technologies Co., Ltd
+
+sources = files(
+    'hinic3_cmdq.c',
+    'hinic3_eqs.c',
+    'hinic3_hw_cfg.c',
+    'hinic3_hw_comm.c',
+    'hinic3_hwdev.c',
+    'hinic3_hwif.c',
+    'hinic3_mbox.c',
+    'hinic3_mgmt.c',
+    'hinic3_nic_cfg.c',
+    'hinic3_nic_event.c',
+    'hinic3_wq.c',
+)
+
+extra_flags = []
+
+# The driver runs only on arch64 machine, remove 32bit warnings
+if not dpdk_conf.get('RTE_ARCH_64')
+    extra_flags += [
+        '-Wno-int-to-pointer-cast',
+        '-Wno-pointer-to-int-cast',
+    ]
+endif
+
+foreach flag: extra_flags
+    if cc.has_argument(flag)
+        cflags += flag
+    endif
+endforeach
+
+deps += ['hash']
+c_args = cflags
+includes += include_directories('../')
+
+base_lib = static_library(
+    'spnic_base',
+    sources,
+    dependencies: [
+        static_rte_eal,
+        static_rte_ethdev,
+        static_rte_bus_pci,
+        static_rte_hash,
+    ],
+    include_directories: includes,
+    c_args: c_args,
+)
+base_objs = base_lib.extract_all_objects()
diff --git a/drivers/net/hinic3/meson.build b/drivers/net/hinic3/meson.build
new file mode 100644
index 0000000000..231e966b36
--- /dev/null
+++ b/drivers/net/hinic3/meson.build
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Huawei Technologies Co., Ltd
+
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
+    subdir_done()
+endif
+
+if (arch_subdir != 'x86' and arch_subdir != 'arm'
+        or not dpdk_conf.get('RTE_ARCH_64'))
+    build = false
+    reason = 'only supported on x86_64 and aarch64'
+    subdir_done()
+endif
+
+cflags += [
+    '-DHW_CONVERT_ENDIAN',
+    '-D__HINIC_HUAWEI_SECUREC__',
+    '-fPIC',
+    '-fstack-protector-strong',
+]
+
+subdir('base')
+subdir('mml')
+objs = [base_objs] + [mml_objs]
+
+sources = files(
+    'hinic3_ethdev.c',
+    'hinic3_fdir.c',
+    'hinic3_flow.c',
+    'hinic3_nic_io.c',
+    'hinic3_rx.c',
+    'hinic3_tx.c',
+)
+
+if arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
+    cflags += ['-D__ARM64_NEON__']
+else
+    cflags += ['-D__X86_64_SSE__']
+endif
+
+includes += include_directories('base')
+includes += include_directories('mml')
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 460eb69e5b..b5442349d4 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -23,6 +23,7 @@ drivers = [
         'failsafe',
         'gve',
         'hinic',
+        'hinic3',
         'hns3',
         'intel/e1000',
         'intel/fm10k',
-- 
2.47.0.windows.2

