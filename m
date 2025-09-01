Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E0ACA1002
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 11:14:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28A9240DD7;
	Mon,  1 Sep 2025 13:12:35 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 232C140B90
 for <dev@dpdk.org>; Mon,  1 Sep 2025 13:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=iIvjk0l/JS41VSUBxneh3P+7ZnN7+vDUFoaOGGuGwEc=;
 b=C1gD35au5l7Lshm10YFp/wcnE9jlEjqyUPmkoXu1s4JOYOGlJ2wnrUAQoxMr9O
 94dLS+4bLITNooXH9pQhvVcnRzID2Okyl2S6Wgi5wPojRh8bXhdhqzCVOZN3XVDM
 Jf5gWX0E/knqHndhs1+5b1QnRy1SLTwIk1sVw/qWiYKic=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgDnT6lXf7Vo9Y1rAQ--.56050S21;
 Mon, 01 Sep 2025 19:12:26 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V7 17/17] drivers/net: add hinic3 PMD build and doc files
Date: Mon,  1 Sep 2025 19:10:50 +0800
Message-ID: <20250901111102.9280-18-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250901111102.9280-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250901111102.9280-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDnT6lXf7Vo9Y1rAQ--.56050S21
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4xGw18trW7tw1Dtw4DCFg_yoW5JrW3pa
 1UA3yFkryxGr47XwnxtF17ArZ5Xw4vkFWUu39rCa4YvF98Gr1UZw4jyayIvrZrX34IvF1S
 9F1Svr9Ikr1jqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeOJ5UUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAgW7Cmi1f5QAEgAAsS
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

The hinic3.ini file is added to this patch.

Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
---
 MAINTAINERS                         |  1 +
 doc/guides/nics/features/hinic3.ini | 60 +++++++++++++++++++++++++++++
 drivers/net/meson.build             |  1 +
 3 files changed, 62 insertions(+)
 create mode 100644 doc/guides/nics/features/hinic3.ini

diff --git a/MAINTAINERS b/MAINTAINERS
index be7c815f11..80c43e8465 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -783,6 +783,7 @@ Huawei hinic3
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

