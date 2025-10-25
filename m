Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50453CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 09:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FE84402BE;
	Sat, 25 Oct 2025 11:42:59 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 75490402AF
 for <dev@dpdk.org>; Sat, 25 Oct 2025 11:42:57 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=K3wio+ugAZ9Fblx3M2R8Abx7oMM6KRUQmJPfddnBpCU=;
 b=r3lKManMsHY+Kyq/eZp8nPIt7vv95jUbsQx9t6thQugSgtjXTQ43shAscPqt6nXCWJ2AECvo7
 u4Y68DbKyooYzwjRNokVD01KQuoagAPRH8oYzGP2got5GVoRULgltdjitdG/LvLlBchR/QpKBvF
 MRtkOLIRfRRoQC4zIjutKuw=
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4ctvv94YbQzLlVq;
 Sat, 25 Oct 2025 17:42:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 104C21A0188;
 Sat, 25 Oct 2025 17:42:56 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 17:42:47 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH 2/2] ethdev: support hide zero when telemetry regs
Date: Sat, 25 Oct 2025 17:42:39 +0800
Message-ID: <20251025094239.4915-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251025094239.4915-1-fengchengwen@huawei.com>
References: <20251025094239.4915-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Support hide zero when telemetry regs, and also modify filter usage.

Now the usage:
  /ethdev/regs,0,hide_zero=true   --hide zero values when dump regs
  /ethdev/regs,0,hide_zero=false  --don't hide zero values

  /ethdev/regs,0,filter=ssu       --filter ssu module when dump regs

  /ethdev/regs,0,filter=ssu,hide_zero=true
          --filter ssu module and hide zero values when dump regs

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ethdev/rte_ethdev_telemetry.c | 52 +++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/lib/ethdev/rte_ethdev_telemetry.c b/lib/ethdev/rte_ethdev_telemetry.c
index 020e3979b0..a910864bc5 100644
--- a/lib/ethdev/rte_ethdev_telemetry.c
+++ b/lib/ethdev/rte_ethdev_telemetry.c
@@ -1383,18 +1383,21 @@ eth_dev_handle_port_tm_node_caps(const char *cmd __rte_unused,
 
 static void
 eth_dev_add_reg_data(struct rte_tel_data *d, struct rte_dev_reg_info *reg_info,
-		     uint32_t idx)
+		     uint32_t idx, bool hide_zero)
 {
+	uint64_t val;
+
 	if (reg_info->width == sizeof(uint32_t))
-		rte_tel_data_add_dict_uint_hex(d, reg_info->names[idx].name,
-			*((uint32_t *)reg_info->data + idx), 0);
+		val = *((uint32_t *)reg_info->data + idx);
 	else
-		rte_tel_data_add_dict_uint_hex(d, reg_info->names[idx].name,
-			*((uint64_t *)reg_info->data + idx), 0);
+		val = *((uint64_t *)reg_info->data + idx);
+
+	if (!hide_zero || val > 0)
+		rte_tel_data_add_dict_uint_hex(d, reg_info->names[idx].name, val, 0);
 }
 
 static int
-eth_dev_store_regs(struct rte_tel_data *d, struct rte_dev_reg_info *reg_info)
+eth_dev_store_regs(struct rte_tel_data *d, struct rte_dev_reg_info *reg_info, bool hide_zero)
 {
 	struct rte_tel_data *groups[RTE_TEL_MAX_DICT_ENTRIES];
 	char group_name[RTE_TEL_MAX_STRING_LEN] = {0};
@@ -1419,7 +1422,7 @@ eth_dev_store_regs(struct rte_tel_data *d, struct rte_dev_reg_info *reg_info)
 
 	for (i = 0; i < reg_info->length; i++) {
 		if (i % RTE_TEL_MAX_DICT_ENTRIES != 0) {
-			eth_dev_add_reg_data(group, reg_info, i);
+			eth_dev_add_reg_data(group, reg_info, i, hide_zero);
 			continue;
 		}
 
@@ -1431,7 +1434,7 @@ eth_dev_store_regs(struct rte_tel_data *d, struct rte_dev_reg_info *reg_info)
 		}
 		groups[grp_num++] = group;
 		rte_tel_data_start_dict(group);
-		eth_dev_add_reg_data(group, reg_info, i);
+		eth_dev_add_reg_data(group, reg_info, i, hide_zero);
 	}
 
 	for (i = 0; i < grp_num; i++) {
@@ -1447,7 +1450,7 @@ eth_dev_store_regs(struct rte_tel_data *d, struct rte_dev_reg_info *reg_info)
 }
 
 static int
-eth_dev_get_port_regs(int port_id, struct rte_tel_data *d, char *filter)
+eth_dev_get_port_regs(int port_id, struct rte_tel_data *d, char *filter, bool hide_zero)
 {
 	struct rte_dev_reg_info reg_info;
 	int ret;
@@ -1481,7 +1484,7 @@ eth_dev_get_port_regs(int port_id, struct rte_tel_data *d, char *filter)
 		goto out;
 	}
 
-	ret = eth_dev_store_regs(d, &reg_info);
+	ret = eth_dev_store_regs(d, &reg_info, hide_zero);
 out:
 	free(reg_info.data);
 	free(reg_info.names);
@@ -1494,7 +1497,11 @@ eth_dev_handle_port_regs(const char *cmd __rte_unused,
 		const char *params,
 		struct rte_tel_data *d)
 {
-	char *filter, *end_param;
+	const char *const valid_keys[] = { "filter", "hide_zero", NULL };
+	struct rte_kvargs *kvlist = NULL;
+	char *filter = NULL, *end_param;
+	const char *filter_val;
+	bool hide_zero = false;
 	uint16_t port_id;
 	int ret;
 
@@ -1502,11 +1509,24 @@ eth_dev_handle_port_regs(const char *cmd __rte_unused,
 	if (ret != 0)
 		return ret;
 
-	filter = strtok(end_param, ",");
-	if (filter != NULL && strlen(filter) == 0)
-		filter = NULL;
+	if (*end_param != '\0') {
+		kvlist = rte_kvargs_parse(end_param, valid_keys);
+		filter_val = rte_kvargs_get(kvlist, "filter");
+		ret = rte_kvargs_process(kvlist, "hide_zero", eth_dev_parse_hide_zero, &hide_zero);
+		if (kvlist == NULL || (filter_val != NULL && strlen(filter_val) == 0) || ret != 0) {
+			RTE_ETHDEV_LOG_LINE(NOTICE,
+				"Unknown extra parameters passed to ethdev telemetry command, ignoring");
+		} else {
+			filter = (filter_val != NULL) ? strdup(filter_val) : NULL;
+			hide_zero = false;
+		}
+		rte_kvargs_free(kvlist);
+	}
+
+	ret = eth_dev_get_port_regs(port_id, d, filter, hide_zero);
+	free(filter);
 
-	return eth_dev_get_port_regs(port_id, d, filter);
+	return ret;
 }
 
 static int eth_dev_telemetry_do(const char *cmd, const char *params, void *arg,
@@ -1582,5 +1602,5 @@ RTE_INIT(ethdev_init_telemetry)
 			eth_dev_telemetry_do, eth_dev_handle_port_tm_node_caps,
 			"Returns TM Node Capabilities info for a port. Parameters: int port_id, int node_id (see tm_capability for the max)");
 	rte_telemetry_register_cmd("/ethdev/regs", eth_dev_handle_port_regs,
-			"Returns all or filtered registers info for a port. Parameters: int port_id, string module_name (Optional if show all)");
+			"Returns registers info for a port. Parameters: int port_id,filter=xxx(Optional if show all),hide_zero=true|false(Optional)");
 }
-- 
2.17.1

