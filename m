Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC00CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 03:56:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE078402C8;
	Wed, 20 May 2026 05:56:52 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 8123A402C8
 for <dev@dpdk.org>; Wed, 20 May 2026 05:56:51 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=WUcl/OiGYARxYtQGjAWXwPhlHtfBeXUkeEdbVchp84c=;
 b=4rr9vtrZR++Oy1g6iH2RQWKMQUZpvQt1/KgeDW4lgef/VxqdLfWh3gxYSO2Com9APmwxAwRXJ
 XUmGH+ugm6seII0xWsMmHtd8XSz5oAP9VkqsHaXlvQQ+xkmpDQRCdBujMvut91n0xP54Rn12AZn
 HaXjKfqMPfExDnWcJxn7v+o=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gKyGg1DLkz12LhT;
 Wed, 20 May 2026 11:49:47 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 779FE40538;
 Wed, 20 May 2026 11:56:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 11:56:48 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH 2/2] ethdev: include device name in telemetry list output
Date: Wed, 20 May 2026 11:56:41 +0800
Message-ID: <20260520035641.50555-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260520035641.50555-1-fengchengwen@huawei.com>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

The /ethdev/list telemetry endpoint currently returns only port IDs
as integers. Enhance it to return strings in "ID    NAME" format so
users can identify ports by name directly from the telemetry output.

Original:
  {
    "/ethdev/list": [
      0,
      1
    ]
  }

After this commit:
  {
    "/ethdev/list": [
      "0    0000:7d:00.0",
      "1    0000:7d:00.1"
    ]
  }

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ethdev/rte_ethdev_telemetry.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/ethdev/rte_ethdev_telemetry.c b/lib/ethdev/rte_ethdev_telemetry.c
index a910864bc5..f82b174110 100644
--- a/lib/ethdev/rte_ethdev_telemetry.c
+++ b/lib/ethdev/rte_ethdev_telemetry.c
@@ -53,11 +53,17 @@ eth_dev_handle_port_list(const char *cmd __rte_unused,
 		const char *params __rte_unused,
 		struct rte_tel_data *d)
 {
+	char id_name[RTE_TEL_MAX_STRING_LEN];
+	struct rte_eth_dev *dev;
 	int port_id;
 
-	rte_tel_data_start_array(d, RTE_TEL_INT_VAL);
-	RTE_ETH_FOREACH_DEV(port_id)
-		rte_tel_data_add_array_int(d, port_id);
+	rte_tel_data_start_array(d, RTE_TEL_STRING_VAL);
+	RTE_ETH_FOREACH_DEV(port_id) {
+		dev = &rte_eth_devices[port_id];
+		memset(id_name, 0, sizeof(id_name));
+		sprintf(id_name, "%d    %s", port_id, dev->data->name);
+		rte_tel_data_add_array_string(d, id_name);
+	}
 	return 0;
 }
 
-- 
2.17.1

