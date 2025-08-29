Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB5FC8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:25:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7809A4068A;
	Fri, 29 Aug 2025 10:24:47 +0200 (CEST)
Received: from lf-2-34.ptr.blmpb.com (lf-2-34.ptr.blmpb.com [101.36.218.34])
 by mails.dpdk.org (Postfix) with ESMTP id DC93240674
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455880; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cTYlZ5fjQ0WXCejfwwCNaUUEmk+CS2DdQB2IH1nRzLE=;
 b=HtNpwjpK6bWLUGsRiDVcb5ygC11MWABBkbJH0fIRtesBbYkR49/U7CS4xUKTMmBO+uSKKG
 RV0/tpOFk1JxjXSLNKvckmGlDxnw4Fz0hF0vkonjr6tFpqz6zZUTDqxCogJbJympFMamxJ
 ov4IG6g947w45wDLUDurw0prDbzveQ5L3/Kp37CYfcAZdIk74Fgux32YSDP9KGNbYvlGOb
 mqStwrlQGNm39KreJD66XmbzKle/rLTi6hHOHphl+nscB7cFnrsysM17tXlWcjWQ13KB9S
 Q1MO311a+c/PKX3xvccgFkzSJNVjM7sgg3I0103/4PuJAQ8IYxSNA62+ouadBw==
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:37 +0800
X-Lms-Return-Path: <lba+268b163c6+7da947+dpdk.org+wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
Date: Fri, 29 Aug 2025 16:24:37 +0800
Message-Id: <20250829082436.24369-14-wanry@yunsilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: <dev@dpdk.org>
Subject: [PATCH 13/14] net/xsc: fix uninitialized value
X-Mailer: git-send-email 2.25.1
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
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

Coverity reported this issue: Using uninitialized value mac when calling
xsc_ethdev_mac_addr_add.

Coverity issue: 456592
Fixes: 0b0f9c161e ("net/xsc: initialize representors")

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 6102c158e8..988d734b5b 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -886,7 +886,7 @@ xsc_ethdev_init_one_representor(struct rte_eth_dev *eth_dev, void *init_params)
 	struct xsc_repr_port *repr_port = (struct xsc_repr_port *)init_params;
 	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(eth_dev);
 	struct xsc_dev_config *config = &priv->config;
-	struct rte_ether_addr mac;
+	struct rte_ether_addr mac = priv->mac[0];
 
 	priv->repr_port = repr_port;
 	repr_port->drv_data = eth_dev;
-- 
2.25.1
