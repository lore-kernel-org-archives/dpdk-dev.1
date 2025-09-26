Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B1FCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 02:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 654BA40E34;
	Fri, 26 Sep 2025 04:48:38 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 0247640DD6
 for <dev@dpdk.org>; Fri, 26 Sep 2025 04:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=FrchONvinaAfzzQv86C0tukhKN8AdmprgkR/xE1ajEE=;
 b=OjWjOIvIlJXiTw+K9AEc8MPnnzwrK3A9WOTlwnUlK8M0/5i6o+N33SrLcGha/Q
 0AbaYPFMTkNaY3x/lSYidOz/1kQ6zReWE100hdf/9xY5gs9BLHucF65E0vqRau7J
 BmRE76cNmi1UkNwZ5FlFsYjvtlhVZvla6dLO3Yh5z+7AQ=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgA3nrvk_tVojsdDBA--.48533S22;
 Fri, 26 Sep 2025 10:48:29 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: gongfan1@huawei.com, Yi Chen <chenyi221@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: [V14 18/18] drivers/net: add hinic3 PMD build and doc files
Date: Fri, 26 Sep 2025 10:47:34 +0800
Message-ID: <20250926024747.1314-19-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250926024747.1314-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250926024747.1314-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgA3nrvk_tVojsdDBA--.48533S22
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWxKryDCw1kXFW8tFWfGrg_yoWrXr4kpa
 13A34fKr9rG3y2vwnxtw1UAr4rXw4vkFWj9w4xJFyrZF90kr10vw48Kay0y39rJ34UZFyS
 vF1YvryakF1jqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jO9N3UUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHw-UCmjVqPrjHAABsf
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

The hinic3.ini file and hinic3.rst file are added to this patch.

Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
---
 MAINTAINERS                         |  1 +
 doc/guides/nics/features/hinic3.ini | 51 +++++++++++++++++++++++++++++
 doc/guides/nics/hinic3.rst          | 47 ++++++++++++++++++++++++++
 drivers/net/meson.build             |  1 +
 4 files changed, 100 insertions(+)
 create mode 100644 doc/guides/nics/features/hinic3.ini
 create mode 100644 doc/guides/nics/hinic3.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index e24fbcccbb..3719ff5143 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -786,6 +786,7 @@ Huawei hinic3
 M: Feifei Wang <wangfeifei40@huawei.com>
 F: drivers/net/hinic3/
 F: doc/guides/nics/hinic3.rst
+F: doc/guides/nics/features/hinic3.ini
 
 Intel Network Common Code
 M: Bruce Richardson <bruce.richardson@intel.com>
diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
new file mode 100644
index 0000000000..bc70c887cb
--- /dev/null
+++ b/doc/guides/nics/features/hinic3.ini
@@ -0,0 +1,51 @@
+;
+; Supported features of the 'hinic3' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Speed capabilities   = Y
+Link speed configuration = Y
+Link status          = Y
+Rx interrupt         = Y
+Queue start/stop     = Y
+Runtime Rx queue setup = Y
+Runtime Tx queue setup = Y
+MTU update           = Y
+Scattered Rx         = Y
+TSO                  = Y
+LRO                  = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+Unicast MAC filter   = Y
+Multicast MAC filter = Y
+RSS hash             = Y
+RSS reta update      = Y
+VLAN filter          = Y
+Flow control         = Y
+CRC offload          = Y
+L3 checksum offload  = Y
+L4 checksum offload  = Y
+Inner L3 checksum    = Y
+Inner L4 checksum    = Y
+Packet type parsing  = Y
+Basic stats          = Y
+Extended stats       = Y
+Stats per queue      = Y
+FW version           = Y
+Multiprocess aware   = Y
+Linux                = Y
+x86-64               = Y
+ARMv8                = Y
+
+[rte_flow items]
+any                  = Y
+eth                  = Y
+icmp                 = Y
+ipv4                 = Y
+ipv6                 = Y
+tcp                  = Y
+udp                  = Y
+vxlan                = Y
+[rte_flow actions]
+queue                = Y
diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
new file mode 100644
index 0000000000..87dec019bd
--- /dev/null
+++ b/doc/guides/nics/hinic3.rst
@@ -0,0 +1,47 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2025 Huawei Technologies Co., Ltd
+
+HINIC3 Poll Mode Driver
+=======================
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
+- Flow filtering
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
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 61f8cddb30..2d32068ed2 100644
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

