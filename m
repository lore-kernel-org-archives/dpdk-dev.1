Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FE3606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sGKYO/cp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A887A40264;
	Wed, 28 Oct 2026 04:51:13 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 38FFE400D7;
 Wed, 28 Oct 2026 04:51:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJFrs6QkPeDaIlSDnKUnXFwZkGDdFf8SQ0j+yXOzZ8G9tNORxo+fcWOFTlhHSintGJBj2+SPOFfCVaxXUmwVWg3Q8/M/3aOS0c+hD7aquhp+6i7th3DVhHJlBIAZRAG0ewkRH3U9I992ZTYRKOimwTwzM08Yr3jBFhPws8cEUPs71j51o5zctNnzqO9wpijwzSDOilXKi/Pgzz02TkUirf5FomPifVMAI19MkMjlsGCIAmtzv7I405yUyWorPEeaoY6mOgQRspaUMxZ4qtMlvgKza0GY3vXcJ3/52lbUg4YMz5B1tt/hFWJvZqIcdBm8UylMnwdLV0jl/IHznGeGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6gL/sKormhzT8g2fN3Orr+8tFmn7RECw+I9rSKjDSk=;
 b=q6VOVUYhqZzegNmAuOQlZ9J/s9CJ+vHpoD9+s5w1o7N7mYuzLRNeWRaDBJil8V2ZSacwSwPwZveiOjCAv2irZROcGCGaPUnKlWaNWS+z8nqhhgUyCMgAjWWw2C97sYVB7ZlQRq0CpXIfI/JVdYT3FoKsdRrg6afN37QCYzpovs0xmwNobzrI8uTVcnrBKfbtimWsX/fBSsuQT4JOjjDFQMaPDh4eGmL/Tjp/NWGRliwoxJQmSOwr7SWXME6/54kakWCLbJdUvJ/i1IkOMyt/SHlD3ZMrZLTqpdfQkMQ3++EDEsntpgT4X2DBKKTE2/kOmFI/IyyU8PE2J51MSJxKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6gL/sKormhzT8g2fN3Orr+8tFmn7RECw+I9rSKjDSk=;
 b=sGKYO/cp/+Z3uq6PX3IxutJ+rg8mIS31MN55ScTNH8pDh0zCGyNjEl+wGHtSLg6WO2WwPfnB36q5sYpQJ4MUVmcJgKj4JCh6DkgyEhIiN7Wuzs8BY1MayDC0gUUl0o5kV4sdNlwueyKfpIGRmKMD4oTQCxzEOXSUfrW6NJ+oFKmJaa8RqGgwA665+EdZA0SNINCpz3TtTc5C8t+jICq5mIQcCCWmLNZhA1GREagstObw1eDC8odT1qHf5KtIjGei0xDmwJQy4nW7/XFYKI5i0V/mkW8NYUJHuY69+Ac6L/9fEeGChEn47Wjk7hQ21PwsTFAqhcXdN2pNhsZZ/ftSEw==
Received: from CY5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:930:3::23)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 03:51:03 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::6) by CY5PR20CA0026.outlook.office365.com
 (2603:10b6:930:3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 03:51:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 03:51:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 20:50:46 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 27 Oct
 2026 20:50:43 -0700
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Erez Shitrit <erezsh@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5/hws: add the DF bit for IPv4 header in NAT64 action
Date: Wed, 28 Oct 2026 03:50:17 +0000
Message-ID: <20261028035017.3900338-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a2d3e2-8f9e-4a5d-d5cc-08df34a6af8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|261026135527099003|261026140227099003|261026130827099003|56012099006|11063799006|261021121427099003|10067099003|261022115727099003|261009223027099003|261021123027099003|261022075727099003|261021135927099003|261022105027099003|261021133027099003|261021130227099003|261022113327099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: XPQMFcSqE+oCjKzxCMP2NxF8WvHlcumy7CdiRTCvezlTSNr5xVbAhphbAR6xzv7aQnY47ltNF7lKfvKh3SCBrZlAyNIWej4zdpNbHqasKnW1g7qTqCA9G2HxBm200O8sl/RkL6rhLzpITthMfkrn71zZpcgobVxBq9nP3uzkXfAdYQnwGhagOFLBGwIvXv28aEeS2IPRG0lsIwVqyImzmGVQQvFRSxR0jIEOIS9WvXBDxDq8uDSP+MC6Xqu26S2mppmVJb3TFEhgbjwQlk13RWblaTiarHVXC3rKmM/oDDwS6MQPZ48E/GxkIyCpjhuFj65yLtxDrqdLeJGWIpSR77lxtRv3mO8dsG+ehFoi6C5yxtxa2l9b0iaWWQS1jB1zOT3btZBYM1XwR+yX4ElC8R3iEVFqwAOtSqxdHYoBDbE+0jlzVIjJnsuhgeAUgr4utjf/OYRktLp7FyIiltwb0VS6dMMvhvQ4haeocixX1dv3YjSXsxCD7nQ4I9/6tf+/rhYM3HW4PZAQj13Qb8/pSxGocWkr6EC9zLs1aH6oKK3yAgHL4kLkR3b2eIDILA+Vm/0Jz6pASTwAxJoX/Kj+bAVWefPHoFr2Q27YIM8RXECpoToXVSL87dDawSRO4w5m9DX0faHGCjWS6WADcunC7DZy7ehaqgw503JcYVgcUX7JRsSjfcee4Cva+RUUwUnU/OdCuJMozA8Ge7VUDZ80kg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(261026135527099003)(261026140227099003)(261026130827099003)(56012099006)(11063799006)(261021121427099003)(10067099003)(261022115727099003)(261009223027099003)(261021123027099003)(261022075727099003)(261021135927099003)(261022105027099003)(261021133027099003)(261021130227099003)(261022113327099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1PeBcE/5Yd0KcdjAnRO6XCALQJYL8lCbiZ3G1L6OeLZ5EIe1Vy6XmQ3+cnFE0A/+W2TfwA6QbC0H0IQFc+/hG9twJu2fj/ijtTCfBQk8wt1Qb0lC77Lmm+j6/k7lAwhzmxfscaqW3EvA1BI7b9g3MASJk6ltUuyYg044LwFGcgQqGHikbzfXgFuxWTuaXYtqZYvhQ8jCGj0jXOf8I2y0aKdZ2tHSu6zOL9n6VkhtMQu8KsRuzTu3fyt4zCcQLUguU9TwaKov5G0Y5A4YO6NsPAlEV6OdgkH/Ri+mm3++l0VAorAhnGGJqAMWKz5Z0SFaSaqK1H+CEzrGyt5WDUf85kLEKm4aJZYNV/41mQhdPjAgE3tO6jJdZn18HDVV5l5aqKQI2V5T1zxgKlXpRx78TcuR6CB5EWYzgKfl2UpH1cuZIzYGKBTZxDDnz8Sc1cJi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 03:51:02.3408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a2d3e2-8f9e-4a5d-d5cc-08df34a6af8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Erez Shitrit <erezsh@nvidia.com>

We set the DF bit to 1, and re-calculate the csum for that buffer.

Fixes: 06d969a8c5b8 ("net/mlx5/hws: support NAT64 flow action")
Cc: stable@dpdk.org

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Matan Azrad <matan@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_action.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index 498c6aa109..3e48739eb5 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -507,8 +507,11 @@ mlx5dr_action_create_nat64_repalce_state(struct mlx5dr_context *ctx,
 		memcpy(address_prefix, nat64_well_known_pref,
 		       MLX5DR_ACTION_NAT64_HEADER_MINUS_ONE * sizeof(uint32_t));
 	} else {
-		/* In order to fix HW csum issue, make the prefix ready */
-		uint32_t ipv4_pref[] = {0x0, 0xffba0000, 0x0, 0x0, 0x0};
+		/* We make a buffer that contain the right HW csum and the DF bit set.
+		 * 0x00400000 - contain the DF bit in the right place.
+		 * 0xff7a0000 - is the csum for that buffer, calculated via external tool.
+		 */
+		uint32_t ipv4_pref[] = {0x00400000, 0xff7a0000, 0x0, 0x0, 0x0};
 
 		header_size_in_dw = MLX5DR_ACTION_NAT64_IPV4_HEADER;
 		ip_ver = MLX5DR_ACTION_NAT64_IPV4_VER;
-- 
2.34.1

