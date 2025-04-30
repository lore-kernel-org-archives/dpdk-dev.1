Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AFFC369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:49:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9761B402A7;
	Wed, 30 Apr 2025 15:49:17 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 45FC540280
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:14 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 mx-outbound21-53.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZiba952PkVVI6D4eCrEgLs3l9ZOb6RdGG91wTzksSeR1oo6pvljJmz9qHEJ+RcOfPfb5FlhgIySQacBGng7mTcT3jHIQn+qYgwyxQfVjLlktJ2PEEjGZHaeG+T/jueHD4HicvnvxpAiK0cSsYxG0o9SNPaV046yBDfMmsVHgoGCWgSE7u1tn/6zxC+D5BQ6w/uqbtJGD0SfgfI8hPteCLsoefye8Si9RQJZovcpwMAiwz7Od0xlAVMYyjVWaYkioMHZGZttcVXiiYxYhc6RBf7LvRQkWSTxjkCEpvcfhYAATmgdlQiVPy1RKKN8ruhe66kCViBIgrXbQW8kcjTrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCJTRCBMYq+QYGtU2uhT7c3QvWnWXZ5aouejh512UIc=;
 b=XWf5bk+wbAKxY8PQfXvZO1USccXTa6Mdwf5p7BPvOSMZFhg5tivp2QttWRVNW0JSaKVO5jLzoL0O20WOPkUV8YhBsNGIMMk7KieON0cFsXh3OhAAozfv5RyUmoxS9MkzV/xFnYukBsLiPAG8/zUfJZVfiv6nQf+BrV8HCfm4B7Vjh2X7cPQRn/zdOO+rUMgjPyMmSjeK3Be5dNRDDxjd0VNWL2VlCF5y2Iyy3yITFzx7y5NJF35TdBzSNhTPtPYj60V13HlmBWa4b9d5TfObLVk6O03Jyozw+O9FL0PIse7AO1GhWCp+ll3HQtxmBLwAW88eD/2QLprP1aORm0f4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCJTRCBMYq+QYGtU2uhT7c3QvWnWXZ5aouejh512UIc=;
 b=QybQs8oPz4IYOWynTG0DIg3Q9b8fmCA4RxtdEsXzJ9VkalNimTrICGI5BjbSrMBHcOWX/esA++PYqG0q+dW3/qJAoBXCw6Vnwbj1qNdgRCuMQ/Aby2vPaYPyEZbAn0QkG08LKMNma0oijVk9PRI3bXqBsXVP8JwqY0wWjALW8Hw=
Received: from AM9P193CA0026.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::31)
 by PA1P190MB2245.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:48b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Wed, 30 Apr
 2025 13:49:08 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::b3) by AM9P193CA0026.outlook.office365.com
 (2603:10a6:20b:21e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:08 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 04/25] net/ntnic: remove extra memset
Date: Wed, 30 Apr 2025 15:48:16 +0200
Message-ID: <20250430134840.402553-5-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|PA1P190MB2245:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: abbe02f1-9a9e-4e9c-5e88-08dd87edc7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c0TvRtuRyU9U7uw6GKCawQQqXHvfDskKafd4dofluvZCj7aDB+/nUUwK6tnf?=
 =?us-ascii?Q?/2P4sP7XfEDGOwHrpTUKXw2p0ZlPwMUONMOhxoSxOvMVZwkqdz6+mpmdVb6I?=
 =?us-ascii?Q?1pMaWjVSop4oy9oWay+nSoUHf0/XqYDRVKz6S/I/c1XGRphxp0SvyPS0ONl+?=
 =?us-ascii?Q?bylk5jgBZxzeWwAP/JQ9X/fDjinz1yj+M+LaD5SFYjTLOw+dkYGRbUPKjc5/?=
 =?us-ascii?Q?+92Zx8E8IgnjbDzAu/eA0tU8PZWwA1fGbk+8IBk7gIohON7PblyCMdUWEJVW?=
 =?us-ascii?Q?3BYNvCYaAv99Yt0KvAeI3cNTSC4Hpwk2NeOaRV7vkXT/3YMQhBv5ycVr4b8d?=
 =?us-ascii?Q?engN1ibo/mV3OpDeNqU/ayxMGKWOCpTDdIOAsVJf22p9qi+vd+0C+nuI9zOz?=
 =?us-ascii?Q?s2GvPX+Ai4IYR+OMY6PNRcLNaeamSoa2RL6SRdgd8XMs7mC09zXYjStt7EFj?=
 =?us-ascii?Q?eaFNAr+UeD0C4auC8x64XskLI8ibAT3ZJ1EjyWidHYLIFpjTRG+cA7JeUcOa?=
 =?us-ascii?Q?ZNCu9M13jjas9BekjEKT23iwXo/jf8tS0dawGgOYyEBaPwLVDxD8FThBWSEQ?=
 =?us-ascii?Q?FIHZV5ppHfYxwNXCabLgRU86FKnt3C4FpX+qR//wZG0OpQ+/FQJHHa0QY9gU?=
 =?us-ascii?Q?P0SIHTxYs5vyL1iwLS2VXiQJ1ZvHO5nOVMlNH7C6PoKuFoxmqjcfpydeMK8S?=
 =?us-ascii?Q?c5I8crIUnfDvr3GbhvabboBjYfkVUu/s8HlFqCKjgsIhvXKrV3uK5PN3CW9M?=
 =?us-ascii?Q?dRxjUVlqeMLb0D7+K7Gw7gyFctcuJuus+jBc/zwQYLe0uricPyVNpILDsr50?=
 =?us-ascii?Q?u2Gif2lvqP08XQo8K3aTjtR0cUS9lyP68XG6CLvJdKZ92Rnc5nKoo6fumzcW?=
 =?us-ascii?Q?wTtLGCN4AQ2ESXksaP/MB2Npyh37R3eiBAutWz7PSvlR8bZfwTWSMHZwnCly?=
 =?us-ascii?Q?M2+stnRwJpEi8v4tzsIER0puuIwYJe0M01IxgFI7Ew1z1AclwrjUtcTULw50?=
 =?us-ascii?Q?4wYjybzTGKnmzzPg9v7IgBoA/a++Z9wacXJIl04Be9tQW9YM8TCxl+MoBw10?=
 =?us-ascii?Q?9rnpgeAsaKWCuLt6xpoqk+LdKzw6sIFaKbp4Amgy0JB01m7ZfgXA3Cg4l8Wg?=
 =?us-ascii?Q?lta40dDoPsT8ykqRnWCSPMCefdpH6Tq14VxwYHvqjCRqvJkfpoS6qTP80IiV?=
 =?us-ascii?Q?JSCGy2NcfNg/gCw4K47Zg34FrGMWMddcPWR9912KEsxNb5tmt2Ne8O6Yozon?=
 =?us-ascii?Q?v96ElGqJmSlve4jp2v5NO4ZgifDl4+tDI3H8pcqC9BW+jQKNv9qIGI+pbjyF?=
 =?us-ascii?Q?uF3MoOmu1GMNIQPs2f6QVlHfW8hbLZ/3XJ83e0WWOpKW3ETkX2vDEcF019No?=
 =?us-ascii?Q?D1L4/FH04GCKW/HkQLr0hKQO2OPU9AWmP8CkIAMGJ8Dre8b3dgPUESZ9pPBE?=
 =?us-ascii?Q?cr2v8lKJay4WjOfTzzBVqw3mJKaljAm9st7OLKJov9XVzHZulbYtLJDefhon?=
 =?us-ascii?Q?26A3GZpEBS9gSQNsUd6BJeAV3iuK/c8V8D31?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9ImwAHzbqr1nSBu+KNdrPN4ub8+6MAmqiVn5A7Zt5sMmo0asfDGA5AI/ArPvdLowF3HWo2v8jztUoV9C/I1xns4WsaOWwqzAUvRZsCon8pIZ+JpjqpkHCftEgZUf99bAZUDeUJpPDWw/k0bqeSgFjCx+LuLUA5cX1Mqx95Jwlwa3cxmPK6d7wI2XW7UqG/Moedm8jc/UIUjeRTCiLGjSjOAPKyjKE0EKEXvd782af5i/OxLVgto5ZaMVzpM4hZbAUC8sSaPpbocD9GtsMujN88XVJSW1qud+iX0R3kXt42j9amXVl3J82DCC86DabRX20O8w2O07n/qsubhewYDwRKINLZ7JuVqS/5e35f2Y3cCk5mA+6fSIjQ+PoCqzVXSBxLDLEuRYgIbEgybhbcatG28b6sqOJux2ZOQFkA6NXY1DZyQNAfa/Kp2Gjm3HHhBm8AQqOcG1KQ+0E7//K5PUqzZtJTnHFYC3fwexUAB7JE16Lm/TLcaSXfMXNiJL+MHVBptO5yOYCM6ldYaUMuwuPKnz9GWTSIzf6iXyPobzbvC2MjHo9ccpKsbbxle9ZGCMkEF1Mi6aToIe5ehDvvAdJ0RuQW0I+mg/y+yBRH3CfE63afgEJkfcDtK8TdsVA3ZpRihGUNlhQn8+gAQ/82lSpA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:08.5464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abbe02f1-9a9e-4e9c-5e88-08dd87edc7df
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P190MB2245
X-BESS-ID: 1746020951-305429-7636-9229-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.18.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpZGhkBGBlDMMsnU0szAINXQ2M
 jU0CzNNNkg1TLJMjE5NTk5ydwo0UKpNhYASYG6Y0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan15-77.eu-central-1a.ess.aws.cudaops.com]
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

The function rte_eth_stats_get fills the structure stats with zeroes
before it eventually calls dpdk_stats_collect.
That makes the call to memset inside dpdk_stats_collect redundant.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 9a6667b3be..f9644b5826 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -200,8 +200,6 @@ static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_st
 	 */
 	ntnic_filter_ops->poll_statistics(internals);
 
-	memset(stats, 0, sizeof(*stats));
-
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS && i < internals->nb_rx_queues; i++) {
 		stats->q_ipackets[i] = internals->rxq_scg[i].rx_pkts;
 		stats->q_ibytes[i] = internals->rxq_scg[i].rx_bytes;
-- 
2.47.1

