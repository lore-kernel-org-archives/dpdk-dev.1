Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6033C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB0A040A70;
	Mon,  9 Jun 2025 04:55:42 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013031.outbound.protection.outlook.com
 [40.107.162.31]) by mails.dpdk.org (Postfix) with ESMTP id A443140674
 for <dev@dpdk.org>; Mon,  9 Jun 2025 04:55:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT+0fnoz626MwoX69UCYpikf9fSH6EYcAfEyhffPP8cqJMomew6Q+RFU7HR8auxUZpRnvBi3pVr8hILfV6b4YQTc9NgQx6fKKE8YUm3KO+G72G/dWZhgxANJnYzb8GdBfuLYPi4w11o5wgp68yhM1JR/LGYvZqv7+CrqsKuawgEIlQQjuIiCV8n2PjngM1xOwN1ZwLqUCOblr4SFOrCo+yhn2eOXHPVzLHm/sXMCT0NaMZmBR3qYLo1f8xl29PPl4PGDEhLJngbQVo3GxjqJyu6O0m5cF6Hn7J4pjXgn3Js/fiZ/gVwZrVMB8E47APuRU/vjEFiHMPIorTQYK7eHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gFceXfbfVLOFbThsHJ3Q0iRA22cRtUnngBPvCQV8Y4=;
 b=kpX5u9ekzFTY28KTM9jiZ5ocIyKtHHDi9McO9rZKTdmWhPGbfzsjyyKCLtY7qCDuU8yB+xoFf0KHwraPbqD5OXtx1vxyIoO83pfSHn8b5P0fHOAhenuKX7AGK3GF8pbqX6zGjzYJ6hCciOU6lPsFUtjWEpsVmeLqlR01wounGRMeWLyoakEWe7awrIUvhHHAPA6+TLvGqEx36VvrIwJijv2O7OyRx01Fhi70BrRGcBUK04N8JMF6v+Tt1XrbxtIHeEqFHCjMCceVzX97gqAqcimYfHzyMGaEYXzKXplLVk8u8OXG2Lu+cA73J8mmkD9FPxVUbYroSZ3gwHEHmWYfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gFceXfbfVLOFbThsHJ3Q0iRA22cRtUnngBPvCQV8Y4=;
 b=ACcE7K3jYeCUHDqFsUwuUhjVLg7eqdV+3xeYG/CiOBHCilTZX+vQJquJ5CCVoQm07TsX/fIYg0utP4xuvzFScFdSOqXhZ822YtkTdD9cU8VJyEgasETBmqieVylOIHua2xGg8X2ySlXpUs9jmeKgWh3JseJdx4G0YZQQBLwdz5sx0asTWsQe0FLawra3ozcFA9Fmh0U4LbrdA2cr5OxaGtluBVJdWRy18btQhaED39VGS9nEb93Trnw1t/bEzK+2+2HH+fR8+xDwT83kKDAiCHx+Glt7KwpHvFBOAa5k5Mp9blTHapl9f/tVSlynn9O+mtxyxvzJSRjlzW79TxsrpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:30 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:30 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 10/11] net/dpaa2: setup the speed cap based on the actual
 MAC
Date: Mon,  9 Jun 2025 08:24:49 +0530
Message-Id: <20250609025450.3997062-11-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609025450.3997062-1-g.singh@nxp.com>
References: <20250602104041.3322164-1-g.singh@nxp.com>
 <20250609025450.3997062-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b840ffe-9c4a-429d-876b-08dda701188b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R/CtVC8P/nHaOGquS8mzfeJfSjE+zRNkZEnFH1qhnUEWd2cnUir7XzntUn25?=
 =?us-ascii?Q?Vj1mawvOz2ueYwvVJd/1Q+GXq6RXQrsIFH2EDuQu/xnDlOnIcMbtvcV/Njmv?=
 =?us-ascii?Q?+NayL3Myef7FYpGhaJF/ak5v2QHWmM3G3LGKcKQAOzET0DGbpw0u2WrRhoIb?=
 =?us-ascii?Q?qpq6vlNUP7vH0FRPI4oI+HFEo0Co71z1bBHFLOQ2HCc2fC2nYO0skko3hHdS?=
 =?us-ascii?Q?gsW9jDmuVNdFF6XuYvNC6pF9L6P3FhLRw3ojbsxG//amusC1EoYTZE3BSKxB?=
 =?us-ascii?Q?qlOd0LKSRcQMMfnyhuVYQvsRimG33FQho0QZUyJqiiFss6CUv2/jojPDH1iY?=
 =?us-ascii?Q?+c28P7FRw8Y8ua1svLNg6DgyqbvXZ2gTlnrIZrClsLDsUTeByGN3HO+igeaX?=
 =?us-ascii?Q?iSZ0YvzGGn5IVhY2VBe/20rkB5SD7y3/Sl25I/85ooP8slaBuZTbN2aLB6y/?=
 =?us-ascii?Q?zwGmgnBxl6WzfccwaZohKchAGhlGgvysy7WqgDJTpu3M2vRlGoL+p1a1UY5S?=
 =?us-ascii?Q?Zms0iTYUNSMGXfQJK+30v2v1tvzsUWWCINRRPjHZL3QHsykXyiATfFeXvvpb?=
 =?us-ascii?Q?KCrrUFgHJqOqQiAqDUxIuSlKz/ze8B+i0DbOj5HAjGeDeFFVl0BIcV1AoEk5?=
 =?us-ascii?Q?dk/scD4izjYc295ikq9b+2Z1DI/1HWV21kw3s6SoQ2brCwHk3xnU0AjnvYe7?=
 =?us-ascii?Q?JaotJ67rMCvrdX++IKyk91btxLJX14pf9v3vMgdjHUSv6KUy2Sl6f/XB+h59?=
 =?us-ascii?Q?7jVqI9i2nKrHd3qqQ2LtZCtJF8kngMCJ0gPOw6ZspsnXEzOYERXwG1ZePNwf?=
 =?us-ascii?Q?Thc3eNszQMTbgpZnEv9hmS6h963Wknh5MDaFL4bYFAi7sR0nj5wk9jUT7Hgp?=
 =?us-ascii?Q?J92sHJ1iRKmVXLwQRF4J0N0AFlu3z+5axtnyjYf2+mj0ThuGdkiyb70DkKkU?=
 =?us-ascii?Q?+d8snlXSLH2eovZ/OrinhWU4E2osYY5OSIQRjfXTalsXnRtdb4gGUrD6/t85?=
 =?us-ascii?Q?SNAsGjaKrWxTPID4pgzT27QOPGIBHEMOBeOCMR10UG/xjtDT5XJGWDaPU1jj?=
 =?us-ascii?Q?c4IQ0xSJ7HbJJdifrHTDrRK7Iv077nRM6TjUVT4W/gta0ot4qVBiO3yNTpMn?=
 =?us-ascii?Q?rHek9klXbNQxCh9Bx1FNOhNeQEq61Q8vl6F8X8c1Zb1NRSvV5B675/UFc/t1?=
 =?us-ascii?Q?3UrUbRs3YpOPqSTN8OFRPvfH03W3UvTm/lQcyqevfE1TNata0PMlVg1hSfht?=
 =?us-ascii?Q?RqTTVTrd9BbAk1WzdvzuY4lJvelq0iQ9xQRhKbl8Nh2Jl2vEY0lXk4zLOHS3?=
 =?us-ascii?Q?Nb0reY05JrOtmdJSAw03Bot/JFw0HVLDQX5d58FLyR6l/6e69uk0luGOGHQG?=
 =?us-ascii?Q?5munD0H/O7fJd4VKe67cRclV4NA00GZXBlgCv68+YPtpz72FvvHu/DbhudIV?=
 =?us-ascii?Q?/2zWSGrrN4yHkFXdsNN3ideJYr0zsLyZESLg+6xCPfy/lqTeDhv2PUkSD4y5?=
 =?us-ascii?Q?zIGoMAWr3bJBihM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z8K67HObGaQcKR3rPRxIVdlAEttM+6jYpkEClAYsG6DeN5Hj3UF/n5sONvWy?=
 =?us-ascii?Q?RgQWsJsUnn5J+W4doZ6qznaH0WW//ghjS6TIuO9CgR/eyCCo7+guZARdKKq0?=
 =?us-ascii?Q?o0HA9Yn+saRt1xW2FwSDVYXJAdCpvW1VwTbl2fWZKZXJdcs2gY9UBSoquZQQ?=
 =?us-ascii?Q?RZfYpcsi/7ujo2i/Z4UKebgkFgJ9QGO6U6rQG8lhdWUaCz49F8mc6kYAso1O?=
 =?us-ascii?Q?GT8uAnnlecU74L3KlfMOT2cp2swCcgLUNAJPTbFpYtDLWkjO8kG07sQWSwnt?=
 =?us-ascii?Q?6qlYoxs5g+T/21FMkujkUonnoti6GhsGJ7RrlyQVntCwVAXNyU0s+NPLWgHd?=
 =?us-ascii?Q?V2T2FLXiegPbt3O/uZEPjLnb8dOEOvEstutmzuVfqbaxtp/Vp/WCMzU88pIm?=
 =?us-ascii?Q?8I/kABpUwU56YgLZALmU1aUg43z/P1J90dLaiL9nhWTfBm9xoXBzfjVnIzlN?=
 =?us-ascii?Q?L9r3O/MTJqXNxpRS+WxgMHeBLBYdMimaUOdT3094X+ipL0aTkRlO5OPc/WMU?=
 =?us-ascii?Q?r4JW+MT05Seucn2R1s2dASCRWJuCcd03hWpN+05cU7pca+6ErHvVF+8jCtRO?=
 =?us-ascii?Q?z6BmcxTQ+HrOBwdxAg1gVv4kfIWCtwraW4ILMpKLr6YDx5PGq+RZ1ei/RLOT?=
 =?us-ascii?Q?C8bgawCoxaHzD0BXgnGkn7skBY/wstvA0HxOkNS1WtcsEbFjOAe9jOW4sIHV?=
 =?us-ascii?Q?1x2uZbNjCba1m1ThiAf19mhgHsNo1ATmWG1ZFyCtn+HOBaZblAiuYx8peJ2K?=
 =?us-ascii?Q?ZV+B16Kjpb1PAKuoK9a2pr+8zpH4LwD+hZLAIiGzIGnivGmHts3BtLPsnKM+?=
 =?us-ascii?Q?FQtMWQfZ1PjLnp3olzGgtuKwoDof2XQ4U+dNtS4UT6y+2hPbKLKW+3Cq9GnP?=
 =?us-ascii?Q?glnfixC8PEOPAgsbR7WpGCx4vKu1NvcDcDu69ZDj22i1NOPMVs1JbLPMG+Ai?=
 =?us-ascii?Q?yikE5hJbSfi9lg5BefS72+0IhLdcrvp6K7Src5zaZSZgAT5QZLa1kdwrCKXy?=
 =?us-ascii?Q?HyTCFhyu/49xyLfbuvHtBx7X7+RJof9Fs2V4hlrctjWvgTTZzr7VNESvIZFG?=
 =?us-ascii?Q?31NMedsOzq8+h7ItHWs2Dd3C1XVGelvP9obbd6117L6qvWDoMbkX1zp87oc6?=
 =?us-ascii?Q?b8z1HCVeLg3eMPb61z/VYU/N41R+OMf2JgHO7qxlwrl5C/m4uGsehndBldYA?=
 =?us-ascii?Q?hHQwAYbnEDTLNA2iUJlILZfCHwK0X2MsxE4FN2d4HG27HqxLRm8/ooclPDcq?=
 =?us-ascii?Q?5ZuKkBNAHArBbvTcS6vhHYJWzRcC0R9OPVPFUizwPmeMslQBgC96WwtkIIi3?=
 =?us-ascii?Q?dUBEX7Tow64sdHMtQYuiNWUMNZh3PWMo7zrRNCMl+iYZg4KVsBITEybFFSoW?=
 =?us-ascii?Q?Gfbv62tqE999wYT8DHhVXf/1K/RZMjEHhJ/6I8nu0o+CNXRNKzhjXYDtons/?=
 =?us-ascii?Q?Yg5t8kv8iC6qbr4Ml4FjA1MGP7t4SB0T4X5WVvKWsQhL/0aKGAPJR5fzp6Gx?=
 =?us-ascii?Q?GNixqS38LSy8PQ/UGEjK3uXJxxIel4azZsOZtwjPf/90OXRVaQJoylaDumzq?=
 =?us-ascii?Q?Fj8CzL7uVmD2YwarjvwT2SNrxikBjBQCI6qc/wjq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b840ffe-9c4a-429d-876b-08dda701188b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:30.7950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsnOitV9ZKuneioa0qHMb1xfGN1U0n/UJSXO+TU8YzHv4IQgTb9szulFG67buhhY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
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

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Previously, the speed_capa field from struct rte_eth_dev_info was
populated with all possible speeds that the MACs on the system could
sustain. What this meant is that the bitmap of speed capability did not
reflect what the MAC could do in the current circumstance.

Fix this by using the newly added MC command
dpni_get_mac_speed_capability() which returns a bitmap of
enum dpmac_link_speed. Since the MC API is a newly added one, we check
for the DPNI version to determine is we can use the API, if not the code
will fallback to the procedure used up until now.

Also, we interogate the MC firmware only at probe time to get the needed
into and then we store the information in the private structure to
use it any time .dev_infos_get() is called.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c    | 87 ++++++++++++++++++++++++++---
 drivers/net/dpaa2/dpaa2_ethdev.h    | 12 ++++
 drivers/net/dpaa2/mc/dpni.c         | 21 +++++++
 drivers/net/dpaa2/mc/fsl_dpmac.h    | 15 +++++
 drivers/net/dpaa2/mc/fsl_dpni.h     |  5 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h |  4 ++
 6 files changed, 134 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index b88c9d748a..c661e027f5 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -290,6 +290,79 @@ dpaa2_fw_version_get(struct rte_eth_dev *dev,
 		return 0;
 }
 
+static uint32_t dpaa2_speed_to_rte_link_speed(enum dpmac_link_speed dpmac_speed)
+{
+	switch (dpmac_speed) {
+	case DPMAC_LINK_SPEED_10M:
+		return RTE_ETH_LINK_SPEED_10M;
+	case DPMAC_LINK_SPEED_100M:
+		return RTE_ETH_LINK_SPEED_100M;
+	case DPMAC_LINK_SPEED_1G:
+		return RTE_ETH_LINK_SPEED_1G;
+	case DPMAC_LINK_SPEED_2_5G:
+		return RTE_ETH_LINK_SPEED_2_5G;
+	case DPMAC_LINK_SPEED_5G:
+		return RTE_ETH_LINK_SPEED_5G;
+	case DPMAC_LINK_SPEED_10G:
+		return RTE_ETH_LINK_SPEED_10G;
+	case DPMAC_LINK_SPEED_25G:
+		return RTE_ETH_LINK_SPEED_25G;
+	case DPMAC_LINK_SPEED_40G:
+		return RTE_ETH_LINK_SPEED_40G;
+	case DPMAC_LINK_SPEED_50G:
+		return RTE_ETH_LINK_SPEED_50G;
+	case DPMAC_LINK_SPEED_100G:
+		return RTE_ETH_LINK_SPEED_100G;
+	default:
+		return 0;
+	}
+}
+
+static uint32_t dpaa2_dev_get_speed_capability(struct rte_eth_dev *dev)
+{
+	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	enum dpmac_link_speed speed;
+	uint32_t dpmac_speed_cap;
+	uint32_t speed_capa = 0;
+	int ret;
+
+	/* The dpni_get_mac_supported_eth_if() API is only available starting
+	 * with DPNI ver 8.6.
+	 */
+	if (dpaa2_dev_cmp_dpni_ver(priv, DPNI_GET_MAC_SUPPORTED_IFS_VER_MAJOR,
+				   DPNI_GET_MAC_SUPPORTED_IFS_VER_MINOR) < 0)
+		goto fallback;
+
+	if (priv->ep_dev_type != DPAA2_MAC)
+		goto fallback;
+
+	ret = dpni_get_mac_speed_capability(dpni, CMD_PRI_LOW, priv->token,
+					    &dpmac_speed_cap);
+	if (ret < 0) {
+		DPAA2_PMD_WARN("dpni_get_mac_speed_capability() failed with %d", ret);
+		goto fallback;
+	}
+	for (speed = DPMAC_LINK_SPEED_10M; speed < DPMAC_LINK_SPEED_MAX; speed++) {
+		if ((dpmac_speed_cap & (1 << speed)) == 0)
+			continue;
+
+		speed_capa |= dpaa2_speed_to_rte_link_speed(speed);
+	}
+
+	return speed_capa;
+
+fallback:
+	speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_2_5G |
+		RTE_ETH_LINK_SPEED_10G;
+
+	if (dpaa2_svr_family == SVR_LX2160A)
+		speed_capa |= RTE_ETH_LINK_SPEED_25G | RTE_ETH_LINK_SPEED_40G |
+			RTE_ETH_LINK_SPEED_50G | RTE_ETH_LINK_SPEED_100G;
+
+	return speed_capa;
+}
+
 static int
 dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	struct rte_eth_dev_info *dev_info)
@@ -307,9 +380,6 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 					dev_rx_offloads_nodis;
 	dev_info->tx_offload_capa = dev_tx_offloads_sup |
 					dev_tx_offloads_nodis;
-	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G |
-			RTE_ETH_LINK_SPEED_2_5G |
-			RTE_ETH_LINK_SPEED_10G;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
 	dev_info->max_hash_mac_addrs = 0;
@@ -326,12 +396,7 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->default_txportconf.ring_size = CONG_ENTER_TX_THRESHOLD;
 	dev_info->default_rxportconf.ring_size = DPAA2_RX_DEFAULT_NBDESC;
 
-	if (dpaa2_svr_family == SVR_LX2160A) {
-		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_25G |
-				RTE_ETH_LINK_SPEED_40G |
-				RTE_ETH_LINK_SPEED_50G |
-				RTE_ETH_LINK_SPEED_100G;
-	}
+	dev_info->speed_capa = priv->speed_capa;
 
 	return 0;
 }
@@ -1133,6 +1198,7 @@ dpaa2_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 		/*todo -= add more types */
 		RTE_PTYPE_L2_ETHER,
 		RTE_PTYPE_L3_IPV4,
+
 		RTE_PTYPE_L3_IPV4_EXT,
 		RTE_PTYPE_L3_IPV6,
 		RTE_PTYPE_L3_IPV6_EXT,
@@ -3010,6 +3076,9 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	DPAA2_PMD_INFO("%s: netdev created, connected to %s",
 		eth_dev->data->name, dpaa2_dev->ep_name);
 
+
+	priv->speed_capa = dpaa2_dev_get_speed_capability(eth_dev);
+
 	return 0;
 init_err:
 	dpaa2_dev_close(eth_dev);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index ee5ae3b70a..70357f0351 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -396,6 +396,7 @@ struct dpaa2_dev_priv {
 
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
+	uint32_t speed_capa;
 
 	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
@@ -433,6 +434,17 @@ struct dpaa2_dev_priv {
 	LIST_HEAD(shaper_profiles, dpaa2_tm_shaper_profile) shaper_profiles;
 };
 
+#define DPNI_GET_MAC_SUPPORTED_IFS_VER_MAJOR	8
+#define DPNI_GET_MAC_SUPPORTED_IFS_VER_MINOR	6
+
+static inline int dpaa2_dev_cmp_dpni_ver(struct dpaa2_dev_priv *priv,
+					 uint16_t ver_major, uint16_t ver_minor)
+{
+	if (priv->dpni_ver_major == ver_major)
+		return priv->dpni_ver_minor - ver_minor;
+	return priv->dpni_ver_major - ver_major;
+}
+
 int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 				      struct dpkg_profile_cfg *kg_cfg);
 
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index f651f29b02..a1f168dd04 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -3493,6 +3493,7 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 	/* send command to MC */
 	return mc_send_command(mc_io, &cmd);
 }
+
 /**
  * dpni_get_mac_statistics() - Get statistics on the connected DPMAC objects
  * @mc_io:       Pointer to opaque I/O object
@@ -3520,3 +3521,23 @@ int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+int dpni_get_mac_speed_capability(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+				  uint32_t *speed_cap)
+{
+	struct dpni_rsp_mac_speed_cap *rsp_params;
+	struct mc_command cmd = { 0 };
+	int err;
+
+	cmd.header = mc_encode_cmd_header(DPNI_CMDID_GET_MAC_SPEED_CAPABILITY,
+					  cmd_flags, token);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	rsp_params = (struct dpni_rsp_mac_speed_cap *)cmd.params;
+	*speed_cap = le32_to_cpu(rsp_params->speed_cap);
+
+	return 0;
+}
diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
index 076da5b5a3..2b18651b7d 100644
--- a/drivers/net/dpaa2/mc/fsl_dpmac.h
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -67,6 +67,21 @@ enum dpmac_eth_if {
 	DPMAC_ETH_IF_1000BASEX,
 	DPMAC_ETH_IF_USXGMII,
 };
+
+enum dpmac_link_speed {
+	DPMAC_LINK_SPEED_10M = 0,
+	DPMAC_LINK_SPEED_100M,
+	DPMAC_LINK_SPEED_1G,
+	DPMAC_LINK_SPEED_2_5G,
+	DPMAC_LINK_SPEED_5G,
+	DPMAC_LINK_SPEED_10G,
+	DPMAC_LINK_SPEED_25G,
+	DPMAC_LINK_SPEED_40G,
+	DPMAC_LINK_SPEED_50G,
+	DPMAC_LINK_SPEED_100G,
+	DPMAC_LINK_SPEED_MAX,
+};
+
 /*
  * @DPMAC_FEC_NONE: RS-FEC (enabled by default) is disabled
  * @DPMAC_FEC_RS: RS-FEC (Clause 91) mode configured
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 2f8125314c..8d28b8ce76 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2025 NXP
  *
  */
 #ifndef __FSL_DPNI_H
@@ -2017,4 +2017,7 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
 
+int dpni_get_mac_speed_capability(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+				  uint32_t *speed_cap);
+
 #endif /* __FSL_DPNI_H */
diff --git a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
index f653f2c0e4..cf4558d540 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -132,6 +132,7 @@
 #define DPNI_CMDID_SET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x281)
 #define DPNI_CMDID_GET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x282)
 #define DPNI_CMDID_GET_MAC_STATISTICS			DPNI_CMD(0x283)
+#define DPNI_CMDID_GET_MAC_SPEED_CAPABILITY		DPNI_CMD(0x284)
 
 /* Macros for accessing command fields smaller than 1byte */
 #define DPNI_MASK(field)	\
@@ -1031,5 +1032,8 @@ struct dpni_cmd_get_mac_statistics {
 	uint32_t num_cnt;
 };
 
+struct dpni_rsp_mac_speed_cap {
+	uint32_t speed_cap;
+};
 #pragma pack(pop)
 #endif /* _FSL_DPNI_CMD_H */
-- 
2.25.1

