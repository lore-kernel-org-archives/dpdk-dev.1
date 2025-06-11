Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D405C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C116F40A6D;
	Wed, 11 Jun 2025 12:52:34 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
 by mails.dpdk.org (Postfix) with ESMTP id F30D3406B4
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrT19TSeincjJZ12bSOztf4fXaZ3wFuSPnBiVkK/pNCPY1HdERn7rZeXithVXP0LgzcCIW4ByckfzV6+qLHNGF4RgQs9QAlGUbaLxYJqYpXytSOQnachKQ3cyDA9NfMe0U/BMGfYhRh78ewvwexK/2pdBvMPfxYqfBspDTdtqrkrI5QF8UdvXVz/f/cXPOW6IEvy5mwSQxQegMmvD/VAuwyaMjuzLD53U8dIi04w/xd/YdtOqpZwA6vXdajy4XzYqCca8cwqADMCrThDOw7IFucjKxWRjKZ/uZ5P4Oski+daKkafdkhBcj0nY9371/S873fI5nkwd+82I/JxTw54IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sVbQvfquzR6XCenJJdYQ75apGCaAG/Nh7D8ArNBhgU=;
 b=VT3lhRrOgnzdnMoUq8FBJZgoov3vJKaAIL3IziIUNdxxXuIwssGmNK+J8Tu6xa/iuqh0Q1HwqJT0f6DxH3Lv3bSyuvjL8rY5o7IwkjyxsqMS+m43wgdMnvJhJ4z3fxaZZKWXAjOUbQn56BZ5mLMkGZT3pNdwoxOohjegS+A4oTmCfIWl0nag4YAo1c+oBvwl6kRlkEZ/1qJcgz2MhhxJxG78l4ZC9eDvXZr1DrR0ewBY4mQQNt55pcOHPiWyUqSc4xB70ujvw+k0kvrfwFtBF5xK10rUadDQ9QrRdpPwsk/UW7RuSZS6ZsdHTt/6GhjTYhSCdkRigzhcRM+buYmOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sVbQvfquzR6XCenJJdYQ75apGCaAG/Nh7D8ArNBhgU=;
 b=Yamuhgyi3sqAaSBKv4q9fMpdPkgboyzLS289PMA9jCqvAuX+P9LiLedibBY7Uj4LPP7zp3RcYDDLNRsWJ2de2sjqGPEbE+JWcRM0DztyedfsITJv6WxBJvMFDf8kLImgsy5B+5eJfXFdSiy/bS3AVeLnFed5Ra8QB0BrCYhNdTRfAGyfGLGfvFqUVET1x7QwXxfVc0tl1UXiknPgazJ4n86cr5Uo5ptszBiIuk/8r8M2OpQeBX0pUdfG1grtnKa7vYXWTqauJhRYe3c++pR1sdlZI6BVGV7dIY/mTSEKVvQQY37w2IEgYmiEqCCmm1vhVe0HpV+SrVrwCBhjZMnMlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:32 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:32 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v4 10/11] net/dpaa2: setup the speed cap based on the actual
 MAC
Date: Wed, 11 Jun 2025 16:21:48 +0530
Message-Id: <20250611105149.655144-11-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611105149.655144-1-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
 <20250611105149.655144-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c66b2e-b317-4a8b-cc26-08dda8d610de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ik3nn8fAWqEOjnZbaStxnRUowyWXzUv1+tLqCJd4chjhWg6bTb7R7gWUP5rS?=
 =?us-ascii?Q?r9Db1on6TV74kAzkjM5Bdg66q1x2LWq4u9WGNOQuGvFo2btNEHzyevD7mJcL?=
 =?us-ascii?Q?fE23hkBgaUodOdU6b8Gx3ehvqmpOXucixq2VoRSU50qO+DFt5hqcHTyvyGVq?=
 =?us-ascii?Q?UC2jumQd+fNSx6YVuE661D3pFJ7LDrzxnsvH3Ph+HVvgDz/BZy2E23B+MMEn?=
 =?us-ascii?Q?cBriAYYIZDpQRXIG0hNsusEH2ZbsMwVQ07OUbSG4kpS3++dwkKiPtI2HoOf/?=
 =?us-ascii?Q?1Vcy0QzZMO7JkVpMaRB7P0l1GbkdQOZRoGqCCCL7619UC4dz7DQ8uI4+J9Jk?=
 =?us-ascii?Q?S/JtIlO8AmmTpspsgGfOE0/Y6u+fF5nXwx6NxAqZMNgsBgfyo1ruj2SKKvvX?=
 =?us-ascii?Q?97JCvV9G5UYQPqr8VRxtuU7jMKAa87z3FgNSSJUQgW6SIngWAVcJh/FHAlx1?=
 =?us-ascii?Q?+lvBXtsHEYbeUEwEAQ5pee4ePbRs9yUHdBb6jCgUwC1BMHtIx5IEr5h1qfy3?=
 =?us-ascii?Q?kCEkV3aQ+lsS3OAlTF+9tbIlmkQbRMPXkfRwv3syXcTTzqM2t5vqGzA16QFf?=
 =?us-ascii?Q?mMJrKYxmpgLMO/66zxdU5C5lo0iR8PXC7rsyv8TDBIPuTXkzvSv04v1jCXyO?=
 =?us-ascii?Q?GRtSTytE7QjGPnJLiQzjnbwop+e5IE5EZw3uE6/73/bMQzgCeaj4/e3taWxU?=
 =?us-ascii?Q?scQMTP4mCZ0NVaJYIvaiDhTLaZhFrTnw2bdRGANnrPBzZLTByhNxratVhp6e?=
 =?us-ascii?Q?xgqtpLKqfTnUVqi7qeguqh/G0ZjNvA8SJCfyUPm5w01sjnrYDd4et4GTW1p9?=
 =?us-ascii?Q?B1fiuCik3YoshGcHH8W/+VGQsGUcaf+1jZTJJR6Ali9rVftvSkos6Il43ZNO?=
 =?us-ascii?Q?dbf467FBeVgu575O26NSvSdQXNfUapj9ScL2/sRxjJQtTslXoFThncNE7jfj?=
 =?us-ascii?Q?+2ue69ZEatSudKQBHT1O0eF9rSqOFTyo/mukkNZpN1gcT1S1MD4W6BNPbapl?=
 =?us-ascii?Q?7CYfmXmybope0CGN2ohiNCwnSfpq8ztRe0aoQuG7IBrk8TcepqRrsPyeE5H6?=
 =?us-ascii?Q?+Gwi3Up0hs1JL9lfLstI2w/s9dOa3ASW13I+nghLHd6FlUTvR9ykdYkYSBaF?=
 =?us-ascii?Q?kXf2O4suDqkAWFJdTHaT2U2BJ4kIqXjbHCm/QVNK1x/qZLnHtn8m402qc2iL?=
 =?us-ascii?Q?YpxWwywkLYNPMMP5a/ItAu68wkUoJPestDdfmoLCaGcPfL6CKktZ2PEwhWkz?=
 =?us-ascii?Q?5e23yPwbqM7Neo2r3FoiBx5xExneQnz5RlL1xusKw4MYMRQ3hpYTtbvxAK0d?=
 =?us-ascii?Q?zcsd/XwDBVWtIH2cMaRvxbYeAWPG6XM6EFWCuhs03lBlGBaM1VtAOyJETExW?=
 =?us-ascii?Q?kFDiodeCZ8f02JJqx3EJnjhtGUbnSuDLvygq/CURYuMITO2TT1cGYK06updh?=
 =?us-ascii?Q?JdlDL7T5wv4tTWOKGVRQvPYBI1IWMXwNmhihLxNw/qpU1qau2qGbh0VcTN9R?=
 =?us-ascii?Q?/SVz93PJamf7P2k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cQvFPki4h/5cc62pQv9zQ/C6CwcWXucsHx2iQIy1PXajvNMMpjO2wMKNcaAu?=
 =?us-ascii?Q?+dIkBKLe5Ow2Jnwe5wCDAGvxa+om8J1Ii7o4VWqNn6vdZqw7Z3HaMMhrlIDU?=
 =?us-ascii?Q?rDkfuDUi+WMAekO/PRFQq5mxl8sf3tqP1+hmu/ulxa2JOZSEuFqEqyD+x9DO?=
 =?us-ascii?Q?vnhoEj/tE749z797x/zmv+Kw65P8B5NCeUxaiJ2pKO8k+eLg6pGeQFvUUgZa?=
 =?us-ascii?Q?ACgRW95DHX6kH83m9RyPqkfcHTN51ZR6Jjqrr33KdRdz9WI0AqQxq5S6y3wp?=
 =?us-ascii?Q?yUl43po8A02SsRQcrWJd6k6ah3JrC56q6qLppFScWXJnKZlLtadXvYFKprGN?=
 =?us-ascii?Q?gBU5lJPcHSEY4W1Q/yXOj1MVPja/6ru1fJL5caX3SChSO+++3jMk0BEQMU5V?=
 =?us-ascii?Q?dEryk8lSq6URNZ0D+/I3g1rIMgtjcWQLI/tqq/YQnRKeXVIfRz+EwXvILomJ?=
 =?us-ascii?Q?+rqkwWoLyxEewZ5HY05Wn1g9PWLeoanzt3nDIpk2eQaMsHeAmy4RMJNXiWVY?=
 =?us-ascii?Q?BTamLVL2XE6PsdM3+YqA2P1Np7bQ3+vPW9EtXgkbmwPCjpbj4Uk562BPDwQt?=
 =?us-ascii?Q?xjIgV+hVuIzX0GLG8ZuDDzBPzY++yHkWjgTD7lSEUi7oAqDXPnDK+026nZac?=
 =?us-ascii?Q?iBBkqDao9j5M4XfgsFSq/nJFnr9UAGWbqNisfHjiqbgrQAFQ3pOktLc2ojPx?=
 =?us-ascii?Q?fvCJDwUA8ZXANdM4g4Ut0jET4tkEYj7S7AQxMo6L8o9PgvojsOVntqmMCudF?=
 =?us-ascii?Q?Ey8H3GCWfO3ajVqU2VtjUcBQCHscKwOHv7Fqq66sDy/MG0fJsCvZPWkJEqcH?=
 =?us-ascii?Q?uSUBTUk87VJV+JatDLGuOE3xq2GvzGcQzIeQoRumh3ICiapssP60P2EQhX1E?=
 =?us-ascii?Q?iSVZnNZX/4pX8p0YTBLsF4TvwWq+LB3Z/FsO1z7Wf6xeIiXL+i++R3IRw9Ro?=
 =?us-ascii?Q?j/t/zwtda1ZrHRNqfH9/Cn9N3gv7iD0AK6DCoReXUH7OdgQjry2UZdmpL8lg?=
 =?us-ascii?Q?XTqiWAkK/Kj4vpBrIw5pGH3E640B9yy6SmMgQ+KOXfc3+1dqElLFPgYE8KsZ?=
 =?us-ascii?Q?zFG82TMy2e28q4Td9NKNfGWzgXYmcfb4hu8/E6j2PefbNVAr//ujTBLS1Y0c?=
 =?us-ascii?Q?KUm7iPiOR8F33RdmMxsuVpU7P82b+voBHXeTgAv74HCZ99JOXBctzog07/84?=
 =?us-ascii?Q?SZAWpZwt1GdcDnP9teE2VgBvvTw4ZTgB9V5FMOl6GtGmIKYdcedwchtDozfw?=
 =?us-ascii?Q?fvIjkngpgBHy2r+QzNlZNHwj0PqTEvArfHelJGuvQTLHGyFfA07Jr2oVK32u?=
 =?us-ascii?Q?8+bUlqe7ISOjaOi7ZTxt1heSlxDfTBkboGQ5E2Kbd8l4ipuCBYQw28kYf0uD?=
 =?us-ascii?Q?0U6GyHXdI3nPlZmqbT74dpaWwDLCgGGdCY5KJYFlJMZsfN5deBbKarTVuGVt?=
 =?us-ascii?Q?0E6Ujisj2VTqb+fkyjZ1jISJdwYVF1B8av9YVi3ZwyHpgobgGQ3h6aylZqGB?=
 =?us-ascii?Q?y+slkILVWe5BAdGlN0VonWp2ovwf9GikoKJOwraqibWoC83J1FU4PWIgdy4S?=
 =?us-ascii?Q?IeKxHi0AMGDMQeGGcdr0ZHLkP37VlQnn2yt5r3P1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c66b2e-b317-4a8b-cc26-08dda8d610de
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:31.9952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mL+CLg3MOBl+9HpXrGxbOPjuwjf0ZxX9BHVPXqgxkZoYO8/qwKTyJTCe1H1D+nyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348
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
index 526f88393c..092197f221 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -400,6 +400,7 @@ struct dpaa2_dev_priv {
 
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
+	uint32_t speed_capa;
 
 	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
@@ -437,6 +438,17 @@ struct dpaa2_dev_priv {
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

