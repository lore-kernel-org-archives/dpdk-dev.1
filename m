Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2978CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 07:41:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84863402D9;
	Wed, 12 Nov 2025 08:40:59 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
 by mails.dpdk.org (Postfix) with ESMTP id 808844026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 08:40:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCmJSmniXQzK9VsO0HN3nZS3cAhWWh9hIvyJGRjo3uDQlI/IlnSM/slxA8QvQv3cTYUwzVJoluY6iYOW2FjsMnIupeyg/iEYhab0+6/VFEQMwWb1r0ILfkedZl0mkiVm2tNIY5Exn6QWdCEab8Ffc0sIJpS3GifpvwQkKkho6eIiy6O2i3GucxTxtBZjwD40RN1B34XXRJSxj721Aj5qLRI0fQbRT0JgptP4gr5Zpa6sdZ/wplTxwfYjLJOsJjIEdeyBWPL5VCnKDU2yHT7Y3ruYpuDQulsMWNeUlCFGuV8ZIpCzx6zXRsyu6RV9wYn8VQQZbPbVh7bmisafYtBCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYsHwtm524XE0noJP80HLxmufmT6mxyARu3l22KsWhc=;
 b=dOFCjI4Sh7WHHOlIEQQ8LCX69Cqq2zl47UU+jIVWJT6cZfcb6Xfep9P/ID/gG0Ixmt9rYX0bxVO560p36rZMXplChf7EAAKpRlJd9XnoH3Yz/mVmYBK/DB8l/hT5eEzOZ4UaB53fOSHneZLQNHKTzL3wvHHFMcAiqeYbFx8r9Rd5jJA81Xwfjacj0jLa7iruipCotIMka7vidWv9BrwMvCjFwoj9ZR3vykDpRezKjowoi/2f9kw8cPAZwvQH27GPD8W/JZ6VsLqiRm1HBHfzFknTWGse/DU8R2EuvxtaUUNBHXlPePSZ+NIfQEHv9p5eLgTdxg27blHrOQbIcY6Z6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYsHwtm524XE0noJP80HLxmufmT6mxyARu3l22KsWhc=;
 b=lqIG1SmpA0XDEI2ktjvOgwetDGZ1HuhpGHqoKCAQgN7cBxPZcO7jZkbCOH16fY63qu80Xf5kHJVUCKs6XBIWxOLSrIkzw7jHu9V7JH/10S9f/OhCY0iNmOQ61JKu8LGEUSm45VpbUQ3Q8Y1prBoHT830eV2AQUbZd+pn7xRL6tGkA/1cbBP+C2ACfmpYvSGNnbBBgbIF9ycldrxSzgIkXN1BsXF1guBzhRQtup/yZpqP2cZZiDyGN5ySm1V3IiTiOZyqpGpF/zxsqotvu51f0QcSeI4+0EvXOcO6AMN7OycWXdjR7sQm3OATbTMkTUUBOq4CoITsbAg6X9vmOXRVDQ==
Received: from CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::14)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 07:40:53 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::ca) by CH0P221CA0004.outlook.office365.com
 (2603:10b6:610:11c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 07:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 07:40:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:40:36 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:40:33 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <bingz@nvidia.com>, Roi Dayan
 <roid@nvidia.com>, <xuemingl@nvidia.com>
Subject: [PATCH 1/4] net/mlx5: release representor interrupt handler
Date: Wed, 12 Nov 2025 09:40:15 +0200
Message-ID: <20251112074015.8901-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9b4597-56bc-4597-b2b3-08de21becf00
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CXddmfz6piWRrZknB+ryKXVakfmgn+LFDrtcrOSK7rRdIKykETss6j1hFlqD?=
 =?us-ascii?Q?LF8eWBSg50MkKv2jCwUEghgmo26+Kky2mVc2qbxKWJbxcGbtkp3tnHwcMHi+?=
 =?us-ascii?Q?vjJug5L7tFPFTsxNxsaueXb3ED9/2JYaC4r0iz+Q+U7oHA9jQ9jBR6dm1UWv?=
 =?us-ascii?Q?EJoKYwaMwPVxgE3hG8INwSEN/BzK233Qlfqtdsqu4aY0i9lCRoe8tEvMjJa7?=
 =?us-ascii?Q?xzErXlixKqCfutzwtGyJlQb/9aKdFKv4EyutXKDzCWASQcyU3cAgaxD3SWr+?=
 =?us-ascii?Q?S4VbAbgwO7mdi6B5bVIjeu0RsiF1aQtqdM7B/FCP1d55Fc6HdiUUuAOhJ+BO?=
 =?us-ascii?Q?R0gAXZUnssBbWueBuxl75khWtstQeP+ZM+oDS5tcaDSqo4zcci6u3utbJGF2?=
 =?us-ascii?Q?aJKtZY1RhKzL9P3HDviHD+mMupBWXQOqIRkqa/EuOFPoP3BMYEEJV0CbGp8J?=
 =?us-ascii?Q?HKa9k1vt45Sk4iQ09rE8QJZsRcMeNy58XdtKuGS5ML5V33gSqElTHdO6c6Bw?=
 =?us-ascii?Q?O6WsgI+ZSd8w9pMslqth08aSEE1W7s8LQuohaaZ39RsVENBn0oonyOjHgfaE?=
 =?us-ascii?Q?Crfx4ri3tr+6fVx8cNnhE4+0g/BhkplFOSNPdArRx3ZYaMNjhPhKakWExifC?=
 =?us-ascii?Q?2a4Ckvt3NfTqGziZiy6qRRrWRFUcZNBeA44Ua2Z7KiKMNL1jzHcfspeLKA0f?=
 =?us-ascii?Q?4BRdcsZtvwhYXDPJbyNpNTa9HgekbuFFBIaSfkT3Oq/pbjtJ3IzUIwU8qtn0?=
 =?us-ascii?Q?daky7GlsTkkTAQJqbE+igeWWIfLFroP9rg2T9DHiotKozzlfgnBg2yBze7s3?=
 =?us-ascii?Q?W4otkwUVESsFJqU3TCdOIgb5HVBcM5ylfAzvZ1sQJrx54+k6ytGOhgsvF8TO?=
 =?us-ascii?Q?RSwVHUIIuPumbVeuCzwlM3lVT47Jvk4X2RMiHaz8U+oO0+7JV+xUnVWVrcgv?=
 =?us-ascii?Q?6ib2gURX/4MUkMZXRlUIHYCMDRXfTXUws/Ku/6ogWL34cDXHqRix2xdxY25i?=
 =?us-ascii?Q?jyfnqtuKSq23FnPsqwZqFkE21t3SrBwj9M7Yfmz1FrZRkEltlQAP+zAJEGPE?=
 =?us-ascii?Q?korFTTd+k7bPwzaAJczEo//WmmchIz9V/X5MyTOLNCGoShQJXTxsNkvQmHnG?=
 =?us-ascii?Q?92wXonKque2GD0SDKIgLFAbVCljElLKMUlpskYZK4bg49Da85DxI9S1SEFs1?=
 =?us-ascii?Q?KwuUGdzgiwhyjf9JSWoVun9JYhvowK7GXhPSPL//Jv0u0ppUywCrhkcpCXuP?=
 =?us-ascii?Q?gTpQYiUsI5UhozJItuigSvqHByWYT2/b64m6ngtCcxeEbooRW/LEBWEL590E?=
 =?us-ascii?Q?g9fUB5cM/YdpRWLsp4EtByE7MezfYyeel6kHE0rO59GFrgtVGL3MzJ3RB+7D?=
 =?us-ascii?Q?1jrNxHOOgwXjPMnfYMmNBZ4K0wYsdF0IZr26REJFWrwysJCmloeNzidrKRDP?=
 =?us-ascii?Q?rlUhoJvJNMRqvPl1W9tPRFvWMpIYNTjDxdMRbAS5q7FdFyt7rvOgqn6vQMBm?=
 =?us-ascii?Q?QkBhC/xZCpkOv7Vt/vtVZIcsmdmfa5CR6rDJeY8DOEfVgR0CYnKkgpaJ0nFm?=
 =?us-ascii?Q?BAqvT9lzoWYQmpZCVt4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:40:53.2142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9b4597-56bc-4597-b2b3-08de21becf00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

From: Roi Dayan <roid@nvidia.com>

Looks like commit the cited commit removed the representor
interrupt handler cleanup by mistake. Fix it.

Fixes: 5cf0707fc7e9 ("net/mlx5: remove Rx queue data list from device")
Cc: xuemingl@nvidia.com

Signed-off-by: Roi Dayan <roid@nvidia.com>
---
 drivers/net/mlx5/mlx5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 666216c21a..591420c77f 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2389,6 +2389,11 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 	/* Free the eCPRI flex parser resource. */
 	mlx5_flex_parser_ecpri_release(dev);
 	mlx5_flex_item_port_cleanup(dev);
+	if (priv->representor) {
+		/* Each representor has a dedicated interrupts handler */
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
+	}
 	mlx5_indirect_list_handles_release(dev);
 #ifdef HAVE_MLX5_HWS_SUPPORT
 	mlx5_nta_sample_context_free(dev);
-- 
2.34.1

