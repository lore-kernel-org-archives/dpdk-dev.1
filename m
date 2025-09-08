Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F27BCAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 13:53:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C8E240662;
	Mon,  8 Sep 2025 15:53:34 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id DD3DF402EE
 for <dev@dpdk.org>; Mon,  8 Sep 2025 15:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=T7mKipBdp9IPTT6EdkxMUx/jVq0rqfABxERcTX7xTb4=;
 b=I6OHjvzWBskPnPa6b43D7JMDe7NFNueG8BPQTEsZFlJdEHG9R5z/o1V3eruA8p
 xGKbgK2xiMojBsft/47gpSVcmanpkmnCN8Qc1nJ7Q+T4X1lcHtwiUAfDBcTd0K+N
 Axr6L/cJIE/Ifl5OChWNbi6fXijVN/Gufc1WjoRCgy1EI=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDXbbu9375oixA8Aw--.20503S5;
 Mon, 08 Sep 2025 21:53:23 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>
Subject: [V8 01/17] doc: add hinic3 driver
Date: Mon,  8 Sep 2025 21:52:09 +0800
Message-ID: <20250908135236.11873-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250908135236.11873-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250908135236.11873-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDXbbu9375oixA8Aw--.20503S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW5tr18tFWDXFyruF18AFb_yoW5Zr4Dpw
 4DCryfCFyrK34rurnIy3W7Zr1UCas5G3y8uFW8ta45XFnxGr4jgw48Ka12yayDGF1F9ay3
 Zr1jgrySk3WjvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0fOwUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiJh7CCmi+3UsGEQAAsn
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
 doc/guides/rel_notes/release_25_11.rst | 3 +++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index d4c04f3b81..8062ec42d7 100644
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
@@ -1771,6 +1771,7 @@ Xingguang He <xingguang.he@intel.com>
 Xingyou Chen <niatlantice@gmail.com>
 Xing Wang <xing_wang@realsil.com.cn>
 Xinying Yu <xinying.yu@corigine.com>
+Xin Wang <wangxin679@h-partners.com>
 Xin Long <longxin.xl@alibaba-inc.com>
 Xi Zhang <xix.zhang@intel.com>
 Xuan Ding <xuan.ding@intel.com>
@@ -1805,6 +1806,7 @@ Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
 Yevgeny Kliteynik <kliteyn@nvidia.com>
 Yicai Lu <luyicai@huawei.com>
+Yi Chen <chenyi221@huawei.com>
 Yiding Zhou <yidingx.zhou@intel.com>
 Yi Li <liyi1@chinatelecom.cn>
 Yi Liu <yi.liu@nxp.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 7aca98c537..ea71eac351 100644
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
index 32d61691d2..f782ada7d3 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -54,6 +54,9 @@ New Features
      This section is a comment. Do not overwrite or remove it.
      Also, make sure to start the actual text at the margin.
      =======================================================
+* **Added Huawei hinic3 net driver.**
+
+  * Added network driver for the Huawei SPx series Network Adapters.
 
 
 Removed Items
-- 
2.47.0.windows.2

