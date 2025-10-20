Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8ECCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:45:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B816A42E1D;
	Mon, 20 Oct 2025 18:44:12 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 8DC2F40A7F
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:53 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022084.outbound.protection.outlook.com [52.101.66.84])
 by mx-outbound44-20.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnTQbIuCf88gaQ40UAyUkzZJerTC/yhfT+2fQoYTVyY8UoksM07X5kXEdmFTTy3xCPSa7nCjMnQjFhdMeY3TFEn73saBEWQXb59R+aGTNsaasLB952UxriaHFUngu1KBBuqDhUXxTxN3VySwm9OswhDINMO394HwWVfYPL/JrR8h3Q0w2XBHecARi7VH6pUWlrf02mxsVPMsJwTuuaLD8VPVgWdtnmS3BD1V63DksFVSLcdA9bwhVK3miPcQRIdJ61GKbbJpsJh9mvjisi8sO2iZ1rpB0E013r97hNy9/+474pkQmoaOl7vLTuud5tVxfeZJCqmyzorvLMdjXsrKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsMF0K8yyM9OZXYV5n6DAcIF3JAYzM1DbTsBuWaQMLU=;
 b=rVY9MJpAZ4pNTxeDEwcmVxWPAYKPAS/0h8EhAWBEsAILNhEQf2oCgvXb7fddmrEOyywB3GfuegYTECuSBM3k/koPDKjpoJjtqOWzwoOeT/SG74u5SPxYfJO+Va/wVYX1hnwikZCCZgk0A76v9d0929i3eiw+1ZB0h/U6EtG2jxgDMOCkts60/O8aQaUN7mKDX7dOb2iQfMmNps027d3M0by6Kbcl80QBw11t/JrX4KjWibVymY6aABzb1pimcbgOSqWwP4LjwJBreq64oC4F+lgvoWPqSUB8KiwsZOx1b83spFiwS/Lr2wf+R9yokkkRbXEz6rmoCc95nFw+u+L/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsMF0K8yyM9OZXYV5n6DAcIF3JAYzM1DbTsBuWaQMLU=;
 b=WQJoeB5mwp6PtXJa8HiOe11CPo2QcoiMtG4DY0JwVWEiY15WH2ENsE5lqGUbaDS5tVJjdQvkSwvmsHrqlbax4t1quNSK31LiXi7rCDTxYiv2CYXqwMswWFE7m2YJlu25H3UBjkIqG/izDiM59PjLNUzrK5ty7G9AoUvgUXUyjik=
Received: from DUZPR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::16) by AS8P190MB2006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:528::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 20 Oct
 2025 16:43:51 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::4c) by DUZPR01CA0020.outlook.office365.com
 (2603:10a6:10:46b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:54 +0000
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
Subject: [PATCH v2 15/21] net/ntnic: add flow query with count action
Date: Mon, 20 Oct 2025 18:43:24 +0200
Message-ID: <20251020164336.283664-16-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|AS8P190MB2006:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 01f1f2e1-1874-456c-308c-08de0ff7d98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v7jj8+GrMhZ3o2y6HDMlqYHJmsOp2jVjX5zpGyejkBU7K6PuOONMS6hbgueJ?=
 =?us-ascii?Q?9w5tBkXBqOCHmJ/RIQ2OoPuuMJW1t0OzSlH9T4g264SSt0PvzGstisPvOboD?=
 =?us-ascii?Q?SEVtsr+uWlk3phUcCbH7FPjFXS3KejzJSzg8BhDjyyd6/gepKtZ7B0mnmKFl?=
 =?us-ascii?Q?YXirsjC/MkWnT+K5FimqWoWIaJvSuJsmwLUdeNOoGjIOzBT7wShPUO2WfCmO?=
 =?us-ascii?Q?tGX0M8m/xYx673UMNIA/WhOzjSNVgkuksztalpINC/0LCaQwFeXR1qzTb975?=
 =?us-ascii?Q?h37eX0kr/J/slYM0SMtD8uVuhHbbldbnlWN0tpYabCUh06dXmJi7Q1wknmgj?=
 =?us-ascii?Q?HfXPjP4uASZA6E0a1SYQY0mLpdknT1qw2VeqR7OLIIPTt66s/QCpAC+jgG80?=
 =?us-ascii?Q?mwL+hiPoQBAO2WTjsh2rLxklyh6dkqBSfh8UP8Es+ZPIKUJe0DK64JtMIl2l?=
 =?us-ascii?Q?GbcGMje0ixuE838rR2Nm85ege7hJsEAbemE7kYo+RA1cxtf2jp1m4g/u6DLC?=
 =?us-ascii?Q?j+eLvQPJ1wUMLPwH67ZzgbQhvBn894lI2MzD2QIllpOVFteBuNUzxV1hhZTV?=
 =?us-ascii?Q?ju1FBARxgLAukrrKQEHo6oCO6eYF8A46rjxAF05XT9I74AlHEeP0VQch8f+X?=
 =?us-ascii?Q?rJ+TceA2KOAwkaiN1JM2LtIPpmkt+tui2hbJ1rRG1Sy/A0MKbn7PmbF43mfs?=
 =?us-ascii?Q?YxDB6KCXaEl4REaTP5KiFVBumjC7omSoy1ff7J0c36eKLtLBUDMM4XmjrpXS?=
 =?us-ascii?Q?yXn4gStnKMa26X0T2zdRPLBS3dXyvvtmT22yD4ow2eHkv8zIKTOA/hu+zi2v?=
 =?us-ascii?Q?UZxD/laiFhM8fU6/tvEaHi/5EIS4RXcpkkugw4XHxAcAp6juIyY0vMlcDSV1?=
 =?us-ascii?Q?Mr+LHHmERsx1jmAyMWhDBCMHTuW5iA+nClKdS+QDzEzrTCmHZCa1pIibfwME?=
 =?us-ascii?Q?8BMosgpJ82ahbX0dUfxsKakvchcG6IuzDL+MnAy7Jct/2Zk9uGZfLKiJ+LSc?=
 =?us-ascii?Q?QPHIio1Ocf9cAyOaOmTqbj7iD0WGjQwTN7juR0BK3PZ3Fg8e8FJDCEK3FOGn?=
 =?us-ascii?Q?Ngv7udlZhwGAiWCPuIZyrvt4Ic3IZKmPVoQLU6x+FAWRLefhaZYkjoNQmBwd?=
 =?us-ascii?Q?2zO1gFd0+nx4Ztv29rB71H5t+jyhAmpxzyMvgw5OHzVxu21rfgOHrLzVAXXX?=
 =?us-ascii?Q?ipqKGByx0hU+2DV2iUIo/s7BnUqjoW4hlekvdnEjZ6Rqyj2xgYp2mBnN+WC9?=
 =?us-ascii?Q?oBkYXjliv+iUbPG+ZBEuKyfqNPi4ycHnzalY6NQPLwiaZJaMv6Fa5qa9+rj2?=
 =?us-ascii?Q?m8bVqRR4DBKueXALSXGmAEkbDDjBvV8suzFDkINnKnXqsR083hHeTNEni2Ck?=
 =?us-ascii?Q?+r16a9K3tAMh9TssLUYU2fRBxYaZ0dUbEjh/0WkOKNm8X3XoWYsigLs0qVod?=
 =?us-ascii?Q?VQvXMVDEC/8UBTSJ73QZr93r97XjbWZj+/W7GmNdYWdfZ3n8ReRQuhm/Eoam?=
 =?us-ascii?Q?fnY3kuKX0qDZDAg6p9p2cExVPVoA5di1KrXyYGQXllzRqqN4CRSoU+iHt9sP?=
 =?us-ascii?Q?VYGxSxyAxlMIO7kgPSA=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i9xCLZ++MyaKYX6/kIr/LDe4p0kCiwzIRMpy1KL4jGFs+X0wA2ttby4wdbhDVbRzFxKGJwu83L0mSL56/vXqdOcIePRBSRCf+UhOzutw+6nvLJEhniTfu3qtsBv9WuSUghg3yuQ3ub2VWri6Y7ZJioUZ3Mg2I4IFmSYLakBCBq6N/CjLb7y87LadKHG/32+55SQDN6mGozJqV/aQJpbRinrI9Zt3uSWaYPGdE75HaHSu1UyqkU1wXKMv0scs2D1ZltlXAOt4JAhMwMjRNaJrB010SxJnwak95mCxvsLVKewk/T0JR524UY7e63+po4tVvzBbeEvVz4LU/7W1lAcK6E5EhagYoiDVl+oGC56/sV84bHMvp7nh2rRrl/RooRoEYeSKfWmoILstmXO80KvDNnHA2xNL2DYPwFHw/XMb8cht1OQOydzWMrwWrZzDPA/yV2sSOU/xcse/+erX4Zm+Oqk/zBLwLETWrUF/sLN8og76OD+WstqgtV8H/pn5eRqEk3m8eLUGFpML0tiLvdc9R0N26OiAE9o/qVKMX8ydpHpcB9qmRBW6b7Gm9dhmsUXxgOH0b++7NYVuCYz8AKoP0fCjuhs1LFXTBzzIOTnNr+rDgh02jViqwBvq3ImbxEB1Z2TKAtV+Orv5t+7QCigSRKF3o2O9H/ZyQ4C48bPntVA=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:51.2881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f1f2e1-1874-456c-308c-08de0ff7d98b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB2006
X-BESS-ID: 1760978632-311284-32700-8333-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.66.84
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZmZgZAVgZQ0Nwi2djEyMTU2M
 AgxSDJzMDExNDMyNIiySTRMCXVJClVqTYWAExVn59BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan9-254.eu-central-1a.ess.aws.cudaops.com]
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

Implemented the `eth_flow_query` function to handle
flow queries for ntnic driver.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 doc/guides/nics/features/ntnic.ini            |  1 +
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/doc/guides/nics/features/ntnic.ini b/doc/guides/nics/features/ntnic.ini
index 1bf9bd76db..a5aadf33ee 100644
--- a/doc/guides/nics/features/ntnic.ini
+++ b/doc/guides/nics/features/ntnic.ini
@@ -35,6 +35,7 @@ vlan                 = Y
 
 [rte_flow actions]
 age                  = Y
+count                = Y
 drop                 = Y
 jump                 = Y
 mark                 = Y
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 813ac04481..124d9a5b67 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1285,6 +1285,51 @@ static int poll_statistics(struct pmd_internals *internals)
 	return 0;
 }
 
+static int eth_flow_query(struct rte_eth_dev *eth_dev,
+	struct rte_flow *flow,
+	const struct rte_flow_action *action,
+	void *data,
+	struct rte_flow_error *err)
+{
+	struct pmd_internals *internals = (struct pmd_internals *)eth_dev->data->dev_private;
+	err->cause = NULL;
+	err->message = NULL;
+
+	if (is_flow_handle_typecast(flow)) {
+		rte_flow_error_set(err, EFAULT, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL, "Error in flow handle");
+		return -1;
+	}
+
+	poll_statistics(internals);
+
+	if (action->type == RTE_FLOW_ACTION_TYPE_COUNT) {
+		struct rte_flow_query_count *qcnt = (struct rte_flow_query_count *)data;
+		if (qcnt) {
+			if (flow) {
+				qcnt->hits = flow->stat_pkts;
+				qcnt->hits_set = 1;
+				qcnt->bytes = flow->stat_bytes;
+				qcnt->bytes_set = 1;
+
+				if (qcnt->reset) {
+					flow->stat_pkts = 0UL;
+					flow->stat_bytes = 0UL;
+					flow->stat_tcp_flags = 0;
+				}
+			} else {
+				qcnt->hits_set = 0;
+				qcnt->bytes_set = 0;
+			}
+		}
+	} else {
+		rte_flow_error_set(err, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL, "Unsupported query");
+		return -1;
+	}
+
+	rte_flow_error_set(err, 0, RTE_FLOW_ERROR_TYPE_NONE, NULL, "Success");
+	return 0;
+}
+
 static const struct ntnic_filter_ops ntnic_filter_ops = {
 	.poll_statistics = poll_statistics,
 };
@@ -1299,6 +1344,7 @@ static const struct rte_flow_ops dev_flow_ops = {
 	.destroy = eth_flow_destroy,
 	.flush = eth_flow_flush,
 	.actions_update = eth_flow_actions_update,
+	.query = eth_flow_query,
 	.dev_dump = eth_flow_dev_dump,
 	.get_aged_flows = eth_flow_get_aged_flows,
 	.info_get = eth_flow_info_get,
-- 
2.45.0

