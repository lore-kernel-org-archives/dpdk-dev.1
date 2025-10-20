Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F86CCCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D957442DFA;
	Mon, 20 Oct 2025 18:44:13 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 657F340E27
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:54 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020113.outbound.protection.outlook.com [52.101.69.113])
 by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UePMdAJaKTzv7PstaahyH79vLdogbxZldrlWj39PftMrbGO/uRdkX8UWTz8B+54FtuTCl7DPEQro3RTiOU7ZktFuZszFHiIyn9TrF1C/1Htu9q+1UWJ6Zg/Tpf/3S0PjLBbr5EpGl+hcnRWv6RkmwREgCNBjcuhPm2PIY4EPscUYKZoDmkmeYHDd/6rtEt4Z39tbD7WRnznmGsNqXIuXOaL7WH5uFKoIh49d9FchOLzLtNKJGwS2pD4xBYbU48dWf8EpCsOH7v0DMhhHGuVEkPRpA5EqLG7Dgf4juD4FSLH3UVpLLncOndSpWwNW7Ss+hDyMEApYTJzqUISpiCs8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9exQVg3M2INBD5BpUlagXzlUwcr9POojQhQ5rIMuEo=;
 b=h9t9JFL6b7zaQnH+BtQwyTeBUYagVt0ew9SgoZkE0yRZdUOqqCKuiUTqex/XxRj/egoRcgdLI679DTYbPgSQErm+uiuKZeeJ786WP+3JJHFvsedlCe5OGc/S0SpcmbFIwvEeuVbyHRVyNt+3soQ7FixERTBFnIAbU8TDcw++4PzLzuhSsy5Tue8o8tQo2nYVvIm9shgJANPZu166ZaqvtYgP7QBm+gYWPxGN0i7NPeHs3m9j8rAooQh9jWybEVe/UwT52NgkQoJXXRt4gpjPuniOI8nm1wHcAISHpB2lmgHCjGq/K/Uxc5sn8sm8gu+g+jZ7hsN0m+WeLS7x7oAInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9exQVg3M2INBD5BpUlagXzlUwcr9POojQhQ5rIMuEo=;
 b=HZPR3VCFBkcMXGLgn0+tdA5gfkJoysi/mqVp7r/XF9yyLs9m+6U8KNa0ZQsQ0a69C7jUc4LHLx337lLSeuIOtqBqFZ45sGwyKczDow7oUX5kmTb/8cYelmHJ87DQY0AFUnT7fRGAhRYBsus+tZSR9EuhptEfeg3Yi9aNE1MsnkY=
Received: from DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) by PA4P190MB1309.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:105::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:52 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::84) by DUZPR01CA0023.outlook.office365.com
 (2603:10a6:10:46b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:51
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 16/21] net/ntnic: add flow pull
Date: Mon, 20 Oct 2025 18:43:25 +0200
Message-ID: <20251020164336.283664-17-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|PA4P190MB1309:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3c7be50a-36cf-4fb7-af7a-08de0ff7d9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tpOXz4QSzRKSbCGr+zHVPDPpOsB4lx9mjUvTfIelxOedwsFj2Ydov88Swvf6?=
 =?us-ascii?Q?SHkvRWIl8AqOEZ/L2lVP3Ih8Vgyq8D63VIna4V0nOWPjvzGszNO7KB4MuDRE?=
 =?us-ascii?Q?CHgiOItsdQ2Yl2kxrJk0bB3ts6S8ZNNEV9jDY+sDDdtsWQyiTheppbWeV3ri?=
 =?us-ascii?Q?8CC3Hs/d6HiOtFNylSHuIzWh+QKkK9Ua/BMV1ogp+eUtdzYPfNN2erPECPvg?=
 =?us-ascii?Q?wqsAU8CnIQ/G4qeElt/V7xEoL6yOJdttjT+/ROrmBsFl6B6Xh63qn+AFD3D/?=
 =?us-ascii?Q?aWRYmf/pG/z108bBSD+0JFfAnwY2YoVP1kebuEUJ6j5igZ+E8k9MaEUd5lYL?=
 =?us-ascii?Q?qW0zK4VpBQW6HETHstEk6Eopy8bBh4NWjaRY0ig3YoUDXxPrBoyKumI+eFz+?=
 =?us-ascii?Q?Yyn1giyjqH9llS8WnNgH8kpvUNZlzD/I1XG6L4oHr5lgua6rqRjNyUuoXXFN?=
 =?us-ascii?Q?Li+PDZVmlDYHohFa2Oq2yT71RxIl7+FiKWlFw10Ghc3stQkPVuBa2MeurHrz?=
 =?us-ascii?Q?umWSRfGkVhS0t18aOvjkiVWmNuDcIlM9Z0bZV08ypC8+ILivMsmHE+803kgW?=
 =?us-ascii?Q?TUwUdh5EoGjx51G4LyMnnSKurnF8k7JreKeCqlNN6pRms/+6bPzeYMVlNouz?=
 =?us-ascii?Q?Nf+PbUQe9+wTWS6zIZzkaUVY1+zVJrNK0T+L+Ja0B4ABV4y2BFqYo/sva2Ji?=
 =?us-ascii?Q?nnQUYVXBFK2dbwovWzuoNnxPs3kpNdvvppahwddKEFw7Vae8TS5je3bdQfW4?=
 =?us-ascii?Q?IabRJCjRafmRVu7aTpFMjSzsgbLXSrWmiuw9PzRMVprJjVkjnrtbP0jPnri9?=
 =?us-ascii?Q?TgsImV2kEqPQbqRCzTCGCIJRPSsG2Mk55nKbBYzCDoLOXA2akRPirTPc+caR?=
 =?us-ascii?Q?NYx2Mb1ld5nkRHQkUq1tMZOEjEWWtAmA8vTeRHZS71fBOSv16m5v0UbICWgx?=
 =?us-ascii?Q?sqjHpT8IzPLgAit+gkIPB9AE/hGsij62VmyWkxxoKexHTI55JrKDohLJ4vsN?=
 =?us-ascii?Q?wVxLiUnmHKOVLtvlO6xlt92CRQpncb11z3J6LhLP8azffx7Uk5JqtH62IKYO?=
 =?us-ascii?Q?2Bcer/fa2othcs3K60Tq/mz/NwDuj9HqH1jJDyln9+IMDn3hbSazKwr8V/0X?=
 =?us-ascii?Q?fQHWPix4S56Hhyj5NOtmOFibYqcOhMpEK01CBrmIaaJo+Ga3eivSqSRxp6ff?=
 =?us-ascii?Q?WblkInQu5tQRfJngC7bJh1ExrjFtjSV6aAWap+ylm/uYmU9BWaZM2AVM3ctQ?=
 =?us-ascii?Q?oK6nFodeYCFaZY09Zbi9DzKTrOUvqeIWacREOGc4mY3QQXR33zyi8DGi/tFw?=
 =?us-ascii?Q?aTD77A84F4nWbwdy8ADw/QVtNyMaQxlyt9sdW940RNusuGdi/mhGacsfa8GO?=
 =?us-ascii?Q?IKsKRzQ/p1klqE8NYI82wdrq0lPpHqCf8WJrmlch03VOA8/hZTdIGLfDt14d?=
 =?us-ascii?Q?1IDjp3C54tsgqPAwkUUpVCVQeaKEO6blOmW/dDT6sEXUmAsPTXO8FoIOSR1z?=
 =?us-ascii?Q?NNkkEdgQ8Zxco6BSgQ5RkMXzrnfKBzSyDpXfIiSrXTS9MRT/rekoKJS2eJi6?=
 =?us-ascii?Q?IiFXrPa4RbhIAh0xfkU=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0LVPSqQP/1qK/nsCdTVyBzxbN4+/b7FnB6DfISLWjCP0XJZl9Xzl9SHUuPiwbVqm7BgSnzdASRf1wTzmxxD5ZUfDtRpC5nC79Af6HxpOwlBCVGrv8rFe6Fn5ESByt0wQ7GRocHVGrPMhBidhu/yaLKBr7buYfartn6I1/c3/6WU9icyPvSDFBXDd7bT7zP/8Y9PluIsPi33vXJ0uq+/JkSq7PoobGqO9+YTErWemOOFN8Ds+4lYj5DOfy/fpaTgaCUVe70coSZuw8gR3OxOHQbnvbmGQio0Z7KzYHSFtB45dcp50JkufNBt9el/N0IWPBwGPSBQoP27aHicdaN2gnBFs0gDMoQMIXTgweb99EorYFgCIw062uY2lb3IwuSf+/qqUzsHAyXdQ96n55yX+cmI5H5SZd2PQ5VmZ2vXqVZvuqWFunAQ/1Xne04E1XDioB3Ay4em6eEvhtoYa9+1+yrT8bR+XVaR6wd0dUarl3ULRp+35CCcgRhssx4Df+KT/JD+FoJUS2JzDczN2rNloV2DGuusPyLTvGLmyo+nlLK1T1/QhMfSD3iP7j0hLQ6vFbqFDvzJXUoysN3mNfJi6Swge1y4nZpgpzGP58CIQ7EgzSY6Lc/UhE6T/dNNULjpEpY+oDP3CAKYFj7K0LBSbZaqi20NYSIrm9uEguiE71ek=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:51.9941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7be50a-36cf-4fb7-af7a-08de0ff7d9f7
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1309
X-BESS-ID: 1760978633-303027-28482-63644-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.69.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYW5mZAVgZQMNkwLdXcxNgsyT
 zFwsDYMMnCzMjMNDExydAkMdHQLMlQqTYWAN5+aLlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan12-246.eu-central-1a.ess.aws.cudaops.com]
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

