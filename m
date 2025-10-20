Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC76BCCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97D0A42D55;
	Mon, 20 Oct 2025 18:37:02 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id B8E7440B97
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:45 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023085.outbound.protection.outlook.com [52.101.72.85])
 by mx-outbound9-130.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBUlaeBoiyJtWGYyD8uG5/dM9JhVB+1VXQQIlhmBR9Jx+aNt0OZ+aX0z0xrAUmSEVknHlo3+3bkiAGVtTXrabl7IhiMh9uAgoWbVVthKmile4k7JwAZWAUA5W1k5ys6rnwgyPalPWRRCZq7dJg+5OoUyVHjZumicGD+AvxpG0Bd+SAAi52PlYLaV8VlQsgkh/7QbkRxxd7R4mhLJgLFqcOWvj6ae0Kyso4c74cjusd+jDtZdBiKdpI6PVxmmdHcleqrQ3H4ZflUod/s/E69n2Qx2oujrNtngtEpTU1QFGoU8n8EmLbvg65AwdVZ0FiG0pGqvGYA9BtKTKQQq/toFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvfCU7oHVj8/jLplMSp80Zcwv3zix7T1v39DmjtXMiA=;
 b=EIXbsDf+KdPApSvakHi7y2CiAAltS4FyoYfvraoAvwO3dvht787BnlULODOIV6ELVXWwih6sqQDpYSvwKt86UK4U1jB0enjveSH0xdxxLoPYaqx3yhqRvOlqDp8u7AtaAnrOJCiQa1tLVlk8HA5H3qAamyCNAHAdHdVwBPViyx5Cr/FHs+Dru2GQu9UM4woTZTHg9Cy/artRflZDRuSHzDTMa5Kw0HknGhME5gVIeUnKRSMoIxfVM4wEYis5KGX/SOL+x9gccGc4nVwrpr0D3YSXH7USTz3eKVToUGWuEsNtJ0UZRW75BOEMF/4UG7whvYX9fXTnV7NSQ0kbEaUzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvfCU7oHVj8/jLplMSp80Zcwv3zix7T1v39DmjtXMiA=;
 b=KfMsa4wVwvt8satquRArslGEJtRAz+NrIu8Op52yZfT7OYh2A1e7D+5FW4W5JjTDBa6eUmNCLq24pNsoZFmfai6NtWH+w7J6dQOJSEAdr2fPWppnsFVatB8yRswLZkbN/m9rAyknbe7GkNTCwJszmGo1C615i+OGduoZcDPa6Xg=
Received: from AS4P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::11)
 by AS8P190MB1936.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:521::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:43 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::7e) by AS4P191CA0016.outlook.office365.com
 (2603:10a6:20b:5d9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:43
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 24/24] net/ntnic: rename table ID functions
Date: Mon, 20 Oct 2025 18:36:15 +0200
Message-ID: <20251020163620.282312-25-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|AS8P190MB1936:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 681d9eba-f6de-4959-1a2a-08de0ff6da51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qBDRoBMEvttx/JXieOaYe9kiuOZp78kSWW2SgCC2OMBh7DjBFsW5V+JoUh2g?=
 =?us-ascii?Q?UYsh2f8DfxK6A8HWt4qC2gw7Lj84wb4xebWCAl8jpuc2OI/5NpTWaLdbwR5J?=
 =?us-ascii?Q?YWn9YV5wVZrucKC2spMSVFORxjkYbwE8LIir9LQPeX7oIq3shHRnTGW2Upxh?=
 =?us-ascii?Q?dvmQ3vGlW2jXiMllJVn7IGgwqQIBxdD0E7wqs5ehOwVVMEQlNHXQz0pKz/xT?=
 =?us-ascii?Q?XpqBPV1CiUCctcUDWDnFrL3rV8IIxFfJCt4PPGf5whwHkvu0vLKoy/N8YEgF?=
 =?us-ascii?Q?PuA25lRyK+DFIHRuJr5qXIqNhp1oveQjO6jt0TVVT+wbBxna2p9r+0dYDFlX?=
 =?us-ascii?Q?eG43JYyaAqHa7xIVXBok8/Enclni9H3jU3tXcp5RZK6JimPsNBSA70vy8hWi?=
 =?us-ascii?Q?ndmaTCCvPdbe95tlZNjbR8G7hL3iMuVfpNrZ9xWtqg+yc266ABZlO/8ltiQN?=
 =?us-ascii?Q?XBp7ME5OaaPGxFuu/XYWo4bRN1TQ/8ExWdwKko1JoYAyjOr5stMKE59PO/wd?=
 =?us-ascii?Q?UoF1q7mEwlqVXlZo8XfpJ8SKriUqSfycfG2Y2dcLKgv93ag+Nz3vH9B3quxM?=
 =?us-ascii?Q?NShQ1/8reo4F9KjVRJejCjLNP3CIB3/9WgaGCiuwHYP9AAr85XvidJEwKW1I?=
 =?us-ascii?Q?rMl6WsVQ2T/JsOV8qT7+agYXyhAkBGKZiCn7pUPDAHBktcfhzWAMim9P+HPf?=
 =?us-ascii?Q?gXfhH/DNvJygtlPAv0ygPjfJaBRlV3+aL3kv/gHa2pjECuUgrzRZpzkJGGpJ?=
 =?us-ascii?Q?O+y8Lk3G7l0BzqXq487Xd3S9hxE7pbxv9eIkxfpZJXUCJZhyJ1sQkCldxzna?=
 =?us-ascii?Q?UE4mY990Ea+d4woo+JUjofSs6F+3h1nEuevcBRzKj29GiEZfOU530utq/n6D?=
 =?us-ascii?Q?g6W5Si7upYzRLP1ZdYtawhIz6q7hVN0RXA6OyCuJ5dCBfLIx9Mtb+Z+h1s2/?=
 =?us-ascii?Q?FVouIXxhUIuHGyf+85bv/r3m3VmDnDM2UEFMURgu7HN0lzE4kuNtDrlVh9g7?=
 =?us-ascii?Q?95gyZ56j5bXB4AR9ebHiwD8wNGEXfPMeoPIC/ruKogTOI7Z/Mfb8p5t/tDz4?=
 =?us-ascii?Q?sMy7zdUY8vLbCXkIOL64lQHQ7HRr7jgPMMYRj8PMMw6BzFxXRg/mRhMsW6O+?=
 =?us-ascii?Q?GHSsebbvozyHBHtHFVJS4ZBjFLWtz/CLEA2BJ/VUje53xTRm5PnoCfjbympT?=
 =?us-ascii?Q?auYjCDozaDSJm8aVBi1uiqZHsI+i1hyz1hB1TgVxdtVSIan+MWXNFndo2DPh?=
 =?us-ascii?Q?Josc9CM9aWq2DtQWrECWSMbEX3/5bjSCcsu6FAxQ6CMC9v1O+JbhteQ7qyxm?=
 =?us-ascii?Q?6lAmdDaBJyFNfj82lpWlR7TtS0+yJxMqVwpKVGLnZZEX/C52CJKIn17lQ+vi?=
 =?us-ascii?Q?VE5SAWf1qcdbRoqQsK1wNPGiXrPAnROXJLd80Mdsd5uZ3mDe1FjcJc/fOVuL?=
 =?us-ascii?Q?Lgcs92Wi7cd5wTKPjPlaK1etAO1xe3n2Yo0w8J1Rs6gTdHdWapyvcImIWFN3?=
 =?us-ascii?Q?dW40pxt//UKTHV0YNYImbJP6fqZKuCY7Ynim/YdNX1C7ZFFHJxQjU2b678oh?=
 =?us-ascii?Q?ScKeoKT0mOU+tXNAY1Q=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1LlrLSWqftqb9oBNc6zwGgrVQgHwJv3i24TT4Q/WMTBxEuM6/pIGOoYcwgV39cZGsMHYnBaGrZHFlzikmU+pC1JMy29/trk4pOJoUrBLpSrXyVMJgRRbeSWctHAzexwbSMI0kpZjKxDqdKmmZ7b+edcTHSadMpE46kxrAZFZhzTPFyKa4BBUYNqDbLqkyy2o8HNnPPEEzCMNXEujVVp6XtzlF0t/UgaLopSqedt8x4yfHP0DhR1mZuLRBKt87T0jxjmaow1rLqAPvprcqLcKN07BZ28YV+zQ0k+0pwcOYi+5xxhdsn8gBkcxev7XXYx7f1XUeDH+J4RKSo+pCvlpJugf9OfMUVQXGLFRae530nhakScztqENfsuxXpjfbK47JRKXp6tiL2B7mMRjLbg8Bhx5dHV9BOVy/kruoKACJOWKxEOsMhgBfPeKC85p4c2LbUtjaFFdXWh/BZ6kV/8nXaoe0jrFgHrfaai0DKANnpO0ewQq8U1TniWZWn2d2qK34RD25ObZTXCDalHX7EPXRsDIv0DqjmgtQTDQxFCy2YaOsvI+9ZpkfYiPSVIpvtr0RzgkRP/PHnFKg3drAkfpVlq8flmB2D8V4YASta7ZRrG926sC3mM54zmCDutSS83I4bWOxAh1wEI7MbAXY8eY1mYg7BLPb+yEu2XPqH8SblE=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:43.1212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681d9eba-f6de-4959-1a2a-08de0ff6da51
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1936
X-BESS-ID: 1760978204-302434-10213-72808-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.72.85
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYmxmZAVgZQ0MQozTDFyMgoyd
 LA0NIiyTIxxdTANMXMyCzF0DwxMTlFqTYWAGoBvopBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-7.eu-central-1b.ess.aws.cudaops.com]
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

