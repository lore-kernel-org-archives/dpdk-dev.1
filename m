Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16027CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:45:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 705B140E49;
	Wed, 24 Sep 2025 16:42:39 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id B7E3440A72
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023117.outbound.protection.outlook.com
 [40.107.162.117]) by mx-outbound42-195.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d82WO5Jx+7bc6undYMAgj4VpJJko6FHOxKZV7PiJ45qXpFNNFe++aOsHXpV9guRfMojFeF//oBxKmcVqtPzxWKxwYXrcTTwyCrH8LNHf4/siLJhOj/AfztRu822BkhyBGpoEKOdwi/jNVJyyod29K98QseYSAJ4y4PKZfrnAtrSHKvkX0VRRLMOf83SmmfARDBv05XN/vlHTKc/jIMp4vYTKrxmYeEbwy02kLEMg/JmLHKLUx4a8S9AH+U1nIw/crJBxhGJPko7D3CRuthE1lU2YbUTcKB//g+7SsF34qiaOjb03CYPz2sj3aveZp5SDMGlaz6rAq448FQdvYEtOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvfCU7oHVj8/jLplMSp80Zcwv3zix7T1v39DmjtXMiA=;
 b=Eqj0K+qYi8lhs3R1lssqrWvJgeXX+vmRY29xZPDl4N5rIKi+d+IspHr5bcTYfP8oVF1RSIRFSq2h8BEdfwgbP3yLE9lKeITbZMjTYETxaRkncqtU3oADxNvi5gFgipxzK2Ta9rwIUxMyrIwyNwRGSrAaUtLe2tFL4GavkItirRaPuvuMj+VeIsr/xCmNJngV+2BiNnFigaYCi8/g18+8yU+2Bg4KZb85hv+1NLeB7C0Go4FWo+t3TT7IMI+Nhrm+X+FYgFe1kcdk3AW9mYtf751bLt0Re2yAimtVXiFu06CBuFaQ+H6/80aH+Y8AnrKKGzb0VzC3sSUwbCObLtM19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvfCU7oHVj8/jLplMSp80Zcwv3zix7T1v39DmjtXMiA=;
 b=LogcTcV4agz0KnqCXISDdOZ38NHbPvI71DijQfwtSpWqDI+n8dgK2yNrD5gWXql47PPe9XAnTAZQBvpPGqhxoK4f457YJ1SSyL8Hlnj35dmnNPTtdJ6zMcKsBO2rK0nU5YSa/zwlcywA5HLGPmxEQQ2ky1TNJiP0uWElAaU8t1E=
Received: from CWLP123CA0229.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::16)
 by DB9P190MB1308.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:42:19 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::4e) by CWLP123CA0229.outlook.office365.com
 (2603:10a6:400:19f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:19
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 24/24] net/ntnic: rename table ID functions
Date: Wed, 24 Sep 2025 16:41:47 +0200
Message-ID: <20250924144152.53203-25-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DB9P190MB1308:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d6e071f8-6876-4053-49f9-08ddfb78906a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UrsLCVMJ3gzPACpYvl5SQNc0xtRIrvBZmJzGbDqVE3riq2dNT3DlbHkJ21F0?=
 =?us-ascii?Q?he09gL+CGb8cb1l4WZAFGCAKEIj3zsnhAamxjyEdrWJe2A3w2Pmvtj7RSM98?=
 =?us-ascii?Q?0CRQMir7bqNFJPfxVtDpQi6yqMOMEHQ56jbytda5pI5JyjeLTEX+rIzUz4Qj?=
 =?us-ascii?Q?3k0gEnFYganj5Rc2DjEPZmvG9+/+JNCCgS4ocXwJOmrsTZ6s86DbO6GUGSRy?=
 =?us-ascii?Q?3fdaYA1zYXGlYp6fK044ygRefZTLTV7RoSTf3pFDwONGyLmGsz3CVC+8RIi0?=
 =?us-ascii?Q?j23BRBULT0aXEn6yw4CTnz6tYIeSsQeV953lX1FvRzLho1wtt2LwiXiWfWyw?=
 =?us-ascii?Q?4gCnQeAKePbnim7yUpu0GBoNFd1fyZ3W2966fu+zJL3geYWGJQt+8GBZHnB0?=
 =?us-ascii?Q?U1ztSprWJPJwx9Yfjjl1sFaxH+9tg4gZ6OTFI0XJQD5mdE0xN+aYL/YAUL1m?=
 =?us-ascii?Q?v67j/NVB4BJ3KbE5I/6Crjc2/ZW3UyRR60ucmQcHLukDAZ2Rn1MT8QqGP0OD?=
 =?us-ascii?Q?HmIT1SnK2PcYi+nDfR8C0EBnjifwMevoBs0SYZdyuvvhHmv2UXSuF4VWj4yT?=
 =?us-ascii?Q?Pls6eBflGs3/iXNOYqVGFj66IG8u6f2H2SSonTCgp5IRXARwUohM6Zugo43i?=
 =?us-ascii?Q?VfJpPl1Qd6T2lmhvZstfF1pvAcChk/tlK/A9o4Xs+gBUuHeXv45pWIJZoHSv?=
 =?us-ascii?Q?YXJDSb7kQeMWcKc9kf1rkWlG6A/U1F5MPmdobeZvjthfDi6oL/GbWvmCl2VK?=
 =?us-ascii?Q?TjWmsNKjpNRuz8dHalMQxRbqcocg6sN+HASvzNplHpYmgbfv4PTo3fSKFVst?=
 =?us-ascii?Q?QyjaPylpOYz8bF2VDVfL+phEpeVH+Aw7pio9m3QrtwaixROr87Os1+r1s5o1?=
 =?us-ascii?Q?KEwTq9AXOsR0kRH0E/mMNcGdnUSnweqbZwf+nRXZh2KFhl6D8IL+uWtEOKh0?=
 =?us-ascii?Q?98kGetjeNnoPZZZy6+oit77cAKJU/KPivSKRyX1tWJp6IeoDrKy5kU21Ock8?=
 =?us-ascii?Q?RdXY+SwTC7vttwP/peyMN6dyAbqA+WW3HaVY45Biv8SnNnn0VuhQKYk4u8B0?=
 =?us-ascii?Q?aR+p2lt0hqkIcf5sgEiRRiVWoBEoRzwo0/eBooNxp9XO8QggtgeN4aWvPn9N?=
 =?us-ascii?Q?ZB2OiuLGjHts20eZYrmqSLinHkttJbdQjfbC0OMkEXoYDNP8cTYC2Yo7FYXb?=
 =?us-ascii?Q?NbGOdOOPPoTZMr53fojFR9QxhXT0DEzNE+rH9JBN7LJB6pH038NnfqFvG2eU?=
 =?us-ascii?Q?EmRO9Wh4L0h2uH9mmtpeq7xtMi13tfG9nUO3wEt17C5dP+9WHF5ErkqwVTSZ?=
 =?us-ascii?Q?my2ncf/kDz+njzPA1dxeGQPE5MafIBEXs0nW9N2Y6fjgHyk9UiAJH8H1lUOy?=
 =?us-ascii?Q?aqyjhXnLJFDXjBAxB038l8Q1xdn3nBRGcGJc8v3ESrGlaB8BJzjvOq8vwJ7n?=
 =?us-ascii?Q?twsaEU1sgfe+pfhCoIe8BgJqKdpsNYAdSylWpVafDUIcPjAueA6rP5oYpcaN?=
 =?us-ascii?Q?N/NTXSbzeGzVPQVU9BXqTYj/xVP4I+J0ybRl?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JUTEIA+E1It+k9gKYoNe429eZAaVqGP6TT1EZRLKv8k6NdCGg3UhkGFWhB4WkdodF4UpCZ5oLU0SuODyZDDJaiuvZUvFQOoUUkAMxn6L8V7ZAvUY7puWFSrBh33rqbAJ6Ofeg0DLLhipA87SyQx46Lto8h0Z1ictaPKCJvDaAbHaJ3L8nFlvgdzzNemu2wM7LlXawr/geUoX5kartCuVbtTe+Silu3aX4Xod1DBVFqOOvJu5iSEV/m5wEpIPbDoaxuRlCNAXa+AuLQBx5f2GAx2yHadlBMIuThqJFjy73ZtOVg8v1HZj8B7+n0REr430ARSA7LU3q2nJ3eu/QdV9NpuG87B9e5murCM3CVRB71ig/umd2SJ8xdMMzFaW2WBbndP491nx61Aa3au46SrLkD8IWwopTRHjxAFTAauI1AVgZUJGzkRhJueVi3ptPKWx/2n320ywWaQROQUWh6pqAWyCXQnRNFSo+iyPd1elKLPdagGBHTog2AmNgOqkXyZmGWAtFGNUvaH9Pbzkhv/5naYA26COi+w5Wge2POQitpEHZH/wIK3uLTW2ybm6QXarYX/QDaX3oloZiimFlNhXEuyfnW0aUPi/2+WykZHR2WLFx9PlUWvHEgIPWONw+4/1KuUWAs2lBc87XdBkzsM/Ig==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:19.2996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e071f8-6876-4053-49f9-08ddfb78906a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1308
X-BESS-ID: 1758724940-310947-7721-8064-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.162.117
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYmxmZAVgZQ0MQozTDFyMgoyd
 LA0NIiyTIxxdTANMXMyCzF0DwxMTlFqTYWAGoBvopBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan8-57.eu-central-1a.ess.aws.cudaops.com]
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

