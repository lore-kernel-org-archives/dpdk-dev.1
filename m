Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB11DC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C988440685;
	Fri, 30 May 2025 09:14:31 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
 by mails.dpdk.org (Postfix) with ESMTP id D77BB4068A
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXV8bZQABB2xSDZyxr2VTq6QCNgD30NUwuLCkhxPLUo2cPJqMsfGwMioq5jDFL5NmQctlFr5LIg0ynrkrefLYRsGvUQHm0EsrGjpAHcIr6Ib78Vrf8rhacFR5rd1Omozh0wOauthcKGlHHofQF6UixhUX6hJz55rSt9YkT4qIGcFGKREhlKYDA+PD1FRd40QfjLBTblXgHsC2+rhATp3KdOVxddzoATt6LtxnSFatKulfl1rDs110sVaOZIDwjzG7nhTNBCyEGKr9FUFSBCma2gyKxCgrGzAjL9XpJv/hmnHsC1G2454cZY7sKKslt5oId8Bb+e/d0xlqYnp81CISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+JnGS6QDkysu/Psk48S4HRpe0XvVBq2227s5KSaVTc=;
 b=zE/zXH6ZaIn9YvjDElHSxE+Aj6SR14pXq+JZoG84LT9GxWBPvbH9LVVHV91SvD3fJQ4qNa80GKXYwH/Ly4kPhf4K0zy0sb7+s3kJ4IT/rHCEt2ctHEiNy74TJT0i9M2P9elyPKbYEhq7kZ1tpN/I0m3Vck74uRpAg1Ez2T5wsDTpslxMUu+8fBV5a9tNdhl03TIbdz3tb5ySfaJWBQALyE+ggnZLM3mhMFDJbAHsk35H7sJlizkMN87ThHe/9RgQVohMetqYFOWLc0TNwcuspZRRyix+l2rD/YPrbApA9C4LHagxoT6TmihrpDSwnubD6jXnUsz4kgYKqboifETDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+JnGS6QDkysu/Psk48S4HRpe0XvVBq2227s5KSaVTc=;
 b=NC5O0YVRylUs3JO6YracGhpeg6In+QDlPzQ1OMuSfrV24BCoNFcPbmeVQWW3rbTl6IflU2k1GzCFbDj5NEri0B9g9a+ELP+TD8/ZmaUSS8MMntlUHUJj8qP7OZXJ+EvtD2HN6dma45o14kSWXYDDLG9UA88YEorShJMqdf25QBSyR9nIAIeSOSNy08oMMAF61y1Quaax6lVCU/hMfHQBalaQjqEtwAQzkXJG2ydhZLFUY7X5Y/ZdYoZ/VduMAf9cWa8h9M7gWsgsBDVGVEdfXYoP4xC7x8c9cvdn5F7rCUfZyOGt1U1GaDOXwqyLIYxks2bBy/hyiSc848nrWTX1pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 07:14:28 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:28 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 10/11] net/dpaa2: setup the speed cap based on the actual MAC
Date: Fri, 30 May 2025 12:43:43 +0530
Message-Id: <20250530071344.2939434-11-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8205.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8205:EE_|AS8PR04MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: cb07ea6b-1b68-4354-df0b-08dd9f499d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nIyZQmaWI9plx9VGRmnsjI7dj99Lii6BovlKz116DWxP23wx9hM/8TPY4jy6?=
 =?us-ascii?Q?2cOtxe7XNZr90oDtKcBEDGy1Noc5LLM+lY7NdK0sPgYFYcmSWxkO4x1ixY6d?=
 =?us-ascii?Q?cBl8PmJuNw2JHHvhiNHlSFeswj1r+rN43SNdc61TCaXfTGw/u6o0OpGOP4sD?=
 =?us-ascii?Q?q2b+msmDHNzp4Dukox9LBEgotLq7MLMbpISlxTvgWzF879Dh8vgkgFnvsF+I?=
 =?us-ascii?Q?SfWMkuXaVnqo3mqJr3y5CLWwpgqDePqjqBNRE08mnhOLGgXc6nhPRkGOsFqi?=
 =?us-ascii?Q?stC89DugxQVCpokr8Kx7kLsoRZFvzZ8aFd42pFf5XLsF1aNgyvPUbeABqDUH?=
 =?us-ascii?Q?a6fpIPdybUc5O9a219RN9/0cFU83t/DOnOxNY7z8VKVXQKBlHetrHdrcxsr5?=
 =?us-ascii?Q?nfL0q27O8lJcEAwapWzj3XZAIFTu/o5/AE4PDZ5ORCUw2V+ezYmKDyYHZoy/?=
 =?us-ascii?Q?n+xYBov6VdoZRLUzx1r2oB7CY+MgnLJtD7JtaUe8ie/TxIS7MXxLAUk3TgPB?=
 =?us-ascii?Q?WeMneVIYG4opNimqk94jAUxBWDrfxY49acjnWwsdaJhzScGLCWWjKj9fAbgq?=
 =?us-ascii?Q?c/KUD71FBiGycsD3a/v9ubX7KCmMcxbvI6ZyBizu6VRvzV3m0tPSClKLQXuO?=
 =?us-ascii?Q?jcx4Zw5Lwr0DK3uWykBXOl/TRwZ9HED01QVEwUWVrB9Aw2SRWQhkDGz1/YdB?=
 =?us-ascii?Q?ayrpObqlOu9qmsIJBVelxypekGsg9tiu3h37snBN2Y0XXyWoccSiY7SVi3Rd?=
 =?us-ascii?Q?nMCtdxNdgjZu/o+sluAg0zuC1MfNt6NfPAMHysQG0JtyXi2P40LSLHJujBzF?=
 =?us-ascii?Q?sQS8LFUlE+yM2Lz2mGMkeJR14f8zSHOoQspPveE8MdmEn+PICd1moohdc87R?=
 =?us-ascii?Q?yQU9AbXhs41S2I1jfIij6h0bNV6C7FTaRWFn5PuPMqw9Sj3pKljclyMHr5CC?=
 =?us-ascii?Q?1HJI3z4Xv1UQfI0Ua/gzR/Hv4MxhWK2jsv1lWuGZ/YGyLQ5Nmi0I3k29bmVp?=
 =?us-ascii?Q?ig6pTGl6jgXwE3T6FPOfVHLwMrzbONrkkhqOsztzKVb5vM2qgpvPt2LRNY8G?=
 =?us-ascii?Q?Sv8zCC63ELDNR9UzY9LAbsjeFDq0d5xVIi+xzXXHI/q3tRvpcRfjRUAK/hip?=
 =?us-ascii?Q?rVkG3233PLfJHLqALR/SAAl2ke3HPxLVvIJjtcVGhEbexSP+4Y2yYb/XPIvq?=
 =?us-ascii?Q?CiJkTA/Adu+8Xojy/WLlTEKU6A2iT/0VaVtl8QxZu+prgYrhAkWWMN79/x7Y?=
 =?us-ascii?Q?sywLa6hwFxxlWFy/7ZTB71d0RDM1gSeAMHqZRRkjOkYlnISuo3b1WqwWMC2j?=
 =?us-ascii?Q?x+1pmyLFtT1yfL3vC/SDYe3u6cJnipxcWEDZgT/ghmJSLwciYcsG26wleFsT?=
 =?us-ascii?Q?E3rg1fGd8m4sollgqpl/hW4RILLT0u651r0tIM9ghsaTPlhCG01j2C7Z1XuZ?=
 =?us-ascii?Q?d0E+gyqYnjRIm5F49+jxrTg2YwJ+ofcTXeyUqf6BmyKdqy6nj45C3rmvtX12?=
 =?us-ascii?Q?yu3z/pmoOnpL7CA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pf8KYfqYp0vp1mzjjhsci726+aWXAYckbTEEvacG+VVZ3pRn7DWkH8PwBRub?=
 =?us-ascii?Q?R2xk5/UdHKY8K10QOTQD6WR6lhgtdRW4DAQIo5+Yp5bQr0sZ7B7ShpANT7sv?=
 =?us-ascii?Q?BASya33cSR9ZRXPUBCZXhjtNFP5rZkj45jA4kkNXK/XasCUsqZkl4Z2U99L5?=
 =?us-ascii?Q?GaC0o/bFx5lJz3WON+F9wA/4AFjxPF3O/kkSeMotQtPgmrdXpp3HLbmG8BNF?=
 =?us-ascii?Q?taTOK9BHQIV9OKN0VwzDqtfSFvyNNj/eOdwRJ4rrblNN7Pyw7FF7ePASJzQM?=
 =?us-ascii?Q?nfXDNid7CQy30G0pK8nikjD+GCIc3kY47Phx/JcBzwvZUdhTmsFw1D+KDK8/?=
 =?us-ascii?Q?8/G6sbPJikf5GrkT0P3J7mrlCUQQV8TAqv5KXN3aakQD2lQf7OVVEROIOV+N?=
 =?us-ascii?Q?HlNq7rBFEtv1UEPfvpP2WOsbCxft9x4OLvL6R6Uoqb07cOAb6BikqSGp5TtG?=
 =?us-ascii?Q?TMs3w7V7/I4vYbwuf59fD+maRt/OGYa9WB/T3Mpg1LQuyYxZKBU8NhHudf1C?=
 =?us-ascii?Q?EKXFCL3Hn+0iMRAheraJaMOIHl809iYs8dvn4gRhrbUYmqvrErsC0bacopTN?=
 =?us-ascii?Q?C815FOvHDFippuOJBZwxbUfDoU+wHdZpK9Tr0aoQth1kJJ+QFo53/k0wamm7?=
 =?us-ascii?Q?tsTmDlQs7CJwDzvKqmjUeW+tRIXIXpf1J4vL7PCIe/EmPD3+fWIuQT7qDFtF?=
 =?us-ascii?Q?VRWQySssR2Dz21YLBb4JG576+2n/35o6qG7NYbpAAdKmatIx4EIBnhUTK8s1?=
 =?us-ascii?Q?0ZAX18eaThPnJdQAHS0MuTJOJ8e0RnvS5ahIC1xz2DLNEVRRKnKn5r1Ku2BL?=
 =?us-ascii?Q?FjfNbl4Kz/3kKExaoUts/DJXEEVJgJbTItHRAA8BhEZDKHCWr6yJ5njbi+Iv?=
 =?us-ascii?Q?O3STm6BPo0FwQ3mQyNwl1AEdHWNPT8lVEP9nJcqjxHwSxvmD0SqHDgb6UJhq?=
 =?us-ascii?Q?KhdibP05G8awg0JqE09HFm276c78vJ7ugiPv+vNooovwTQV/PNM5gShgQmtm?=
 =?us-ascii?Q?1SsMaOIjmDlTd1Kro1BmeV98MG4T9doDKvovJNeYlWSBURUQBu0Qa7oifZZt?=
 =?us-ascii?Q?EVcdZ8zRv86Umh6kzdjLlcZBdykn8Ua0c6Adp6izIaIqQfHdAUmXnUB8Fle5?=
 =?us-ascii?Q?QueKU7EfkIQ7S/nwjCgbjACIi4Nm61arvMDceF3VhdrwaaegSE4NeJx3Nl7g?=
 =?us-ascii?Q?5p1Basgy8qm9kifQl2XlKudEAih0o16DM/G01H9i1sG8VxbU40KNX98TrEW6?=
 =?us-ascii?Q?a1O1AJILFijFhSTfqxbj5WLHMZJar4zPsSAlvYHQVqTayo7j2hOkIiiiOsBu?=
 =?us-ascii?Q?k+W7UTvZml3XYr3vbEECaLxXNWGD5S2ETeBce16fASZDVa20LE1YHay2tQfQ?=
 =?us-ascii?Q?Ro4K8aKbwA06eePC1H5qMUvItAnFXNNNh5REB+VjwCKSNkPkDwBPW/VP7MR2?=
 =?us-ascii?Q?7nKCrehfOFfLUjAUMLQqYqVLqdsmvMi14uqxG66n27v+CoimWNHMIDwVxnGr?=
 =?us-ascii?Q?yjpETXKsmntcHv53e8fFepRQk82d6sbYxpCIgQHPB2YxfTpFfMzTrIB3KCUB?=
 =?us-ascii?Q?DHqF1+YQ4ITQJfgZ4FE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb07ea6b-1b68-4354-df0b-08dd9f499d7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:28.6376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfaqUo1vMNT3Hsvwt0sN71rXEibSiBUha89LRDChL2w1P2XcrJUNK3njDK1WwwQW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173
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
index a71f1658da..478c9cca20 100644
--- a/drivers/net/dpaa2/mc/fsl_dpmac.h
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -92,6 +92,21 @@ enum dpmac_eth_if {
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

