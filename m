Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEBACAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 11:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3228640E4C;
	Fri, 19 Sep 2025 13:25:52 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTP id 092CD40DDC
 for <dev@dpdk.org>; Fri, 19 Sep 2025 13:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=Ag6iDGi4WaluCnKp2qZnelmKloDEprT/dAQe6H1up2M=;
 b=gDPf8/X3Ps3jMVgxqXPhDG0kuwYxjd6xBeiTpegplInP95etAS7OppOaCeiDke
 2pGxBqS7E37xR+waNN4+1CcT30Tzw/FDpf0lVZdZmLS8CLhCb5s67+iSBmezbbIW
 5OCFkSRo1ere3my6S1ra5a64TgqzWBBtzhjE/oxl3tLrY=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAXb7yQPc1oTJ7bAw--.46410S22;
 Fri, 19 Sep 2025 19:25:44 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: gongfan1@huawei.com, Yi Chen <chenyi221@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: [V12 18/18] drivers/net: add hinic3 PMD build and doc files
Date: Fri, 19 Sep 2025 19:24:22 +0800
Message-ID: <20250919112433.17926-19-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250919112433.17926-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250919112433.17926-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXb7yQPc1oTJ7bAw--.46410S22
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWxKryDCFWrAF1UGrWDXFb_yoWrWF4Upw
 43A34fKr97JrW2qwnxtw1UAr4rJw4vkrWj9ws7GFyruF90kr10vw4Utay0v39rJ345ZFyr
 ZF1YvryakF1jqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jznmiUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiBgzNCmjM-7rjXQAAsS
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
 doc/guides/nics/features/hinic3.ini | 60 +++++++++++++++++++++++++++++
 doc/guides/nics/hinic3.rst          | 47 ++++++++++++++++++++++
 drivers/net/meson.build             |  1 +
 4 files changed, 109 insertions(+)
 create mode 100644 doc/guides/nics/features/hinic3.ini
 create mode 100644 doc/guides/nics/hinic3.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 8520e3ee70..91fc5da89e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -784,6 +784,7 @@ Huawei hinic3
 M: Feifei Wang <wangfeifei40@huawei.com>
 F: drivers/net/hinic3/
 F: doc/guides/nics/hinic3.rst
+F: doc/guides/nics/features/hinic3.ini
 
 Intel Network Common Code
 M: Bruce Richardson <bruce.richardson@intel.com>
diff --git a/doc/guides/nics/features/hinic3.ini b/doc/guides/nics/features/hinic3.ini
new file mode 100644
index 0000000000..50012ca696
--- /dev/null
+++ b/doc/guides/nics/features/hinic3.ini
@@ -0,0 +1,60 @@
+;
+; Supported features of the 'hinic3' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Speed capabilities   = Y
+Link speed configuration = Y
+Link status          = Y
+Link status event    = Y
+Rx interrupt         = Y
+Queue start/stop     = Y
+Runtime Rx queue setup = Y
+Runtime Tx queue setup = Y
+Burst mode info      = Y
+Fast mbuf free       = Y
+Free Tx mbuf on demand = Y
+MTU update           = Y
+Scattered Rx         = Y
+TSO                  = Y
+LRO                  = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+Unicast MAC filter   = Y
+Multicast MAC filter = Y
+RSS hash             = Y
+RSS key update       = Y
+RSS reta update      = Y
+VLAN filter          = Y
+Flow control         = Y
+Traffic manager      = Y
+CRC offload          = Y
+FEC                  = Y
+L3 checksum offload  = Y
+L4 checksum offload  = Y
+Inner L3 checksum    = Y
+Inner L4 checksum    = Y
+Packet type parsing  = Y
+Basic stats          = Y
+Extended stats       = Y
+Stats per queue      = Y
+FW version           = Y
+Registers dump       = Y
+Timesync             = Y
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
index 0000000000..0eebcf0723
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

