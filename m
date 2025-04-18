Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE61C369C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 09:07:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59DFF40430;
	Fri, 18 Apr 2025 11:07:27 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTP id C5E93400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:Subject:Date:Message-ID:
 MIME-Version; bh=AaLamSrmZZWEXPHKKYhoQuffvUbRVLmYzWGJT3eVBlg=;
 b=nKnuaJ1OLJHmZYs58H5ATnbt5ryXcf2r+vcQr3O27fnj+xdjldgst/pPo01Ux5
 L/lI0iYR2sB/iLzQY0lFA17vysZ/hmjRrrG/FN/si/Vp5cWcIeUP9z4vk+gKuWI2
 +0VjWVh0gCkj3La2XY0bRAX7/drklP4RjXUL5QGkIJyOw=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDXqJVFFgJorqzGAg--.15042S5;
 Fri, 18 Apr 2025 17:07:21 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>
Subject: [RFC 01/18] net/hinic3: add intro doc for hinic3
Date: Fri, 18 Apr 2025 17:05:47 +0800
Message-ID: <20250418090621.9638-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDXqJVFFgJorqzGAg--.15042S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF47ZrW7CFW7tF4rXr1kZrb_yoW7tFyfp3
 Z3CrWfKF98G34xurnIy3WUZr1rA3WrC3yUZay8t34rZFn8Cr10vw48KFWIy3yDGFy0va4f
 Zr1jgry3C3WjgrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgmi_UUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiKg8zCmgCALtfrQAAs-
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

From: Feifei Wang <wangfeifei40@huawei.com>

This patch adds some basic files to describe the hinic3 driver.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
---
 .mailmap                               |  4 +-
 MAINTAINERS                            |  6 +++
 doc/guides/nics/hinic3.rst             | 52 ++++++++++++++++++++++++++
 doc/guides/nics/index.rst              |  1 +
 doc/guides/rel_notes/release_25_07.rst | 32 +---------------
 5 files changed, 64 insertions(+), 31 deletions(-)
 create mode 100644 doc/guides/nics/hinic3.rst

diff --git a/.mailmap b/.mailmap
index d8439b79ce..8c1341e783 100644
--- a/.mailmap
+++ b/.mailmap
@@ -429,7 +429,7 @@ Fang TongHao <fangtonghao@sangfor.com.cn>
 Fan Zhang <fanzhang.oss@gmail.com> <roy.fan.zhang@intel.com>
 Farah Smith <farah.smith@broadcom.com>
 Fei Chen <chenwei.0515@bytedance.com>
-Feifei Wang <feifei.wang2@arm.com> <feifei.wang@arm.com>
+Feifei Wang <wangfeifei40@huawei.com> <feifei.wang1218@gmail.com> <feifei.wang2@arm.com> <feifei.wang@arm.com> <wff_light@vip.163.com>
 Fei Qin <fei.qin@corigine.com>
 Fengjiang Liu <liufengjiang.0426@bytedance.com>
 Fengnan Chang <changfengnan@bytedance.com>
@@ -1718,6 +1718,7 @@ Xingguang He <xingguang.he@intel.com>
 Xingyou Chen <niatlantice@gmail.com>
 Xing Wang <xing_wang@realsil.com.cn>
 Xinying Yu <xinying.yu@corigine.com>
+Xin Wang <wangxin679@h-partners.com>
 Xin Long <longxin.xl@alibaba-inc.com>
 Xi Zhang <xix.zhang@intel.com>
 Xuan Ding <xuan.ding@intel.com>
@@ -1750,6 +1751,7 @@ Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
 Yicai Lu <luyicai@huawei.com>
+Yi Chen <chenyi221@huawei.com>
 Yiding Zhou <yidingx.zhou@intel.com>
 Yi Li <liyi1@chinatelecom.cn>
 Yi Liu <yi.liu@nxp.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 167cc74a15..f96a27210d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -773,6 +773,12 @@ F: drivers/net/hinic/
 F: doc/guides/nics/hinic.rst
 F: doc/guides/nics/features/hinic.ini
 
+Huawei hinic3
+M: Feifei Wang <wangfeifei40@huawei.com>
+F: drivers/net/hinic3/
+F: doc/guides/nics/hinic3.rst
+F: doc/guides/nics/features/hinic3.ini
+
 Intel Network Common Code
 M: Bruce Richardson <bruce.richardson@intel.com>
 T: git://dpdk.org/next/dpdk-next-net-intel
diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
new file mode 100644
index 0000000000..c7080c8c1d
--- /dev/null
+++ b/doc/guides/nics/hinic3.rst
@@ -0,0 +1,52 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2025 Huawei Technologies Co., Ltd
+
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
index 093b85d206..1d65cf7829 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -24,37 +24,9 @@ DPDK Release 25.07
 New Features
 ------------
 
-.. This section should contain new features added in this release.
-   Sample format:
-
-   * **Add a title in the past tense with a full stop.**
-
-     Add a short 1-2 sentence description in the past tense.
-     The description should be enough to allow someone scanning
-     the release notes to understand the new feature.
-
-     If the feature adds a lot of sub-features you can use a bullet list
-     like this:
-
-     * Added feature foo to do something.
-     * Enhanced feature bar to do something else.
-
-     Refer to the previous release notes for examples.
-
-     Suggested order in release notes items:
-     * Core libs (EAL, mempool, ring, mbuf, buses)
-     * Device abstraction libs and PMDs (ordered alphabetically by vendor name)
-       - ethdev (lib, PMDs)
-       - cryptodev (lib, PMDs)
-       - eventdev (lib, PMDs)
-       - etc
-     * Other libs
-     * Apps, Examples, Tools (if significant)
-
-     This section is a comment. Do not overwrite or remove it.
-     Also, make sure to start the actual text at the margin.
-     =======================================================
+* **Added Huawei hinic3 net driver [EXPERIMENTAL].**
 
+  * Added network driver for the Huawei SPx series Network Adapters.
 
 Removed Items
 -------------
-- 
2.47.0.windows.2

