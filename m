Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D08C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43FCA42D2B;
	Sat, 22 Feb 2025 04:58:06 +0100 (CET)
Received: from lf-1-16.ptr.blmpb.com (lf-1-16.ptr.blmpb.com [103.149.242.16])
 by mails.dpdk.org (Postfix) with ESMTP id 62CBE42D7B
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196677; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=RR5NLd98UEnFjrc8ll3ihmGNdxG2Oxo/jng/h35px1M=;
 b=HKEH2kGfDpI2f4yB8DmTEsyIfiww0QdelTAPnxTH3Ez2PKObd5o4yTY5CMnZ6WpgmVaxlg
 r4UtKLHYSeoDqajO8GZuIL/r632yFBf6MUYAsODk+erAeD6jTil0boBL7GHNSXfWyuMUuO
 vl3zmHTlCA36a2rq899qxfg8rymL104zVk7IRYvQDjmUMxYsmfMzAwC6GFOL2NkFU7q0/s
 x7wO0ZdTYT7nWucpIPA8ifdnWDBjjLsKZye+MWV385Uwz1YxrKUL4HoOO2vN7UKyS/x+9Y
 oQ8h+qs/FLeGw1YO3dBMHZNkWYZUjFTVBVCC6JKytjRT+qZAslYTacP/jjpBRg==
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+267b94b43+ade8d0+dpdk.org+wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:54 +0800
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Subject: [PATCH 11/12] net/xsc: optimize memcmp returns not 0 check
Date: Sat, 22 Feb 2025 11:57:55 +0800
Message-Id: <20250222035753.2290067-12-wanry@yunsilicon.com>
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
https://pvs-studio.com/en/docs/warnings/v526/

Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 44d861e484..28af9c5d15 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -663,7 +663,7 @@ xsc_ethdev_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac, uin
 	for (i = 0; i != XSC_MAX_MAC_ADDRESSES; ++i) {
 		if (i == (int)index)
 			continue;
-		if (memcmp(&dev->data->mac_addrs[i], mac, sizeof(*mac)))
+		if (memcmp(&dev->data->mac_addrs[i], mac, sizeof(*mac)) != 0)
 			continue;
 		/* Address already configured elsewhere, return with error */
 		rte_errno = EADDRINUSE;
-- 
2.25.1
