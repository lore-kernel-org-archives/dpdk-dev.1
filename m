Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D782CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:22:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF5FB40E0C;
	Fri, 19 Sep 2025 11:20:37 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id BCEAA40A71
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:29 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021072.outbound.protection.outlook.com [52.101.65.72])
 by mx-outbound46-45.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tv7tJI37mtV+v8Aw+VFhRJrUjGAzxZ6OVBGopBfN6nQ7XnIneqlywP248jd48/0mbWfwSWlQP4QX/M4s6pW5EQLw2TkhC7X+OhJ/X/McIFB0GSNo7kUTdpOohpa7Lww68jTwT55c1EBmi+42BK9ENDbx42Vkin8bFr8I5ntJlAlweYuifaxwdP01biRWCe7Jys4OIVwD76fLIQWA8Hg5HL8oTCpExCZZjKiftcoeirmkUtYZ3WXBgSbaJ8Nxj6UkwGpirdQFcS8AWK5j6OyJbKSODcIGYIYhfSo+CleN090C+NqMl1cLu48e0zRlyaZhZ0/NOcS9yhRShr8dw0U8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvfCU7oHVj8/jLplMSp80Zcwv3zix7T1v39DmjtXMiA=;
 b=T91HaNly4VPBqaOBEOa/AoYU7xX8HLkBmoiOEtkUGWRWKiDRSvm7mJvUH/rSwhsiWy5dsHG815Qwec0FPg9AagGPoJfk3usE+ajGnGbZ+5ljcZWqez/u7LzwLBveXZwiBp9hmYbE/YoYHiKkLwDiUO7eelLmnaCC9i9ndqxVjrBRUsJXniAoHv/FmXAXRMeUkhrZvo892x5qT5WpF88bW0Z3IKq6ByZyaWmTFl9YbTT04EOCs8Lul/wULECNvBMogQREZE/TDdQnTadthr1dy2NoJpeCkYX+ULcov7ch4u5RIPLz8XIBLByWm7i8/fLnew5YvTJdc/7Ks8HeJJbPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvfCU7oHVj8/jLplMSp80Zcwv3zix7T1v39DmjtXMiA=;
 b=Zl6hc9WI8aArh6zaTGw697cQaONceVWw9kmHTV9CKb1Gho6bU+ngqljXNtbeFBShC7Y/TrMJBjS3XmV9EPI8bcunQZIJJ219JYJ2j42lodBiZPUEfmGAMCTKp1GYGipYUP8nJD91LQ9HmIWqRryklBWAlgNJsMvBNX5XVfRvJ9Q=
Received: from DU2PR04CA0333.eurprd04.prod.outlook.com (2603:10a6:10:2b4::25)
 by PA4P190MB1295.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:108::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 19 Sep
 2025 09:20:25 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::98) by DU2PR04CA0333.outlook.office365.com
 (2603:10a6:10:2b4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 09:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:24 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 16/16] net/ntnic: rename table id functions
Date: Fri, 19 Sep 2025 11:15:01 +0200
Message-ID: <20250919091504.1548351-17-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|PA4P190MB1295:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0f703ef-ca0f-43ff-9c8c-08ddf75dc408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NPXheP16nmfbCPV+u0S8+D+flDkiJlXiFKqGBEOJtR8bT5tmmypjdwd/k9iM?=
 =?us-ascii?Q?5AVdCYCEcyPNmpGvgflQZ1HmkfSjbuHeT6RUA8XzsG4huoMvtKCcLHJitNvI?=
 =?us-ascii?Q?Wt0OD+lB9+WRwe4OwVUykF4MoDT4j7yE3+7v48++CIQjVYqeo/jn694QCjE1?=
 =?us-ascii?Q?Gwi0ZrAi/E87fQ5EIbvYD6Iks5Z37ZfvzWMrub9R8+kbLiehjztoTBaw3Mgw?=
 =?us-ascii?Q?LEwHdk/VGC/UaGwDN/Eu4iP5q4kwoZ023LCd0Jo8e0iZ+KlDCVvn/lZDoNko?=
 =?us-ascii?Q?PfT+5rpz0z/umeha4MY2zX9CTtAYJtQXBdPmpjkTQjqhTJJCTV4XXot8+K5L?=
 =?us-ascii?Q?6pw7JpHzvXChYVJR6M21yJLc0aubrOCDpzNmaCUgsyStkBlxLFJ8TCmdBvQf?=
 =?us-ascii?Q?J/FtsYdQzOcTa9CWM/n67kv2DRMJ7ItCQlB/vt1cOnw5VyfV4oMVdySZCinv?=
 =?us-ascii?Q?GDwzJeVEWCHiFLZtGjhVFUljTNWDjA1lxHZHGFD7sYOproVUd9cYQxqRg0pp?=
 =?us-ascii?Q?UZ8uy0xlHY8zcJNBpTH51RvNgGRLwI1mJ43TILFcJ99OXePZI6cEtBeoxWRT?=
 =?us-ascii?Q?7xMUUKevsM5BIqF6K3ZlGqSOarl8qggLOpQwCFkz9FN8GDlhhm0BzWqz7y70?=
 =?us-ascii?Q?mC2NLFDw8ZRqj1O07fqTk8c0uW4kiWcB3hsQSAqTcD/Qi5xzrwiX+eYcHgf5?=
 =?us-ascii?Q?kiJkLr24+z7w3PwNRn+RlpyMJpsjuJ3behJc9oQvx7RVNg5TMB/J3JXHmxiS?=
 =?us-ascii?Q?Qt5JWrJyObF1RXIRol0Ky6kM2kygOXsRkyft8Awb+GmjMD2orYh1kwjtC/h9?=
 =?us-ascii?Q?yf+x7YEOa8JmWoiHjc4duHToY6VND9olqh5sYJ3QRoWwneBo0dg3Iv4YnSER?=
 =?us-ascii?Q?p/zdllhYpxK3DjISAmJxZazcJD+6/mxcnUKgbPmpsm0xqkV8ewfzGm+SrMwZ?=
 =?us-ascii?Q?99r8INa4hJRqtTTYteONyvasQgcER2G8WppsbZymzrXbCgQdlERS8JXuo+Kz?=
 =?us-ascii?Q?WbPK6ckjC2o9q9pxoE3prt8dZfduEWdjiyco47QbIxeJs6BUGSbru/+aoB3J?=
 =?us-ascii?Q?ZUXgBL27kIhPXo3NC6fX4QWQAXVa3BB8AFBsKVVeW9N+e92exmpXOb/74uXD?=
 =?us-ascii?Q?Ngj7YWqNwTzO24MAgzyaYtHZx/SdcxD0sKqmNgHjq2MDIlNu3Dpqy+3XCPb+?=
 =?us-ascii?Q?DvT5B+Sxup2LO2nsMU/IJaHLp/pJKIxfHQs6y1Byxp/1fbVBFCTHXXm3OZt5?=
 =?us-ascii?Q?UrKlfoNSh9qyCS+VN0XYNewYRoNL0Yje1HZ4Zuvn577nKjj7wpk40WiB3O9d?=
 =?us-ascii?Q?KYEkrolK5GmYA2bqm3SBMoH2W6XVJHLYR6cxQfRcy+uAv5OuL54OskUPeQFe?=
 =?us-ascii?Q?TLJ/FZYAvGe/u2flVDQAitkgwR61zbP554wy8lXobxPZ7R7t731tzini421i?=
 =?us-ascii?Q?gXQYn7ih/zt9WeCf0TPvYlhHiijxT5lZqIh9YS1nbVBfy1CLbzd1xWWHgF63?=
 =?us-ascii?Q?FYq5vbr3SbMFWZko2NEYiDJRrOzOr1btYsPS?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rXXmLkaCCb7EdcOQfGGmoo5HFnc77mxjRC1P0SZjci9ThL9LeGnaErP2e7cNgV3UvSxr7TYpFKVQWBkBVxYPodWNSM7D8ItryAwqKLm5pjxfZreDbmzf/NC3dGV/41GiYJzaC+yTwf5v4QRcB7MCNONnwNw4KJQ4uIwVF0N1uX+2U5AjzIb80dwD/8ts+nHKGsc6k0I/9YdGcFdrwUpPr6dbebHayUY0sKufjDDj7aItY3tg6lNs9RwOZy0zwXRGz7ywlgRwhXZb7N4KyFnwxwPekd5CuD1NjizD28E5pQdtj1LIw4/NHbGY8LXtmFhpDM/BmUhln+mS21E911UQWAsq4qI4X7xX9FKaSYfpkulrNGscWoQ6G1/MOqzrQ+P2+7aix7QKMVqqhGq7y3zUWdhPrGVw2wAjun1/rgFUlGBfm+vxaGZM3nMSi+kDAajQgubFQVolGQdnlkk6Lc1sZ44r+53hrU5BgSYKQ4vnOmR8tl44rxHreuS4sXiaJmtpF4mRNEm8s9wzUgISkqaj8OapMyiNWbDzEVztPsAGlvNB1CwP8SPJFYgyLOUl9SQElsc06sjz4yaCvK23tjlYY4B0Rxd/Rpd/qvtDW8JzFrhOPPfd7eWUe7DwxQOBAKiQ4WnhmBugoqqJgWY3ONFBUA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:24.7874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f703ef-ca0f-43ff-9c8c-08ddf75dc408
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1295
X-BESS-ID: 1758273628-311821-7629-1101-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.65.72
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYmxmZAVgZQ0MQozTDFyMgoyd
 LA0NIiyTIxxdTANMXMyCzF0DwxMTlFqTYWAGoBvopBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan16-167.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

Extent table id functions with prefix nthw_.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/nthw/flow_api/flow_id_table.c  | 10 +++++-----
 drivers/net/ntnic/nthw/flow_api/flow_id_table.h  | 10 +++++-----
 .../profile_inline/flow_api_profile_inline.c     | 16 ++++++++--------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/flow_id_table.c b/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
index f22796597f..f7c983fb9f 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
@@ -64,7 +64,7 @@ static inline uint32_t ntnic_id_table_array_pop_free_id(struct ntnic_id_table_da
 	return id;
 }
 
-void *ntnic_id_table_create(void)
+void *nthw_id_table_create(void)
 {
 	struct ntnic_id_table_data *handle = calloc(1, sizeof(struct ntnic_id_table_data));
 
@@ -74,7 +74,7 @@ void *ntnic_id_table_create(void)
 	return handle;
 }
 
-void ntnic_id_table_destroy(void *id_table)
+void nthw_id_table_destroy(void *id_table)
 {
 	struct ntnic_id_table_data *handle = id_table;
 
@@ -84,7 +84,7 @@ void ntnic_id_table_destroy(void *id_table)
 	free(id_table);
 }
 
-uint32_t ntnic_id_table_get_id(void *id_table, union flm_handles flm_h, uint8_t caller_id,
+uint32_t nthw_id_table_get_id(void *id_table, union flm_handles flm_h, uint8_t caller_id,
 	uint8_t type)
 {
 	struct ntnic_id_table_data *handle = id_table;
@@ -106,7 +106,7 @@ uint32_t ntnic_id_table_get_id(void *id_table, union flm_handles flm_h, uint8_t
 	return new_id;
 }
 
-void ntnic_id_table_free_id(void *id_table, uint32_t id)
+void nthw_id_table_free_id(void *id_table, uint32_t id)
 {
 	struct ntnic_id_table_data *handle = id_table;
 
@@ -129,7 +129,7 @@ void ntnic_id_table_free_id(void *id_table, uint32_t id)
 	rte_spinlock_unlock(&handle->mtx);
 }
 
-void ntnic_id_table_find(void *id_table, uint32_t id, union flm_handles *flm_h, uint8_t *caller_id,
+void nthw_id_table_find(void *id_table, uint32_t id, union flm_handles *flm_h, uint8_t *caller_id,
 	uint8_t *type)
 {
 	struct ntnic_id_table_data *handle = id_table;
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_id_table.h b/drivers/net/ntnic/nthw/flow_api/flow_id_table.h
index edb4f42729..99789955bc 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_id_table.h
+++ b/drivers/net/ntnic/nthw/flow_api/flow_id_table.h
@@ -13,14 +13,14 @@ union flm_handles {
 	void *p;
 };
 
-void *ntnic_id_table_create(void);
-void ntnic_id_table_destroy(void *id_table);
+void *nthw_id_table_create(void);
+void nthw_id_table_destroy(void *id_table);
 
-uint32_t ntnic_id_table_get_id(void *id_table, union flm_handles flm_h, uint8_t caller_id,
+uint32_t nthw_id_table_get_id(void *id_table, union flm_handles flm_h, uint8_t caller_id,
 	uint8_t type);
-void ntnic_id_table_free_id(void *id_table, uint32_t id);
+void nthw_id_table_free_id(void *id_table, uint32_t id);
 
-void ntnic_id_table_find(void *id_table, uint32_t id, union flm_handles *flm_h, uint8_t *caller_id,
+void nthw_id_table_find(void *id_table, uint32_t id, union flm_handles *flm_h, uint8_t *caller_id,
 	uint8_t *type);
 
 #endif	/* FLOW_ID_TABLE_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 3f80e0f945..d9c10a8eab 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -211,7 +211,7 @@ static int flow_mtr_create_meter(struct flow_eth_dev *dev,
 
 	union flm_handles flm_h;
 	flm_h.idx = mtr_id;
-	uint32_t flm_id = ntnic_id_table_get_id(dev->ndev->id_table_handle, flm_h, caller_id, 2);
+	uint32_t flm_id = nthw_id_table_get_id(dev->ndev->id_table_handle, flm_h, caller_id, 2);
 
 	learn_record->sw9 = flm_id;
 	learn_record->kid = 1;
@@ -327,7 +327,7 @@ static int flow_mtr_destroy_meter(struct flow_eth_dev *dev, uint8_t caller_id, u
 	mtr_stat[mtr_id].n_pkt_base = 0;
 	mtr_stat[mtr_id].buckets = NULL;
 
-	ntnic_id_table_free_id(dev->ndev->id_table_handle, flm_id);
+	nthw_id_table_free_id(dev->ndev->id_table_handle, flm_id);
 
 	nthw_flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
 
@@ -431,7 +431,7 @@ static void flm_mtr_read_inf_records(struct flow_eth_dev *dev, uint32_t *data, u
 		uint8_t caller_id;
 		uint8_t type;
 		union flm_handles flm_h;
-		ntnic_id_table_find(dev->ndev->id_table_handle, inf_data->id, &flm_h, &caller_id,
+		nthw_id_table_find(dev->ndev->id_table_handle, inf_data->id, &flm_h, &caller_id,
 			&type);
 
 		/* Check that received record hold valid meter statistics */
@@ -507,7 +507,7 @@ static void flm_mtr_read_sta_records(struct flow_eth_dev *dev, uint32_t *data, u
 		uint8_t caller_id;
 		uint8_t type;
 		union flm_handles flm_h;
-		ntnic_id_table_find(dev->ndev->id_table_handle, sta_data->id, &flm_h, &caller_id,
+		nthw_id_table_find(dev->ndev->id_table_handle, sta_data->id, &flm_h, &caller_id,
 			&type);
 
 		if (type == 1) {
@@ -958,14 +958,14 @@ static int flm_flow_programming(struct flow_handle *fh, uint32_t flm_op)
 	if (flm_op == NT_FLM_OP_LEARN) {
 		union flm_handles flm_h;
 		flm_h.p = fh;
-		fh->flm_id = ntnic_id_table_get_id(fh->dev->ndev->id_table_handle, flm_h,
+		fh->flm_id = nthw_id_table_get_id(fh->dev->ndev->id_table_handle, flm_h,
 			fh->caller_id, 1);
 	}
 
 	uint32_t flm_id = fh->flm_id;
 
 	if (flm_op == NT_FLM_OP_UNLEARN) {
-		ntnic_id_table_free_id(fh->dev->ndev->id_table_handle, flm_id);
+		nthw_id_table_free_id(fh->dev->ndev->id_table_handle, flm_id);
 
 		if (rte_atomic_load_explicit(&fh->learn_ignored, rte_memory_order_seq_cst) == 1)
 			return 0;
@@ -4057,7 +4057,7 @@ int nthw_init_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 
 		nthw_mod_flm_pst_flush(&ndev->be, 0, ALL_ENTRIES);
 
-		ndev->id_table_handle = ntnic_id_table_create();
+		ndev->id_table_handle = nthw_id_table_create();
 
 		if (ndev->id_table_handle == NULL)
 			goto err_exit0;
@@ -4132,7 +4132,7 @@ int nthw_done_flow_mgmnt_of_ndev_profile_inline(struct flow_nic_dev *ndev)
 		free(ndev->flm_mtr_handle);
 
 		nthw_flow_group_handle_destroy(&ndev->group_handle);
-		ntnic_id_table_destroy(ndev->id_table_handle);
+		nthw_id_table_destroy(ndev->id_table_handle);
 
 		nthw_mod_cat_cfn_set(&ndev->be, HW_CAT_CFN_PRESET_ALL, 0, 0, 0);
 		nthw_mod_cat_cfn_flush(&ndev->be, 0, 1);
-- 
2.45.0

