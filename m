Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAFBC71134
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F5AC40B94;
	Wed, 11 Jun 2025 12:52:31 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
 by mails.dpdk.org (Postfix) with ESMTP id 662BB40B90
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkBz0nneS4KGPA9yrAmqKeFqIp3NYl7qXgohe/ctCCzbooK84GaMNjZqDRTv39rV63x17Z/Z9yArku2sUnDtA7z/qeeyhu2biQv45Al92Gs4ad5XBucDjSIn+M+QfJ70/hOpwFbXdVcGNCe+kVz4ljnJxM+uZMy5heKJG1fJZsRF55So4ZJCe3ozMKl48L1lRKlfCd8v7UpoP94SuDRJYopYsdTVYi0+UGY8Y3k8+33bMwO8UBulWGQWTD6Xiudh/Zhx5CCKQIetdBhK1dmJ3yPMKuDGUapSBUF7F+jvKaUjcPzhCpsLSp4i0H1PEhFUNNiVtqY6sn4g46Z4oyEyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ1MOMfiUcI1dxV/qhSdpHLcSM41jDNlcao7Cb2mEL8=;
 b=mL8YizXOm7ljeKsPyvVTs1ZOQ4j16V4FhSbjmfrscrEABrHHGAdAfEP9JliiK2erYHqFsE82YcTITAngmin0MMpdk9Sw2AmbHwlCcV06oFo+PdZ1gGVaOayspr2cHesfN2Nvyo3d6ujQQ+7RdTDcV33zAcerISZ6iowDNwI6Qi14BRsSHKCHCOw/ThBU703ADWa8DxtyViq7Mh7h7qSbCydBVVJ5yViL6LwyjWmiXXTpyzAW7sKIcLPjH5Mci8PmH4MCl3eeO0vN8Xg/VozBuK02I/Fl6Qkuf5R27vTwI6ibUTHlGdWX+3OaUOmDPoE8ZMpnOQ1bNxGNlqhg4g4w/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ1MOMfiUcI1dxV/qhSdpHLcSM41jDNlcao7Cb2mEL8=;
 b=ZY7MIsZYI2spsSunoGrhUR+6mLEWiYALznVN12+4fZhlMtSItXBaUqqhCN1tdW4hoQbtQWyWnTWZRH46fMHRCXVI+u4/9lf6ySzzUIz9f8Wc8YLmn2JNMORampYc3xBNRoft6q0ZAQkTbiXa5V6Y9C0nUnlNcfFwBdSRqkRId/H7NkEkYTE3UZLDZl/bSfCRIkU8ulxhZaNxrMDYznv9ReoUbkcHuc81s24CZRU/H6FI2vHmWJxnfegcok6UK/gsL/a7Xjz0aCuijr6fMaUp7TFJ1IbY3GN0AdiGhug3XnBnRvgUQQrU7C6ORVgaDScdFLgHXA2l0aAEvLlP+eV4mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:29 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:29 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v4 09/11] net/dpaa2: retrieve DPNI API version at init time
Date: Wed, 11 Jun 2025 16:21:47 +0530
Message-Id: <20250611105149.655144-10-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1c63bcf-142d-4607-9318-08dda8d60f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m6LKbqq6uwadYh+QyenNznAMxmMvibFx6SXR7aOVfyL1+PxYJAwpngPRnPJa?=
 =?us-ascii?Q?WWwG+NTo77jJK3w9BmWo9WoREElKtlnpSjwPt3xSIUTwQw24HFZnneK2Mm7W?=
 =?us-ascii?Q?XVsSSekyXQclFxyCZBBEHGg/CcoYgzT9Dfhl70clVezSkc1ixlMQCuKa/7jT?=
 =?us-ascii?Q?Yx6cjStECe2WShzpLsLzQi4FjqAQBdZygnudHV4YFBUePTNVKvMYS4zugMZz?=
 =?us-ascii?Q?lHPOm3v+gFNmYGIy45eyE19+XlPx+PWpom5Zw2K7g4iWnLmc+4+gRBaKll0Z?=
 =?us-ascii?Q?7fU7VyAuI1rcfWtmBVXXpfhlP+tiegwxnlRZYnLZmZA5DqQvYIj6Pp4bo6nK?=
 =?us-ascii?Q?uw7lsa/qW+gBwc5zXGB20hSApNHxcBssJmSsk9D8IJp4RQ/qYQyUq0sLVmhe?=
 =?us-ascii?Q?LVZ3WcMVfs/ewzTvL2SOPtFU1zeNAGZRziagyq7bftDwjQ3KGLtLfMAi00gb?=
 =?us-ascii?Q?1lIDGDj76NuaEc7njzmXpwqlMMhKQI5Lgqc3QZEACmYDkG+tAYj7GT57NXNw?=
 =?us-ascii?Q?0XH4yMhtHSAnZ8kmWycOnVEN+W0FtWw5V1AxqG8PqfLKzWq47XkuNf/Y5bAe?=
 =?us-ascii?Q?FvcTumoZp5OnD8YUnk2HQvg5MV0WmQb646+6H50gQjN0thAUjHD1z8JMYOPQ?=
 =?us-ascii?Q?lXBvDz22H+m+vF++TjqukYY+gbUC0tXZAylaI9iAipvmg+2fSyPA/bc6ByTo?=
 =?us-ascii?Q?xMJsYvebjvOmFr379qYZcDrc/YwQrlAoHu1k9SLk5jQoNbWCgzkp6iY8myNH?=
 =?us-ascii?Q?FjWbRkAZfm66iig7dXtEKUnotBBuxobwvaT5ewf2go1xF/nKg8OZrTQU59gb?=
 =?us-ascii?Q?Ogk05ZsX0NWURbDtEMiKEzmGpckYk6rf5cns9UWbWjoHrsY8zlvsD6WkDa34?=
 =?us-ascii?Q?jHhu9wadJCFuKejx/Q0lURdtQj9surqNq/XgRviy3Y/oFmchTCX8eO/1WZAv?=
 =?us-ascii?Q?BOqvekQcc3o1vVIIxJjOGAjSs7+XqTqU5BTPGEexFgybTKVIK3/5Gh2gVPnE?=
 =?us-ascii?Q?isnHE+RU3aSwWFyaa3CNUBdeolkTRgzW/dwgCBk496DhaYqEY06kBXtzpekj?=
 =?us-ascii?Q?TAvCAszCYUECU8OXEM73poef0klfRJFHOqJ3wNyRoIG0+K5hP+1oIx9heyTj?=
 =?us-ascii?Q?/HnIe4eDpiiXBek7wURK7s1+CNEbR39oAOku5rIiV0mIq2EsLlOmrQCs2DyV?=
 =?us-ascii?Q?SI9BdJbosu8tMuB4pTTTWKeXlb5aUCYLB3f+FxgAOudxfguirifEPZI+E38M?=
 =?us-ascii?Q?kF7bOFM51DPvQOH24rMFlt6JtZYMEq1sF9p5kNJN3HMBp2NR+RLwl52EaepH?=
 =?us-ascii?Q?RShzkrcpO5jYjJYa9cwEDMzcO6IB391digAqgIIkuzSEqZ4V3u0s6vTmbvMO?=
 =?us-ascii?Q?7Z2pQTEnIii30w8JfIC7mqOUMpi3X8fXEuvjhlIAseB4KDMxdO0HlF7aRil0?=
 =?us-ascii?Q?x9Wv61x7MwKFmeJuITDZMPXXeU40jVqlI0Vud+vPeDOhO4iuHnpKbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O79xLZp6YPCSO2izjQn8T4pnxWhMqlwCyjzCGETJCQhFizmn+d+JXH4DXS09?=
 =?us-ascii?Q?ubq+RKTpjmGoBl2jCYSet1e2oq/TOnKKwWLwHDwTniULF7++eIb0S3fXtXSP?=
 =?us-ascii?Q?Abu3+83zDKJAJJtu6WJDkW3jzAZipZzensYAVCKAaz+4Kk3kZKhVWnPQMmyT?=
 =?us-ascii?Q?xmt9Ps5VCblbKgsNW9lu5zCQuBP+97+WT+QxNGX1PQ/i0Hvq64lUZmJI4JjK?=
 =?us-ascii?Q?85pX5mkeJdUigp1u+3veX6zArTmJVRnwMZxi5o2W7rMHkMhSM7LCKt3SYwdb?=
 =?us-ascii?Q?hqcXI2gKwkMu0PJuStGDZnaqGDM79p+RviXqoV3TCljnEGQ20MCbGxBKwgMy?=
 =?us-ascii?Q?knNFs/nGPB98+XoEldmoBLgk8OrWdgc/0wl8UcMnsgcRdwhUWyyPrZCwSex8?=
 =?us-ascii?Q?poTTbZvNIpumD0aSrmLfUXp9UPrtCh9D5HAUqVWxPUtdOaxCW01CN49UvVcX?=
 =?us-ascii?Q?kNr+fO8uugTRr1JfPoyLPy+H0CVpQkx3WOhbHRM85vgIltnVmiU+gkhicchq?=
 =?us-ascii?Q?fH1DhTeS7lchCJsj3r0RrE1DFUAiWO5rjAWOl84n96vof9i+SSOphL8OHHfY?=
 =?us-ascii?Q?05EqZUShLaxdKFtr8bcIx7pzt9xCqJRP7Ef+f36IQtCr3jUQR60nPTDR6r6S?=
 =?us-ascii?Q?wHRUMTnpZ3MsATFQPwy8q3kZJWqDreaRNuCnlyUXZI2dDqqe2WNMYlgoVsPP?=
 =?us-ascii?Q?IIn4kOqy6D0njTFWuGeo4wcTx5q31Th5x13J5EXz+xLP8uAARVpE/Q5V6Rul?=
 =?us-ascii?Q?K/NJE36tjadw3ZilpAuJFrI8g8pzB5tmtn8bQL0VOW8BChMKjn76w6AaGeiC?=
 =?us-ascii?Q?rbEdQsN4jnW1x+MYCxJOrQ1brwWGi31lXZ+DApw8ndKmyRYsVQ347KczhbO+?=
 =?us-ascii?Q?JHh0WF87ylHWMvJDIIEyDkQF2DZoKSX9qiHGIwshfVuFSfaRN4gPZNnTw2PN?=
 =?us-ascii?Q?4GCmhcgGmkgJOszsGXqeazaQ6Zh1skCr1dq9se5X7vufwiBrh5UsoU/dM9w0?=
 =?us-ascii?Q?0rKuG9YVtoFNq5DvCimzlofSQ09pmOcurgV/rHQTFmLKbak3zRF6TUZxWWDX?=
 =?us-ascii?Q?rUud2Y3b45O13PpbGqkKn05CQF+ILhXWxbbAgT3wuwgiHAiQtjRC1WBhhryb?=
 =?us-ascii?Q?KBs5Tzu5IXs/zaUQbCeJ7WrnMG9A0Pts0MN/2OTeMX/ZSCSF+VMKFkvPf95B?=
 =?us-ascii?Q?UmdoUSQC9WILKH5MJjmcQVpygbW4xJOA3ytB3iYYGN5c0ungwSjMuju9HIae?=
 =?us-ascii?Q?/0bcHHyS5zEpd+U1hZNHWJEuQxldSC+VNZX3wlW2q2wV3vXCBUReNJHjEKs4?=
 =?us-ascii?Q?hT46rlM9ndNK/YnzlocJNFhM1rZY6YgrEWkulGnK33Qr6vGgG9oAJHl3NwKV?=
 =?us-ascii?Q?PibNz74P45+FCx59fVeTDN0W9BucFLhsKzk2j0aQ6F5Fp77zq21n5X4TgPH4?=
 =?us-ascii?Q?ZLJxdN8RY+TuR/uXwkPxMJaGFP4HIwULR+N+zS6I12S93RQte94n1DLtgsG5?=
 =?us-ascii?Q?fgUdn6Q0B5x+NeiyDxzdEOfRjQcoKcrUsjCXz/5lPcNewlkzBKyg677DQieT?=
 =?us-ascii?Q?y5NQ/3IV9aCEEmwF/2Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c63bcf-142d-4607-9318-08dda8d60f81
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:29.6096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTj/nWrY14Q5U3YRz1WKB3mIU3NySV+v+YfiWq7wmYncP38ZhFXMqReK/vxi2Agq
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
index 3dec1492aa..49aa2f08a3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -607,6 +607,7 @@ Ilya Maximets <i.maximets@ovn.org> <i.maximets@samsung.com>
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
index 94de1024f8..526f88393c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -398,6 +398,9 @@ struct dpaa2_dev_priv {
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

