Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F57CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 07:53:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03CBD4067C;
	Wed, 24 Sep 2025 09:53:40 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 4D38040613
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=/wtgcq9dQdDSnQQVRCgRAgxuuzaPcXVlvx6Eiv6MmJU=;
 b=SM9b4TsvIMw0c5wqXY+tWb/ZAh9iBix3vFus+hENNZT1oaEClRAVRC3mu8scFm
 Fb5u1mBmHgm97OPw8+yU/TzDgmsDYmIVymM2U3kK3/TnN8sMbjxkV0mXtdegDyC0
 hrAMN08LHI5m75PTnDQyMJMFw8z7R+I89jayvFGtuMIC0=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDnT+VCo9No80coBA--.31336S5;
 Wed, 24 Sep 2025 15:53:34 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: gongfan1@huawei.com, Yi Chen <chenyi221@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Xin Wang <wangxin679@h-partners.com>
Subject: [V13 01/18] doc: add hinic3 driver
Date: Wed, 24 Sep 2025 15:51:48 +0800
Message-ID: <20250924075216.18750-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250924075216.18750-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250924075216.18750-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDnT+VCo9No80coBA--.31336S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW5uw43Cr47JFy5Cw1kAFb_yoW5CrW7pa
 18CryrCFyrGw1rurnxt3W7uryUCas5u3y8uFW8ta4rXFnxGr1Y9w48Kw429ayDJF1F9ay3
 Zr12gryIk3WjvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOL0nUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHxrSCmjTYMDXMAAAsh
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
 .mailmap                               | 4 +++-
 MAINTAINERS                            | 4 ++++
 doc/guides/nics/index.rst              | 1 +
 doc/guides/rel_notes/release_25_11.rst | 4 ++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 0b043cb0c0..12c9da40af 100644
--- a/.mailmap
+++ b/.mailmap
@@ -446,7 +446,7 @@ Fang TongHao <fangtonghao@sangfor.com.cn>
 Fan Zhang <fanzhang.oss@gmail.com> <roy.fan.zhang@intel.com>
 Farah Smith <farah.smith@broadcom.com>
 Fei Chen <chenwei.0515@bytedance.com>
-Feifei Wang <feifei.wang2@arm.com> <feifei.wang@arm.com>
+Feifei Wang <wangfeifei40@huawei.com> <feifei.wang1218@gmail.com> <feifei.wang2@arm.com> <feifei.wang@arm.com> <wff_light@vip.163.com>
 Fei Qin <fei.qin@corigine.com>
 Fengjiang Liu <liufengjiang.0426@bytedance.com>
 Fengnan Chang <changfengnan@bytedance.com>
@@ -1777,6 +1777,7 @@ Xingui Yang <yangxingui@huawei.com>
 Xingyou Chen <niatlantice@gmail.com>
 Xing Wang <xing_wang@realsil.com.cn>
 Xinying Yu <xinying.yu@corigine.com>
+Xin Wang <wangxin679@h-partners.com>
 Xin Long <longxin.xl@alibaba-inc.com>
 Xi Zhang <xix.zhang@intel.com>
 Xuan Ding <xuan.ding@intel.com>
@@ -1811,6 +1812,7 @@ Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
 Yicai Lu <luyicai@huawei.com>
+Yi Chen <chenyi221@huawei.com>
 Yiding Zhou <yidingx.zhou@intel.com>
 Yijun Geng <1204565380@qq.com>
 Yi Li <liyi1@chinatelecom.cn>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2729be66..25530b9cf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -782,6 +782,10 @@ F: drivers/net/hinic/
 F: doc/guides/nics/hinic.rst
 F: doc/guides/nics/features/hinic.ini
 
+Huawei hinic3
+M: Feifei Wang <wangfeifei40@huawei.com>
+F: doc/guides/nics/hinic3.rst
+
 Intel Network Common Code
 M: Bruce Richardson <bruce.richardson@intel.com>
 T: git://dpdk.org/next/dpdk-next-net-intel
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
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index efb88bbbb0..19048f9cbc 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -76,6 +76,10 @@ New Features
   * Added multi-process per port.
   * Optimized code.
 
+* **Added Huawei hinic3 net driver.**
+
+  * Added network driver for the Huawei SPx series Network Adapters.
+
 
 Removed Items
 -------------
-- 
2.47.0.windows.2

