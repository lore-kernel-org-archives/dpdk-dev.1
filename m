Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC7CCA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:40:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A83F8402DC;
	Sat, 30 Aug 2025 14:40:51 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 6A40740151
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=TNvkyLCUgEMYkS5R5MRJEvAOth4KBI7c000ebASU0tw=;
 b=BrvEG/iVJsYtWKeS6K9zOUm0S71t5iWFSOXN+35ccZp2PRgfT6koIdrJNERePU
 3leFr0iPFTxKgwe7w4m57eWC2AenqJAh+Xhl+LMTLz3wMYb1q/cXmi3Ya+YslLwV
 l/kWQ3ztiYHbRRlTdQq+xgMyX6tpuem1mU4pPI6emCP9U=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S5;
 Sat, 30 Aug 2025 20:40:46 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>
Subject: [V5 01/18] doc: add some basic files to describe the hinic3 driver.
Date: Sat, 30 Aug 2025 20:39:13 +0800
Message-ID: <20250830123942.5037-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWUur47CF4rtr1kZF1DZFb_yoW7JF1fpw
 43CryfGF98Gw1xurnIy3W7Ar15A3Z5C3yUuay8tFyrZFnxAr10gw48KFWIy39rGFyY9a4f
 Zr1jgrySk3WjqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYOJnUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAQ65CmiydD3FygAAsg
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

From: Yi Chen <chenyi221@huawei.com>=0D

This patch adds some basic files to describe the hinic3 driver.=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Xin Wang <wangxin679@h-partners.com>=0D
---=0D
 .mailmap                               |  4 +-=0D
 MAINTAINERS                            |  6 +++=0D
 doc/guides/nics/hinic3.rst             | 51 ++++++++++++++++++++++++++=0D
 doc/guides/nics/index.rst              |  1 +=0D
 doc/guides/rel_notes/release_25_07.rst |  4 ++=0D
 5 files changed, 65 insertions(+), 1 deletion(-)=0D
 create mode 100644 doc/guides/nics/hinic3.rst=0D
=0D
diff --git a/.mailmap b/.mailmap=0D
index 8e898e303e..ecd7fe5805 100644=0D
--- a/.mailmap=0D
+++ b/.mailmap=0D
@@ -434,7 +434,7 @@ Fang TongHao <fangtonghao@sangfor.com.cn>=0D
 Fan Zhang <fanzhang.oss@gmail.com> <roy.fan.zhang@intel.com>=0D
 Farah Smith <farah.smith@broadcom.com>=0D
 Fei Chen <chenwei.0515@bytedance.com>=0D
-Feifei Wang <feifei.wang2@arm.com> <feifei.wang@arm.com>=0D
+Feifei Wang <wangfeifei40@huawei.com> <feifei.wang1218@gmail.com> <feifei.=
wang2@arm.com> <feifei.wang@arm.com> <wff_light@vip.163.com>=0D
 Fei Qin <fei.qin@corigine.com>=0D
 Fengjiang Liu <liufengjiang.0426@bytedance.com>=0D
 Fengnan Chang <changfengnan@bytedance.com>=0D
@@ -1735,6 +1735,7 @@ Xingguang He <xingguang.he@intel.com>=0D
 Xingyou Chen <niatlantice@gmail.com>=0D
 Xing Wang <xing_wang@realsil.com.cn>=0D
 Xinying Yu <xinying.yu@corigine.com>=0D
+Xin Wang <wangxin679@h-partners.com>=0D
 Xin Long <longxin.xl@alibaba-inc.com>=0D
 Xi Zhang <xix.zhang@intel.com>=0D
 Xuan Ding <xuan.ding@intel.com>=0D
@@ -1769,6 +1770,7 @@ Yelena Krivosheev <yelena@marvell.com>=0D
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>=0D
 Yevgeny Kliteynik <kliteyn@nvidia.com>=0D
 Yicai Lu <luyicai@huawei.com>=0D
+Yi Chen <chenyi221@huawei.com>=0D
 Yiding Zhou <yidingx.zhou@intel.com>=0D
 Yi Li <liyi1@chinatelecom.cn>=0D
 Yi Liu <yi.liu@nxp.com>=0D
diff --git a/MAINTAINERS b/MAINTAINERS=0D
index 0e9357f3a3..eeb735679e 100644=0D
--- a/MAINTAINERS=0D
+++ b/MAINTAINERS=0D
@@ -780,6 +780,12 @@ F: drivers/net/hinic/=0D
 F: doc/guides/nics/hinic.rst=0D
 F: doc/guides/nics/features/hinic.ini=0D
 =0D
+Huawei hinic3=0D
+M: Feifei Wang <wangfeifei40@huawei.com>=0D
+F: drivers/net/hinic3/=0D
+F: doc/guides/nics/hinic3.rst=0D
+F: doc/guides/nics/features/hinic3.ini=0D
+=0D
 Intel Network Common Code=0D
 M: Bruce Richardson <bruce.richardson@intel.com>=0D
 T: git://dpdk.org/next/dpdk-next-net-intel=0D
diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst=0D
new file mode 100644=0D
index 0000000000..c9e49a2be2=0D
--- /dev/null=0D
+++ b/doc/guides/nics/hinic3.rst=0D
@@ -0,0 +1,51 @@=0D
+..  SPDX-License-Identifier: BSD-3-Clause=0D
+    Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+=0D
+HINIC Poll Mode Driver=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support=0D
+for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.=0D
+=0D
+Features=0D
+--------=0D
+=0D
+- Multi arch support: x86_64, ARMv8.=0D
+- Multiple queues for TX and RX=0D
+- Receiver Side Scaling (RSS)=0D
+- flow filtering=0D
+- Checksum offload=0D
+- TSO offload=0D
+- Promiscuous mode=0D
+- Port hardware statistics=0D
+- Link state information=0D
+- Link flow control=0D
+- Scattered and gather for TX and RX=0D
+- Allmulticast mode=0D
+- MTU update=0D
+- Multicast MAC filter=0D
+- Flow API=0D
+- Set Link down or up=0D
+- VLAN filter and VLAN offload=0D
+- SR-IOV - Partially supported at this point, VFIO only=0D
+- FW version=0D
+- LRO=0D
+=0D
+Prerequisites=0D
+-------------=0D
+=0D
+- Learning about Huawei Hi1823 Series Intelligent NICs using=0D
+  `<https://www.hikunpeng.com/compute/component/nic>`_.=0D
+=0D
+- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to se=
tup the basic DPDK environment.=0D
+=0D
+=0D
+Driver compilation and testing=0D
+------------------------------=0D
+=0D
+Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_bui=
ld_and_test>`=0D
+for details.=0D
+=0D
+Limitations or Known issues=0D
+---------------------------=0D
+X86-32, Windows, and BSD are not supported yet.=0D
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst=0D
index 57d161c526..1a1e3a6825 100644=0D
--- a/doc/guides/nics/index.rst=0D
+++ b/doc/guides/nics/index.rst=0D
@@ -33,6 +33,7 @@ Network Interface Controller Drivers=0D
     fm10k=0D
     gve=0D
     hinic=0D
+    hinic3=0D
     hns3=0D
     i40e=0D
     ice=0D
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/=
release_25_07.rst=0D
index b75405edf6..0821ca8b63 100644=0D
--- a/doc/guides/rel_notes/release_25_07.rst=0D
+++ b/doc/guides/rel_notes/release_25_07.rst=0D
@@ -160,6 +160,10 @@ New Features=0D
   (including out-of-tree nodes).=0D
   This minimizes footprint of node specific mbuf dynamic field.=0D
 =0D
+* **Added Huawei hinic3 net driver.**=0D
+=0D
+  * Added network driver for the Huawei SPx series Network Adapters.=0D
+=0D
 =0D
 Removed Items=0D
 -------------=0D
-- =0D
2.45.1.windows.1=0D
=0D

