Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B967C71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:12:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FEB242E95;
	Fri, 13 Jun 2025 04:12:09 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8F35442E54
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:12:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPo6qy/2y7SdQ2Fx8ZPjiSdZDhvHkk+HGUcoM6/a5JnYUjz0iivbINnBHD94mRYlNG/W9fYubcQyXvaF6OIublxeEJ6GUUx+r/DipWlgGzYLTrIDtr29+0vpskZqvjSW7FcG5nIk1S8e+JF8WY+BKlbHunl7IfnTfZDX7e93AjQNRU19EBLfQ6MmXNAgWheEFglKnWLqRfZztTVYs3fOFeTk1zjiKfSIoEewbBlq3LlEWOY2P0+WwOm8x0VtYWmed3ba9lLXW+QnvS+7S/Crhf5/8JsrgDSUVtVPywmhzqvxiKkDo8hFtUD+R29otkul21+gt20i6VyyeufZxIWDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jqu8SELcZowBvUKxJfw49/KgikFI0DplvoEbY80wcj0=;
 b=citaVXnyw0VBGRRmLn1+HXghrvdk2yBoGKs3j31fqAeqsM52MnBFDd5Ge1e7G/UdmMdYq9tnhA7S7IMwo/AJl7qUxRfjJj6Vpd2oD41QnoGmEs/oBpUA6G/6h6Rq/nJ885dfri8wFhRcUe+3eoXe+7j2vsWiE0CclqNbuOaHHsYyF4cRv6IYuITGEx7LzcTsqqfpu/M8+qP8Qzbm1Hw1cYc/nP1CryHy11ccE6fQcr6mPMzuBsRS2KIahdn0YT5us2nQbJSM0a0MKikR9SxJg68ViaZRDA50h780t995i4IJAPPCPs7M5Ckj0p9wrnud4kU742c8s4IlJdH7N6JM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jqu8SELcZowBvUKxJfw49/KgikFI0DplvoEbY80wcj0=;
 b=IUJnfPJm5tcH4neuzM07lNweThRKiYnuZXsNNNni92aR39VyQoMDU9EHN4bm3Vt3uLznHyi8VFu1KneRMBQAYwoWSOdZFbnu4AN8YSJMUKE14CDm1UMO94Rt8lQM8DIbgVnnML6vTPn5xBJPurUJ0t2+Sd1VoIE0xTtOPno0XEV2sfjR5otr1+9er9hKPLbWcbnh0tW2YxyLh5yHrkpbq5KkAFuJ3xK8pK1ILXw2dPJphHX0Jt8AKXsd4Te7cwmHtyDw37lvXvj2XEtOM6zgffOYdzcYIPaHZNg1VNM8S9gjATeFAg91LlqKMBVLCItFL9PDkPdvWbdPpPqgt/Ln9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:12:05 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:12:05 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v5 10/11] net/dpaa2: setup the speed cap based on the actual
 MAC
Date: Fri, 13 Jun 2025 07:41:24 +0530
Message-Id: <20250613021125.790614-11-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613021125.790614-1-g.singh@nxp.com>
References: <20250611105149.655144-1-g.singh@nxp.com>
 <20250613021125.790614-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d92fcb5-6b3f-4132-3699-08ddaa1fb13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k3Yvx6hO9IBZHAyXQMnKNORZAv9iuJM4WdP2wpjHFzjjLwgLN1aZzbT3lkdI?=
 =?us-ascii?Q?SpM84pxgqbzFV3bX69MinOP8Xh55VWI0LMhcE15FxvZ6jybCLYDmp4neb3nV?=
 =?us-ascii?Q?cHqBvy0pNcN9rM5jtbGQFbg5Ho5J9frKno8jSLIRo3k1Zxxy5LwDtaiqCSt7?=
 =?us-ascii?Q?Ok3QqSTjmBJWrdAULtq4Op7Hhhj1fyhm7/VhkoH4+UO2FsbGDl4TU1o7rM1l?=
 =?us-ascii?Q?wq2DoZ8kx07gBJpKb/hGCvPMHVZq8J8dzirPH6ntC3VrUUJFM+fDaUXTqfcx?=
 =?us-ascii?Q?/bKmxyU6SbvBZPJms/Ibh6/6bYcTAwYak2U+BUcBBgiUJmW+Yz9BWbxHlSWg?=
 =?us-ascii?Q?Y0hOYUCBNwlaRg2PdoZ2oy4L8C6dIRi+32dOTgWRFd11VLE4zL7Vq4VJEpmM?=
 =?us-ascii?Q?2qWS/BWIKoZZJSAo9441v9W7MjShlje1PKU6NKXpHLMeiX3dv3nhiN75C4kg?=
 =?us-ascii?Q?AeYkrIkec5BuJgYYTu9YgpxziLYz3f92M4CsKxvgR+QMZbtQ2+av8h7bbnOl?=
 =?us-ascii?Q?Pssz0/ZG73h+iTXErcJvXpLTTQNZJOdY/Ta7SMnPc7NrwEVkSfj9W9an8Nbo?=
 =?us-ascii?Q?vBntA0oc8FEbSggMTBjrQzJpNDBLJ8fx0jb5nm9RKHBeAKoe4PzJt4FigGyK?=
 =?us-ascii?Q?298JK6abxRZTkK4e1hcEXo+9P+1Ej+sJaosXsFWkT1PGPEmfxJurX626GXjS?=
 =?us-ascii?Q?8ShdmiJxlTq+xqkgyAVixjrin4Fnei3644bK63x/EF5TtcbcljLNHx1xNs0a?=
 =?us-ascii?Q?JVHhJzDZMDWRanvUqBUnvdvAKTYmf0iNhFLCgm6LGsRNc9UIAc4qc67UqZ4h?=
 =?us-ascii?Q?W2PqfnjHWKGUPR1z/BbjuMH/Mod98AcrQOeDmmVBu580URM+1QpbT75rgmNK?=
 =?us-ascii?Q?pBZWqqbicUHjRYyZpC35tPmLozTN98Hc0y/D/FN1LLo50EwIE74WKfM7DiGO?=
 =?us-ascii?Q?pMnJwdxXhscg4OrpnV1uYXVTW4gdq315HwkmEaLGIpWLQf8ZwCjDjzLjbcO6?=
 =?us-ascii?Q?jAwQDV2Poyi3WIYihG1254IbE0vLBtg0oVFBTN3uL0tLKWL+Mq7dIEziyX8S?=
 =?us-ascii?Q?Szt6COwSl26X1hiMS0h0HrJtrMYhU7ZtRNkTZ9eUm+w3AqQ9fjPYaPqmZlQ0?=
 =?us-ascii?Q?dotMGGubZEMHQLf2SfeIa92oEN5UgLDzNLZCknCP3KeswV0KsS8VBgzKddoX?=
 =?us-ascii?Q?zQp03QEsEU5v6vDDl3n9ZMcTolr5m9dQFU0iDV8iHnCNSjHsQpAGJTOjfqok?=
 =?us-ascii?Q?dF58TLu9lx5uRm2oKy+xCJ47ykBwm5NmL1OQC8ENNAaAAbL3Y9f/xAsO70pa?=
 =?us-ascii?Q?O07M0D+v6r0glnvIjBEuexe1vii3XN/zdxDGDTfXexRahDGzOWUI39dJ4ZMt?=
 =?us-ascii?Q?UDH7RpIoo2m7VwksxYlI8hOEIeGPeT4QmOdOBMQ3gZWSKfwCUCj0VmNJJG1g?=
 =?us-ascii?Q?SNub+j+DQEr8T2ZCCWbBx46EqDhjnoXuVyWawPi+LsvuBqrr4OpXqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxlV28XHmP1iXE5yW4ePdrd34/gf35S577yVrUkOSd2znnDOkSbsdseGzMOd?=
 =?us-ascii?Q?kwicE8h+mb1bidoMJbkRo2OEFVn/2bEt4wyQFaGtxfeWSXdEUZyX6veUq3FF?=
 =?us-ascii?Q?Agkrx4CGL7w/Np7MJSkqzdjduqQuvb6A41xRqlrssIk8waU4alslXvOy4mlf?=
 =?us-ascii?Q?OpSMomFOezB/8kJtBQXKcdyLF/T6Ew5zm9kt6Owk08URKuGx0+0VPqw9wYpz?=
 =?us-ascii?Q?+WQSM8Aq5++il5qHM28wz0qk3eWShz6iujMgGEaV78FKTyBxEzmDPSwriTro?=
 =?us-ascii?Q?IjSUpxRF71X0qJ8qV1gcp4amtRh8v77NCZbHFFpzo7ctZYqXQ+Je0MAavKDc?=
 =?us-ascii?Q?vpmtPX/q5/mwL0Qb9/KzAykZXR47M2DlWk65C9O3ukcZSJyh1OCowkctD1Qo?=
 =?us-ascii?Q?9p6jNFzutEeN5wO4Zn+tly4VBCXLXabYs70bDusD1rbDHIyf6Qgjn044RzyS?=
 =?us-ascii?Q?wFyU1FKYE2eE0C/PMmz8OGjql4LGTw37LOEAUEUoM9JBXpW1aR+JcsmfU4VA?=
 =?us-ascii?Q?g1QRLxDsFesKdyqQ5nn5P4pCp38ZLlWe91sGz9fYxAGaF6ZFBNYIOf6BvpFk?=
 =?us-ascii?Q?rmoTmhz3jxSHhcJEWJmMqL0TIl6d+HfGhwcgW0GbkGM5poaJTOZJnqoVBxu8?=
 =?us-ascii?Q?5m0i8mAAPp/lHXcONn+Xpr8riJgpfXWivVvQqdVHqKOyuLFI283PDz4c0wFE?=
 =?us-ascii?Q?GYZIjmg7fdGC2KR+ELKFnqeKIrL1ESy8i9dws3PKJA0juIcIF7z9L2Z+vP9J?=
 =?us-ascii?Q?Uac2CMX660mP1baQJwxBOH+cbe6DlPtwf6bg1xEDyMxwW6L/hPdRRP1qoFbw?=
 =?us-ascii?Q?9KZntQmgqVRyViODJZPRjreJmXDVXMI3Wv3NS0SEJuVJqusORxO0dRlBP2so?=
 =?us-ascii?Q?mCVBOmUeoMjEgFuiUKFPc7RinIvpf2AWMrSnTTGchKj8ee5QEx9EnLamVAOI?=
 =?us-ascii?Q?RWfXsQwLmMSNKteQb3jI+KKOVEcEt8nyh2TtC/VCsB5VLjE9pcdVgBKPOGLh?=
 =?us-ascii?Q?j17QO4j8oK4TL2Wozlbl6p4Qto30ZBE7nvgQ/OvXQqFaZb1i3dZGzar9lQSE?=
 =?us-ascii?Q?GjeTa8QWvoASm2v99bTfuXmwXcmi4hb63XXMMs+k9LeSmTSFrXvaniGLFPBB?=
 =?us-ascii?Q?WZ8WSjvzSjWaV4gfwYuktADBVHWd3lRwGwTyhp7ZCDHw0RZMjrhO3e523vHO?=
 =?us-ascii?Q?F4vU54jbOSDLnMMq/ndYOxk7g/PmxYoF0KKeIq3x82iiYXsveVki71XPQzOF?=
 =?us-ascii?Q?6zm8SMpStLZyLUcTCGloVEOFVa2WZIYso9cE1BT4q63Pcq+fysildTwCzhfM?=
 =?us-ascii?Q?M6H3WYyuNVFOX9FQKDY8s1dT2cu5bolotouIGYaGSNgzWeP5iH9rYKuCmzOn?=
 =?us-ascii?Q?E26uEjbUpGwO3VHdkPuNE3uO8jGrHQSKxyvQSJ2Q15w6faiWUL6zkub6c6yy?=
 =?us-ascii?Q?Pz9zYgLFVQPqynRDTRzsrYj6OEPKJi/gxyQVF3it4LFofD+d3wMQ6w9EnSR5?=
 =?us-ascii?Q?S7lSw744Mvgo/cc1SUQPan7tjTAz3dUvZosMjrqRrAsZgGBY4Vo7QzxyFwt1?=
 =?us-ascii?Q?zD5+rVIq5LPuoI7n+0bfU9cAbuzUTtJvm8Z/fS3N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d92fcb5-6b3f-4132-3699-08ddaa1fb13a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:12:05.3901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwgBV7iM8MIOmEqzlHFcWE8uRDxbMCCYNXP0KAaLRkqU5u5LHQIzz6DgYgEMVqjQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
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
index 375d646cfc..61d7573a4b 100644
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

