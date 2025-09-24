Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D1CAC5B1
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:43:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94E3540E12;
	Wed, 24 Sep 2025 16:42:24 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id C524B40B9E
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:12 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023095.outbound.protection.outlook.com
 [52.101.83.95]) by mx-outbound22-32.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5w7fo2zk/nEpMlBxcXiKSabWb8LErQT0qJQ6EcqiZXgpJa8ypVaaOC/zvxDPm1wlxvVbzdcmJ+CmuETZCmaJRkRtv9rHkdvmxwQO9ZdyRFMxSSqtdgo0TeXbt1m1Hcrz8OhFJlAvLGRDeqiwJSDNT4geSjRZk2kMbQGrXMep042gAnqyw0Ujz4O2Cx5yKpvDCIJzCLET/90JftndyWNdFVdoc8/pN7zVQv+ALXeIW2AwZ8b9YQCzyn3WIanyh5WjrKVLawlhbCOjafupVqQ/bfIdCOjipYR3dr1sylxqJKAVhA9XQqFF4HJ6kOK/P88PqlQ6JA0NRBEtrJAQ0Ze3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hegyqYQ4c6ufeM7lcOsIVkLpa/QlkBYKMziG/FnXSA=;
 b=YHGkn76d0Of8zCJvTvWw6q3KJkfEkPBh79dJ4t87Plj7TkGUv4KT/uasCBd6Jfs8irenMybsyDyoi3dGeqrTw8ZFXNovPgFF4yGDZeeu2e3NPgdaMPN9c3ijqnVOXwsVugA17VxhmUTBZkPBr3E3q+MsDg+wssKsdWJUQpD2Ybq+qGpQxWVtLJ+9xQVVIfQ36DzDWKEGf2fXv8ST4YQ32ZV3fpRSSLsZg1KZ6N+KmrZlJphWrfaGhfiUx8HqF9tXM7QHTGGYoelmRIK52+xUCaq75o/0+Eb/Teh/IhLa1kedel0sGIF/n5DLcFDWIsPPFzzdHd95UgP4By7YIgY7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hegyqYQ4c6ufeM7lcOsIVkLpa/QlkBYKMziG/FnXSA=;
 b=p1LFtBni1ZRB019EVAHiTbANXKJYbGnCbHbxTHz3VnwUd5YUWspJe6zvchxWZ3V2nRC94mALCqs6xWJ5zbdmsetS6xu358LM+8ocHhD6DX7LmAZ0MEBbHFL34QYaFZljZJowQFiKPGAXwwcPNvsO3YK+2QwwTdCSiPdbMyor+Qo=
Received: from CWLP123CA0232.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::14)
 by PR3P190MB0809.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:82::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:42:09 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::50) by CWLP123CA0232.outlook.office365.com
 (2603:10a6:400:19f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:09
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 14/24] net/ntnic: change prefix flm to prefix nthw
Date: Wed, 24 Sep 2025 16:41:37 +0200
Message-ID: <20250924144152.53203-15-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|PR3P190MB0809:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 589bc4ff-a49b-4c34-b69f-08ddfb788abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IlnwWwS1yE41WN+vHM8LCKubTeIlKsHmIDCAKsRbgApT/5i47E8eUc0X8NM6?=
 =?us-ascii?Q?GNALBr9ymvkm0pJmhnlxn613sK4ZFCVYKMzwUXLGaUMY2l7kQCHWuC4AHCHa?=
 =?us-ascii?Q?Jzy4NhzAo5TMnlOAPngjhOL+i7JIqPSsLqwU4mKNF0uXZ/jlu3DqKBS0Rgiu?=
 =?us-ascii?Q?vjq/UUNUI1ftLuWiFYpWIoRD4LljdtJIh446yy6LgTpACnxXShXgL9XBLp9q?=
 =?us-ascii?Q?BzEu+3NAgCNgW+zSKd22TNWK8xf15m8otDBnhiTd0C/se+8b2I8TW+rQcHbJ?=
 =?us-ascii?Q?HgyW3/z+BMS/Kh+AK2iB5a1t9rCC4Iyggqlv82bA3O8fCOhAEqE/Xe/i6c3h?=
 =?us-ascii?Q?X1ogNnxygBwUHhpxg3JP4WcoFU8s/IWPXqOZXJctmTQZ4CVkXzXA3o8qRCRs?=
 =?us-ascii?Q?/gQJZrLSC+jafDGhjzHHvqJvSJz+54Gg9eZY2tYElQdvVOZe9D5wS/mVVGZ9?=
 =?us-ascii?Q?0JHjLcq9AsnvQXBvzBDzaC3lahwM+c7RLDn5+pS9imWFL3q4UeJ0fBLvJoXq?=
 =?us-ascii?Q?/kgj4Pdgga+wgDnPCSomzaQusQin/SjyrszQcE/brb6fFNhX0V8HnX2GwXfA?=
 =?us-ascii?Q?uLlqRFkvEDjUMrENO2JLYzlDuV1POsfLbAE2iKtqRe8DWhzvjqudoXsaPZS9?=
 =?us-ascii?Q?FAEz9KUXPqFTC87WWSqhMSMzoiRmhf7hM5i9pXaQlCNw+sRLdlUX2zzE23cT?=
 =?us-ascii?Q?IQmVEMRZAsnsW+143IDPxxG/JtMQTIi46yRKLeXkxpCBVDASGSt1cKeX33by?=
 =?us-ascii?Q?o/Av38o9KyKJhU5RsjkiTDP7X77OGQAgNTv9EWOR60a67SY3wMs6zNPrhyBp?=
 =?us-ascii?Q?mohPSPaRnQi7yvbY9v37lYKL+0pdedVHcyhLL0jinqgzmJi+NGMgytAvGHGb?=
 =?us-ascii?Q?TzDt4LsBoitohluLFbbX8jLT//BRY3UAmcgijwQR9YIw35/Ml6Mnm89+cOhE?=
 =?us-ascii?Q?k5weLMtzvfh4jwjRh4KFCeX5l8uRO1Vu2Afwy0/I1yCBUW7achmbFmw+0+hH?=
 =?us-ascii?Q?551RLQW5akRKIdn2jlBsw8kM3KzAlZ6Rw67w0qpZGxfXut10I2jG2d7CKDEi?=
 =?us-ascii?Q?RCu5dtINtqfIxHHUfAECucN3KNGRIqyJOSNf3JWcsWLZpkg4bCFmXya7VfXx?=
 =?us-ascii?Q?ERhz1Ct5YBb1/M1MlAU4Kfhx1caI4FUn+DlXptJZtyxKZVQE1yoW5WI0kOz0?=
 =?us-ascii?Q?7OZwO8yd8DFO5lnN4neUHp/UpU67iEEMe+leF1hWxTLe0eddi+PBdl0zX9Rc?=
 =?us-ascii?Q?r4lxgdRg5Gi08TdPoiDT/1bcmy3qRRnq/Wo1pfjhwY5qj93zPtHWqQyJyXmI?=
 =?us-ascii?Q?11YH4bavw/5fKHGLxtyUuFCF4qjlK0DKH1OL4bYQaWWqBK5chBBWWsS/cDjg?=
 =?us-ascii?Q?3kVddigN+rvtCuS4xMtDbVgBvpJJ0O6WnaQ47HzZixtiwx6aKqUPtCP9f3X8?=
 =?us-ascii?Q?TTyA63SGww8eoDW8eZmj1RdYsWQwNqyil/T0v9G1W1gsJaxHLQOeQc94bX1F?=
 =?us-ascii?Q?mz1+jrnblZpTV6vYQoIa4r9a+LGfdi7P1Mcg?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VoKWa3XJy+kZ9M6TOgFKpFWLAyFCYhkhRFeQhK1T8f3RMQNtww08yku7oeE+xB92Pvif83d3HiwrgZiSsYJzz5Rqd2MpsDS6xcvLQbjHx+lrfNeYLdo/RWNx08nJuoUP5eCHWrP2K7s7Do8YDnHaqYmFhkFhwjAQsVV/iFeZ3vrXHdRM10wH5s+kKQqdHqRSFlVN6DXkrz0xhYZHSSCT6L5iqUbpV+Pwh9TbCVNJqKcGxhuQZXW6gcicjGkiqXQyEd6OyBwzLsvcSgI4zDzmK5b41bte6JDD+i91Mvutd+zf0WFSRw7aHh86EaWU8oAzZmB6rZh7OD/q5lzqltJzaJmiqg+cG4dZcnsmT2xDU8v31Rridso5LjUpwD4flhtNcTn0b3XzDJ7DxPSN11UYsVanLhW+U8K6f04FfxWzCXpNz1o8dYkc2w+E2OGUkR6ZCe/PCW0Xh7p0th77yfJ1Ab2l8Rh38fTWfyDekQISzqK2lcFxqiaW3AVHDhb57HCNzfOjUKMJB8JFRmxgkXB2zs7Ey7BfL5qoTv0LmQYmiHeuUYqcIW9gNFAirYXR4JXMY3KRy/0NWyvvN4ifsMVlSyFMGGWn7KjVH5nkh5FxzJcYgxlaH5UYncwJudVs51bXtopwX+mNxbq+epoXi4rwcQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:09.7862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589bc4ff-a49b-4c34-b69f-08ddfb788abe
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0809
X-BESS-ID: 1758724931-305664-7607-8021-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.83.95
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmhoZmQGYGUDTV1NDQwMgkxS
 ApMcnIwjApyTIx2cAsMdkyxdA4ycLIUqk2FgBqajqXQgAAAA==
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

Change the prefix flm_ to prefix nthw_flm_ to specify that these functions
and part of the ntwh (Napatech Hardware).

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../flow_api/profile_inline/flm_age_queue.c   | 22 ++++----
 .../flow_api/profile_inline/flm_age_queue.h   | 20 +++----
 .../flow_api/profile_inline/flm_lrn_queue.c   | 12 ++--
 .../flow_api/profile_inline/flm_lrn_queue.h   | 12 ++--
 .../profile_inline/flow_api_profile_inline.c  | 55 ++++++++++---------
 drivers/net/ntnic/ntnic_ethdev.c              |  6 +-
 6 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c
index c7522516d1..87c1a5a29e 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c
@@ -13,22 +13,22 @@
 static struct rte_ring *age_queue[MAX_EVT_AGE_QUEUES];
 static RTE_ATOMIC(uint16_t) age_event[MAX_EVT_AGE_PORTS];
 
-__rte_always_inline int flm_age_event_get(uint8_t port)
+__rte_always_inline int nthw_flm_age_event_get(uint8_t port)
 {
 	return  rte_atomic_load_explicit(&age_event[port], rte_memory_order_seq_cst);
 }
 
-__rte_always_inline void flm_age_event_set(uint8_t port)
+__rte_always_inline void nthw_flm_age_event_set(uint8_t port)
 {
 	rte_atomic_store_explicit(&age_event[port], 1, rte_memory_order_seq_cst);
 }
 
-__rte_always_inline void flm_age_event_clear(uint8_t port)
+__rte_always_inline void nthw_flm_age_event_clear(uint8_t port)
 {
 	rte_atomic_store_explicit(&age_event[port], 0, rte_memory_order_seq_cst);
 }
 
-void flm_age_queue_free(uint8_t port, uint16_t caller_id)
+void nthw_flm_age_queue_free(uint8_t port, uint16_t caller_id)
 {
 	struct rte_ring *q = NULL;
 
@@ -43,17 +43,17 @@ void flm_age_queue_free(uint8_t port, uint16_t caller_id)
 	rte_ring_free(q);
 }
 
-void flm_age_queue_free_all(void)
+void nthw_flm_age_queue_free_all(void)
 {
 	int i;
 	int j;
 
 	for (i = 0; i < MAX_EVT_AGE_PORTS; i++)
 		for (j = 0; j < MAX_EVT_AGE_QUEUES; j++)
-			flm_age_queue_free(i, j);
+			nthw_flm_age_queue_free(i, j);
 }
 
-struct rte_ring *flm_age_queue_create(uint8_t port, uint16_t caller_id, unsigned int count)
+struct rte_ring *nthw_flm_age_queue_create(uint8_t port, uint16_t caller_id, unsigned int count)
 {
 	char name[20];
 	struct rte_ring *q = NULL;
@@ -112,7 +112,7 @@ struct rte_ring *flm_age_queue_create(uint8_t port, uint16_t caller_id, unsigned
 	return q;
 }
 
-void flm_age_queue_put(uint16_t caller_id, struct flm_age_event_s *obj)
+void nthw_flm_age_queue_put(uint16_t caller_id, struct flm_age_event_s *obj)
 {
 	int ret;
 
@@ -125,7 +125,7 @@ void flm_age_queue_put(uint16_t caller_id, struct flm_age_event_s *obj)
 	}
 }
 
-int flm_age_queue_get(uint16_t caller_id, struct flm_age_event_s *obj)
+int nthw_flm_age_queue_get(uint16_t caller_id, struct flm_age_event_s *obj)
 {
 	int ret;
 
@@ -142,7 +142,7 @@ int flm_age_queue_get(uint16_t caller_id, struct flm_age_event_s *obj)
 	return -ENOENT;
 }
 
-unsigned int flm_age_queue_count(uint16_t caller_id)
+unsigned int nthw_flm_age_queue_count(uint16_t caller_id)
 {
 	unsigned int ret = 0;
 
@@ -152,7 +152,7 @@ unsigned int flm_age_queue_count(uint16_t caller_id)
 	return ret;
 }
 
-unsigned int flm_age_queue_get_size(uint16_t caller_id)
+unsigned int nthw_flm_age_queue_get_size(uint16_t caller_id)
 {
 	unsigned int ret = 0;
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.h
index 55c410ac86..babf73fd7f 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.h
@@ -28,15 +28,15 @@ struct flm_age_event_s {
 
 #define FLM_AGE_ELEM_SIZE sizeof(struct flm_age_event_s)
 
-int flm_age_event_get(uint8_t port);
-void flm_age_event_set(uint8_t port);
-void flm_age_event_clear(uint8_t port);
-void flm_age_queue_free(uint8_t port, uint16_t caller_id);
-void flm_age_queue_free_all(void);
-struct rte_ring *flm_age_queue_create(uint8_t port, uint16_t caller_id, unsigned int count);
-void flm_age_queue_put(uint16_t caller_id, struct flm_age_event_s *obj);
-int flm_age_queue_get(uint16_t caller_id, struct flm_age_event_s *obj);
-unsigned int flm_age_queue_count(uint16_t caller_id);
-unsigned int flm_age_queue_get_size(uint16_t caller_id);
+int nthw_flm_age_event_get(uint8_t port);
+void nthw_flm_age_event_set(uint8_t port);
+void nthw_flm_age_event_clear(uint8_t port);
+void nthw_flm_age_queue_free(uint8_t port, uint16_t caller_id);
+void nthw_flm_age_queue_free_all(void);
+struct rte_ring *nthw_flm_age_queue_create(uint8_t port, uint16_t caller_id, unsigned int count);
+void nthw_flm_age_queue_put(uint16_t caller_id, struct flm_age_event_s *obj);
+int nthw_flm_age_queue_get(uint16_t caller_id, struct flm_age_event_s *obj);
+unsigned int nthw_flm_age_queue_count(uint16_t caller_id);
+unsigned int nthw_flm_age_queue_get_size(uint16_t caller_id);
 
 #endif	/* _FLM_AGE_QUEUE_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
index f6cc09de9b..4f974a6e5b 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
@@ -16,7 +16,7 @@
 
 #define ELEM_SIZE sizeof(struct flm_v25_lrn_data_s)
 
-void *flm_lrn_queue_create(void)
+void *nthw_flm_lrn_queue_create(void)
 {
 	static_assert((ELEM_SIZE & ~(size_t)3) == ELEM_SIZE, "FLM LEARN struct size");
 	struct rte_ring *q = rte_ring_create_elem("RFQ",
@@ -28,24 +28,24 @@ void *flm_lrn_queue_create(void)
 	return q;
 }
 
-void flm_lrn_queue_free(void *q)
+void nthw_flm_lrn_queue_free(void *q)
 {
 	rte_ring_free(q);
 }
 
-uint32_t *flm_lrn_queue_get_write_buffer(void *q)
+uint32_t *nthw_flm_lrn_queue_get_write_buffer(void *q)
 {
 	struct rte_ring_zc_data zcd;
 	unsigned int n = rte_ring_enqueue_zc_burst_elem_start(q, ELEM_SIZE, 1, &zcd, NULL);
 	return (n == 0) ? NULL : zcd.ptr1;
 }
 
-void flm_lrn_queue_release_write_buffer(void *q)
+void nthw_flm_lrn_queue_release_write_buffer(void *q)
 {
 	rte_ring_enqueue_zc_elem_finish(q, 1);
 }
 
-read_record flm_lrn_queue_get_read_buffer(void *q)
+read_record nthw_flm_lrn_queue_get_read_buffer(void *q)
 {
 	struct rte_ring_zc_data zcd;
 	read_record rr;
@@ -62,7 +62,7 @@ read_record flm_lrn_queue_get_read_buffer(void *q)
 	return rr;
 }
 
-void flm_lrn_queue_release_read_buffer(void *q, uint32_t num)
+void nthw_flm_lrn_queue_release_read_buffer(void *q, uint32_t num)
 {
 	rte_ring_dequeue_zc_elem_finish(q, num);
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.h
index 40558f4201..ee1e2a63eb 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.h
@@ -13,13 +13,13 @@ typedef struct read_record {
 	uint32_t num;
 } read_record;
 
-void *flm_lrn_queue_create(void);
-void flm_lrn_queue_free(void *q);
+void *nthw_flm_lrn_queue_create(void);
+void nthw_flm_lrn_queue_free(void *q);
 
-uint32_t *flm_lrn_queue_get_write_buffer(void *q);
-void flm_lrn_queue_release_write_buffer(void *q);
+uint32_t *nthw_flm_lrn_queue_get_write_buffer(void *q);
+void nthw_flm_lrn_queue_release_write_buffer(void *q);
 
-read_record flm_lrn_queue_get_read_buffer(void *q);
-void flm_lrn_queue_release_read_buffer(void *q, uint32_t num);
+read_record nthw_flm_lrn_queue_get_read_buffer(void *q);
+void nthw_flm_lrn_queue_release_read_buffer(void *q, uint32_t num);
 
 #endif	/* _FLM_LRN_QUEUE_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 32aae24499..1a78933b7f 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -194,13 +194,13 @@ static int flow_mtr_create_meter(struct flow_eth_dev *dev,
 
 	learn_record =
 		(struct flm_v25_lrn_data_s *)
-			flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
 		nt_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
-				flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+				nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 	}
 
 	struct flm_flow_mtr_handle_s *handle = dev->ndev->flm_mtr_handle;
@@ -232,7 +232,7 @@ static int flow_mtr_create_meter(struct flow_eth_dev *dev,
 	if (stats_mask)
 		learn_record->vol_idx = 1;
 
-	flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
+	nthw_flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
 
 	struct flm_mtr_stat_s *mtr_stat = handle->port_stats[caller_id]->stats;
 	mtr_stat[mtr_id].buckets = buckets;
@@ -252,13 +252,13 @@ static int flow_mtr_probe_meter(struct flow_eth_dev *dev, uint8_t caller_id, uin
 
 	learn_record =
 		(struct flm_v25_lrn_data_s *)
-			flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
 		nt_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
-				flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+				nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 	}
 
 	struct flm_flow_mtr_handle_s *handle = dev->ndev->flm_mtr_handle;
@@ -277,7 +277,7 @@ static int flow_mtr_probe_meter(struct flow_eth_dev *dev, uint8_t caller_id, uin
 
 	learn_record->id = flm_id;
 
-	flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
+	nthw_flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
 
 	rte_spinlock_unlock(&dev->ndev->mtx);
 
@@ -292,13 +292,13 @@ static int flow_mtr_destroy_meter(struct flow_eth_dev *dev, uint8_t caller_id, u
 
 	learn_record =
 		(struct flm_v25_lrn_data_s *)
-			flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
 		nt_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
-				flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+				nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 	}
 
 	struct flm_flow_mtr_handle_s *handle = dev->ndev->flm_mtr_handle;
@@ -329,7 +329,7 @@ static int flow_mtr_destroy_meter(struct flow_eth_dev *dev, uint8_t caller_id, u
 
 	ntnic_id_table_free_id(dev->ndev->id_table_handle, flm_id);
 
-	flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
+	nthw_flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
 
 	rte_spinlock_unlock(&dev->ndev->mtx);
 
@@ -345,13 +345,13 @@ static int flm_mtr_adjust_stats(struct flow_eth_dev *dev, uint8_t caller_id, uin
 
 	learn_record =
 		(struct flm_v25_lrn_data_s *)
-			flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
 		nt_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
-				flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+				nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 	}
 
 	struct flm_flow_mtr_handle_s *handle = dev->ndev->flm_mtr_handle;
@@ -376,7 +376,7 @@ static int flm_mtr_adjust_stats(struct flow_eth_dev *dev, uint8_t caller_id, uin
 	if (atomic_load(&mtr_stat->stats_mask))
 		learn_record->vol_idx = 1;
 
-	flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
+	nthw_flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
 
 	rte_spinlock_unlock(&dev->ndev->mtx);
 
@@ -385,19 +385,19 @@ static int flm_mtr_adjust_stats(struct flow_eth_dev *dev, uint8_t caller_id, uin
 
 static void flm_setup_queues(void)
 {
-	flm_lrn_queue_arr = flm_lrn_queue_create();
+	flm_lrn_queue_arr = nthw_flm_lrn_queue_create();
 	RTE_ASSERT(flm_lrn_queue_arr != NULL);
 }
 
 static void flm_free_queues(void)
 {
-	flm_lrn_queue_free(flm_lrn_queue_arr);
+	nthw_flm_lrn_queue_free(flm_lrn_queue_arr);
 }
 
 static uint32_t flm_lrn_update(struct flow_eth_dev *dev, uint32_t *inf_word_cnt,
 	uint32_t *sta_word_cnt)
 {
-	read_record r = flm_lrn_queue_get_read_buffer(flm_lrn_queue_arr);
+	read_record r = nthw_flm_lrn_queue_get_read_buffer(flm_lrn_queue_arr);
 	uint32_t handled_records = 0;
 
 	if (r.num) {
@@ -405,7 +405,7 @@ static uint32_t flm_lrn_update(struct flow_eth_dev *dev, uint32_t *inf_word_cnt,
 			r.num, &handled_records, inf_word_cnt, sta_word_cnt))
 			NT_LOG(ERR, FILTER, "Flow programming failed");
 	}
-	flm_lrn_queue_release_read_buffer(flm_lrn_queue_arr, handled_records);
+	nthw_flm_lrn_queue_release_read_buffer(flm_lrn_queue_arr, handled_records);
 
 	return r.num;
 }
@@ -481,10 +481,10 @@ static void flm_mtr_read_inf_records(struct flow_eth_dev *dev, uint32_t *data, u
 
 				is_remote = is_remote_caller(caller_id, &port);
 
-				flm_age_queue_put(caller_id, &age_event);
+				nthw_flm_age_queue_put(caller_id, &age_event);
 				/* age events are supported only for physical ports */
 				if (!is_remote)
-					flm_age_event_set(port);
+					nthw_flm_age_event_set(port);
 			}
 			break;
 
@@ -973,13 +973,13 @@ static int flm_flow_programming(struct flow_handle *fh, uint32_t flm_op)
 
 	learn_record =
 		(struct flm_v25_lrn_data_s *)
-			flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 
 	while (learn_record == NULL) {
 		nt_os_wait_usec(1);
 		learn_record =
 			(struct flm_v25_lrn_data_s *)
-			flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
+			nthw_flm_lrn_queue_get_write_buffer(flm_lrn_queue_arr);
 	}
 
 	memset(learn_record, 0x0, sizeof(struct flm_v25_lrn_data_s));
@@ -1034,7 +1034,7 @@ static int flm_flow_programming(struct flow_handle *fh, uint32_t flm_op)
 	learn_record->eor = 1;
 	learn_record->scrub_prof = fh->flm_scrub_prof;
 
-	flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
+	nthw_flm_lrn_queue_release_write_buffer(flm_lrn_queue_arr);
 	return 0;
 }
 
@@ -4575,7 +4575,7 @@ int nthw_flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 	(void)dev;
 	nthw_flow_nic_set_error(ERR_SUCCESS, error);
 
-	unsigned int queue_size = flm_age_queue_get_size(caller_id);
+	unsigned int queue_size = nthw_flm_age_queue_get_size(caller_id);
 
 	if (queue_size == 0) {
 		error->type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
@@ -4583,7 +4583,7 @@ int nthw_flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 		return -1;
 	}
 
-	unsigned int queue_count = flm_age_queue_count(caller_id);
+	unsigned int queue_count = nthw_flm_age_queue_count(caller_id);
 
 	if (context == NULL)
 		return queue_count;
@@ -4604,7 +4604,7 @@ int nthw_flow_get_aged_flows_profile_inline(struct flow_eth_dev *dev,
 
 	for (idx = 0; idx < nb_contexts; ++idx) {
 		struct flm_age_event_s obj;
-		int ret = flm_age_queue_get(caller_id, &obj);
+		int ret = nthw_flm_age_queue_get(caller_id, &obj);
 
 		if (ret != 0)
 			break;
@@ -4843,12 +4843,13 @@ int nthw_flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_
 
 	if (port_attr->nb_aging_objects > 0) {
 		if (dev->nb_aging_objects > 0) {
-			flm_age_queue_free(dev->port_id, caller_id);
+			nthw_flm_age_queue_free(dev->port_id, caller_id);
 			dev->nb_aging_objects = 0;
 		}
 
 		struct rte_ring *age_queue =
-			flm_age_queue_create(dev->port_id, caller_id, port_attr->nb_aging_objects);
+			nthw_flm_age_queue_create(dev->port_id, caller_id,
+				port_attr->nb_aging_objects);
 
 		if (age_queue == NULL) {
 			error->message = "Failed to allocate aging objects";
@@ -4898,7 +4899,7 @@ int nthw_flow_configure_profile_inline(struct flow_eth_dev *dev, uint8_t caller_
 	error->type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
 
 	if (port_attr->nb_aging_objects > 0) {
-		flm_age_queue_free(dev->port_id, caller_id);
+		nthw_flm_age_queue_free(dev->port_id, caller_id);
 		dev->nb_aging_objects = 0;
 	}
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 6318a32e4b..c580684a84 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1547,7 +1547,7 @@ drv_deinit(struct drv_s *p_drv)
 		/* Free all remote flm event queues */
 		nthw_flm_inf_sta_queue_free_all(FLM_INFO_REMOTE);
 		/* Free all aged flow event queues */
-		flm_age_queue_free_all();
+		nthw_flm_age_queue_free_all();
 	}
 
 	/* stop adapter */
@@ -1981,7 +1981,7 @@ static int port_event_service(void *context)
 			/* Note: RTE_FLOW_PORT_FLAG_STRICT_QUEUE flag is not supported so
 			 * event is always generated
 			 */
-			int aged_event_count = flm_age_event_get(port_no);
+			int aged_event_count = nthw_flm_age_event_get(port_no);
 
 			if (aged_event_count > 0 &&
 				eth_dev[port_no] &&
@@ -1990,7 +1990,7 @@ static int port_event_service(void *context)
 				rte_eth_dev_callback_process(eth_dev[port_no],
 					RTE_ETH_EVENT_FLOW_AGED,
 					NULL);
-				flm_age_event_clear(port_no);
+				nthw_flm_age_event_clear(port_no);
 				do_wait = false;
 			}
 
-- 
2.45.0

