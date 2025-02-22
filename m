Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA95C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:58:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50B3F427DA;
	Sat, 22 Feb 2025 04:57:51 +0100 (CET)
Received: from lf-1-14.ptr.blmpb.com (lf-1-14.ptr.blmpb.com [103.149.242.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9D4F14027D
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196662; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=oxXpR40vZf4rx85Ui4c8wb3BLAqkpzqIAUZF85rIdMY=;
 b=PdbwG5gQVqmYUD5gQApIbudyLafB7LAkParZLBCaAuaD9mtwUVmNMztJhiCDTvRaXWWm7n
 9UDi0X9Spj0dWt4rEXnFVxnlik8JUEqSGc2kAjphgzm5fcb4GNMegsaInlWYtyx5JJ16at
 Ya3m2wnJfem1tFb9dyivEWZKeSOwxK2z+7fBO2arWh4QEPp574LdNfnwJm0iQh/F/CDdnz
 hHz7WIg0J1ZF62oKlrYI6F5xLWCevomTraEjLfUldK9v1xi2S/pRK1HXTsYC2WEKRcB62E
 4vJhIoy0ZFQMGqdMOKT246VLPC/uXr+uIglz4Zk3thdAYGMLU5Z8OI3typWJ+g==
X-Lms-Return-Path: <lba+267b94b34+784ad7+dpdk.org+wanry@yunsilicon.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1
Message-Id: <20250222035738.2290067-5-wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 04/12] net/xsc: remove always-true if expressions
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:39 +0800
To: <dev@dpdk.org>
Date: Sat, 22 Feb 2025 11:57:40 +0800
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
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

This issue was reported by PVS studio, described as:
https://pvs-studio.com/en/docs/warnings/v547/

Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_ethdev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index b9675a5218..0729d43884 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -721,16 +721,13 @@ xsc_ethdev_init_one_representor(struct rte_eth_dev *eth_dev, void *init_params)
 		config->tso = 0;
 	} else {
 		config->tso = 1;
-		if (config->tso)
-			config->tso_max_payload_sz = 1500;
+		config->tso_max_payload_sz = 1500;
 	}
 
-	priv->is_representor = (priv->eth_type == RTE_ETH_REPRESENTOR_NONE) ? 0 : 1;
-	if (priv->is_representor) {
-		eth_dev->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR;
-		eth_dev->data->representor_id = priv->representor_id;
-		eth_dev->data->backer_port_id = eth_dev->data->port_id;
-	}
+	priv->is_representor = 1;
+	eth_dev->data->dev_flags |= RTE_ETH_DEV_REPRESENTOR;
+	eth_dev->data->representor_id = priv->representor_id;
+	eth_dev->data->backer_port_id = eth_dev->data->port_id;
 
 	eth_dev->dev_ops = &xsc_eth_dev_ops;
 	eth_dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
-- 
2.25.1
