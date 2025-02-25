Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C3FC021A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 01:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91E0B40662;
	Tue, 25 Feb 2025 02:35:19 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2094.outbound.protection.outlook.com [40.107.220.94])
 by mails.dpdk.org (Postfix) with ESMTP id 818B9402B1;
 Tue, 25 Feb 2025 02:35:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGoyHNA3k9V1jSYxr2Kq+6BLjJBwJCShOyKltOho5gqM+z9QavA8rmJZ66mBOCdVo2GqxYoS+XgueMqg6HOc9PMFFKYTlMbtNXliKwzJgMg8NzZpD3vy5ZVm5JMwTzBvh17o34jsxxbo/OqfIw7B69f8DeQ/GP87XlIhDTCsCIL1c58AbGeU/4CuKvLTmZekVYoyhX7JCzMW/Y+JbzCdbhKorCDLP9zWIjX2sC6N2i+NxGz78kEQqLiDwFGbPISu/ehfLu1V0hRGb8t4r+Z7lGkhrpc7/z3WJnZ49DF739QxEU+i/kki8P4yqBTN1X1YI/WwLY1lc4bYrbCpn6NzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eQs6Sgyi4yte+SBQuw0p4dTdF9TXbtfDwfALvS04Nc=;
 b=pKIfDD5WI+KOC2r1+cAEua8qzI6xMlm3YxfgCzpBuKtdaDk8SgbBaBefRXFQ2vSCWY4gWFr5d8/PPE2MNWoTGJfeCBOBWcw5jAzDuvDxFeIaboN6QclX0eXvyoYsFwSQlP4YCWdeQrAUwNumZIWYHZavVuY3WmYfKrlgf76u4y+X4FWXD1WLXqyIsS1K3RkjGnUTxPM0GNdSGb98FCvKkiniMVg1uFfWfFHCeL1PjBS3gcs5LA+JCVNLWLFyrr4g+4jBJxgtXMIH+sBo3Ua3YHjyfXbYt5afYM9X4OlhDh84S6BL0t1mErgIjIeDKyucOE1j2yV82k52wYvRe+EviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eQs6Sgyi4yte+SBQuw0p4dTdF9TXbtfDwfALvS04Nc=;
 b=DdG5Ms62DUmx18sDjfzMKq94zWLwv4JVcOFWqDdsxPpyi7d4KP0fP+vBMoGFRq3xPdgZVt2pXOHxVp+8Tpn1JB3rmO+i1e8fPDcKhfA4TmAEskh9qJXHBZavFrT2Z++LTYSSvZTbF/XyS7rDnYeOmqW4JCnc4/1w8ivNsB5/C+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by BL3PR13MB5180.namprd13.prod.outlook.com (2603:10b6:208:343::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 01:35:15 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 01:35:14 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>,
 peng.zhang@corigine.com, chaoyong.he@corigine.com, stable@dpdk.org
Subject: [PATCH] net/nfp: fix get represetor wrong port stats
Date: Tue, 25 Feb 2025 09:34:54 +0800
Message-ID: <20250225013454.442170-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|BL3PR13MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fdc395-ec69-4079-d095-08dd553ca6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oQa2QmwZQXDQ39EudeugUxyJ+ocxRc2QdSER+ILsTdvHWEvi60elMYZEkAY6?=
 =?us-ascii?Q?9XchLj1OJU7BzXOqDfDwn98fssukGTyUj9TMP3SsRVeg0c9yv8ioCLCplIJU?=
 =?us-ascii?Q?JtL2yColYVSe6Idmw8IBgzCkAeBO+em0zZmd2IdUOGHTKi6GlITKqoFhyNZ3?=
 =?us-ascii?Q?+I/DEcweumVJKif3k278DMT1rBOE1eMXlM4I2iWDzLtzKULl59WT3p1MP02f?=
 =?us-ascii?Q?PD9hpzMnH6QwsqsgJaSkTAN8W0rSAHA4bWOwpq4swmKs1q/ZDIQp3Or0/B+f?=
 =?us-ascii?Q?H2o4L7UGygmftDGwS5nuc6f7L6OiqALeKmPNGCtQ0gP+k3/a/+D94MfAzFzM?=
 =?us-ascii?Q?hAKZQeL0fJiLiukeGMwztrtUL4Dz22gnynpWF7LGXgHe8WZHghCEHt6emcx1?=
 =?us-ascii?Q?wuHbDPDEFFyfpygkZ7magnti7aGTV9Gty0VpqvJxALwnO4EvDx72uptwy+8W?=
 =?us-ascii?Q?cuJ6uykDiACNZzq9YtAm2G6J5zjlwUlajedXAlfbD++ejWpPrOGpwuJOQpOV?=
 =?us-ascii?Q?XFZKNXp03/XsjPQZtyR8PVTVGqIXs8qCAvPVrrGD8NSW1QwwAmkzKdTK5+HA?=
 =?us-ascii?Q?JPx+LJzMtalb9RcIOkgJ1eQgDxkUiWN5gSpXPXLCwGEJKtdHp2WP2guPsK6W?=
 =?us-ascii?Q?rY6x9nem/rOa92w6WKruRciXqDKaOMvwGQSZc/Y7w/t6EiZnZNJwbanGi5qa?=
 =?us-ascii?Q?jEMKEkcGiID/qucznqtDkFDqAVm64J9Jx3Gf1WeoWUvkACYOrl1vedE5UH4f?=
 =?us-ascii?Q?udr/5xdmjbrswwG/0/3NWVaHNKS7oNo7l4gJC8ogr9ViecgSle9DwpeiGDar?=
 =?us-ascii?Q?sXa0jZ4TseElEedYj97pz4O/5MvRuJV4cWMzhtoSn7P3E6REUDIHXWptBKK5?=
 =?us-ascii?Q?EgyrHB67uC6HTlTTeUBKprH5NbTj7noGem+GdFJA0LeJEciIFYzlCK0cxwoK?=
 =?us-ascii?Q?lGokr4GDaFWgFrUvS7fAtAnuEbnnkn/0tOvS/6gCe8Sjx2s59Jcbkz2Fp/XY?=
 =?us-ascii?Q?8wtgSVFqKqTJuCQwx+4Y2tAluOKrCvM2xIFrA+deewFhGXje/d3bGgZMFrNE?=
 =?us-ascii?Q?CKNBnK1ccYmkksJWw+sFSvPLlwp1MMUmPbJuoH72kIGOMNMj9SsF43IGeOVh?=
 =?us-ascii?Q?jv/ndDHkDWrL4WA8KSZG/SU3ZXqonCGwxoXQdQ3pwXsIxU/L8GOZk/QvHbtg?=
 =?us-ascii?Q?hx/CWT5bAzS/X7lp3gBC3V2QlgZ14aL6dkGL0NXXS5DmJkGaCTdZq6vcWqzv?=
 =?us-ascii?Q?fH+F+oQ+BUFuz6yuV5ySt4EY/VrNZmiogFKBQB4HxXz+AZ8cA8pDhV5Tm9mn?=
 =?us-ascii?Q?ZeU8HM0JUZ8K9U/057lTKUwYNYGSSuXOj3+0msJI9WbAVoqfcvqTyswbiwcR?=
 =?us-ascii?Q?05uDIFFbIutVrUYbyGbG0snZzzc/NjvaycXSM67Gdfl5tdPuYC31AYJuK0Zk?=
 =?us-ascii?Q?0JrGYlWK0ctru8VCzaYpvgqbk2+Fm6x8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcJpkuhlrvfRRL1oVt0peCUlFtcu6mW35XLQPeRGTXMdsTMRIZhiQtWtccw7?=
 =?us-ascii?Q?iWFvBdlqaKDP6rYT4wWui5vGMcn50Uv8y15UMsoKcClgNWUie/8Vfbtun/Nm?=
 =?us-ascii?Q?hwDulSGvfFmPUceSF43r7IGBWNT615R6lU6v0taaWrz+GQFkX7FS/c0L+uQ7?=
 =?us-ascii?Q?GRHYJyOoBf5IO5BTvS5psag7cBtxB1oAW+4TvGVb1RG65Is/qJUuTnyKLyA5?=
 =?us-ascii?Q?FlqOTCVyDqi/AydMRpu7yj/EPWJeT0MTq+BiEeO76AzHnfeaCI59hnBuoTjz?=
 =?us-ascii?Q?9BGF45K1nw1S320gfbjxT0Dj9Zxj30ALLELDzOlnT3hyxZp3SYZbtMT49cbC?=
 =?us-ascii?Q?GxqwJziRIdILsmTPHrJ5HVjP0iqwAxwpgJIcf3S9xs7VgahlC9Yuvpe3En0M?=
 =?us-ascii?Q?j43zFn9ekJSzZNYZCZXly/QUqtsVV77HEGBDLIvgPGvcxByJ6zzwOeVvfgiS?=
 =?us-ascii?Q?AeR2gRien0rlztNNjThWaKAKSDuWeMX0MG8wjYODL5eMb/LqKO3ejGNPqBUH?=
 =?us-ascii?Q?mROg08K0vXgU2RDV8wLCcepOlXL8FLWajrpeQCi1rb7VWO+7RCsnoW9tfAkd?=
 =?us-ascii?Q?I1uOJpsmKCL8kNvQjhsMt9dQUNx0MS4Uquzq6UKmWZkW7s2CJX9QiSdq0ZHH?=
 =?us-ascii?Q?drQkrUz6lDhM6/nN/JR340arhrZt8rhQBTcOeOCG1TRe/NpzmvP6/9K9DiuR?=
 =?us-ascii?Q?o3F4Hk77ZfJA1O7fjxAv3ahkpTNmHD3fWwnkZoxWDTRMn4fRclMUhzCx7xZI?=
 =?us-ascii?Q?KXexmLYrY9z0Hs3rwOgWq0vPAdTDbn85Ju943seKfNUyRXTfNRi5LVhmieAD?=
 =?us-ascii?Q?e8tAndO15KsVgNbhJe+WooH0paDuFdZQqw44fXCMmUo5JqTGuKhFajNIGTra?=
 =?us-ascii?Q?P7gfGfCiRHuEjZ15yw/38Dyd08+dVaXxilGyZkDnkvweGalA+R7JqNI6RNFd?=
 =?us-ascii?Q?/ovMkMJdBqevnWnADviiVoLHbndEqH+mAhVw2mLmRmq0usjRCN4Ev/4pYl1g?=
 =?us-ascii?Q?qurth6sNrUwH304KIpZ20mT7SP5E5sYqiaOpXS9hNuAtpaIC7Nvgsj0ZuEVv?=
 =?us-ascii?Q?9T5id6pXUqZS/EZEnqSPo8p4idJBSEHPjTYe5zvORAPeWBnZC4T9wqvOaCDG?=
 =?us-ascii?Q?zm0oxyTxIe+e/WaCKNabETj02NrxHlea/OU/UJoGwpcoWW7H7nRdYuzHYq06?=
 =?us-ascii?Q?Id940IEuX8hGNpGUpONkaldCsBwnOo1KaVIdz82cXuXMLMzkBTzWQQBakCdf?=
 =?us-ascii?Q?BSTvOrLuOTcvRL4xKa9YCZwxn6sANSa1O91xslMt7t8+gou8YLhB7+MCX7AU?=
 =?us-ascii?Q?u1I56a7omIsjJISDKzpWcJfwvFiyvg4sUbyW72/IxG3P1J9Cw8mkaJOZai2A?=
 =?us-ascii?Q?1AWaNRUA8B1UzP+/bV5eeywb0GsQDCJUtGfOr9eo97K61tvreXAksMjK4/3N?=
 =?us-ascii?Q?41nPobllEAwAkYABPzWxd9r/z2/66Pf74iohwnqKxSsJb1VcvcIMpBVuXG1y?=
 =?us-ascii?Q?yvt8FDYTYeo3WRKrSXXESZfeexcwvgOpQGi648yqfdewdu5deQHr8vS2Pgsf?=
 =?us-ascii?Q?QCJlFSwL0A14BSy38oF5X9Ij8NP1rxFAB2SGRm58JHejk5L/erADTL3jL3zE?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fdc395-ec69-4079-d095-08dd553ca6e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 01:35:14.4617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NBwvpYODjc2+F/R7U3vFQhuL7hqiwtjl1Hq0KsiyrHtzeWbTSZkv2xNFWsz37IwDN6qi9gEoBF78gpFAzM3JDjpYqj1CLDKan1DzSv9bD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5180
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

From: Long Wu <long.wu@corigine.com>

The 'ipackets'/'opackets' are used to record the number
of packets on represetor port received/sent. But the
code does not consider concurrent calculation of
'ipackets'/'opackets'. If multiple queues are calculated
'ipackets'/'opackets' simultaneously, it will result in
incorrect results.

The previous logic has recorded the number of packets on
each queue, therefore driver only needs to add the data of
all queues to obtain the data of the representor port.

Based on this, modify code to fix the issue.

Fixes: 636e133ec891 ("net/nfp: update Tx and Rx for multiple PF")
Fixes: 82a2c286f35a ("net/nfp: support xstats for flower firmware")
Cc: peng.zhang@corigine.com
Cc: chaoyong.he@corigine.com
Cc: stable@dpdk.org

Signed-off-by: Long Wu <long.wu@corigine.com>
---
 drivers/net/nfp/flower/nfp_flower.c            |  2 --
 .../net/nfp/flower/nfp_flower_representor.c    | 18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfp/flower/nfp_flower.c b/drivers/net/nfp/flower/nfp_flower.c
index f087d0dfdc..804ad494d5 100644
--- a/drivers/net/nfp/flower/nfp_flower.c
+++ b/drivers/net/nfp/flower/nfp_flower.c
@@ -238,7 +238,6 @@ nfp_flower_multiple_pf_recv_pkts(void *rx_queue,
 		for (i = 0; i < recv; i++)
 			data_len += rx_pkts[i]->data_len;
 
-		repr->repr_stats.ipackets += recv;
 		repr->repr_stats.q_ipackets[rxq->qidx] += recv;
 		repr->repr_stats.q_ibytes[rxq->qidx] += data_len;
 	}
@@ -277,7 +276,6 @@ nfp_flower_multiple_pf_xmit_pkts(void *tx_queue,
 		for (i = 0; i < sent; i++)
 			data_len += tx_pkts[i]->data_len;
 
-		repr->repr_stats.opackets += sent;
 		repr->repr_stats.q_opackets[txq->qidx] += sent;
 		repr->repr_stats.q_obytes[txq->qidx] += data_len;
 	}
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c b/drivers/net/nfp/flower/nfp_flower_representor.c
index 9601aa5f96..e377d45e53 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.c
+++ b/drivers/net/nfp/flower/nfp_flower_representor.c
@@ -315,9 +315,25 @@ static int
 nfp_flower_repr_stats_get(struct rte_eth_dev *ethdev,
 		struct rte_eth_stats *stats)
 {
+	uint16_t i;
 	struct nfp_flower_representor *repr;
 
 	repr = ethdev->data->dev_private;
+
+	repr->repr_stats.ipackets = 0;
+	repr->repr_stats.ibytes = 0;
+	for (i = 0; i < ethdev->data->nb_rx_queues; i++) {
+		repr->repr_stats.ipackets += repr->repr_stats.q_ipackets[i];
+		repr->repr_stats.ibytes += repr->repr_stats.q_ibytes[i];
+	}
+
+	repr->repr_stats.opackets = 0;
+	repr->repr_stats.obytes = 0;
+	for (i = 0; i < ethdev->data->nb_tx_queues; i++) {
+		repr->repr_stats.opackets += repr->repr_stats.q_opackets[i];
+		repr->repr_stats.obytes += repr->repr_stats.q_obytes[i];
+	}
+
 	rte_memcpy(stats, &repr->repr_stats, sizeof(struct rte_eth_stats));
 
 	return 0;
@@ -385,7 +401,6 @@ nfp_flower_repr_rx_burst(void *rx_queue,
 		for (i = 0; i < total_dequeue; i++)
 			data_len += rx_pkts[i]->data_len;
 
-		repr->repr_stats.ipackets += total_dequeue;
 		repr->repr_stats.q_ipackets[rxq->qidx] += total_dequeue;
 		repr->repr_stats.q_ibytes[rxq->qidx] += data_len;
 	}
@@ -434,7 +449,6 @@ nfp_flower_repr_tx_burst(void *tx_queue,
 		for (i = 0; i < sent; i++)
 			data_len += tx_pkts[i]->data_len;
 
-		repr->repr_stats.opackets += sent;
 		repr->repr_stats.q_opackets[txq->qidx] += sent;
 		repr->repr_stats.q_obytes[txq->qidx] += data_len;
 	}
-- 
2.43.5

