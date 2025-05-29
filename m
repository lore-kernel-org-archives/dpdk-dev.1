Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A4C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 08:16:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB15B40ED8;
	Thu, 29 May 2025 10:16:04 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id 9B1BC402B6
 for <dev@dpdk.org>; Thu, 29 May 2025 10:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=qeKWnpxYSU33i4PsiwosA1GIOt/be2SXJ3iVtP+Xqf4=;
 b=oFxB8V5l1BUes1mOueKTT3EyD8ZbqrRqf8n8kFoEvTAk2D+QByYdZZsEobajRj
 qOEUGHt/bdeatDHm37IRPLATWoSJWpV9Bi/WnbUrA89eOMR6WHkhZI6Nbnq4+KuA
 wDIgeYYjsjCTn7azKiKw04aX8s/X/7vwhm7jKRb4XGvxs=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgBnrqG7FzhofozTAQ--.8522S5;
 Thu, 29 May 2025 16:15:57 +0800 (CST)
From: Feifei <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>
Subject: [PATCH v1 01/18] This patch adds some basic files to describe the
 hinic3 driver.
Date: Thu, 29 May 2025 16:15:00 +0800
Message-ID: <20250529081529.2839-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418090621.9638-19-wff_light@vip.163.com>
References: <20250418090621.9638-19-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgBnrqG7FzhofozTAQ--.8522S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWUXFy8Aw15Xr4fCFy8Zrb_yoW7JF1kpw
 s3CryfGF98GryI9rnIy3WUAr15A3Z5C34Uuay8tFyrZFnxAr10gw48KayIy3yDGFy09a43
 Zr1jgrySk3WjgrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5OzsUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiJgBcCmg3+XCOywAAsj
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

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
---
 .mailmap                               |  4 +-
 MAINTAINERS                            |  6 +++
 doc/guides/nics/hinic3.rst             | 51 ++++++++++++++++++++++++++
 doc/guides/nics/index.rst              |  1 +
 doc/guides/rel_notes/release_25_07.rst |  3 ++
 5 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 doc/guides/nics/hinic3.rst

diff --git a/.mailmap b/.mailmap
index 91e08f4a1f..deb35ab1b8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -430,7 +430,7 @@ Fang TongHao <fangtonghao@sangfor.com.cn>
 Fan Zhang <fanzhang.oss@gmail.com> <roy.fan.zhang@intel.com>
 Farah Smith <farah.smith@broadcom.com>
 Fei Chen <chenwei.0515@bytedance.com>
-Feifei Wang <feifei.wang2@arm.com> <feifei.wang@arm.com>
+Feifei Wang <wangfeifei40@huawei.com> <feifei.wang1218@gmail.com> <feifei.wang2@arm.com> <feifei.wang@arm.com> <wff_light@vip.163.com>
 Fei Qin <fei.qin@corigine.com>
 Fengjiang Liu <liufengjiang.0426@bytedance.com>
 Fengnan Chang <changfengnan@bytedance.com>
@@ -1723,6 +1723,7 @@ Xingguang He <xingguang.he@intel.com>
 Xingyou Chen <niatlantice@gmail.com>
 Xing Wang <xing_wang@realsil.com.cn>
 Xinying Yu <xinying.yu@corigine.com>
+Xin Wang <wangxin679@h-partners.com>
 Xin Long <longxin.xl@alibaba-inc.com>
 Xi Zhang <xix.zhang@intel.com>
 Xuan Ding <xuan.ding@intel.com>
@@ -1756,6 +1757,7 @@ Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
 Yicai Lu <luyicai@huawei.com>
+Yi Chen <chenyi221@huawei.com>
 Yiding Zhou <yidingx.zhou@intel.com>
 Yi Li <liyi1@chinatelecom.cn>
 Yi Liu <yi.liu@nxp.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 3e16789250..673b24673e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -773,6 +773,12 @@ F: drivers/net/hinic/
 F: doc/guides/nics/hinic.rst
 F: doc/guides/nics/features/hinic.ini
 
+Huawei hinic3
++M: Feifei Wang <wangfeifei40@huawei.com>
++F: drivers/net/hinic3/
++F: doc/guides/nics/hinic3.rst
++F: doc/guides/nics/features/hinic3.ini
+
 Intel Network Common Code
 M: Bruce Richardson <bruce.richardson@intel.com>
 T: git://dpdk.org/next/dpdk-next-net-intel
diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
new file mode 100644
index 0000000000..c9e49a2be2
--- /dev/null
+++ b/doc/guides/nics/hinic3.rst
@@ -0,0 +1,51 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2025 Huawei Technologies Co., Ltd
+
+HINIC Poll Mode Driver
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
+- Learning about Huawei Hi1823 Series Intelligent NICs using
+  `<https://www.hikunpeng.com/compute/component/nic>`_.
+
+- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+
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
index 10a2eca3b0..5ae4021ccb 100644
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
index 6b070801de..a9de42d8db 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -54,6 +54,9 @@ New Features
      This section is a comment. Do not overwrite or remove it.
      Also, make sure to start the actual text at the margin.
      =======================================================
+* **Added Huawei hinic3 net driver.**
+
+  * Added network driver for the Huawei SPx series Network Adapters.
 
 * **Added burst mode query function to Intel drivers.**
 
-- 
2.47.0.windows.2

