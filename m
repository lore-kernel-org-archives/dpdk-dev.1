Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B03FCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 09:38:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FC2D40609;
	Wed, 20 May 2026 11:38:15 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 4D2AB40276
 for <dev@dpdk.org>; Wed, 20 May 2026 11:38:11 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=FnOpAI9hS6xidjxkCkTVZboYpAmCopTvKll7ekTPdxI=;
 b=5hjqEX8NXORTSViLUYTyxuB4WWhwdTMUWBwQ1fae6yDKbimLE/cZSh5ouYgwzliH275tPnaPc
 FVtdulB4Jo/FxZde33A+SJKY4tHNSOqTCwDxjuK03dpmxDx1GE16WobOHDppH0HX5oUVROPhtql
 /WPJdjxzfFCd31iC+F9jKl4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gL5qm5K1qzLlSM;
 Wed, 20 May 2026 17:30:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B33ED4056E;
 Wed, 20 May 2026 17:38:09 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 17:38:09 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
Subject: [PATCH v2 1/2] dmadev: add telemetry endpoint for list names
Date: Wed, 20 May 2026 17:38:03 +0800
Message-ID: <20260520093804.29102-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260520093804.29102-1-fengchengwen@huawei.com>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <20260520093804.29102-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

Add /dmadev/list_names telemetry endpoint which returns a dictionary
keyed by device ID with device name as the value, so users can
identify devices by name directly from the telemetry output.

Original /dmadev/list output:
  {"/dmadev/list": [0, 1]}

New /dmadev/list_names output:
  {"/dmadev/list_names": {"0": "hisi_sec2-0-dma0",
  "1": "hisi_sec2-0-dma1"}}

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/dmadev/rte_dmadev.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index b75b4f9bd1..98ef7e2b93 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -1157,6 +1157,27 @@ dmadev_handle_dev_list(const char *cmd __rte_unused,
 	return 0;
 }
 
+static int
+dmadev_handle_dev_list_names(const char *cmd __rte_unused,
+		const char *params __rte_unused,
+		struct rte_tel_data *d)
+{
+	char id_str[RTE_TEL_MAX_STRING_LEN];
+	struct rte_dma_dev *dev;
+	int dev_id;
+
+	rte_tel_data_start_dict(d);
+	for (dev_id = 0; dev_id < dma_devices_max; dev_id++) {
+		if (!rte_dma_is_valid(dev_id))
+			continue;
+		dev = &rte_dma_devices[dev_id];
+		sprintf(id_str, "%d", dev_id);
+		rte_tel_data_add_dict_string(d, id_str, dev->data->dev_name);
+	}
+
+	return 0;
+}
+
 #define ADD_CAPA(td, dc, c) rte_tel_data_add_dict_int(td, dma_capability_name(c), !!(dc & c))
 
 static int
@@ -1309,6 +1330,8 @@ RTE_INIT(dmadev_init_telemetry)
 {
 	rte_telemetry_register_cmd("/dmadev/list", dmadev_handle_dev_list,
 			"Returns list of available dmadev devices by IDs. No parameters.");
+	rte_telemetry_register_cmd("/dmadev/list_names", dmadev_handle_dev_list_names,
+			"Returns dict of available dmadev devices by ID-NAMEs. No parameters.");
 	rte_telemetry_register_cmd("/dmadev/info", dmadev_handle_dev_info,
 			"Returns information for a dmadev. Parameters: int dev_id");
 	rte_telemetry_register_cmd("/dmadev/stats", dmadev_handle_dev_stats,
-- 
2.17.1

