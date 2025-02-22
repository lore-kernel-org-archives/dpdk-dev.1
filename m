Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A2C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:58:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87E38427E6;
	Sat, 22 Feb 2025 04:57:52 +0100 (CET)
Received: from lf-1-20.ptr.blmpb.com (lf-1-20.ptr.blmpb.com [103.149.242.20])
 by mails.dpdk.org (Postfix) with ESMTP id 74EDF4027D
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196664; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=87oBB3StuGvA33q6vdcvOawwd2+oHc6Jy6iSsq5FUok=;
 b=StDIiC/Ul+0NCfTUeLloqIweEqXLcknxP5Y69g9qjxNgjcySPyKSr7Ps1nhG0Yg/TWNZFX
 C6f0Bvr/emvqtg8x07zgpfOSl5lJLQn3LVscYisVGvRm6e92yCrOMLZroCEjZqf/W0E3nj
 nVjcmqZc45uh18fwr2pZgLDMzdAw3kQwEICzn/5chVdFBVsG8kPD2b86E3VqAKDpMkUetI
 Q/KOQIsmoYJc1NcMX6VyOBwoV+Pzpg4zTHOi5TGDQHtQnLvIfY9lqYk3ryekJQnFvG1mpa
 ktsoMjfo7GjFJEBiXNwXYcbygsFasLrKica/IFvfzcYlWr1if8bELOb7TOmSAQ==
X-Lms-Return-Path: <lba+267b94b36+054d86+dpdk.org+wanry@yunsilicon.com>
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Message-Id: <20250222035740.2290067-6-wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Subject: [PATCH 05/12] net/xsc: avoid variable is assigned but not used
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:41 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
To: <dev@dpdk.org>
Date: Sat, 22 Feb 2025 11:57:42 +0800
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
https://pvs-studio.com/en/docs/warnings/v1001/

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 0729d43884..d04fe78d3f 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -314,6 +314,11 @@ xsc_ethdev_start(struct rte_eth_dev *dev)
 	dev->tx_pkt_burst = xsc_tx_burst;
 
 	ret = xsc_ethdev_enable(dev);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to enable port: %u",
+			    dev->data->port_id);
+		goto error;
+	}
 
 	return 0;
 
-- 
2.25.1
