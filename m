Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0B7EB597B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 08:13:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1B71402B5;
	Wed, 11 Feb 2026 09:13:37 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by mails.dpdk.org (Postfix) with ESMTP id C1D644026A;
 Wed, 11 Feb 2026 09:13:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCtjld5RvYOGc5AirazwWdYXKxt8BufLSxVonKbnuq3mShekE9voBgcaFMhBYvIB1BlSfbSSn4rthPXeoF+zpMl2qp3qTJBKBZqnv2rNzIsoLljPGflQtTSro5LzejpR5aoV9YzjF770njQ0pyIxO5kDi92VZUu1xqA7MHTO4Q/TyCEKoT5ibwQUkRYhY5LeNInoNxz5y5nKBALR6C16oszFmtsMyj8C6mePHdmRwh1e4WcMWtghB9edQXZlU2kFxgLBT/t2dEpPxOhq5d6/d2G3E/v9OhHwwR9vgFSWxoSGSuQeptIqRwYQtpvESxglmjyed1ZX13cChPFeWA4elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4LfgPijwlBxMIlEtZQSZ8wOlcdZwhv6qRNKAcivzRg=;
 b=iuNCuPKNIKGbl1eS+a+XPixaItMYORfujT3lD7e5a2sX1hLjPCAhbW+/q3aBmw86+1yh+lm+Rqs/2VT7SYvfCTZQ644cZsjTaHJzwi7WYBoaFjmt/TeFVPV1SKkqbaxkhozwz8MAzYTR192M52GeH7OuVtm8BSg/fW2NV5evvOOrULF3tA6fcSnGnR1rjxCaxtyX40X60XX/1FUJ15RTl+4cTOB21F2vEHJk+e9bIlVKPI4JKTF/tq8xnQL9PT4n9ZuDIAb8xJKMSKRqbpnf39cso93nHDDjRxeQ5ZOmHRS93zA5TnFus20i3ou9hxxgntxprqwDzE7gQO7Eoe+8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4LfgPijwlBxMIlEtZQSZ8wOlcdZwhv6qRNKAcivzRg=;
 b=RPdG9iQvEQHB83ikLXq57WNX+yg7eEkG8PqT2k/QWMXGWsPO2L+abUg8aesLKmLnhbLGprSa6hTIBDIAcShJ2lbAn9jET7oa2ezGNU8iApfKrlZcMRX6VL3JGay2iF66iEVMy7Xodl5tSGAiXbFakAnxn48H4LwY3++aUbCMZM3xc0KewIhq9T4IikZJ7U2bzpurfa0WnIy3tvmTDFRPjC8dk24M/wBBIiORzLshov7RIEyusbHCd61RvMPETMDvJayS7lnKVHQwMBV1TXU8CVMb0ajVtNoU2s/E02qU4Vz84U3fFWik3GCqjD6FHqDQwNK3SjlcZd4NSv2fIN6ICw==
Received: from CH0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:610:b2::7)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 08:13:32 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::df) by CH0PR13CA0032.outlook.office365.com
 (2603:10b6:610:b2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 08:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 08:13:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:13:18 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 00:13:16 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix flow mark reading after reconfigure
Date: Wed, 11 Feb 2026 09:12:38 +0100
Message-ID: <20260211081239.191118-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 149ed9ad-7167-4094-88ed-08de69457224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yMpsAVqp7WCZbYc8ETG5vtaXMvkd9ilBe4gKPldVzUbawC9ebVdjEmS9eIRl?=
 =?us-ascii?Q?ZsXBJheLtisg9Rw0FloCvrvDQrlb/OthLzoBUksCyfHutZPgpitp0enGmVz/?=
 =?us-ascii?Q?JBkrvgwRkQHPZVhicLzsHmaGzOjv8HNfakPpE5CYPl4NVszsyxiuCt8+520p?=
 =?us-ascii?Q?JUU2SV9In1Bcu3A1OO37pizFGjvIbpB31pAfMr0A0hfudOA9R7bKtlbHWcZu?=
 =?us-ascii?Q?Fn+BGS9uPCkwNdw4HBU0dnPZ42Q63FF+ktOjCtZxsmGsljba0s1aJQIHmYou?=
 =?us-ascii?Q?ymAs2SxSoB8uU33tb3GzxGQDC7sz/m1CzZc2qRgAWXzNg4MmVP9/NQqqp6In?=
 =?us-ascii?Q?suY92nLSW2YsNYejYKVX387Q/glbwfKukTtTwaIzeCUTc83WugAoGrD8Zicb?=
 =?us-ascii?Q?23TGlwjGG7pMTmBNsT8pSOg6al5M0p8s1maKEq4WFk7cnmSZNhJZT228thZR?=
 =?us-ascii?Q?/EmEyd3WKjYCJUEkx9BBEkaD+a1COo0KpL6zhA3uApAMYmdfIhfp9VoHSuNB?=
 =?us-ascii?Q?Vrs9EMzks+v3zkgmbg5YXGMW5Edyawqn+Bc4/mYleoVlB29E6k4I0Z8DYpob?=
 =?us-ascii?Q?cZu83RKBxESaj4/apYhX9U1tyw4f81Hf1hrEsSgj1sG4Mqf29ulUCmzGMRcH?=
 =?us-ascii?Q?Dp4rwcjmbVPkbSCmieLDPYO/olWM1OTbINdL3BpVks2NWHhvnnlN5ICOomb+?=
 =?us-ascii?Q?PxknL/LjAseS++/GUXdCLIUnuTLWdRiO7a9bAiPmfhvm5IwInJT+aPM5npK8?=
 =?us-ascii?Q?M1aYmPAEhjHs8wizHjiFZpklYOpl5PauXmAsbQjessCjWzvaRQUMR52FYwyx?=
 =?us-ascii?Q?m6ks2/OslU9mdXEBuZRqVYiOVcP8KTjHLOM2oQ6qe0Q8kEveWSxO9r9++GyN?=
 =?us-ascii?Q?nWmm+/rBfP9uKXQyfOyC+56/9BUZIn8y1zSNT2gjAWCJXFbGXkO29HpY0tuC?=
 =?us-ascii?Q?hJ32tUhm7HZQPR7qH7dHIhAvZqF4TRAcdz3JRZ8/jF9kgt/2f4SFHUQ2vzCd?=
 =?us-ascii?Q?WAan9RDJEK6DbmZJYN0lxWoIhnTq5+KziMX3mwwWMPurxnYhWXlpT2vXqfJn?=
 =?us-ascii?Q?lgcFJSMyszzf2Da4thsoQYZy1ZSyX5EMYj8WFdnInYn5PRDPpdk2PtLMzQTM?=
 =?us-ascii?Q?oktdtFEDRlO0PviRA542stfrtD5qZ38f4Tr+S4qAy6xBtgN5Or9S4FvKGRAG?=
 =?us-ascii?Q?96HcWQBgoJrU+v+7uqdMNn4KzO7mnFIj/v5bzYJSlE+cY6t2Fu4QIe7F3e8h?=
 =?us-ascii?Q?GayonTLYqD1/cJVVv6p4dDVq+MieejJN7tTVprslGY4dmtCYHGzLNVCO4htq?=
 =?us-ascii?Q?MAGTnjhHwpWITTBYd/fhWPgseiQt/L/yzBxtBIqCIHuDGQNpOyUkv6HnFKZV?=
 =?us-ascii?Q?NtRytW+Tnz+OF3XsCjbXO+rsVRWyir8SKYAc1io+1loj22SbgN6SSbMrgW0e?=
 =?us-ascii?Q?o7C68/XE5Ufn2G5QPDOv6h5TtCVvZWE4OJLrwDXWYwUPgmdX2xQp1EmVwSpp?=
 =?us-ascii?Q?A0LJ8DFpaX+ODdQfJ36r+sZ+v3c97SQTMWeeTSCYAGUwWZbPBN9bO830sJ3C?=
 =?us-ascii?Q?MLFE+OGh45KRelCfwd3DYvBFUffC/Kdmt9fnFMu6ZSC5J1VqShGACDiUJZGo?=
 =?us-ascii?Q?J/Qeip7aio7Ldpq7Jv1d3Z1RvRrhTL33dares8QVKydIsLyGYi6hcuMbL3ri?=
 =?us-ascii?Q?TFgLMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cooIxyFkLiehbij8CODSQGITEoDhlmuvuqCbbiaoK61IKYviBEzhMqYakxyXlSVGrduh+4/fHoTVjBCKo9Qim13HEVuZvNREx4v4LRaG30u+PYJD0w2wsjzk0vz8gbqYSt2Ca25sdVSFy+en/To2YnOhBUrdbxOBDLx0G7iVok5LpGJpa3EOwQ6uGM2jZwePZt3Kl4lYs+Nw39W4e1v+S++eUpIepZ9PMtGcz5XdmGcuu+UBSeqUNXpykYH3CzcHGMS0n3oASzjgGJV7M5SjcrPmgUmx/dub8aXRyVBTHlhOIeMl3/uuE2M4Sg7PDZnTDVkJ3NvjHdPVtHBQWPZ4nx2uC3R+UTARowN4ouwFW7uvFMCK9kXJdh0oJY1b+kaf2p6sQqKMnz0a4qZvPh0gS0R88VTyo9XqksLsrl/0MuMuko2dg3zYydC36wZ5HBbN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:13:32.0122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149ed9ad-7167-4094-88ed-08de69457224
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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

mlx5 PMD supports flow mark action which attaches additional
metadata to received packets. This metadata is stored
in the rte_mbuf in hash.fdir.hi field and applications
are notified about it with RTE_MBUF_F_RX_FDIR mbuf flag.

When working with HW Steering flow engine,
mlx5 PMD reads the HW completion entry field with flow mark value
if and only if at least one template table with flow mark action
was created.
Whenever table was created mlx5 PMD updated the private
data of each Rx queue to inform
Rx burst function to read HW field.

Whenever application reconfigures any of the Rx queues
through additional call to rte_eth_rx_queue_setup(),
this private Rx queue data is reset, but information
about existence of flow mark was not restored by PMD.
As a result, reconfiguration caused applications
to not receive flow mark metadata.

This patch fixes that behavior. Whenever port is started,
PMD will check if flow mark action is used and update
relevant private Rx queue data struct.

Fixes: 1deadfd709f5 ("net/mlx5: add HW mark action")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 0821c93a9a..5add0c4a2b 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -1898,6 +1898,7 @@ mlx5_flow_rxq_dynf_set(struct rte_eth_dev *dev)
 				data->flow_meta_port_mask = priv->sh->dv_meta_mask;
 			}
 		}
+		data->mark = !!priv->mark_enabled;
 		data->mark_flag = mark_flag;
 	}
 }
-- 
2.47.3

