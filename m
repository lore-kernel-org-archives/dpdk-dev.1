Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B73E9B35E
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:02:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9467B40DDC;
	Mon,  2 Mar 2026 12:02:19 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE40402B0
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:02:15 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=9PV5dzxObpDJMKkTy2Dq1N58CA0gliU9RQOcGonLdtQ=;
 b=Dc/n84h2GkW2y3hPVufsSmSaAbC+qFbNDzDjD7BbKOp7JRheGJG0QE6FBzFBijCFt/FzPWSTJ
 hkWnU9jSiR/yRJnZOrsZfoebdFTUsjqkb0Jrig+1Ki6n5q/tKh3LbQSecHlx7huzhLGkZJHWAqD
 VD7oR0TY0id8Y4RIkRejgXY=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fPbVl0qyMznTWT;
 Mon,  2 Mar 2026 18:57:35 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D8D6A40570;
 Mon,  2 Mar 2026 19:02:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Mar 2026 19:02:12 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <qianweili@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 2/2] dma/hisi_acc: support driver forward compatibility
Date: Mon, 2 Mar 2026 19:02:06 +0800
Message-ID: <20260302110206.49670-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260302110206.49670-1-fengchengwen@huawei.com>
References: <20260302110206.49670-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Declare support driver forward compatibility.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/dma/hisi_acc/hisi_acc_dmadev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/hisi_acc/hisi_acc_dmadev.c b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
index b9767d4a08..196aaadc05 100644
--- a/drivers/dma/hisi_acc/hisi_acc_dmadev.c
+++ b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
@@ -764,9 +764,10 @@ static const struct rte_uacce_id hacc_dma_id_table[] = {
 };
 
 static struct rte_uacce_driver hacc_dma_pmd_drv = {
-	.id_table = hacc_dma_id_table,
-	.probe    = hacc_dma_probe,
-	.remove   = hacc_dma_remove,
+	.id_table  = hacc_dma_id_table,
+	.probe     = hacc_dma_probe,
+	.remove    = hacc_dma_remove,
+	.drv_flags = RTE_UACCE_DRV_FORWARD_COMPATIBILITY_DEV,
 };
 
 RTE_PMD_REGISTER_UACCE(dma_hisi_acc, hacc_dma_pmd_drv);
-- 
2.17.1

