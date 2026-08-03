Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C9C55175
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 09:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31B3D40272;
	Mon,  3 Aug 2026 11:07:13 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by mails.dpdk.org (Postfix) with ESMTP id 0173E40269;
 Mon,  3 Aug 2026 11:07:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGSgoR4JKDjymGG5hlALqVzL7cnGsOmPYQugua2+JuRdstmBaKX+W9nOr0YCJLuH2FY+TVg1q8gfCrGJBem7KMZLr0aUtVUP6CXkj2B9PxJQhaVRa0JGMPv9xMfWA8acnirBSxE18iKdnW02UxVF7RDMvwWMvdoRWihXhYkU8Yt+fXRaOnqzNxkkKiC0DOb6JCOBGRyqYvMgtzH6hqiJk+mxczFroVnTtiUiqmOleuzXenvxMCgFbbczJ+NOC8yT+45kwp+y2DPWNoF37y0hu8suaUBfru5unGVp6PQl/bQXYwD/X9Bhu3Tz8l5wOTK+ElgEnKv+KavFOkL/jOvUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omhry3VdlMlrUFG10TUJAaPgEeJmTyv0j7zvNzvk0ic=;
 b=VymNLONMREI67wNtzY8LLAl/JKXi8nPnRjxEUs7/GAfFNaM3n5N4SapuZ2tF1gb9FL5x2dJ3YUa8FINoYOrh8ZiXxbr30akZ77fOrOSuAAoL58bCM/t656pu5Wyt+xrE8IE66cTu+kNFo0vSgRhOZWEz4qqd4lRc40pgiTbcFoWlhcqw5v1+pWbGEqBiZ52VTxY9ycXX7eInwntM264Jp1+sx7z1PdJ/IyuNWjOZxaL5w0R6J3NSdMYI1QgsfxBE7MTauMx6BdEu9X4TUbXJChg2XhC4TYAHC18wrRTB64XglNPrncCLvCAeOFWJ7ZPkSVwass51JztwAD8cfQh3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omhry3VdlMlrUFG10TUJAaPgEeJmTyv0j7zvNzvk0ic=;
 b=qpl3OfNavXq+1g1YGpz1bpFNbC+xssoTPbJS/1nZOBhYVut4WMP/MrqjEKYoVVIvTcfQPqORyqiZ7d1vhXGMZhDUhMEOswVp8gBJ2PQyViBw4oRT5hgmxQmh5C/1abC1uPWPZswaNj72buIgU9EvhQy4wyZkt5Y2r34AHPXQbXCFgXlUgRa4qhGAShdr7V+GwNhNKFXLFbtfS9Pr0cEQ5i8/DvSacSm+DpmglVVTootf3siU7OnXbDjn+ZzmcKVSIDQLFQiXjT7GSDw3huuGLfFkHduqb/faOgOtW5wJoN2NVqOpi0tTcemi8u9jMzsAKZqrIOpjFFL1j4RSc8MZ/Q==
Received: from CH5P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::13)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 09:07:06 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::45) by CH5P221CA0018.outlook.office365.com
 (2603:10b6:610:1f2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 09:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 09:07:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 02:06:47 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 02:06:44 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <stable@dpdk.org>, Gregory Etelson <getelson@nvidia.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: fix aggr affinity pattern create failures
Date: Mon, 3 Aug 2026 12:05:52 +0300
Message-ID: <20260803090629.1758028-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 160c5d99-9b63-4c1f-423a-08def13e970e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: HWgiUR1mZaC0m1XVSIBp+JB5It2+sCz0xQ4L2j1ywVztzE4Wm45Wmj7qTIYtOvq7Rt/D96p42dy+RS9knaWNO7igo3sNlt9nkyHiNAY8t1ZPbf8hDDPR6Z3rMz6vEZaemfiRSE76BDiT0Ph6MeRWEUS8VabPVV9s5++9xeTdvroM1Jnzc+4IoqdYbXjBSHUS2ZpMIdjeCyH3xQNIuUDPRf41x9O0SFktMC6luCuvoS2ZtGwKZ/lvqOFNIqVcOukW1d+yHxq4YUwI1O9WeoidneXXHB+tvFMqkwPw/IAD8VYkAFZqknfEXptibo8/xpMvaNwVwVl3mtaC+9By/OTsKUCsh5e8asVpl5mwXb5hX4sYCH/z8QQ0YmiFmIY9o2V/qcsiTyYcRUBjyGH3Q46ssb1KWe/lF42hSkmQLR/XGK9g6FTSdJGSXhlPpjqf9unzra/Qw/C5oReRA3xjuymIIMGKlDDvEPurfsoiu6zI+VqjLcQwaQjcsA8locL+OED8h/To9+9GNhReMgWEp9eXrbkeIXD62oO4WouQ6Z91PmILDK32kjiaZztCGWqXBlCv5Pz95ZBZF0S4TMUg6VJZxKBOE9lFxeGFgSpJXACwqenHfihzeTnd9XXVXHRf7rITXoz97O73QlZyEaoELdeUukbUkFzWZftDK5ob0bR1N5BdjF00vs0923Ej6gMDns8IZVI/6JfMqIlOSZcFFt5UNQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vrYHUQQBGlZO3L/G50e51B+tjK1aaGzelp1XIbDqa0UFPsNsrT0ITnoKwNgFYo4dKwskcqGB+azdS7AJsIUYy0OF8LD8luaQ2gWzcBUklF1nqdWvQF9eesBnEV9R8F+4imDQ+i46K6cdgZB7t8RLaAIj9NzPM122pYEIu1ppCF+iojNwk4v+6QSAAw69GJtxZMrfJSyLuCQVNuUqB5doexHNnjxbhTaZl1obe/j+J7VUxZn+yLAyZjZTV5+NML8dobOzPpZWI2WBW6Tk5Dz0sNdsz/Doz1SQIVBwl8SpyGMIf/FxAajhftD47eF1rIrgGp+imc/kEKG3O5CljneSI/Iq8/4Nf37MldZJGNrFrp+/Kk/7rxQx/kb7+mhqgAFM6c63bYxD54w3waQzbiEof95vJJFOZv7GullbS3IVDiF3SdTUP0VOwg8xIisBMxSq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 09:07:05.6321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160c5d99-9b63-4c1f-423a-08def13e970e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

The mlx5 PMD attempts to validate the pattern template
by creating an internal table under group non-zero.

Aggr_affinity is only supported under root table and skip
its validation. Table create still fails due to definer
translation error.

Fixes: 80c676259a04 ("net/mlx5: validate HWS template items")
Cc: stable@dpdk.org
Cc: Gregory Etelson <getelson@nvidia.com>

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 1cffdcc54d..30ef2f1c2d 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9588,7 +9588,8 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
 		}
 	}
 	rte_atomic_fetch_add_explicit(&it->refcnt, 1, rte_memory_order_relaxed);
-	if (external) {
+	/* AGGR_AFFINITY only supports under group 0 */
+	if (external && !(it->item_flags & MLX5_FLOW_ITEM_AGGR_AFFINITY)) {
 		rc = pattern_template_validate(dev, &it, 1, error);
 		if (rc)
 			goto error;
-- 
2.53.0

