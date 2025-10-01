Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C5DCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:12:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4036940EDC;
	Wed,  1 Oct 2025 17:10:43 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 16B0040E68
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:39 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021083.outbound.protection.outlook.com [52.101.70.83])
 by mx-outbound13-239.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq2fIiimvbxCSRKkGUVx0GyYAy00g2ivHOHkUWzvxevN0koFRCyprNhUlsnud40Gc+qEBdVNk/NCo0kp/8UEaTZrnaO19cKUu7hbGVjFGrbRDvaFAi7qZcR4fpPJtkOWp68TLDK6jpk1W23T+bH+0NZAopbhtI8QUzHGeepPFu/UmOEnfl/g2xzX/XOuZu51takACF4tXQq/uMH5CrqhTME7Xouj4LB2OdZkFAcVcPihpk4cupD1pzaS076S00sJWHsO4qRi6AJa0M6mYB3NxruHfRPRL0ZMbmHHBS1wUYdw433GlqTchq3zf2pK6pB1DxGWG5dpY5O/KExo5Spuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9exQVg3M2INBD5BpUlagXzlUwcr9POojQhQ5rIMuEo=;
 b=L08sx5GGr5vbiffFbEDUbFSPgu0v9MjCbphQslZSTYG/SIqLSFChi96y4Eg34ZE6WJzXdtCHNC66oNAG/FLwGOMHIxNXldrYqL881+rciPUouG2fZroXVkx44QhKb9CpN3glhXYNuN8P3qbLDuNJhXCw6Vh7dj7wFyvEf9yOu/74QCSgJtvsuSuUW1LoDjeRRMlx9EHF2B3hrci06VnUWLOfcORoNSClH+eImCbzmVoSnmeM3+Y6R4zPOg1/wJ566lSKhBm3tEqBehi5MchHm7tMh7ddtdLs65GG8/GpJuYBG3hS+KdJI2rInGNE+U8Nwxplh8mQDn9SlwdHM8qygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9exQVg3M2INBD5BpUlagXzlUwcr9POojQhQ5rIMuEo=;
 b=UCnCwy+Cjvxi8yEs9Ad8lUDayFS5XocWFrI2t/KB+vWjUUE68hFnrRN7eugqoBEMypH/HwS1DP53DGntfYcuNw/rDsgyffDEWyimlCPV0iSZOx8I5eeyQj5SFgF1rFUv6UlMg2joGzBKiGbfA8Cb047SjhfP6t+dDsCaJssk7sk=
Received: from DB9PR02CA0004.eurprd02.prod.outlook.com (2603:10a6:10:1d9::9)
 by PA1P190MB2634.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 15:10:36 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::53) by DB9PR02CA0004.outlook.office365.com
 (2603:10a6:10:1d9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:36
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 16/20] net/ntnic: add flow pull
Date: Wed,  1 Oct 2025 17:09:58 +0200
Message-ID: <20251001151018.250671-17-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|PA1P190MB2634:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 23501c14-b861-44e1-5019-08de00fcacd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nkRcZ2b9gEawHfcs3TycoypeMIGZU6f4jS6b8mC0olayLMg+ZLXemr6QbX0/?=
 =?us-ascii?Q?SKoCWYv9c7aHfOKAR3OHkGvMPB505XamG6oKzS9JzWiaqZ+sls4WCnzOAYJs?=
 =?us-ascii?Q?+gicH9GIVqP7NXIv7l5LPw7a2wIKzDBv4Gc2d/2QVctVSrr/ZPeLX2pCkhjc?=
 =?us-ascii?Q?Nbf1SF1fa3Ru12ZEFVWQt1/CKyZUCN0oAjqSpuivH3LQww1tlbE0yNfLrBzr?=
 =?us-ascii?Q?JmrSWvBNUQ3mynyQUo2VEnb2K5gFngdddsAevP5TUTImQEhrHJVJnqDhq3HF?=
 =?us-ascii?Q?hKB6l9g+woklOjtkhVfpmXus9wbgYYWMpj9AJGDhRwIiHQh+Nhxus8/PoGQD?=
 =?us-ascii?Q?aDJMFSh0YyInsK7KGeIenbgDxn9pZup9Fwwgo74Z5dGeXOyY7EREDuD6wJPM?=
 =?us-ascii?Q?mX5tD7fiaXr8Bx6ay02LcWfJcYtfCQ6xxnjB6Q6Y8lGa0rzyL3pqNRX8nv+o?=
 =?us-ascii?Q?avoDvBzGaCd0NLt+H3HV9cGW1GXWnecX0vumqtlwYBlYvpmkC3PyQEW8lKhX?=
 =?us-ascii?Q?rz70En9XO0rhOfCkZG2lN23dgAxA8eoY9tFE3MU6/6H4djE3qGtXahKKyR4n?=
 =?us-ascii?Q?PgsWhje2dlxYo7If3qP3MWYTFsPqB6xTTEfGGKU0kgcTzL1KOrbOjaJowlBS?=
 =?us-ascii?Q?9ReYWlDfX0XocBD3zDA0xVqhYQ2FN5qFhHGL8zkViTbhhx/cejBja2Jl32zU?=
 =?us-ascii?Q?9g12hH+wv/qlgY/vcOxzItc6IfrTj8qzxtUASK1ZaXFcUm9ZtbpiuyoA+VBE?=
 =?us-ascii?Q?x3fc4iqtuH9bsZ/IMr0AV1GecgeEu3nUyydjh2hXnOkiYsrHqPMaZsB9y3wK?=
 =?us-ascii?Q?D/syWPJWCasRdKGwR1p+tJckONukhAU3J1kG4az9rRe2oGptWooFf7sTdqST?=
 =?us-ascii?Q?0p4Je44psT5t/i2Cq6LZhvxNQNIVcEMgQcFOyKF/4cAzBA7mjWQNi07eaAIc?=
 =?us-ascii?Q?eJ9I2SFE71+B0o/gdm1DurFKiI98L3xK+4RhRNoR9pMBisGPAgYQwHxOe3dG?=
 =?us-ascii?Q?udztsutQiCa6B+XbkSACu3glGpAmVEFar5/yB2t+ZL80mIY3SFB3h5v4/ntZ?=
 =?us-ascii?Q?1bNN4HU1z7DWtGbFLXB3kOwDeDc2yEdSyzvDNdsYW1sWCiEMN3ZllVKhPug2?=
 =?us-ascii?Q?GfU03uPQ9KA6xQtwFPb5CGyJq8FDhfQYWjD7V/R1kXmB247piHgkl7RwqvDk?=
 =?us-ascii?Q?NfaJQNxU7V2fkzzizjL9FuT9B0eKBVxmRQ8wrBsNdehAktKUh6UgmOQ8O+t1?=
 =?us-ascii?Q?1LqwQmF+atx/9jFLGoo9qLtLrUvr6K6So4QW0uRvjqCbkqjeqUvvxzdbyz9Y?=
 =?us-ascii?Q?OPN0EbyP3qEhWGYSgUBgE59Evz+5mwWMKCkwnjCbswd3To3GKCfVqU/QIbv9?=
 =?us-ascii?Q?AUsg+lGyZq7FkYIQwS04FiJ2jVBZiyVxS0dr2EtzCTz8KsYNtRJLsCaAdcWQ?=
 =?us-ascii?Q?SAtkQf2DoCF60rw9bjrWUzidR+H11N9ykdqO/3NaGg5DCnuQYGQ/HV+yepxM?=
 =?us-ascii?Q?GifVzgbVFiZ+x36wCZgcMN0JPebAykiUkOuPNkQom6y1StNzoSVRLSmKYtjc?=
 =?us-ascii?Q?POkJc3WvMPhzsqDv63M=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TZvl3SWrFUn3UuBYLKVdDAqKUO3zaU8iSou4rFr6MuWXEU5+3rwSoq+O8siJafvPmQJkjpiyjgQXiuCEewAePTT1w0DdVnb2H4uy4ZecbKGC3PhqPGwL7gZ+Ue5pG6uhRHa7/25+J/uKz9PPdWDpHHquJcKY68Lvp5/HaAzQ3V3N4zdISl3FkITWPsRXaX3d6Bh5Q9LWeG1QFHVhh6aCluB+044sBHm97fNIxdKJylPPKGRbivVtQiww5xOEpLuVI7/tR/rddlhKR5wyo7MMg+LnayOFyMxQAIgzCvHkpuaKm0V+MNaRk/9XLOdJ7Yq0KOAndNL/qhPI3b9QSo2kklwtBkM/Aj/DwkP+NJTZprSmCIe/id8t1Y6bpOn9/sae9cb4FkvVrzJsiIKtFHttFtM3q6rC9mcbznGRhnKPeCI37vzex9sIkgPjv7TaPnbK+zqp2ayDMfxeMmPwvyLUdToN3iot9Z69KKXkOVCNzVGGGF7YnrhJ8b7A6pTDFVW1dWf7WNX20D6DcOoiIP9fqfjT4fAf87WLM6yuQcZhwENQZcCl4ORFLFVDgU2OazWcsoCnvKKK/BEAiHlF0MQeuff95e0UIyLtasW0ihDP0LhbE/+gMeA8Wa7DRVEY8mldAi1VqKLwlxSrlRiHtPnZvQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:36.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23501c14-b861-44e1-5019-08de00fcacd1
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P190MB2634
X-BESS-ID: 1759331437-303567-7604-4437-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.83
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYW5mZAVgZQMNkwLdXcxNgsyT
 zFwsDYMMnCzMjMNDExydAkMdHQLMlQqTYWAN5+aLlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan21-48.eu-central-1b.ess.aws.cudaops.com]
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

Implemented the eth_flow_pull function to handle
flow pull for ntnic driver.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/nthw/flow_api/flow_api.c    | 15 +++++++++
 .../flow_api/profile_inline/flm_evt_queue.c   | 14 ++++++++
 .../flow_api/profile_inline/flm_evt_queue.h   |  1 +
 .../profile_inline/flow_api_profile_inline.c  | 33 +++++++++++++++++++
 .../profile_inline/flow_api_profile_inline.h  |  3 ++
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 29 ++++++++++++++++
 drivers/net/ntnic/ntnic_mod_reg.h             |  6 ++++
 7 files changed, 101 insertions(+)

diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index 3e45db67d7..4adf847f33 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -1214,6 +1214,20 @@ static int flow_async_destroy(struct flow_eth_dev *dev, uint32_t queue_id,
 	return profile_inline_ops->nthw_flow_async_destroy_profile_inline(dev, queue_id,
 		op_attr, flow, user_data, error);
 }
+
+static int flow_pull(struct flow_eth_dev *dev, uint16_t caller_id, uint32_t queue_id,
+	struct rte_flow_op_result res[], uint16_t n_res, struct rte_flow_error *error)
+{
+	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
+	if (profile_inline_ops == NULL) {
+		NT_LOG(ERR, FILTER, "profile_inline module uninitialized");
+		return -1;
+	}
+
+	return profile_inline_ops->nthw_flow_pull_profile_inline(dev, caller_id,
+		queue_id, res, n_res, error);
+}
+
 int nthw_flow_get_flm_stats(struct flow_nic_dev *ndev, uint64_t *data, uint64_t size)
 {
 	const struct profile_inline_ops *profile_inline_ops = nthw_get_profile_inline_ops();
@@ -1274,6 +1288,7 @@ static const struct flow_filter_ops ops = {
 	.flow_template_table_destroy = flow_template_table_destroy,
 	.flow_async_create = flow_async_create,
 	.flow_async_destroy = flow_async_destroy,
+	.flow_pull = flow_pull,
 
 	/*
 	 * Other
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
index 42da580235..4693671809 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
@@ -289,3 +289,17 @@ int nthw_flm_inf_queue_get(uint8_t port, bool remote, struct flm_info_event_s *o
 
 	return -ENOENT;
 }
+
+int nthw_flm_sta_queue_get(uint8_t port, bool remote, struct flm_status_event_s *obj)
+{
+	struct rte_ring **stat_q = remote ? stat_q_remote : stat_q_local;
+
+	if (port >= (remote ? MAX_STAT_RMT_QUEUES : MAX_STAT_LCL_QUEUES))
+		return -1;
+
+	if (stat_q[port] == NULL)
+		if (flm_evt_queue_create(port, remote ? FLM_STAT_REMOTE : FLM_STAT_LOCAL) == NULL)
+			return -1;
+
+	return rte_ring_sc_dequeue_elem(stat_q[port], obj, FLM_STAT_ELEM_SIZE);
+}
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h
index 1be02c6750..db309bfb6e 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.h
@@ -51,5 +51,6 @@ void nthw_flm_inf_sta_queue_free_all(uint8_t caller);
 void nthw_flm_inf_queue_put(uint8_t port, bool remote, struct flm_info_event_s *obj);
 int nthw_flm_inf_queue_get(uint8_t port, bool remote, struct flm_info_event_s *obj);
 int nthw_flm_sta_queue_put(uint8_t port, bool remote, struct flm_status_event_s *obj);
+int nthw_flm_sta_queue_get(uint8_t port, bool remote, struct flm_status_event_s *obj);
 
 #endif	/* _FLM_EVT_QUEUE_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 19c552bcd4..a7f96cf451 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -5400,6 +5400,38 @@ int nthw_flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t qu
 	return 0;
 }
 
+int nthw_flow_pull_profile_inline(struct flow_eth_dev *dev,
+							uint16_t caller_id,
+							uint32_t queue_id,
+							struct rte_flow_op_result res[],
+							uint16_t n_res,
+							struct rte_flow_error *error)
+{
+	(void)dev;
+	(void)queue_id;
+	(void)error;
+	struct flm_status_event_s obj;
+	struct flow_handle *fh;
+	int count = 0;
+	uint8_t port = 0;
+	bool remote_caller = is_remote_caller(caller_id, &port);
+
+	for (int i = 0; i < n_res; i++) {
+		if (nthw_flm_sta_queue_get(port, remote_caller, &obj) != 0)
+			break;
+
+		fh = obj.flow;
+		if (fh->type != FLOW_HANDLE_TYPE_FLM || !fh->flm_async)
+			continue;
+
+		res[i].status = obj.learn_done ? RTE_FLOW_OP_SUCCESS : RTE_FLOW_OP_ERROR;
+		res[i].user_data = fh->user_data;
+		count++;
+	}
+
+	return count;
+}
+
 static const struct profile_inline_ops ops = {
 	/*
 	 * Management
@@ -5438,6 +5470,7 @@ static const struct profile_inline_ops ops = {
 		nthw_flow_template_table_destroy_profile_inline,
 	.nthw_flow_async_create_profile_inline = nthw_flow_async_create_profile_inline,
 	.nthw_flow_async_destroy_profile_inline = nthw_flow_async_destroy_profile_inline,
+	.nthw_flow_pull_profile_inline = nthw_flow_pull_profile_inline,
 	/*
 	 * NT Flow FLM Meter API
 	 */
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
index 2c2d0e2fbf..86e867b728 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.h
@@ -123,6 +123,9 @@ int nthw_flow_async_destroy_profile_inline(struct flow_eth_dev *dev, uint32_t qu
 	const struct rte_flow_op_attr *op_attr, struct flow_handle *flow,
 	void *user_data, struct rte_flow_error *error);
 
+int nthw_flow_pull_profile_inline(struct flow_eth_dev *dev, uint16_t caller_id, uint32_t queue_id,
+	struct rte_flow_op_result res[], uint16_t n_res, struct rte_flow_error *error);
+
 int nthw_flow_info_get_profile_inline(struct flow_eth_dev *dev, uint8_t caller_id,
 	struct rte_flow_port_info *port_info,
 	struct rte_flow_queue_info *queue_info, struct rte_flow_error *error);
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 124d9a5b67..044f2e55d9 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1173,6 +1173,34 @@ static int eth_flow_async_destroy(struct rte_eth_dev *dev, uint32_t queue_id,
 	return res;
 }
 
+static int
+eth_flow_pull(struct rte_eth_dev *eth_dev,
+				uint32_t queue_id,
+				struct rte_flow_op_result op_result[],
+				uint16_t n_res,
+				struct rte_flow_error *error)
+
+{
+	const struct flow_filter_ops *flow_filter_ops = nthw_get_flow_filter_ops();
+	if (flow_filter_ops == NULL) {
+		NT_LOG(ERR, FILTER, "flow_filter module uninitialized");
+		return -1;
+	}
+
+	struct pmd_internals *internals = eth_dev->data->dev_private;
+
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
+
+	/* Main application caller_id is port_id shifted above VDPA ports */
+	uint16_t caller_id = get_caller_id(eth_dev->data->port_id);
+
+	int res = flow_filter_ops->flow_pull(internals->flw_dev, caller_id, queue_id,
+				op_result, n_res, error);
+
+	return res;
+}
+
 static int poll_statistics(struct pmd_internals *internals)
 {
 	int flow;
@@ -1365,6 +1393,7 @@ void nthw_dev_flow_init(void)
 static struct rte_flow_fp_ops async_dev_flow_ops = {
 	.async_create = eth_flow_async_create,
 	.async_destroy = eth_flow_async_destroy,
+	.pull = eth_flow_pull,
 };
 
 void nthw_dev_fp_flow_init(void)
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index fa511e78cd..241fcabddb 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -397,6 +397,9 @@ struct profile_inline_ops {
 		struct flow_handle *flow, void *user_data,
 		struct rte_flow_error *error);
 
+	int (*nthw_flow_pull_profile_inline)(struct flow_eth_dev *dev, uint16_t caller_id,
+		uint32_t queue_id, struct rte_flow_op_result res[],
+		uint16_t n_res, struct rte_flow_error *error);
 	/*
 	 * Stats
 	 */
@@ -560,6 +563,9 @@ struct flow_filter_ops {
 		const struct rte_flow_op_attr *op_attr, struct flow_handle *flow,
 		void *user_data, struct rte_flow_error *error);
 
+	int (*flow_pull)(struct flow_eth_dev *dev, uint16_t caller_id, uint32_t queue_id,
+		struct rte_flow_op_result res[], uint16_t n_res, struct rte_flow_error *error);
+
 	int (*flow_info_get)(struct flow_eth_dev *dev, uint8_t caller_id,
 		struct rte_flow_port_info *port_info, struct rte_flow_queue_info *queue_info,
 		struct rte_flow_error *error);
-- 
2.45.0

