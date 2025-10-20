Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59118CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8106140E0A;
	Mon, 20 Oct 2025 18:36:45 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id C3CD54067A
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:39 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021083.outbound.protection.outlook.com [52.101.70.83])
 by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CogJhKFhPwHYNvzkOXYsS/jB5sowfq6uNDjutCevvtZz9ci8i9dOZlZku604lJhMRBFh/M6fMzOY/Vv43MMlW36NLgx+MKLvNoTnmapf+xcsr2TeH+2eBnAmWyqxsFparUsvhy/ljdkZ6aZ/MM9LC6xU5onGJy+TNTDpFJv1xpyT5N26NSIhpDKJz0prCNHMBeJ6rivNoeZOhI9O15jB7Wyt7ar7bvp6TUvJAA7wg7zf4jUh9MMjB4TD7OGy9BJG9d1gHAylIznY27AuO2JhvNBiWbn5vAhFs8khM+joD/dXxhsUiBSpKLdz/stQO/e33Pu1NvmLRxiNLNnnDM6oHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hegyqYQ4c6ufeM7lcOsIVkLpa/QlkBYKMziG/FnXSA=;
 b=K50owjUKis+9hMPM2WvEt9oxJ5wNZFEXW483AWfvXjVpgUTrCiIL1etNzYdSSxObAv7RKMwG4w+iEpcqCka1IhVAh+Rg+FIGjtNTESwuYGxuI6bnZ5W80InWBO5vY7wgwjOohUKuoIIUXxG0flpngPD6ycN+fulhvod7h+A2u5lDm60B/j39oe6bmHLbzEmJ5SkqLkySlSB1p8ZQWl1b0IXl2Ku0Yf/2//HEDZeASewaAp5Fd5j4cuBT5eA0Wv9NP98DeTKDrmTzD10NicbM5GXsgW8cXzrHASanspG67cHsGvylpqF/Wnn6kkrZfdvnvQT17XvNbtioybdsmtwwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hegyqYQ4c6ufeM7lcOsIVkLpa/QlkBYKMziG/FnXSA=;
 b=A9uOSVDRjTIXRqIyMtDT6/489f6Zbva7wA7TX0ksCr+szEctuJNSyt07DsLKwJLvby1DUwQMu2OZfMfI/PwCBnXFlmxCmpg8G9zhOOHavVR1Or6Nz+uEIOpQIjY3wrBToddcFJHtQjJcBpMssVzljsornnWZBuiZaPwYhI6atvU=
Received: from AS4P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::19)
 by DU0P190MB1858.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:37 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::5c) by AS4P191CA0023.outlook.office365.com
 (2603:10a6:20b:5d9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:36
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 14/24] net/ntnic: change prefix flm to prefix nthw
Date: Mon, 20 Oct 2025 18:36:05 +0200
Message-ID: <20251020163620.282312-15-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DU0P190MB1858:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c06914ef-0d1b-4c94-391e-08de0ff6d699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wgotf06kJE3FkXW59bOPbG58IlPyCVPRWFXWlugNCaCeDOEgTkdLUEByghkr?=
 =?us-ascii?Q?u91JTJGaoM5bXSNrxHZCDNTBwQPEIWcQmNcan4sJTIrPPnbNi6PLX6lD3HNR?=
 =?us-ascii?Q?kW9nFR0Z7B0szmtFJNuuH69hAvirVu8HQpIIhm5QZvF2F4oYVcunsHjkP7RW?=
 =?us-ascii?Q?eLcvvd+ZQTY9RjqLJ1+kOotYjY5vioAb6yb8lwKP2UufeTxF9473l7jbeoze?=
 =?us-ascii?Q?fZsGCtF+6Xzf4i7fKJVMKEKNaNr6CgSCWND+YdSj9UpPutROFhC1BXECBLHP?=
 =?us-ascii?Q?i7LcYDHnOmghv6o/ccbP3D7d56K7EcawoW1k6OYcGROrvxMuYXyajw5tqeq+?=
 =?us-ascii?Q?p+qnD7OSsVdUOthGlqAdTMGFwP3XPf0WlQDtZZhvz28uklgX+HnHQA8HdZ21?=
 =?us-ascii?Q?2mIOXL9M8tDrdJsBRYC/E7GyuJo9iRTlv86JunFlhDA+p3jl/fqv6hBx06Jb?=
 =?us-ascii?Q?Gti/I5x82AHBG1Z3+oTX+in9vuSwodRgrDGQM+qMxZQekJyAMgm7aUhWV9Ed?=
 =?us-ascii?Q?zCQwWh/zxCtsTP2tExP6i3wawexl8LjZZmIhwS2h93NZvhco+hh7b1KiIWw+?=
 =?us-ascii?Q?2CVulNoQTBw97tqf7gkDZcGV9AcKwtFlEKjRTQFglSWoiBntPlPLLSHtCchP?=
 =?us-ascii?Q?za1Esnwlkd4Tb8bULJZ6l+Vdex/Phoqz4ywyA5/xHlIRzA5DDl4qyiEYbsPF?=
 =?us-ascii?Q?lKic0PTGXy8EV9HPl0MnEBHuIwv+eXOo0lUzCgeIUrJIjk3ACZb/iNBo6Eho?=
 =?us-ascii?Q?kYbdDgAQ3DWBGAIEI+Lqp97yGma1RULKvDxq/tGuxpyeOV6AAupQHlLO5GNW?=
 =?us-ascii?Q?HZupvYT+HUL6klJw09sSlVS3AJ9cUUfRfJ/e+FN9ZSqpCScKYrq0Nd6XABJW?=
 =?us-ascii?Q?jL0dikEIQTc68l5SZqnfJ2bAZgRWbp8gXvh7uk4HXr4tCecUriG71+HMXDpm?=
 =?us-ascii?Q?h50Pc+MoTlpLh4iYtedvT/QvarHIKXT3ayp+Q/qjOEPQk6IIDWOkrQofOPrS?=
 =?us-ascii?Q?yymhKitAQwO8M8N/ReXZxSa14EkK1Yxe3+Xk/If1DWxRMUTt7L4O+HUWoSLh?=
 =?us-ascii?Q?WuEhpFJtcILicA7ZVRJLScPQ0ARJVvvxMPuXmUUKaxxC1eIfufqO4PZqh9Un?=
 =?us-ascii?Q?eVYLix94ycp5S7RzUmLMQ0Ab0kQfe0JrteY1tjiKhOtOQ58CmmpMCtIhzXLm?=
 =?us-ascii?Q?P8XiBHlWHE8IsSz58izC7Cs5y9MXxLPcHsf7df9yCiKQQSqj/onQHTYeetxI?=
 =?us-ascii?Q?vmnoxi4ckLgmJziq4pPXfCG0h96vIF3RxMRxtkyypXPM/v4MwPN98Nlndo40?=
 =?us-ascii?Q?IV6CzesG68UzvplQtoQktjsqaywgEn3k7iiyYzuBudGb94n7ChX/f4XEVQM6?=
 =?us-ascii?Q?8hWaVHWYGfLx0d7CnWV8jP6l11uTsTxYaIBH9jaAnNwGHxzh9hr+MHRJ73Of?=
 =?us-ascii?Q?RWC/L9/gFZko31QgZTY/Kfxi4ITbjc+iXLAVqCdg/+/eKHtFSLmXAesajsLc?=
 =?us-ascii?Q?0khZO2WNclZr8BWuDOWn13kJnBsEc3D5Fk/pbLRRf+QATOXl9evqrzM3hmf1?=
 =?us-ascii?Q?WX2LDUmiYPCSLNWabYw=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tFqUuffMiaea6b7cqm+/ngEz0IjxwXA7Y7/NIawb6q6aogITQccuiTWptYg6cV5+5hXUSEPSaiYrQr11WYYJFC2ugNLWWZEwOeApWanMQLVgTiSVHg4b512U0FQzg/47iAOFpJi+eeqYnCjInvd2z7lkjch2ErK1dt4kROSqMjBE0R0+sQ11sn5ONitEMKT+licWyI/MM68N+SlREHiDDlsgatd6fEsaHpZfx3DK8ECPYWhDucigE61AXQ5B8bnVib4UARQj3lTitSUaL9gOMM+6w5KCGw0m9FgBntSG5o+aINA0UY8wDURuytCSV2jOGyDYcT85IW/2M8GISQxGE/Bd/7w5O0eEeLGBflhPME3jIer5FyUNZ66nZn5iaU/cXNa1aAdUPfWxct6gQQRUqqBhpZdvJAQmVTo1VzPHcVqxV9fXIOjJZf5gzjQg32lpDE1hJbzDqEcyey2yghotQxJaEYohoqC8ipRbL8gugXkJ3GR6ab3pov1bq2FJXbNtjfYUHcyC9nT/dRKJzcXHP0fnFmzwJycz8zfLQxTh54CjpM/BliR5/dbtYoanmy2HsV7BOQ4FEjnPFpahpsi82gFSWTEIIx0DvnOHrsLGpUOKt/N+mYfWx7chpO3kaiSw+1uF3cNvtnJiJflynhXHFhO2xkg5wCx6VshDWrI1/p0=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:36.8753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06914ef-0d1b-4c94-391e-08de0ff6d699
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1858
X-BESS-ID: 1760978198-303027-28481-63522-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.70.83
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmhoZmQGYGUDTV1NDQwMgkxS
 ApMcnIwjApyTIx2cAsMdkyxdA4ycLIUqk2FgBqajqXQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan20-247.eu-central-1b.ess.aws.cudaops.com]
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

