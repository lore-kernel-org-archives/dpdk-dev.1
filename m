Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1ECC021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 10:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 548DA40A6D;
	Thu, 27 Feb 2025 11:21:19 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by mails.dpdk.org (Postfix) with ESMTP id D172040290;
 Thu, 27 Feb 2025 11:21:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHbwtlFM1L0uyjYHKwrP6tLNbF5rmAhhbNT82KSEZkrE1PoUqMMD2AGlH9uHlhptOlq3suy+3E9kz4XCi0lkWprsXXr5cdYYCm+36pEG96KPrOwtcJLJU4GyYJMcZI6A32KxowKiEc64cD5g4qyEPMfWc5vEtJGWEd//+Q+wwgm9GI3Clfr9nGxGNd2PpYnHmDU0Ldirjrklw1x1TSNsKVPmWVuIxo1UX+lXcyIStuMx3qhQ/neNaM7P2JhUBgrR+KOOmhAiWjTH3RVy+jbA165k5gEAnSWRM9P6fl5xM7CpNbk6aybNKA+I5gKAmiLmR4yJwpBXhxGeNsptfxugqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwXtgWmuNppAEJ7ehlvilnqXZ2pdwT2hVfTpp3IujYo=;
 b=hGq7zIfkU/EQgOjBj25QjDYMw4fiDAiN5JqJIxvRBTumtKKM4i0FqK2pLyjaDS66AbwdU0N/dfvCJYLhowfb347ZH6UD8q53E+ZlLRPJ6qR2ilVmYSh/6xdr27zj3wBCOXn5lldtdttvvq50nfS400z2ig8kyCwZbgfo49Lkm38de2NuzUudrpei6b+qcDfE7a/ByE+Oxm4LpslR3a87ee36mqUcbbmSu81AbMoE5RUx+akgeVaP9tdI05pnvxi7CzxXsIIOjdHtcf6YGPMqkBtU3baX4zHgm7ahDlDDd7wFo7pLdNoRzKye24RvptsIpz9e2B0JmTjs3EQOAU3hQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwXtgWmuNppAEJ7ehlvilnqXZ2pdwT2hVfTpp3IujYo=;
 b=P1F9d8d9/rqOyFnd7E2+K2WLG7QU3LGhEiiy6lIg2Fx02FSr/Gg2VgM5ftEmyJHaFi3r94jHbGHa0U2rOhVAdA74U/zCSUZQNJNpxvZxFYYKN+CV4HolsCrK8xumjB9VlQoQP+GbZFkXLqhi2Rllhi+GLoH4lJis22zPS3TYw1tkiatoY+F86wRYkGvRYq8I3604/w3OIRwh1XfWLT3LdKDmGVHzCycJB4ub/R4WpD7pHKodXkiwjo8rERRHRwqBnHAQyPWl2Yr+ggHB75T6M1B9D7RRzeEThAQSCx2QS8QMl4+CQlzsssWZxRE4AvNmpeWZhwy+UtaF3CgP7NjWcg==
Received: from BLAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:36e::14)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:21:11 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::bf) by BLAPR05CA0005.outlook.office365.com
 (2603:10b6:208:36e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Thu,
 27 Feb 2025 10:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:21:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 02:20:54 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 02:20:53 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 02:20:51 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix LACP packets handling in isolated mode
Date: Thu, 27 Feb 2025 12:20:44 +0200
Message-ID: <20250227102045.89381-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f44760-1fd2-4d56-8daf-08dd5718750e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5mYOe0yQDyI3o5Qn8MqlfHCHDr6LYB6IznkYTWQAVUwDFSGc4sFN31mUf9Oj?=
 =?us-ascii?Q?SCTb0ug062b/7TRbt8f3JTnZ+2Ex5LJq/QYkNq4OvyjwtXuNJVvRanFji2Bp?=
 =?us-ascii?Q?DXomFwOIbnW3LRmhrgsKaaRIrO07UjY78S9agPY9wer7D697hfIXpJju65py?=
 =?us-ascii?Q?CF0tA5bx4kWp+ZwmIyD4YGkNGvNa01TMPYBEW82DdYQ+q8srWuvsv+mduSGa?=
 =?us-ascii?Q?BO66iX2JPHLEz173jQhZ72KTfinCYE9z6JSAgMKGsYkJ3jy5yMNIK62VLFoz?=
 =?us-ascii?Q?/aB1DKnyboWVLGhFg8ZCK/XEyuczz4BcimCzohYhniUBI8r8DXUSTBGBrNFn?=
 =?us-ascii?Q?HrTQml/eSv8BCIYkYmpWzxo7ZHL3EvgKxFzUneS6BQ9agj6hgGMOb0cBX52s?=
 =?us-ascii?Q?QNFL+P7GXgn1m9z0VYmKTAFUgyWXPc8Ah7gaQzGrR7iAh06i4EA9eGMdmUmZ?=
 =?us-ascii?Q?/PtJOHa0tzWAyPf0YJCZ+7BaZ36kVfOKbTFuooy2MVhM+1DtT/GhDFk8iCBJ?=
 =?us-ascii?Q?jtnPcjY5fEEw2Z3oBvVB7VFsSZLg81Myrnhbko08Kw6Gy49OCj4B2v6OTAgk?=
 =?us-ascii?Q?YdP9UfAvS62evMbcVOuvvL6kmQ2Ss0oUCNC6DrfFTXGkKj5qL9tZuPasFYtQ?=
 =?us-ascii?Q?LGQFQQMiWZL7hbCN14E9sDh3FTS8lcsJLcHU64gM302Vbvx2P7I8Y//WDU89?=
 =?us-ascii?Q?Ef46uFFqAhpk/0pp46oUMUUj7flUA4bonmQAjLTT1RkxUE77bDFCjLEmrFCy?=
 =?us-ascii?Q?R92YPGB5CRAt+bUzkHPpvjdivoLk6/BZjKxHxTS6VOcT+xHPs+SSoB06Vqt+?=
 =?us-ascii?Q?ahXBoc14bYAmL+q/pgjOHY976BXfUuA2DRL/ONUrR9543hBd6t3d+5gEGZQP?=
 =?us-ascii?Q?rYgm1udKwwWl0XTQEfwqg+CMCRU9QnaH//oDvTeqBOz71InSs6XCdYOTXVeg?=
 =?us-ascii?Q?kqc0E3L7f2pwP41aJTea/upy6vXtDKy+8YJsOrgGDbzWgkyVUG0qPWcdLct5?=
 =?us-ascii?Q?Q41WD0louk0/AHnlOKt+YXmDVJ4r6u47boLcuKXyXM4Fq21t9mog3uvUraqS?=
 =?us-ascii?Q?K5ojAgkv7enD9InOgqmoZ5aaQt3vg0CKhkjsuTKvhI/PBPEeZwiqPIvg8YNc?=
 =?us-ascii?Q?KHruOXAA/CjihZSBiPl660oyzCIIVeTmiOaANGqb410irjB59UZ9BmuqJlmS?=
 =?us-ascii?Q?5/o0Sb3+j/j82ykTIrPws02tj9M56U9z1gAs+aPiSXrROJrW1SI+e+GJ6ltY?=
 =?us-ascii?Q?A/dSYZ+AJY0h12ypK/feAPZkf/2rEcwbLqm5k8XBU3YfmyY6vF59y4qoEx+E?=
 =?us-ascii?Q?ls1QVUItoOit6qHO8SViapTgUqKQcR9e2cEGwhAj78fQJM9F1TydzHw7BqVb?=
 =?us-ascii?Q?4AtAJW6woyy+sql3+8+68jKEIhkYadaJZW1lMjjyOhL71QV1W26vBf2O5Wgg?=
 =?us-ascii?Q?EjHcucwMcjRJ6Wse3BHVFAwt8KgjsUmkqh7/esUO3zzg44Atp/ZxM+8KjBs9?=
 =?us-ascii?Q?yiyXHcfxTMXLD1M=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:21:10.9166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f44760-1fd2-4d56-8daf-08dd5718750e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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

In HWS(dv_flow_en=2) mode, in the routine that enables traffic,  isolated
mode check was before LACP default rules creation as opposed to
legacy mode handling.

As a result, the LACP default rules were not created in HWS mode
and LACP packets arrived to testpmd.
The fix was to create the LACP default rules in isolated mode.

Fixes: 87e4384d2662 ("net/mlx5: fix condition of LACP miss flow")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 79b3d4d9821..4ee44e91658 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1533,11 +1533,11 @@ mlx5_traffic_enable_hws(struct rte_eth_dev *dev)
 	} else {
 		DRV_LOG(INFO, "port %u FDB default rule is disabled", dev->data->port_id);
 	}
-	if (priv->isolated)
-		return 0;
 	if (!priv->sh->config.lacp_by_user && priv->pf_bond >= 0 && priv->master)
 		if (mlx5_flow_hw_lacp_rx_flow(dev))
 			goto error;
+	if (priv->isolated)
+		return 0;
 	if (dev->data->promiscuous)
 		flags |= MLX5_CTRL_PROMISCUOUS;
 	if (dev->data->all_multicast)
-- 
2.21.0

