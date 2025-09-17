Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049E6CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 10:16:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00A4540612;
	Wed, 17 Sep 2025 12:16:35 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 4C5C640144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 12:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=8mvGGkCtutK8aqZEr/C+R5TTeUsD4QJoe6iGr1jGRY4=;
 b=lppVfWCjHXHA3AK7gV83SIc66Sm7oYzW2AH1LVeVtfp+APkbqGeO6yXKpVib0M
 2Jt815qEnXQm3F4z3a8/IKysBV7S9X8qUZiDZcElrpt03oPG9HDFxDAx6Qbh6AZs
 zXM2GbTUetCwEgDjFybb8LPVCjq2ncRTLy2lG68hj9nZc=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgBXohZzispo0ZVGAg--.58210S5;
 Wed, 17 Sep 2025 18:16:30 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>
Subject: [V11 01/18] doc: add hinic3 driver
Date: Wed, 17 Sep 2025 18:15:35 +0800
Message-ID: <20250917101604.17045-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250917101604.17045-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250917101604.17045-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgBXohZzispo0ZVGAg--.58210S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW5uw43Cr47JFy5Cw1kAFb_yoW5CrW7pa
 1UCryrCFyrGw4rurn8t3W7uryUGa4Duay8uFW8ta4rXFnxGr1jgw48Kw42kayDJF1F9ay3
 Zr12gryIk3WjvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiTmDUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAw7LCmjKUX77gwAAs5
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
index cf7993fd4e..a695d47c8d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -445,7 +445,7 @@ Fang TongHao <fangtonghao@sangfor.com.cn>
 Fan Zhang <fanzhang.oss@gmail.com> <roy.fan.zhang@intel.com>
 Farah Smith <farah.smith@broadcom.com>
 Fei Chen <chenwei.0515@bytedance.com>
-Feifei Wang <feifei.wang2@arm.com> <feifei.wang@arm.com>
+Feifei Wang <wangfeifei40@huawei.com> <feifei.wang1218@gmail.com> <feifei.wang2@arm.com> <feifei.wang@arm.com> <wff_light@vip.163.com>
 Fei Qin <fei.qin@corigine.com>
 Fengjiang Liu <liufengjiang.0426@bytedance.com>
 Fengnan Chang <changfengnan@bytedance.com>
@@ -1775,6 +1775,7 @@ Xingui Yang <yangxingui@huawei.com>
 Xingyou Chen <niatlantice@gmail.com>
 Xing Wang <xing_wang@realsil.com.cn>
 Xinying Yu <xinying.yu@corigine.com>
+Xin Wang <wangxin679@h-partners.com>
 Xin Long <longxin.xl@alibaba-inc.com>
 Xi Zhang <xix.zhang@intel.com>
 Xuan Ding <xuan.ding@intel.com>
@@ -1809,6 +1810,7 @@ Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
 Yicai Lu <luyicai@huawei.com>
+Yi Chen <chenyi221@huawei.com>
 Yiding Zhou <yidingx.zhou@intel.com>
 Yijun Geng <1204565380@qq.com>
 Yi Li <liyi1@chinatelecom.cn>
diff --git a/MAINTAINERS b/MAINTAINERS
index fd591d9d5a..e976b79761 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -780,6 +780,10 @@ F: drivers/net/hinic/
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

