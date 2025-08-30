Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA5FCA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A87EE40658;
	Sat, 30 Aug 2025 14:44:45 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 53B5D402DC
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=BHuTM/ZjbrIw9Id1J58kxhX3Lny0DxmZrzs1FkWidCA=;
 b=phE5X4gILeCoMP5D2gDA2EgEm/D/xp74LZcyPqe6cWD49mxm2kUpad1JxA9ctn
 mfGo5/elq2EW3qsthtpkKqpbp/FumXiu0YQH8cFbm8W4x2Kzlv8HrF28wX4D10iW
 pQ2c0v/W3rkGcH+whH+CHiVKDzzqv4kq8AW7O1ckKtWew=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHz+YN8rJogy_MAg--.2603S5;
 Sat, 30 Aug 2025 20:44:41 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>
Subject: [V6 01/17] doc: add hinic3 driver
Date: Sat, 30 Aug 2025 20:43:05 +0800
Message-ID: <20250830124332.5351-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830124332.5351-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830124332.5351-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHz+YN8rJogy_MAg--.2603S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW5uw4DXFyktr4xtF48Crg_yoWrtFyxpw
 43CryfGF98Gw1I9rnIy3W7Ar15A3Z5u3yUuay8tFyrZFnxAr10gw48KFWIy39rGFyF9a4f
 Zr1jgryfC3WjqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCeHgUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiBha5Cmiyd2a-6gAAs9
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

This patch adds document for hinic3 driver.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
---
 .mailmap                               |  4 ++-
 MAINTAINERS                            |  4 +++
 doc/guides/nics/hinic3.rst             | 47 ++++++++++++++++++++++++++
 doc/guides/nics/index.rst              |  1 +
 doc/guides/rel_notes/release_25_07.rst |  4 +++
 5 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 doc/guides/nics/hinic3.rst

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..8ac40e4eb0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -443,7 +443,7 @@ Fang TongHao <fangtonghao@sangfor.com.cn>
 Fan Zhang <fanzhang.oss@gmail.com> <roy.fan.zhang@intel.com>
 Farah Smith <farah.smith@broadcom.com>
 Fei Chen <chenwei.0515@bytedance.com>
-Feifei Wang <feifei.wang2@arm.com> <feifei.wang@arm.com>
+Feifei Wang <wangfeifei40@huawei.com> <feifei.wang1218@gmail.com> <feifei.wang2@arm.com> <feifei.wang@arm.com> <wff_light@vip.163.com>
 Fei Qin <fei.qin@corigine.com>
 Fengjiang Liu <liufengjiang.0426@bytedance.com>
 Fengnan Chang <changfengnan@bytedance.com>
@@ -1770,6 +1770,7 @@ Xingguang He <xingguang.he@intel.com>
 Xingyou Chen <niatlantice@gmail.com>
 Xing Wang <xing_wang@realsil.com.cn>
 Xinying Yu <xinying.yu@corigine.com>
+Xin Wang <wangxin679@h-partners.com>
 Xin Long <longxin.xl@alibaba-inc.com>
 Xi Zhang <xix.zhang@intel.com>
 Xuan Ding <xuan.ding@intel.com>
@@ -1804,6 +1805,7 @@ Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
 Yicai Lu <luyicai@huawei.com>
+Yi Chen <chenyi221@huawei.com>
 Yiding Zhou <yidingx.zhou@intel.com>
 Yi Li <liyi1@chinatelecom.cn>
 Yi Liu <yi.liu@nxp.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1cc08f5aaf..8900564bb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -779,6 +779,10 @@ F: drivers/net/hinic/
 F: doc/guides/nics/hinic.rst
 F: doc/guides/nics/features/hinic.ini
 
+Huawei hinic3
+M: Feifei Wang <wangfeifei40@huawei.com>
+F: doc/guides/nics/hinic3.rst
+
 Intel Network Common Code
 M: Bruce Richardson <bruce.richardson@intel.com>
 T: git://dpdk.org/next/dpdk-next-net-intel
diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
new file mode 100644
index 0000000000..9c0db7051e
--- /dev/null
+++ b/doc/guides/nics/hinic3.rst
@@ -0,0 +1,47 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2025 Huawei Technologies Co., Ltd
+
+HINIC3 Poll Mode Driver
+======================
+
+The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
+for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
+
+Features
+--------
+
+- Multi arch support: x86_64, ARMv8.
+- Multiple queues for TX and RX
+- Receiver Side Scaling (RSS)
+- flow filtering
+- Checksum offload
+- TSO offload
+- Promiscuous mode
+- Port hardware statistics
+- Link state information
+- Link flow control
+- Scattered and gather for TX and RX
+- Allmulticast mode
+- MTU update
+- Multicast MAC filter
+- Flow API
+- Set Link down or up
+- VLAN filter and VLAN offload
+- SR-IOV - Partially supported at this point, VFIO only
+- FW version
+- LRO
+
+Prerequisites
+-------------
+
+- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+
+Driver compilation and testing
+------------------------------
+
+Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+for details.
+
+Limitations or Known issues
+---------------------------
+X86-32, Windows, and BSD are not supported yet.
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index 57d161c526..1a1e3a6825 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -33,6 +33,7 @@ Network Interface Controller Drivers
     fm10k
     gve
     hinic
+    hinic3
     hns3
     i40e
     ice
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index c25266b0fb..4ca3a52065 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -128,6 +128,10 @@ New Features
   (including out-of-tree nodes).
   This minimizes footprint of node specific mbuf dynamic field.
 
+* **Added Huawei hinic3 net driver.**
+
+  * Added network driver for the Huawei SPx series Network Adapters.
+
 
 Removed Items
 -------------
-- 
2.47.0.windows.2

