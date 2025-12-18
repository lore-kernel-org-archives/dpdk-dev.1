Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA97DD6ACD7
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 09:31:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C126640275;
	Thu, 18 Dec 2025 10:31:34 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 0A71F4026A;
 Thu, 18 Dec 2025 10:31:33 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=CvlqttTerFAYq8vtdxluWsVN7bub75I5i9NdZxIeIu4=;
 b=0U0DGe61mtBtY2G/x9RE0jo/zB35YSv3ME1+3eBYcXeWZYfdHNtXOYrLyI5OPiBQPTwLCUrvp
 9rJi0dMdGk2cPmbLP5JUE5JucaCeHPggPGtS1SbtF9FXQs+CY92YwTAlYA7Ev2S1CmNj20rkTtq
 7VrQD2wavzQwvcgaGYEMQew=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dX52N1Fq1zpSvn;
 Thu, 18 Dec 2025 17:28:44 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 17DB514022E;
 Thu, 18 Dec 2025 17:31:30 +0800 (CST)
Received: from kwepemq100013.china.huawei.com (7.202.195.192) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 17:31:29 +0800
Received: from localhost (10.174.243.191) by kwepemq100013.china.huawei.com
 (7.202.195.192) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Dec
 2025 17:31:29 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <dev@dpdk.org>
CC: <matan@nvidia.com>, <suanmingm@nvidia.com>, <jerry.lilijun@huawei.com>,
 Yunjian Wang <wangyunjian@huawei.com>, <stable@dpdk.org>
Subject: [PATCH 1/1] net/mlx5: fix memoy leak after device spawn failure
Date: Thu, 18 Dec 2025 17:31:20 +0800
Message-ID: <1766050280-21036-1-git-send-email-wangyunjian@huawei.com>
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

In mlx5_dev_spawn() allocated memory for the 'priv->flows',
we should free it when errors occur, otherwise it will lead
to memory leak.

Fixes: b4edeaf3efd5 ("net/mlx5: replace flow list with indexed pool")
Cc: stable@dpdk.org

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7f73183bb1..10b59e779a 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1831,6 +1831,11 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			close(priv->nl_socket_route);
 		if (priv->vmwa_context)
 			mlx5_vlan_vmwa_exit(priv->vmwa_context);
+                for (i = 0; i < MLX5_FLOW_TYPE_MAXI; i++) {
+                        if (!priv->flows[i])
+                                continue;
+                        mlx5_ipool_destroy(priv->flows[i]);
+                }
 		if (eth_dev && priv->drop_queue.hrxq)
 			mlx5_drop_action_destroy(eth_dev);
 		if (priv->mtr_profile_tbl)
-- 
2.33.0

