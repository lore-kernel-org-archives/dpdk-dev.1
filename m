Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22866CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 09:38:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E9B54065F;
	Wed, 20 May 2026 11:38:18 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id A57814065D
 for <dev@dpdk.org>; Wed, 20 May 2026 11:38:16 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=aBZVJz1YCR6RtTGCR3jf6dV+oWj8eT0b/7sIaDtywkg=;
 b=rQsz0T1ahqqSsyUNAw02Tch+kbEZLT3WeQYMTvkPAQ06tyZmupdmK5aSxMR6zTbnEDk6mpcU7
 /73XnStx9NteocUIv26w5OqbFcEH85NFB3fUIX5OHx83WSDFw6FyGvka8cSvwH3z4h1vxEwnCZx
 JY//CKWR66ZBkJABdT4tg/I=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gL5r06HXCzcZyC;
 Wed, 20 May 2026 17:30:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id E637F2025F;
 Wed, 20 May 2026 17:38:14 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 17:38:09 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <andrew.rybchenko@oktetlabs.ru>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
Subject: [PATCH v2 2/2] ethdev: add telemetry endpoint for list names
Date: Wed, 20 May 2026 17:38:04 +0800
Message-ID: <20260520093804.29102-3-fengchengwen@huawei.com>
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

Add /ethdev/list_names telemetry endpoint which returns a dictionary
keyed by port ID with device name as the value, so users can
identify ports by name directly from the telemetry output.

Original /ethdev/list output:
  {"/ethdev/list": [0, 1]}

New /ethdev/list_names output:
  {"/ethdev/list_names": {"0": "0000:7d:00.0",
  "1": "0000:7d:00.1"}}

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ethdev/rte_ethdev_telemetry.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/ethdev/rte_ethdev_telemetry.c b/lib/ethdev/rte_ethdev_telemetry.c
index a910864bc5..0e71419473 100644
--- a/lib/ethdev/rte_ethdev_telemetry.c
+++ b/lib/ethdev/rte_ethdev_telemetry.c
@@ -61,6 +61,24 @@ eth_dev_handle_port_list(const char *cmd __rte_unused,
 	return 0;
 }
 
+static int
+eth_dev_handle_port_list_names(const char *cmd __rte_unused,
+		const char *params __rte_unused,
+		struct rte_tel_data *d)
+{
+	char id_str[RTE_TEL_MAX_STRING_LEN];
+	struct rte_eth_dev *dev;
+	int port_id;
+
+	rte_tel_data_start_dict(d);
+	RTE_ETH_FOREACH_DEV(port_id) {
+		dev = &rte_eth_devices[port_id];
+		sprintf(id_str, "%d", port_id);
+		rte_tel_data_add_dict_string(d, id_str, dev->data->name);
+	}
+	return 0;
+}
+
 static int
 eth_dev_parse_hide_zero(const char *key, const char *value, void *extra_args)
 {
@@ -1548,6 +1566,9 @@ RTE_INIT(ethdev_init_telemetry)
 	rte_telemetry_register_cmd_arg("/ethdev/list",
 			eth_dev_telemetry_do, eth_dev_handle_port_list,
 			"Returns list of available ethdev ports. Takes no parameters");
+	rte_telemetry_register_cmd_arg("/ethdev/list_names",
+			eth_dev_telemetry_do, eth_dev_handle_port_list_names,
+			"Returns dict of available ethdev ports by ID-NAMEs. Takes no parameters");
 	rte_telemetry_register_cmd_arg("/ethdev/stats",
 			eth_dev_telemetry_do, eth_dev_handle_port_stats,
 			"Returns the common stats for a port. Parameters: int port_id");
-- 
2.17.1

