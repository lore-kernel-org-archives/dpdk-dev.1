Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11849CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:20:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 739F640A4B;
	Fri, 19 Sep 2025 11:20:24 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 86027406B6
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:22 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023093.outbound.protection.outlook.com
 [52.101.83.93]) by mx-outbound16-38.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge43dmrcuY70iwX93luojQSlz35Xu4pdm4hkJaKb4mBcSkIpcE+jOaeEVlXm2r2/eMUU0Dqw0Cn/F1rCLUG49J/RRIe+ImghnccFTVJNJ4o1uGucKiHf0cgTFnFdVT4hnVotR6AvD97yN++74RczSBLCyGVcgXImcElIy0uAF6yWk5bs4iSkOC9ae8PWUY1m1R52GjBMtv+YF/smH/jWuc51VNUQidyb4LnQgKAtoiq8uwBfMSlzqBiCA/f/P/0k/N6NoWYCwNBMzKbhk+EEtttPr1haJ5IZLaFqZxQQFCZ8RGGd8aHRmp+xpyTs9WKrhO2lNhq5LbF6Pj2Lc6Crlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR1mnIIbPBz0nr5etQVvWkOevawyrtpPN4qlZ1DtJoU=;
 b=dFmEcYaWMfwODWzuF3H03UmQHG66K1uCju4C7Nc3QCjXpGW/Hgwdz2z6jWq4bWO5xrTb2LXy7/efxqNadiJT2tlPEcVtM3+cxzblF4BTmsbCHKNWoSrpZU4sKLYflGQpzO8+a4KFzwg/GcBnBv18nSS0ad6Lxj2ZxVCINfzzH2fpST811PcaZZRTJ2QxWgM+1Hz9g8O8u6XspFqtDuSaWSsSuzGVaFNdLdyvx9WVpJm9IZtohixERy2c7IzS3P3ImxsEZ7bnA5DclSWhO2ySPq6+Q7mAhouxVktkVH/nUGrK5mAVThhc1AIDcZhFCdy0FBwVaCbJhkDFp2QFr1vQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR1mnIIbPBz0nr5etQVvWkOevawyrtpPN4qlZ1DtJoU=;
 b=ivEFFmfMhekkouEVfbvG8AXh8qvNDbjNZ45zCK2FXPMMmTgDuLuMxIzRtS7nvqOi7y4Ffap24x6RBeKtVIvys/e9blwBvLE64mB0eyEpdd0z7PwimJJdvqExAU4eg/qIFrJOv8GZsQPr7ccOpF1vb2bQpY7eGFNxDwVIUb+jjnw=
Received: from DU2PR04CA0357.eurprd04.prod.outlook.com (2603:10a6:10:2b4::32)
 by DB9P190MB1795.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:33b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 09:20:16 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::39) by DU2PR04CA0357.outlook.office365.com
 (2603:10a6:10:2b4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Fri,
 19 Sep 2025 09:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:16 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 06/16] net/ntnic: change prefix flm_ to prefix nthw_flm_
Date: Fri, 19 Sep 2025 11:14:51 +0200
Message-ID: <20250919091504.1548351-7-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|DB9P190MB1795:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b70a4216-4285-4363-2b4d-08ddf75dbf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ZNUaDRm1rfchQVsPe9khvyl7MrvPEbJXxcD1wLSfU39Btuld2oECFb3wCfH?=
 =?us-ascii?Q?Sk9VhCedd1At4Ai3rmHRuhsNrO6HE6xh1FUVpNPBwP7h9TOv+vtxjJvWdRoU?=
 =?us-ascii?Q?RXr4R6jVCclrrM5pIBrNZXnT5RXqYNbONuvUrXLPRiLq5vrnyzFf4BL75Etp?=
 =?us-ascii?Q?MBVFijXUADWbaNL5dx3YapgpFPcyr1MKLQnoNab0ygaKNvWVYY3cdPGMRscO?=
 =?us-ascii?Q?LY2C2aVpvc+gXsMXI6N5A22v/77cIYsKTPTXCJWkYm5PyqQ9eKfvWHcbIjgt?=
 =?us-ascii?Q?GaOkTa6pp4AwFCi7QqJnES8X1j3XJ2hm5PO2VuUVQhAH280QgJGM1dTh59Z3?=
 =?us-ascii?Q?H7+40alncmLWtnI4X+G8E7wanMiuOzM4pMFFprh0KFtHIiZJAOqGcRX0BYfa?=
 =?us-ascii?Q?fZtZ1udXfv1R2z7URDPdPwnIvzkfJ/bk9HMuIWsSvdCraURZlRFTKo0qhfPd?=
 =?us-ascii?Q?YOF2SgPwEooQhGnkQwrA7HrL7bEIxNlnN1mWQus02xmoJVcsvBBZW+onMXzU?=
 =?us-ascii?Q?DE9CiiMNlQxcVZDkqKUzBgEJcaWdCzN9/6NdUDYUbocWpZrnTUrgPuMJ5hOt?=
 =?us-ascii?Q?VqPgbDpLEVr0Al/eJRq/1DE0HnkjJ/EtMyZDf7/M5XUtlEvWu8nPoc2UDvW4?=
 =?us-ascii?Q?WmMhUEfCqX2mc78KyPPaa8+ovjwgKe7ibM6o3mVv0Fss/VSrgdx5bVZTsreq?=
 =?us-ascii?Q?ORwNbIkOQgi0U0/U7xSpc60N0JUiXdjfxhHqR8VB3uEs+VeF/Biws3FcbDQF?=
 =?us-ascii?Q?8g4QpZAX1Qp8PqhY/0GjInf63ToPBMMzY7Ny/xzMguUGLsr18hd1ik/QHzmL?=
 =?us-ascii?Q?iXmx6+vcwL4SLFq8AG2SEXhkbCDvATS5zcOXl9/xXA41YaX9V84mO2R1IuNl?=
 =?us-ascii?Q?XMfP2s9vnVdw/lGhVajyDM/zXhrdhiuD7Tp5p7ZD9fbr94khCEIPmI8O5vtG?=
 =?us-ascii?Q?xtyRQye6iHEDSWs5V3jiCB/ucGjHNzRrz+Qm4JWV2yEmKYPdZnog5bxSuK4C?=
 =?us-ascii?Q?jNqF0aGCp4gZQQ1WmqS2a84OUDySEN2OL77Yd9mAMM3nZgHbK8yBTZrCyrXr?=
 =?us-ascii?Q?PkEi9KXkApAswGMemtSHKiJ5qOwijvFR7OOogrhS7GFOi20rt5WL6M/FF0ly?=
 =?us-ascii?Q?LIrPuonig168+RosevOsZEBeYGISMV8iN/Nrdla/lUzXLX//GjKCIi/7J8XE?=
 =?us-ascii?Q?eB9VT8DcHxU0iAkRAZIezst5cdcso+BAm2jRCKZP5NUVvuI5VYS95Zs37LwP?=
 =?us-ascii?Q?zfzT3C3AFGAzl0UOhiKCGAevaSmJEPRRWphzodIniZ49Nm7S7SnHjErd96Wd?=
 =?us-ascii?Q?mL/V580cJmiEtNcLa53ENz8peGSmbU54mPhU8G7FSFrZDBmi/pXpBP+Gstnx?=
 =?us-ascii?Q?SnLZtpe0zP2n0GC6v9d2xN6SbymVXWum/ZUD3pnXGNSDX415++lcb/lPs9cM?=
 =?us-ascii?Q?5p9cTP6GWrFoYIqP5Has9hbrtRslt1Y98J/7TjyrAQpEWSho1B4CbDnoWBNR?=
 =?us-ascii?Q?nXY20lDu7ACm2jrDi9HR0huXf87VZ2b+U9uC?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0B4qaM19fppYDVHeJ6ntdzGGOLc9BtSFJvqD2gszhK7ekZYHRyDP/Xbtpk8KGTUuqoOGgJaIfRCfsN6TAuKBeTvwPKbRercB6jBxPIIGpxldyJOectT7mTt3UhdGuV66fgMXgKaKHMasPXtUq8SkRwkNKO2k3mkS02aLUgNZFGhTI0OHIwZNbDvIyy2elKIk3vSrk7H2WLAEDtGGuhJWW+tAJ5b5F5oXPG9FWgAjV99nXl9JUWej8fuz2Z982Pf9ComsyZpnUcd1mwyCjAYvIzbBbUB9H+nPIz+u/qkDN3EFnd/DhFG1TYiHlF5g+tvbzrJR3jTOHjgTcr8aSqo0J8jNJMg5j07sNTn7KquH0ypTWHSaU15PmEe1OQOjyHVB6MKIyo4j4DiYSlzaBjabamraRZyqXJVY6rn2KfGu95aVK/sM2zFk+SlMZ4DE2AMmXIU8COYJ9GoUo9pajSnTIUgItyuOtAtzya+2D5+AyC3Qx2PKuPsZRHhKwBpnSD8OVvFv8gtHgmrLs3R+y8+VIU1Bp5mCQtZ/RTGr1r5T8oyvrXzPSJ2wGb8AmQNcCIO13SXYmbJNCcKXz8n3fNLbsZZwJiVBrwMnGL2+ZOHvaeOuqrzlVdUL+FZUoO5CsI+WCAAh2ikUoCnNyiMUHQnfig==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:16.5422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b70a4216-4285-4363-2b4d-08ddf75dbf1e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1795
X-BESS-ID: 1758273620-304134-7642-1094-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.83.93
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmhoZmQGYGUNTcxMTE0swyzd
 TcLMkgLdXIJMnA2DzN1NLIIDUt0TLVWKk2FgD+oO0uQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan22-120.eu-central-1b.ess.aws.cudaops.com]
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
index 9e6cc0e4cd..b515a69c87 100644
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

