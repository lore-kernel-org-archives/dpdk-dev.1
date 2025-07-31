Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21882C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 10:42:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBD22402C3;
	Thu, 31 Jul 2025 12:42:20 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by mails.dpdk.org (Postfix) with ESMTP id B269C402AB
 for <dev@dpdk.org>; Thu, 31 Jul 2025 12:42:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcwtumrkH3Efmmjkis1thH2FZ5DdtGXlWW5UzLouqZrYX5wZMHnrjm8+cKsEo4tEj4bp+QqWz9CAdtqYz8xxF+DVnZxoY6Qy8v+iUI9JfFr91p0yhxSv1/RiXvgSn/f8oI5dmjwBG41kFZUld6BFRuR71v6s9rc6lCF5TggmeSEvZtSTT14NQeyt7Rt/ITaY4E4dZbKr89frz+KXDW720duPJs8CWfQKKPF0laSaOi4pYkkuVpAfE2hjNPl3GgUbqE4fK/pGcqQBADC2FaeU3UrLmJkF11aMqpR8c/KTMCVyQwMj58GWDiVVj86STh4FHyHHWEnfATDwYVrvg5oErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyNi+9mmDirQ0y4cRZyqKoVt5rf4nT5I3f0BZaozFlk=;
 b=JOGdBP7qFmfhqUTOkX+Seq+19RfUV8tWjbTesxrgm15Vn7bV3RbDwQSJUVnivNM0BKHPGrQyfrQSo2BWm0L45WRUi+jAo+lBX8mq769ERrk0E52qvU9nlf5fC9+C82MQgHQnzln3eBW5/4YXQr5Nw4YMgmewuAHbW5J/kqG7rghnMqyE9zlSNMwbXM3NjBuEVq9WcuPcwJHoDuz4yDV9SnjbvyxxN+lfVPgb5kzWZVPSp5++gA081aZbxAJI5DUG6YVshZFUIaGlOtM27EV2KUbqrk4HKeZ/RnTBWWLGGZe7J3X1IpF6VGD4uihrEa6Mo5TWXTnFiPHKF0gdyukGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyNi+9mmDirQ0y4cRZyqKoVt5rf4nT5I3f0BZaozFlk=;
 b=XdEJZ/uy+IqDSWRJspe3Rdf1g4csAMlRGz138Jt07Bgih8SzCqhkyniqmedkCVvAVGU73PCRShzGfgWRr6zKFuOUlpTr1jZ2TR0isHtQ11HU9oNwL0asszcUlOyw/9MLJF4TuAxpeFRD6XNgH7Jwzaz5rKRT8s/aY5PoY5tbQmheFqmJ3vSVoKyO1pU8SGe/YCP3QlQXBtm20mpH+i8oesknSzwujrAlkVdEMsvj8kVbdPgoLo+jWwGWMIwbAb6SfGI5O63hZi1rSME7XieTaW8BAsv9WKo+tnICYuMZvndb9x9QUkfYBxynm4CGSmab3qInDAKhpmOdcZfRyUJV7Q==
Received: from BL0PR02CA0128.namprd02.prod.outlook.com (2603:10b6:208:35::33)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 31 Jul
 2025 10:42:16 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::59) by BL0PR02CA0128.outlook.office365.com
 (2603:10b6:208:35::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Thu,
 31 Jul 2025 10:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 10:42:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 31 Jul
 2025 03:41:58 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 31 Jul
 2025 03:41:54 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, =?UTF-8?q?=C2=A0?= <mkashani@nvidia.com>,
 <rasland@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix storage handling of shared Rx queues
Date: Thu, 31 Jul 2025 13:41:38 +0300
Message-ID: <20250731104138.61593-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 8065c999-80d1-4e22-0f7b-08ddd01eea96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CJZShFTPaVKToLKD1H95iAktZJrurkC0W+S6myrxF14EWDqCJTnyzD6GbotN?=
 =?us-ascii?Q?RNjosReBWqxzb4Le4E7+qKp87SxvAndqWTxENj5m0apnWtArVO+rTDogir2B?=
 =?us-ascii?Q?ZakMB2WrJbtFvsOnYQTzu+wkEZY7n4ze3e47UVwHeGjqYdKXKsAK/4qoKg/6?=
 =?us-ascii?Q?MZqhas7T+f9JExnN+3vv2dgAbIn2it/TeVFKxu7rs+29+8HigN30f2PeSbM1?=
 =?us-ascii?Q?ZR1MI9Q+57tdnJOwiISWU2rCo1KJAcp8B4eMM+8KNZeTLjE2pktHI4LweK6q?=
 =?us-ascii?Q?HcKOl+DpZSap5Do072qWdKBM5HO+Y9MYl1LGgZSjdIgorKcMC/b0VqXyDcbD?=
 =?us-ascii?Q?kGErES8ZukzZwtEGuJDcU+w3RWVzlLsDzQRJmjHlR2vzkjzQZgJiT8+N0mea?=
 =?us-ascii?Q?Ee+18k2frM2FTgXwDBsnjfyc6bu5BApGviY6y08Ey0M7bLNtS5/l56Kh6Oz8?=
 =?us-ascii?Q?0ShaT7KjWizgTqaoxKQfwCwYDfDvOIvlPZIv49HaPpSEKVa7GS4pMM5gEHPY?=
 =?us-ascii?Q?RtWrVqNIJUoVGndUdP68HbkF3IgNTd/5+ekSLpZYOzhOgisrnYtU7PpdT/Gy?=
 =?us-ascii?Q?L+ffi2m0QA2Zpdp/HWYxbRuYoPRGfV8uw05NbIOe4hbbOucj8EWUmdQFejmL?=
 =?us-ascii?Q?p7k7KVuJNimX+gMMrpVGjak6XPLJJjbAOPGAmEF4bVqM5r4Il9y+jxn4q8RV?=
 =?us-ascii?Q?jYziY5hsfmFhq4QgB80xm0OP9o2Abt1+dAow+sPTF2Eoecp/f6TL9qV+JcTO?=
 =?us-ascii?Q?uxtq91WDnMQiV5lkphHOkrp+v2f+4UiSvRYzm86KyDzIqi9I0Zih0uDGaJLT?=
 =?us-ascii?Q?FYkODmnfd0PhFm2WFIYCmYLVRNmzWiXkxy8MsT0FMUM98s3MDtUgjVfrbR3w?=
 =?us-ascii?Q?rP1r0+FacBiBNRHRFQd8rWNeDnf3gEtSdP2gecOVzS0JAn2QjgoU4qXHcVXm?=
 =?us-ascii?Q?himdIyfIimPaLoBQoGDBfFb3jGk00ggy1jKCamLfbCBVA15vdVDHIvk7h7y+?=
 =?us-ascii?Q?jf4wjDgbvWd7xdZ/sfdowCG8ymiDtdFddavVDd8htc+FBYukTKQLZ7C5BSj0?=
 =?us-ascii?Q?3cyTwv0MtTO3tskkvjtXZiFwxUPJ/KAlwb3RJ/u1GGJPX2uQ8nCmRHkcZeIF?=
 =?us-ascii?Q?FdgDG5KkeNPntcuRRGo/hAaXOVp60+J2Cnx+yCm1JQSWCUu/wAW93VQWEZD2?=
 =?us-ascii?Q?YicoZ6TxGM+2S5g7TKOet0aNORm4k9ggYHt5RfEO5utfnaxoPpDN0tbhYAXa?=
 =?us-ascii?Q?WeEd5+renah25VOBoLvqqVFWtmrUsVmiVBnM1m89vKbQAfFTb/XUgWm0PLP7?=
 =?us-ascii?Q?NZr2Rgd1tt8RdM2wXYlObwFpfd+rwYGEocgsEw7poKs+FboE2S8S4zhWAMeO?=
 =?us-ascii?Q?APT6eEyJBb+8xYuNaXYcGmkCCGc0xtlm3M7qtC5xpLOy42so8Xedmp0VDZyB?=
 =?us-ascii?Q?cCBDkp+BRSA8+nZFyp7AqX6OSMjY16Wza6G9QOBUE+IUkKmPNS4HaeL3QZmZ?=
 =?us-ascii?Q?Ot52VqAcPtq1v4XPEh+bdS0Z+Dp+zdvqX4Yn?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 10:42:15.5984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8065c999-80d1-4e22-0f7b-08ddd01eea96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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

The MLX5 PMD maintains 2 lists for Rx queues:
- mlx5_priv::rxqsctrl - for non-shared and shared Rx queues
- mlx5_dev_ctx_shared::shared_rxqs - for shared Rx queues only

The PMD used the `rxqsctrl` as the primary list for Rx queues
maintenance.

The PMD wipes out port mlx5_priv object after an application closed
the port.

If PMD shared Rx queues between the transfer proxy port and
representor ports and closed the transfer proxy port before
representor, the representor port cannot iterate its shared Rx queues
because Rx queues list head was wiped out.

The patch separates Rx queue storage list according to the list type:
- shared Rx queues are stored in the `shared_rxqs` only
- non-shared Rx queues are stored in the `rxqsctrl` list only.

Fixes: 6886b5f39d66 ("net/mlx5: fix hairpin queue release")

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 13 ++++++++++---
 drivers/net/mlx5/mlx5_flow.c     |  6 ++++++
 drivers/net/mlx5/mlx5_rxq.c      |  6 ++++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 696a3e12c7..0266f71bb5 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -747,13 +747,20 @@ void
 mlx5_os_free_shared_dr(struct mlx5_priv *priv)
 {
 	struct mlx5_dev_ctx_shared *sh = priv->sh;
-#ifdef HAVE_MLX5DV_DR
-	int i;
-#endif
+	struct mlx5_rxq_ctrl *rxq_ctrl;
+	int i = 0;
 
 	MLX5_ASSERT(sh && sh->refcnt);
 	if (sh->refcnt > 1)
 		return;
+	LIST_FOREACH(rxq_ctrl, &sh->shared_rxqs, next) {
+		DRV_LOG(DEBUG, "port %u Rx Queue %u still referenced",
+			priv->dev_data->port_id, rxq_ctrl->rxq.idx);
+		++i;
+	}
+	if (i > 0)
+		DRV_LOG(WARNING, "port %u some Rx queues still remain %d",
+			priv->dev_data->port_id, i);
 	MLX5_ASSERT(LIST_EMPTY(&sh->shared_rxqs));
 #ifdef HAVE_MLX5DV_DR
 	if (sh->rx_domain) {
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 8db372123c..fa8b95df16 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1652,12 +1652,18 @@ flow_rxq_mark_flag_set(struct rte_eth_dev *dev)
 			LIST_FOREACH(rxq_ctrl, &opriv->rxqsctrl, next) {
 				rxq_ctrl->rxq.mark = 1;
 			}
+			LIST_FOREACH(rxq_ctrl, &opriv->sh->shared_rxqs, next) {
+				rxq_ctrl->rxq.mark = 1;
+			}
 			opriv->mark_enabled = 1;
 		}
 	} else {
 		LIST_FOREACH(rxq_ctrl, &priv->rxqsctrl, next) {
 			rxq_ctrl->rxq.mark = 1;
 		}
+		LIST_FOREACH(rxq_ctrl, &priv->sh->shared_rxqs, next) {
+			rxq_ctrl->rxq.mark = 1;
+		}
 		priv->mark_enabled = 1;
 	}
 	priv->sh->shared_mark_enabled = 1;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 77c5848c37..1425886a22 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -2033,8 +2033,9 @@ mlx5_rxq_new(struct rte_eth_dev *dev, uint16_t idx, uint16_t desc,
 		tmpl->share_group = conf->share_group;
 		tmpl->share_qid = conf->share_qid;
 		LIST_INSERT_HEAD(&priv->sh->shared_rxqs, tmpl, share_entry);
+	} else {
+		LIST_INSERT_HEAD(&priv->rxqsctrl, tmpl, next);
 	}
-	LIST_INSERT_HEAD(&priv->rxqsctrl, tmpl, next);
 	rte_atomic_store_explicit(&tmpl->ctrl_ref, 1, rte_memory_order_relaxed);
 	return tmpl;
 error:
@@ -2365,7 +2366,8 @@ mlx5_rxq_release(struct rte_eth_dev *dev, uint16_t idx)
 					(&rxq_ctrl->rxq.mr_ctrl.cache_bh);
 			if (rxq_ctrl->rxq.shared)
 				LIST_REMOVE(rxq_ctrl, share_entry);
-			LIST_REMOVE(rxq_ctrl, next);
+			else
+				LIST_REMOVE(rxq_ctrl, next);
 			mlx5_free(rxq_ctrl->rxq.rq_win_data);
 			mlx5_free(rxq_ctrl);
 		}
-- 
2.48.1

