Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE658D6ACE5
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 10:57:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 955CC40275;
	Thu, 18 Dec 2025 11:57:46 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id D7A444026A;
 Thu, 18 Dec 2025 11:57:43 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XpmB43MEbIhTRiGRwBBEWpIJ9XTrtjn3NaU0mBAgeTc=;
 b=rq7ntrZ3ywMoDWaE48DKUCJL2BcsK5UXac+g7Pb+5d5H1styseExVpttg3sbJ8Qe+BuHzf5s9
 CKRJ0eUbAwvngLSQ/JpfajzuLaA6Dno19+ssLY0KsRHYVruiJIYMp8MxSp2imZuv8FnPA+JEjMl
 mB7P/+oB5j24TFy3qNW+4dg=
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dX6xT3nZGz1cyPb;
 Thu, 18 Dec 2025 18:54:37 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 56C471402C3;
 Thu, 18 Dec 2025 18:57:40 +0800 (CST)
Received: from kwepemq100013.china.huawei.com (7.202.195.192) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 18:57:40 +0800
Received: from localhost (10.174.243.191) by kwepemq100013.china.huawei.com
 (7.202.195.192) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Dec
 2025 18:57:39 +0800
From: Yunjian Wang <wangyunjian@huawei.com>
To: <dev@dpdk.org>
CC: <matan@nvidia.com>, <suanmingm@nvidia.com>, <jerry.lilijun@huawei.com>,
 Yunjian Wang <wangyunjian@huawei.com>, <stable@dpdk.org>
Subject: [PATCH v2] net/mlx5: fix memoy leak after device spawn failure
Date: Thu, 18 Dec 2025 18:57:26 +0800
Message-ID: <1766055446-41476-1-git-send-email-wangyunjian@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.1
In-Reply-To: <1766050280-21036-1-git-send-email-wangyunjian@huawei.com>
References: <1766050280-21036-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.243.191]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
v2: fix code styles
---
 drivers/net/mlx5/linux/mlx5_os.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7f73183bb1..7624b2aba2 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1831,6 +1831,11 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 			close(priv->nl_socket_route);
 		if (priv->vmwa_context)
 			mlx5_vlan_vmwa_exit(priv->vmwa_context);
+		for (i = 0; i < MLX5_FLOW_TYPE_MAXI; i++) {
+			if (!priv->flows[i])
+				continue;
+			mlx5_ipool_destroy(priv->flows[i]);
+		}
 		if (eth_dev && priv->drop_queue.hrxq)
 			mlx5_drop_action_destroy(eth_dev);
 		if (priv->mtr_profile_tbl)
-- 
2.33.0

