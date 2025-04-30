Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C2C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:51:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 751ED40A8A;
	Wed, 30 Apr 2025 15:49:39 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id F13A540653
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:25 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2234.outbound.protection.outlook.com [104.47.51.234]) by
 mx-outbound42-181.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTod1wk8Xe2sHyioAx2RZG2LOaP9yJfTABJlxUEjV0zCGHafsDSolWqFErzS/pjRSwyfYUSTBvLH88mAmoLnqQumMXthq5bKtGPBBTQ+/tt9EiNk7pD+DZ3+7BY2u0s2HPcHPbIV1k9mVYVJsyGp7nTGPUBfOvb2iiexKEYME5M2XZ4DN5jgH9OdKnS9/99pj/EffZjhq9Vj7Qzt3i/p8adrVM09phOCBN5cX7xSOAJMEvYC2Z397LJO+SDSp/jSziMGP2ZXiG2LJcQqFsrFYfLYuwniRp18Rq7/Ufs0MxHGY39vLpPKYvpcHzkmx/1jLNvcwxuKB6u0Tby5CB6jsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox8RKrfHfr30b9v3pyzxGWMvb0yXJJqRXfRrTBTvOb4=;
 b=SZxYSF3ZXpNvmb28PVLZ8HQHVB++x53HbepchPWrp01HNOyyyR6nNAn9eJDWXTfN+KV0EDGVrPvGEojStThk9WHNuHmY1pGa8gSkv+SSWzxbIJVTrJ1IhZXEhKvB4SFX8Vo/WBFUrZq2+aIP0ohTm8cMXkS/XANPesLfsnl/XNzKrzlEMQj+vku4gxVZ5nd9nX++z99B4BiQPEKq7/S4dr+1fs5cnl74wqHWhY4DiFeCD+kp1qOS0NOHvI1SGyxmU2hEvLfhWtrLd/oRQFyrprO7bzMMRV/TbpQtu9TQH8nX5VyqsUHZ6U+XB0sF0wAQlMig6JPnOyRNWmn0AKwOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox8RKrfHfr30b9v3pyzxGWMvb0yXJJqRXfRrTBTvOb4=;
 b=jaxlT3pN7OhH2ngFrr0qRfLiNZX+B4pJ4GLmP4SP0QZaGB2ZpZtwgcqx9/UIV5A6NYxDOe8PUOdJDDOl/3t8L5lMLg3RCXk7LqySY7Hvj4XnblJSBRE6RXEqFgF0FDBgYKr4DCk0V05DaIvYrfqfGpvwOFRYP6JLMfIBT2J6JAA=
Received: from AM9P193CA0028.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::33)
 by DB8P190MB0633.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:fd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 13:49:20 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::23) by AM9P193CA0028.outlook.office365.com
 (2603:10a6:20b:21e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 13:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:20 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 19/25] net/ntnic: rework array usage
Date: Wed, 30 Apr 2025 15:48:31 +0200
Message-ID: <20250430134840.402553-20-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DB8P190MB0633:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d8d58588-d1cc-4e4c-9c15-08dd87edceff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P7R3vBDFVdzKtkmSxR/uXdBRRB6PQ8FhkDHGL/3QUO0jRFVL64EE47AGNt9h?=
 =?us-ascii?Q?kVMHLRWDdOOsJ3UD77LupGg4DkJehVNQMWuz3FU9lvj04qEzLDIKEfMEu6bf?=
 =?us-ascii?Q?YQzpM3oVaUUmLutL1qQ+qqAZ6mi4XBV9TI67fpQ19kHgJKd+RNftJSj9V0R9?=
 =?us-ascii?Q?lteXbIRTeiOJGzM5crGDyOrasZyAB1FO6zu1x1vrdWxB84bql6fSxtF5Bnqi?=
 =?us-ascii?Q?ku546DJGc0xbmLc+KY0RDP11iLukWMqz8S8Ly0R5ATVdpmq/pZEsYM0ARa6h?=
 =?us-ascii?Q?ZLi2K4NNPy+R9sxTRdb35MbBQ1lfhuflGEfM9mccGfXIfG5ryCYoKX3MXxw/?=
 =?us-ascii?Q?2ZoKidNEu49bSjoj/IL01YFAiJ+ggsSPHNKSUqpus+C1hnXZxh552hJXg2xG?=
 =?us-ascii?Q?fmPE4zcZm8S4FPX72vXCob6B8XwQBeGHxRtpbfSQ726Gz0lFyn7nwz1StXFI?=
 =?us-ascii?Q?4xTUJbkBqaRlLLagyV4O6E35PqZmxDisfAcJF/liL4amjYGn9Su2movosx+u?=
 =?us-ascii?Q?cSyx6gtK8pYBSgJ4nJpX3Ar14o6/WFu36DnZfyD5SbcLbrV8kocVil/CYD2V?=
 =?us-ascii?Q?iUdfUpRJWmO1i8KMg8kFkrYMQcf9cblSZ8rSesmWfwYxHi0rd3V7gvNhR7sr?=
 =?us-ascii?Q?7ncv8r+T1+c9l4DePE7Iu0nnEdH/eXHQCNQyuxY1FP/4cHvs1oVElUdIPDJo?=
 =?us-ascii?Q?XW7zG4BtozPYdj65VNnsY93CZc0xhf1ej3omcqXy36izHq1zCeMBFaE5UKpA?=
 =?us-ascii?Q?9ebvt9OpxBVCK9IknNXMGP3f9gIi+Kz++p4Jfal7yCyzxZVroto2zl+e71/O?=
 =?us-ascii?Q?r25RBTY9TY4teG1/h/O7/vQ1bdmj2ZMDsoZ3gCqlzDvh51sBg9hr1wiJKh2G?=
 =?us-ascii?Q?4u0dNV6T+ZN8JQGW52brtWNM/QMjISVM/NobaMIHu30cvNLTozRw5LlaKsvQ?=
 =?us-ascii?Q?/aBySVL3gBRrXw+CHl0ZE8rQAMm9hWqOiOz0LmORYQQviM4OivNVZPSVrG1D?=
 =?us-ascii?Q?uChk09xllwSCji7xQWQLAyH+QJar8KuKC4boHB7svTKGCC4+u6h4VcTZQWR6?=
 =?us-ascii?Q?oRxS5U4UMYBLv4m0fWX0d11SRMK/E0ipkuju7Wuv7SItHWWwLjOBaVrDeb9f?=
 =?us-ascii?Q?lX8ag8y91Dupuwiins5/B9uGWbuWziuz+5jgFYIgsOuyl2+PWtRWI0SRNZU2?=
 =?us-ascii?Q?ssr0PIUjnzLj5f1VdUNGiohQ4OP7OMgdXWV7N3dp0PHKOuZFCrNFL9HfTCmK?=
 =?us-ascii?Q?am1e2fFbQHQkSmll9EsaE7ZlJRjw7pgkGzYOVv+QsRlq4Wt+05MYor85pi/b?=
 =?us-ascii?Q?4vMvASWnFgBfezviQ60gcKKWY3C2CBJjNdp0DipaQb14XKLTClNJ6lMk3Mla?=
 =?us-ascii?Q?yR2jyjO+I6wMVZhfGvXdajWmTjq2RuQjzzTnH4rZEis0USwzxuRBfWzIeBf8?=
 =?us-ascii?Q?jnAdgmh0JP6jhwlwO5HH62fQKtu+oiT7KG4T/KfUfUh+sYvXTeU7pEOXFnJi?=
 =?us-ascii?Q?l0K/NJ/M2M7wnZ0+HbBh1rkjFuOL7ZY6Fy2/?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V1OzrxWsYeqM7sD5zxqQ32+Hcp/bvHw3kA1t5ebErKD1RY/yqtRIF0MMUCtYwtXxpOeDF51Aoi4jVIqNXXM6FzC4PaoDBGlGx2fXmEPL2kXhKSTYkgtMU6jbN/P0WQHWDCs9SO2NpTgDgZHUYZBa4lzWg5fM1expjR1/27mTWOrWEjsVyS09hjo9iEg9T8cYWbNS+TOeEyPmor0LlrT/d3A5CdJa9CYu8mk0aOzWsOadw91rDHPWvjGAPETuUMfSWhUmgjUjpHJpIVzvXBsZ6c8pBKDaDfY4rL2jAsP4OGGWWzr0wpwxnXBPxNIOQRFzqGJJckN5q8uV/vsgYeC1M7vGaqFKOpbvrkQopQfKbOLgzAqAo3BZk44vdv0ZC2DdDHFFSQhz6OmH2S3hv73Y8gf2iLwmml4HxMi7BO4K9OLuPDIaTWP2X2AxTt8MK8uROrN3Rnuw0i1Ddz6LRPpVxsQKOIK6Yl7GzDBswf9yjXqKmsWLEqa800py53OVP6GmGAz1VFNKYAMz37pxCzH2x0lpJdXF/M7elyJpy8LO8qpS5W2mIIsOg4G1wqdlmn3z5go6/ZOlSzqFTxKmwtC4GG9dJKf3FfqvTvICYwujKAmbJ17p1YYBi3sy5MorBdhMhbbeO+tb38s4YrCfUAR/1g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:20.4918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d58588-d1cc-4e4c-9c15-08dd87edceff
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0633
X-BESS-ID: 1746020962-310933-7993-578-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.234
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGZqZAVgZQMDnF3MTC0sjcwi
 jRxMQgKTHVxNAkJc3MMCXNNMXCJNFMqTYWAFCc1gZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan10-142.eu-central-1a.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Array usage made more explicitly, avoid pointer arithmetic.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c   | 8 ++++----
 drivers/net/ntnic/ntnic_ethdev.c                          | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 6d1d01d265..75a7504510 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -908,10 +908,10 @@ static void *_common_ptp_nim_state_machine(void *data)
 				RTE_ASSERT(new_state.br); /* Cannot be zero if NIM is present */
 				NT_LOG(DBG, NTNIC,
 					"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
-					drv->mp_port_id_str[i], nim_ctx->nim_id,
-					nthw_nim_id_to_text(nim_ctx->nim_id),
-					(unsigned int)new_state.br, nim_ctx->vendor_name,
-					nim_ctx->prod_no, nim_ctx->serial_no);
+					drv->mp_port_id_str[i], nim_ctx[i].nim_id,
+					nthw_nim_id_to_text(nim_ctx[i].nim_id),
+					(unsigned int)new_state.br, nim_ctx[i].vendor_name,
+					nim_ctx[i].prod_no, nim_ctx[i].serial_no);
 				link_state[i].lh_nim_absent = false;
 				NT_LOG(DBG, NTNIC, "%s: NIM module initialized",
 					drv->mp_port_id_str[i]);
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index a8ea7ee140..e46e93e347 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -379,7 +379,7 @@ static __rte_always_inline int copy_virtqueue_to_mbuf(struct rte_mbuf *mbuf,
 	 * 1. virtqueue packets may be segmented
 	 * 2. the mbuf size may be too small and may need to be segmented
 	 */
-	char *data = (char *)hw_recv->addr + SG_HDR_SIZE;
+	char *data = (char *)hw_recv[src_pkt].addr + SG_HDR_SIZE;
 	char *dst = (char *)mbuf->buf_addr + RTE_PKTMBUF_HEADROOM;
 
 	/* set packet length */
-- 
2.47.1

