Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C15C282C5
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 10:37:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E0A240280;
	Mon,  3 Mar 2025 11:37:18 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by mails.dpdk.org (Postfix) with ESMTP id 062844029F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:52:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNJlsTXSeQ0mReW8CMz+OoW815EuKX1oB1Plv2FWB/M9trSJzzIEDCWX7xmRO/8qimO9MiqwKNAQ+b9F4qP4hzGDleeaQTbbpGXJ435kyOdDLT+zGT3pY6G2xaVNGavBotglrUcIAQIwEtX7uc947tim325XEf95GCSF2MTSDBHPiwdJ3zuDhBgGrKFDplXXRZC4JxKgnFz8SuhxfVWy8gA8ZTs7+H3qXXNrTpmX8V2jNNx2UNloDtSY5NfaxfpRuJ5M2HuzuhF+FwGTeYuEwFAXHsorE9u22OATFQquFLfqASKvTnz41sdq6zuCYKoxjsuec6Je7t8UWuI0l3mFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adjVdyBHiyJ3xTw1RMTS6wnMlIzbPMoZrhjjK3cuN1k=;
 b=du+ilMt/X7eLLOwZQr/GKlAjL9ywNxumr6tJp2VmcIVFWK7Ysxes0s3YJvNVactT/BCusXnmQIYt61K/UmfLUKpnL6dWzdRdUGp4QMOXXcQ0+NyV4byHhDj/taQqImcmXWkxZg3c0fR+uO4Sfer1Ig/5ZlDirOw6OEz61o8TbOKCI9CMLCxSC8jIiovQtcNUnu7bM1qMSwSXISxylgP1tzSO8xgXC/bvHBL6h6iZqxlJRuYqhNlhwwJPV7NOIZOBCJQ5LG+qe42IOLKR4LB1Eiso6A3JYtt/+j/Wwuc1HLDSxyObS8Zhb31m7rNzZA54BzQ4B1HDckQj/9Qhs5+pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adjVdyBHiyJ3xTw1RMTS6wnMlIzbPMoZrhjjK3cuN1k=;
 b=kf1SRWeoNfW3LTl5/SNhTZ7N2wYzwOyzNTsCOHa940IWAD9U+iV/briJYzXU2FITfaaPdzqgMpcEnsf3+ynWX6IWPaiJG8of7SpKEgGnAH6TExv2IIdygtaiJF6chVclv5o8Fd+xqrSPE10gqeVmuk0GARVCnDs/FRQCvlcYSznl+NZswdCXQRbXJMxh0fz7vaFUZEV1IJYPgLng2eik+rnfuIXxcat43ivO4au9jw4yf4jsMzT08dwZlDeqoEn9TP2CfFGfxmlDnIgF3WOi+9bR4VugyEPSSUoXsz0STOcJTfIJ2ImJ4X9fmIfNJWbv8K2KBAoeOB8s7TgjUUH7JA==
Received: from BN9PR03CA0432.namprd03.prod.outlook.com (2603:10b6:408:113::17)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 09:52:47 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::5b) by BN9PR03CA0432.outlook.office365.com
 (2603:10b6:408:113::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 09:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 09:52:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 01:52:34 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 01:52:33 -0800
From: Yaniv Rosner <yrosner@nvidia.com>
To: <dev@dpdk.org>
CC: Bing Zhao <bingz@nvidia.com>
Subject: [PATCH] net/mlx5: add GRE as L4 layer for entropy calculation
Date: Wed, 26 Feb 2025 09:51:55 +0000
Message-ID: <20250226095155.55582-1-yrosner@nvidia.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c83e829-7db3-4740-a999-08dd564b5312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rpGExYLSevh92HgiTvtdJeFhLcVtZCus2kKesWfjv4JBD4bGQ7xgRr6l3hhd?=
 =?us-ascii?Q?a3j7m4O1Iseo/vfaZw36tsFVyHU2A7RVwCmE9Z0WfFAh1f3r8SB5MVj/C8bO?=
 =?us-ascii?Q?t7TfPZmjHgwhWkYLyoj8pxq4bjOl3uQywhYcL4EJ8AqQFDYvr4F/WgQyny9f?=
 =?us-ascii?Q?q9lP9a6YZ7b3OPZGOpcci4lyRy5Ugcq8mkvl2GUxs2gzt2Lhy0B88exyRubJ?=
 =?us-ascii?Q?vhGXKzS+ICa2i9Q9TH4X8vGSv1ce3sUgDJYqnzZEeTBXrIBftLfgDBGgwotp?=
 =?us-ascii?Q?1HKlHzmnJWkH0A/qW5AkV8BSJ2xYuop1RPaYePT0rhh1B4buqfSSM/4gStbh?=
 =?us-ascii?Q?cpvZY+a1gflRXxM36x6D7Qkof9Jy6h6YkMXwXyhKgc6EJYzbCQnO+ph0GbyH?=
 =?us-ascii?Q?3SJ1PkgxGNyiWNnWVkhHlFJ/jBLNX4U1G1+Z936XBz0vf8XFokXfoW42WZvC?=
 =?us-ascii?Q?Te7MM9fpjMGtqruMzUnQfhlI5oe8i1w/14PND4prI/nVnzWhRcd4qDmTMup0?=
 =?us-ascii?Q?fpzWV0eDzRV54nFlBmZ+j43xKxaL93b2ibWD1boCymWEtBy9P6k4gMNrSuA/?=
 =?us-ascii?Q?B/k/EUznhg7An1E41ySAHQb+/GIbQCsTxazPpOmo0zB+1VzpsmEi6kGDLO4L?=
 =?us-ascii?Q?hqrkC4wMLSn5OOfwx/sOYbv3yoqo42MOWLUVCjyEMehn1CufZsanDvxdFUhZ?=
 =?us-ascii?Q?455m7O2ZtjClphKcgWpmZWqvAWCg1VF1UUolsyc9ew2pxUfz59R7tq9CEw+A?=
 =?us-ascii?Q?8KADxdh6rF87245eED8x5GPMbDiKQJoL5ZR/A/LDNd8nYMtbc82b86tDaefe?=
 =?us-ascii?Q?DQq8ps4wp1vyRXVv9GlcMitu8mfqy9OMUwOtNP4OIXpQgYGVQwr0HJcOO5nM?=
 =?us-ascii?Q?9aZPKl4Dcl+srzwCEvG88AisSLkJcGZ4KANPlwHwKpim47s1H1uykgZdaWt+?=
 =?us-ascii?Q?UyWNYhBHDD14s8ZmwNUV7PWbpD7GsvwcCWEiwwhpEqHXcqvAD+npJpmBluc2?=
 =?us-ascii?Q?CrTbDJjpA1sCuqXdoGyguvU0/CnjPuyWuZW+KrvdDNmO0WuZJw1d+lxZRBuK?=
 =?us-ascii?Q?nuPCIji9nYZY9IZNihgCVlnnT7iB8tnpWFpSUUY1R7ykRXrZ80sDipHdm1o9?=
 =?us-ascii?Q?iyt2++HZ8rK2Ab13mCogKVl3WhcsBaKXV0WUXjCSLd5exBsW4D4nzlp3n8fE?=
 =?us-ascii?Q?15NqDqMZ/QrEjFbwzlZyum2D69ubkL4+xkOVgxKeh9S2EJSt9gBYhWI7iA9t?=
 =?us-ascii?Q?H/q7cq7JU9o4UfoK1KVVWDTgyxFc6tQo/0wssFQOjbqh85ebYjILjD0b+jeJ?=
 =?us-ascii?Q?rCEms8xILUDMdzNvmGcxrwkPLArE3YG/8fUBXD/enYFsnW2ewZ1O4SjhBeyd?=
 =?us-ascii?Q?AYlpgNkTsGTzMwqFoAkcWla/IWH6cWMeIIWSIfVG3QQcUvGBDEAA+/48/2Ml?=
 =?us-ascii?Q?3PaVKxToXVSma/2TFYYEl9gVLWJvKT+331znNrUVthQodhqiLuOTUZxVmRDn?=
 =?us-ascii?Q?i9bs/ziGpRnh/rg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:52:47.0871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c83e829-7db3-4740-a999-08dd564b5312
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
X-Mailman-Approved-At: Mon, 03 Mar 2025 11:37:17 +0100
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

Signed-off-by: Yaniv Rosner <yrosner@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index e72b87d70f..27ee9d6cd3 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14875,6 +14875,9 @@ flow_hw_calc_encap_hash(struct rte_eth_dev *dev,
 		case RTE_FLOW_ITEM_TYPE_ICMP6:
 			data.next_protocol = IPPROTO_ICMPV6;
 			break;
+		case RTE_FLOW_ITEM_TYPE_GRE:
+			data.next_protocol = IPPROTO_GRE;
+			break;
 		default:
 			break;
 		}
-- 
2.48.1

