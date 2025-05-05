Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCDFC3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:15:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C64A40DD3;
	Mon,  5 May 2025 09:13:59 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2BE3140DD6
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:58 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 mx-outbound16-191.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IH+fvgfmBf+LQgP+Lnrm/3CVsZeJXmKm/QHrCI569QUTAsKEv2mZDI3ptt8Zew98HTQBt8DNpbQjrAdveNzCkLLauAYSuB7IZbLnVzoJvIbCjCFMJQYpg9Al1RFHsP6c2/tRtbFhYuul5PfFehUgSXBh3JYP59rCGtBZjZBIvI15Jfmxte6XM1bUqC9Kvx5n8MmE14wdqp8pkxPY56ReHSmGs7TSRkpBjqI6m1l6e1LNVEI7NRR9FPNuBB+vCJRg5GxtG3DyoK44GrYcJqweA9lKiWmWmrRB1Qq2yGZlo/gyZMowX12bVWDVuTkc+CCeKTlEzUM5NKiryySMlH7h1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAWkLOInEHAbB/+B8f7LfgZZzq5BQLeIljoDox7pv7o=;
 b=FiPem9mQ766oqX0Va2HesjSOxKDOWRUNXlM3Ccq3qOCJbtSaevNXKXWOT5e4vwmjNfCRM+Ki41PLAqrK6a7uD/tIjAbSTBQ8LKiB+H26Er5TAyl663jaybsx543wqHCwNqQAl9qe7f4Up6uWDhChVRxqAk1gJQA1aHhfRh5FKyFaEcMr/J/Qy21Uz3g05s6VL4aNPOWpdgrf34QlEm0138jMjUUylhEh0fXQX9+HZv+Fnhh1LL/icqBgxJtibyjfmaK3r0wK/+nHO3qWkWlXo809laoVs8BxHj7BcZG5KMLJi9NyxnfFJgQGAR+VdQuoY/14VzNOAQvp4guBSu6gWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAWkLOInEHAbB/+B8f7LfgZZzq5BQLeIljoDox7pv7o=;
 b=msYWKbu7E1Ek5FxP70d6r/odu+SMDVLy2UrE+IhWW/l5/jYIvC5U9DNk388WzNtgeLIaRqGslg/ag73gk9FnB7w4Rh4lKF3zGckhaS9BhlejTuwv1m14pqVMFrok51tblltnm5TiGjeVL25+cpNDYDe/h07HyDj83D74oDeKH/E=
Received: from DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) by PRAP190MB1715.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:27b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 07:13:31 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::ec) by DUZPR01CA0328.outlook.office365.com
 (2603:10a6:10:4ba::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:31
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 25/26] net/ntnic: avoid possible deadlock
Date: Mon,  5 May 2025 09:13:05 +0200
Message-ID: <20250505071309.586015-26-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|PRAP190MB1715:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 613813a1-c116-4c7c-95f2-08dd8ba45754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zEw1Q0qaDc/29NTyFh03+WuSlAd+MQG4GoRkFPsUnwS0kv5hHtj0TtnP+O0i?=
 =?us-ascii?Q?ZmAnjysBVcF8nizni2vexiguqNvzxAsbEbp7JQH3j7ypU7NwekXF8h7K0cpP?=
 =?us-ascii?Q?2t5ywbIAzQCIrDXNjYjkEBDDp7XYp4eiQrIu8Gnk05PMQ3W26LQ0CciQnVOy?=
 =?us-ascii?Q?rSwJGHgcdi6wPcsSa8MKcGDkUJsVgGoMP+X1D2XrOv2wXU3cMuMmcXakBIBw?=
 =?us-ascii?Q?y7LoYp1LmzBs3cBhreS32nYM2wGJH0cbugzT/pB4Hx6ZqXk0RsuPkiO9qaLw?=
 =?us-ascii?Q?ARSWoPwBdOJaLq8Qq+sps7rqpVqwRVhwAIQanVDeoHejx3KPvpNWupN5iXh6?=
 =?us-ascii?Q?Tvpaj5q0QdoEdK3JJM6glp6bk+LF+6Wq7aBVcQulYPughwIOjCJN3wiMBQ0+?=
 =?us-ascii?Q?f3s6nE1BuV1veSHHMNch7ibSsbwlpFX+7AM3BDPoRi540v1TeCqD4ysZmhnx?=
 =?us-ascii?Q?bj207pbJz6DYFVoyyhNjTwJEdoVceqd/D8oV5y8va+Lq7LZ+Ff39SP83P24o?=
 =?us-ascii?Q?DoNRenbU2xUtncnu40UKNcLN5wNAHYJPIp2pyjC9VlT3JggFUzodXRwMFf3u?=
 =?us-ascii?Q?O1QKdaP1l4igVFbSU0lHEq6SMjDA5bvrg9q/xuIkvm+mAoOl4Ut9QQKzdasT?=
 =?us-ascii?Q?lFgYzpLb8kbMFoewqNoY5dGkSX0/ABiH8hgKndRXnY3Q0u1M2MVURuO9K9oL?=
 =?us-ascii?Q?CpQqlpLFS6+jGs2IyNKPR7hdPOjxhgXse1Cn6dwa/+BVYCt+JVtzhxlZBFYB?=
 =?us-ascii?Q?J22Dude89prhnmfgsH4gqryiwIskiZMzBJ6lLHfPhuPgjeEWqVGFt/snpd/H?=
 =?us-ascii?Q?n6YvK3Ixl3n85eOs9Vc8eFV2sTdUOGxXZepbzIjNBs6NYun0Sov649uEDJij?=
 =?us-ascii?Q?qN1srjh6V3ZB0tQHeGRJJB7LoN0lmx72jK5KvSQaGRNM3QdcybzO4xn9BkHP?=
 =?us-ascii?Q?MrEP4YfLoMw62m0RXRURtqbliv4iuMWB0uXgLpjHwKvWGYreBE5TPtAesxZv?=
 =?us-ascii?Q?oVIDjD6J97V0pJFrIdiU1T4UN0vErKE7+a7aWo+3z7A/e4C9FuzRfmMubJ2f?=
 =?us-ascii?Q?AADnPNDzQeIyBGSq4vjqDjBwhKReGxdMfMfnhQRwnL3qyZ2IBZZOrwnlv3P0?=
 =?us-ascii?Q?5usODj9mAO/iRDhIIcEZV74RgYDCDVw09ynflKHnmKJKP4+PMkdhsyZHe4Wg?=
 =?us-ascii?Q?hfhLi1Bg52BdY5W+/YlGWmYq9VY/iA1XRJO19/GXmEDVqpSdDSWWfoh9hlBY?=
 =?us-ascii?Q?Ypw9aGeotXk+r9Y5IqiNcH2YEmFLGaW2DBG8T6qpoT6FzvJZVHCJsgMxh4oc?=
 =?us-ascii?Q?NvrxFdS9CyaNk1wXpdtvDOYVybtnT1zUxNhv5JyCTcRbAhUz1B7kw/Ozn7Kz?=
 =?us-ascii?Q?AeYJd+iKQpFb2Glvb+Hwd6SkXYcV5jIr5sqOw9I47xYBhGr8d6EqOK38ntnH?=
 =?us-ascii?Q?BiXTcxNjSNX2ysG1EBLRH/+wLgrfgTdKVxCPXUtwrriH7l8x9mFJCweHXjhQ?=
 =?us-ascii?Q?RMPvxI/elkndHSPzCYtZByrThm0POr6kwCFH?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SLfWV85hC63HSg+dPR1VeXrZTnDW9EBWwnXwLIzNjVJ2DECPRkIpRMvNsp7Um0xH2sBQoqFR1fwOWPYXptxidmpGzbrGcRl2xQtNzfiPPX4vHJaIBGYlFBjO5mOqqbUBwbI9B/icOm7PPeH7oJ0RtX1/JY6d2AqNG0ZMT6lZ1qTqwbBgqjz5sJ/2JET/TctbQ70F3L/CQjtduSK1WJXRGIQXeU0M68Y8Qf26WA6NSmCdlbNxL9ZkDnpiVJvX4OYeMrOfQIEB5fBV0vnOIlDn3N5XveFpp2q6BmnR2VCZdeIF+BcyEEE71iza6X320wnsTnkFftn5sOs4tno/TveDE1RezpUHc/lwgCCjcEYmTwVp1UGaPGCHwlRLZlQArouXmXJlyB2MgK9FcW+BPV0Zw+VEolFvwO1ORDvXRrXwytveE7lsIpnA8ou16jzerjDerwdCrzM6iiX2WvYlLv5ctU6AEzMo1d5ebzy55CZ7j+8q1/gdn+keb/uZsaGXzggl4gfEbIDnwV1PbXJnAP0+wmE3Vn9kCkGvTfLup7GWrda5HLmx15Acdrq6bxNondJQAjcXeCFrcgOgHMHrH+Hbjjh0cbyK+C10qqMHY9M4gL6eZi7FHNK0io1Tr0hIamiViG2gi1dCVJoNIM5+C9ncKA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:31.0631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 613813a1-c116-4c7c-95f2-08dd8ba45754
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP190MB1715
X-BESS-ID: 1746429214-304287-7663-5339-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGpqZAVgZQ0DwpxTzRIsksLS
 XZICnJ2CTRPM3ILCnRPNnIyDDZ0NJcqTYWAJvBa59BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan18-185.eu-central-1b.ess.aws.cudaops.com]
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

Sometimes during  high flow learn performance two threads
could cause deadlock using queue and mutex.

learn_ignored variable sets when flow learn and gets
when flow removes. Hence, learn_ignore should not be protected
as far as two thread could not access to the same flow
at the same time.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/include/flow_api_engine.h                | 2 +-
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ntnic/include/flow_api_engine.h b/drivers/net/ntnic/include/flow_api_engine.h
index 859c76656a..6401c79e3c 100644
--- a/drivers/net/ntnic/include/flow_api_engine.h
+++ b/drivers/net/ntnic/include/flow_api_engine.h
@@ -297,7 +297,7 @@ struct flow_handle {
 	enum flow_handle_type type;
 	uint32_t flm_id;
 	uint16_t caller_id;
-	uint16_t learn_ignored;
+	RTE_ATOMIC(uint16_t) learn_ignored;
 
 	struct flow_eth_dev *dev;
 	struct flow_handle *next;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 3133464675..cb6a66a061 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -518,9 +518,8 @@ static void flm_mtr_read_sta_records(struct flow_eth_dev *dev, uint32_t *data, u
 			uint8_t port;
 			bool remote_caller = is_remote_caller(caller_id, &port);
 
-			rte_spinlock_lock(&dev->ndev->mtx);
-			((struct flow_handle *)flm_h.p)->learn_ignored = 1;
-			rte_spinlock_unlock(&dev->ndev->mtx);
+			rte_atomic_store_explicit(&((struct flow_handle *)flm_h.p)->learn_ignored,
+				1, rte_memory_order_seq_cst);
 			struct flm_status_event_s data = {
 				.flow = flm_h.p,
 				.learn_ignore = sta_data->lis,
@@ -972,7 +971,7 @@ static int flm_flow_programming(struct flow_handle *fh, uint32_t flm_op)
 	if (flm_op == NT_FLM_OP_UNLEARN) {
 		ntnic_id_table_free_id(fh->dev->ndev->id_table_handle, flm_id);
 
-		if (fh->learn_ignored == 1)
+		if (rte_atomic_load_explicit(&fh->learn_ignored, rte_memory_order_seq_cst) == 1)
 			return 0;
 	}
 
-- 
2.47.1

