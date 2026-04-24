Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD130FE5202
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:48:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA63B402BE;
	Fri, 24 Apr 2026 12:48:39 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 1F984402A0;
 Fri, 24 Apr 2026 12:48:38 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=bHQxi+q+kShepY11mspkZed0joVHWfVtmcSc2jFxhJg=;
 b=UrXZUZi/kABeJUG6kM76qpr0BB8ZLMuswVvdPKhCgV49SCi9F9TvXNaKfC5GJNLc5AD8QRReg
 RofxtedO0slg2yLE4pWpqJQwifJCSs8JODbFfrS6rNMFgcVr7Xb/TxZe7xFeSwoCY0QsVNLmOEO
 6dRCknww6UPKZ0UI2nKO6uU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g28fk713dznTWt;
 Fri, 24 Apr 2026 18:42:22 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id B2D3C40563;
 Fri, 24 Apr 2026 18:48:35 +0800 (CST)
Received: from kwepemq100013.china.huawei.com (7.202.195.192) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Apr 2026 18:48:35 +0800
Received: from localhost (10.174.243.191) by kwepemq100013.china.huawei.com
 (7.202.195.192) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Apr
 2026 18:48:35 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <dev@dpdk.org>
CC: <matan@nvidia.com>, <suanmingm@nvidia.com>, <rasland@nvidia.com>,
 <viacheslavo@nvidia.com>, <dsosnowski@nvidia.com>,
 <jerry.lilijun@huawei.com>, Yunjian Wang <wangyunjian@huawei.com>,
 <stable@dpdk.org>
Subject: [PATCH 1/1] net/mlx5: fix crash if malloc FCQS fails
Date: Fri, 24 Apr 2026 18:48:33 +0800
Message-ID: <1777027713-91888-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.243.191]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100013.china.huawei.com (7.202.195.192)
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

A crash is triggered when memory malloc for FCQS fails. Currently,
the abnormal branch releases the txq, and it removes the 'txq_ctrl->obj'
from the linked list, but the 'txq_ctrl->obj' has not actually been
added to the linked list yet. This triggers a null pointer reference
issue.

The call stack is as follows:
Program terminated with signal 11, Segmentation fault.
1210			LIST_REMOVE(txq_ctrl->obj, next);
(gdb) bt
 #0 mlx5_txq_release
 #1 mlx5_txq_start
 #2 mlx5_dev_start
 #3 rte_eth_dev_start
 #4 member_start
 #5 bond_ethdev_start

Fixes: f49f44839df3 ("net/mlx5: share Tx control code")
Cc: stable@dpdk.org

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index a070aaecfd..594b518ba6 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -97,6 +97,9 @@ mlx5_txq_start(struct rte_eth_dev *dev)
 					DRV_LOG(ERR, "Port %u Tx queue %u cannot "
 						"allocate memory (FCQ).",
 						dev->data->port_id, i);
+					priv->obj_ops.txq_obj_release(txq_ctrl->obj);
+					mlx5_free(txq_ctrl->obj);
+					txq_ctrl->obj = NULL;
 					rte_errno = ENOMEM;
 					goto error;
 				}
-- 
2.33.0

