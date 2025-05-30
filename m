Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5557FC54F30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:15:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5431440430;
	Fri, 30 May 2025 09:14:28 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013036.outbound.protection.outlook.com [40.107.159.36])
 by mails.dpdk.org (Postfix) with ESMTP id 771CB402D1
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJ0NWY8EH/dfFghmOdMyct30wKfSjjg70YWVGn/mHBBOLu6CatS9qM7oB008x6IOK5QhEHLW7isTnmXUusWbN533vro/MzIlH9Kdoegr7G63HrknHkotslgZ3oeituI0mrs1iCnwoAmYTGozmIVQrCTEpkV5HlQA1Qx2cqP86JNFODuuziz1xDIDwQtE1bkTbM+04HiMRbz7nzhhqZzjKSFJxoGcRJxtbGOw4xmLZsBJGKquGS8r0AoprEbpHLw707cOfCOiRzOOoVzYdl7N++SpV3qhqiiQyAiRhKBQ8vWPQI8PhPT9m+WAHCNaw9nGSbC45jQcfnQJsX6svNg2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRWcIPfHSb2am1ilHJsClnMYa3QyedOwxaFuNVgaP1g=;
 b=tPQ6HJE+AJN43vl0qhNx7Wnrn5ye1uJY7B6T34/Qrju6A5JIVZKyGQggmyeLAFq0D3l+G6iBgySiVwTxJGw03qvIBSgnF7qqzaK1O3/NBYXja0DYC0YhrWPxSsXvpqXiC5P2w8nWjsZ5S7+P9prwx08XdaJgJgonf3pNhPC7Z9tZ+yOMl/D2KTpaUjNd7voliH9S+5L+4W+ix0tkoGkrqIpcVvsQc/8lrHeZrH39EQcs44y2juEaZBXF/ebJrcVRlmRckHeqC1YOvdD2+ir+HNLSknLti9kyg2AVpkgglLaAKBoz3fm89QBarXa8Ih2MBQnZq4hXHCO0jtfBj1xECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRWcIPfHSb2am1ilHJsClnMYa3QyedOwxaFuNVgaP1g=;
 b=eFjJaQdxi8kcj18Pp6SJfPe3GoZ2434UgE2EG/VBHVXyfAfb98ldt3Vj9fatNXYb8Hz9QhnK/l/uG97mG18QdfXJNLGrUfzV2PQ+GLDIiUZZoYQdlqioVqpeShK58WQxLcnCw9mnGvbfO32CEgjATdlVAMI8asGLyiEGWBZrNy/bNPkx+vmRdjc1vC/+4UKLUxpeJD53IfdFofsFsB+VJBDzE/Ub5x6gRiLLFUB/ePN7HdwiJ2qyRoWvigJJUni0DxIK9qnZwEpE4Zq7pnNkHtA+xVaxt6Qqf5w32d3/DvrULwIWk9RSzBgqs6TupiI4KOy7JQtomZPdoExWVB/umg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 07:14:26 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:26 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 09/11] net/dpaa2: retrieve DPNI API version at init time
Date: Fri, 30 May 2025 12:43:42 +0530
Message-Id: <20250530071344.2939434-10-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94c3dbdb-ba5d-4d95-fe9f-08dd9f499c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7KgngDEWrNpR384Pq7IugdYJv7AIIEqchKCXFlOGEsZK/WF8Bwwzq7l5cXTy?=
 =?us-ascii?Q?GfSHBhowS6gCd5zwgbRBNOpmQlY2qn8czF8J6JUTMXfWFwZ8es6myaLGvR6D?=
 =?us-ascii?Q?rqOGCvWGARWzNZqBBtzX16kynS6ptF4muPrDM8DJ0/HftL9TNlWn/4nawZvD?=
 =?us-ascii?Q?cEDNmBziGfowicuV36Iiz7QNaXH9OjP3cwOLvQUYjR/w2+VGndt3rui2o05D?=
 =?us-ascii?Q?WTZkr1i1BLt5t6iYxrDAwkS+00jxV3GQN/xlUzeDu6WSXmyzZ2kykMhvrtd+?=
 =?us-ascii?Q?eAdpv5COhJJ/KLyhkL5NBpyA1QVAh2HU1m7JuKk8xV4+k1foohqmwsS1RszJ?=
 =?us-ascii?Q?hgElQUdDPLuCsjRZ83Gv4actxfs7EvjAKjC3tyirtUCCPiPOirXUs7olDUoq?=
 =?us-ascii?Q?D7PAAsJ3DIjfDQ51AcgMwHv1hfMxs64KjTOw7MyncKIVBLaP4fD5PE+oV0zP?=
 =?us-ascii?Q?Q4iDiMDqA6YxFPusv7KnkOq1y/HIXkqiRz3pk44BE1we1etIoYNyXLasUw5h?=
 =?us-ascii?Q?pFp+5tdC+pJTgnU5oZOl7cBrpmc90wSW6QQGteVemHDJ0OYy8V/8f8XETPJL?=
 =?us-ascii?Q?N8PCOrJp2eEIdTzM8ogsHQMeB3HXx9rwJctsLeh2T0udmpCFRMdAjVxo8ko2?=
 =?us-ascii?Q?0EiAuiFo8QsFMcZjlN5A/G91ouNe2LIzshRCLKi6ijarvgudAkYdY0n4xwy8?=
 =?us-ascii?Q?rYhDytOdKeYP8Ar/FrmhTaAsZbN4VD/WHVoh89iB/0bkH9+IXyk8w7bJArfg?=
 =?us-ascii?Q?qdIdROdEFFF7EKLX7dzm7IZCKCG5PB4S1F3kh3rnxPH+FyD1UXJ4w6z8+zZj?=
 =?us-ascii?Q?4w43es4GqvJjsCpkCwyaLJMDkIKlL0lz0AzUPvBFqZEsbbFxSa7so74W83Iq?=
 =?us-ascii?Q?Tk6KE666i9CDZWWMp/xM5I0lDUJSB0mg8N3taorU3++4EF5k0LnhD4F44Jc0?=
 =?us-ascii?Q?Ahix3mNQLInTW1kg4uALwxVg/0Iq/lvR6IhgwJcbiILxG34i7vYvTjoWf0pM?=
 =?us-ascii?Q?rmCQJBcQsT0XIKiTpjQ6PxhhtJMUrccN173/ycKFBt+iYtMwyLsMAT96AAYT?=
 =?us-ascii?Q?IgAtLhDM+fxx06t1KBxb6O/PLnG5bIunUTdbIls5X2lOeZ9D1BrPGkupQLeH?=
 =?us-ascii?Q?Fs/m4Zu1Pyt7Uf+SruBKqw7i8oPTQaIbl+uk9cHVNgxXHuF1TAXdolqEJTqT?=
 =?us-ascii?Q?1j2S1RM8pcaOT5HdPlhkQYciKwYk2bTMkgJXeS1Tg+pstjEaEFa8Dtpwjqxb?=
 =?us-ascii?Q?gg784TqqkrzAUXRoszkx995BgH2BKnrKVbx6bczs3RdGqHFEAI4H3hgLhpVX?=
 =?us-ascii?Q?UlzKqGH2iHxD+/ELeagNWq1LFBHGMI5cl6DTzg0JmN8mf5yYTiVX8JW/Wdun?=
 =?us-ascii?Q?ovUKub2rRpQdYiYjnyX/Zsy+w55zTigpkm3Th3TG4ia1SZ9FUoeMuEbqLKH3?=
 =?us-ascii?Q?cCc1wLFZIPvivdf230haZ6BBX/e73y8PWDdIk5Ra2Gh0CYdcF9MJ/o3fk9bz?=
 =?us-ascii?Q?aprfa2NTAugnjms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xNok3WQF+NmuvCU5kZ4/ymXIwZa5WtQvHM2cGwNkUAkudJMQ1Apa6d50XRQy?=
 =?us-ascii?Q?J06fZ7PxUHkA6PFFuANFZzqkJ3c8d/LJyMiPpGy4MwU+mKvYU+oBXhZVjf72?=
 =?us-ascii?Q?o5HFqY+n+E/GztxeA0Cd5TWj7o3x1MIC/omzJHDK9mEv4lPWNNhVT8w9/v6n?=
 =?us-ascii?Q?3XIzMGrqC+YlWyMF1He2nVXJhFy+yISo7eq4XLddFdHWm5zTBWDkpWEsFDhp?=
 =?us-ascii?Q?PF+Ep+WmsUDGX9f30RISCnO927dtgRV+qYyejvki39VrE6TJkyjv/koH4QP1?=
 =?us-ascii?Q?y0tu/oBguqU6Xg6yDlQV83DiQ80LSULYH4E7jx3MxKQLQfeFyeMYMZS1uHU8?=
 =?us-ascii?Q?Oro+1dqAqZPkE9/eKGR1/sG+W0UvTlJy0AIUWwCdHIVUbyyJCLuXYXqmlQ6Q?=
 =?us-ascii?Q?k+jD4OWjzftPQpiBJuVil5ioplt6HFOixUOBPQ8zlTygjPdd7UpsHFuLCKh0?=
 =?us-ascii?Q?0sXTFwnwjLRrR6LKWSyV2eok8HBVlm9mJbIrJkBdURZtghQJ+p1WK5y0IaEE?=
 =?us-ascii?Q?DNXPzzIF69tRiN20HhcRMlc5ne9GnVYI3Hq15g7ko0ogf83C1pm/Kmtj+Yz6?=
 =?us-ascii?Q?bfQAZfGINFtz7sC2CRDbjSKFQ1N6V0frbTjLOrTAhGNZXOVR8cK5euOD0Ul2?=
 =?us-ascii?Q?qgwOdy+Js/8M2ru9PzEbAXBoggkYZYRAHDw1Yz6j4JN2I8P4w90COuGYlr9P?=
 =?us-ascii?Q?g8whpA/8QGt5Cag4yPy+ntLR7fiDqaGu6XdafRrI40gQ6nnPO4Vp2ZFbvwZk?=
 =?us-ascii?Q?8sk8j/nbmP7fX3E12+fV1wQb6E5VUQ5ppKM8Y2q6nH8VJbA9T0Wvuau0+hPj?=
 =?us-ascii?Q?YRgfRTVKbu9L+TmmT+y/CA5ZJ2PGZUFgMvCiDQ97G/bku5VESuR+vXK8YOg5?=
 =?us-ascii?Q?NMKldTq78EfJ/A7Ze3PatcI3THQniQ19bzfqLdf5/6Rzl7uEEAZowkW7iLQ4?=
 =?us-ascii?Q?/8ngcZ6LPtmbcPi5J6gDR8nEdyDU7dhLl4Uug2NvaNUSu0nFLnze5nSd1FWc?=
 =?us-ascii?Q?7UGXEanzT+O7WlsVEIVBzqa3/9hs2CyaSTQejsd+/vHO8QYBN/O9pKCap7B2?=
 =?us-ascii?Q?JaAy6RZVZqVjYGFpFfuCd7rehzPaxiRt0AFDN9J+SLdm/LGmSPLTjBvhJ9vq?=
 =?us-ascii?Q?OjdoU44YMHucRsCIhZ26s05+nEo6NlHZOOEIn10bDvSGMCqI22ux3HYHxng7?=
 =?us-ascii?Q?B4RWB9lVtZ1kbrEl+XkZIaNjpZA9dv5svNKWV348ZKYxKOvnSAcZZRUwjiah?=
 =?us-ascii?Q?9zPLg0u7zMCB/4rC2KPf6yRzhcKJq1Up13YR5o3dnAi9nHvbonN4orv0t3oT?=
 =?us-ascii?Q?K26e8aSX0LJornQd6hvKmAklA4cbtJVfmzr0m1mfCGWKrFGlcS1Tunk9LMba?=
 =?us-ascii?Q?kR71zdOpSecGBoDlngJtmRhkG/+JRFBD+O+CoHbwM81ZSOng4huAMNauMiVI?=
 =?us-ascii?Q?T/M+kvhwLt0sT4o/m/NXpBkCx5Ay9e4AKBGZHV/UMM6caK/V77O7N4Lru6yx?=
 =?us-ascii?Q?gxsS612TlVVnQoCMTix5hnZQPKcj1Arph0Mv3KZ2S1dQl6UALSpEuryT5XGd?=
 =?us-ascii?Q?SQZwYMRZVhAkjmSLa6M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c3dbdb-ba5d-4d95-fe9f-08dd9f499c12
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:26.0464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irrhm4ntX5RRQTxhIhGiC9GmkKWeU8E9MTMjmkEHNaeewKNQ3FBBkRF+uUl2G7P0
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

The list of availabla DPNI APIs depends on the DPNI API version
available on a system. Retrieve the API version in the init stage and
store it in the private structure so that it can be used at a later
stage.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .mailmap                         | 1 +
 drivers/net/dpaa2/dpaa2_ethdev.c | 8 ++++++++
 drivers/net/dpaa2/dpaa2_ethdev.h | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/.mailmap b/.mailmap
index 91e08f4a1f..93905921b1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -606,6 +606,7 @@ Ilya Maximets <i.maximets@ovn.org> <i.maximets@samsung.com>
 Ilya V. Matveychikov <matvejchikov@gmail.com>
 Ilyes Ben Hamouda <ilyes.ben_hamouda@6wind.com>
 Intiyaz Basha <intiyaz.basha@caviumnetworks.com>
+Ioana Ciornei <ioana.ciornei@nxp.com>
 Isaac Boukris <iboukris@gmail.com>
 Itamar Gozlan <igozlan@nvidia.com>
 Itsuro Oda <oda@valinux.co.jp>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 298fded65e..b88c9d748a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2814,6 +2814,14 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
+	ret = dpni_get_api_version(dpni_dev, CMD_PRI_LOW, &priv->dpni_ver_major,
+				   &priv->dpni_ver_minor);
+	if (ret) {
+		DPAA2_PMD_ERR("Failure in get dpni@%d API version, err code %d",
+			hw_id, ret);
+		goto init_err;
+	}
+
 	priv->num_rx_tc = attr.num_rx_tcs;
 	priv->num_tx_tc = attr.num_tx_tcs;
 	priv->qos_entries = attr.qos_entries;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 570b1608a0..ee5ae3b70a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -394,6 +394,9 @@ struct dpaa2_dev_priv {
 	uint8_t max_cgs;
 	uint8_t cgid_in_use[MAX_RX_QUEUES];
 
+	uint16_t dpni_ver_major;
+	uint16_t dpni_ver_minor;
+
 	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
-- 
2.25.1

