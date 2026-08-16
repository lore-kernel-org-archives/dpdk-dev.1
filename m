Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ECFC5B572
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 08:15:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AAF2402D1;
	Sun, 16 Aug 2026 10:15:49 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by mails.dpdk.org (Postfix) with ESMTP id 5EA2B40289;
 Sun, 16 Aug 2026 10:15:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaPLe4LamtjmEZkjhAUrmP8qzpZvOq29Q79Ahh87t0g3t9eM5kf1vUpJOrHnklusDcm5WjsenW0Kyc/V5YcRZO7Zr4SSLDSNSmjFypgLf3UuDdPv0Q8dg7Z8rmNbhiLAweTvjirtKxd0zCO3FyWupuWWX2gosyJ/fuoqTd0RgJJUMNytGZ4RdmBkUYL5SF9BNHkiuFT+n+MQIZsF9Sszf+3xMVpYZJIo1YDQ65gBcj86C6RH11p41oUIYzl7ib+TciKLoGzyzvC1/Dj3Y7kyJFGppBrH6aqfziv+PBJgCjwh0f/3n8k9BgcUW4gWKtoe1eLB1ZwAg1o2Cz2zgAFchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri0htl24Eyqbhk/3NVcP+6ATha18Z2jib77MnMCbxYQ=;
 b=tUgNzuWKYVYzC5FzoWJhYyJhmASJvXbdEUpHe0RROMxp2Q0iGEHWo44YEia3SXdE6Wwl3pCmyLS44ESLWFbBSlrgGXAQ1j07rXZ/x7NfmINLDo70iIE6M0/FCZRAJjRxKkZ8ZspkRMFwm62c5RmqrQtv/LotYld2GDmh9GnON+lZO8HQZVeeNqzOFabO/rF4qKKB0yuRPXBrVz8ZX8dPY8GBnOI/adBWO8Tvddkb3UDgFBe2oXNKeht6V+DHZ8EGq1GPOpgR2Ivdv55IGgnkUrU9ud5pcwzsC3loTijHiNIzjpZ3HHOaGUjbE5ukyr45Z5Ja4APDECttavC3NjTEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri0htl24Eyqbhk/3NVcP+6ATha18Z2jib77MnMCbxYQ=;
 b=RiUVKqip+QBrwVXokjuhBpGFYmLQT2gIdT/gHG9Py4wXiC4rkIy7F7t//jCymlfmnUyHbXhtKGl8Oqi3oj8/PFgaw4GlDkS4tzM0ee7kJVSYBpU0dI6X5+V6fwJg/FefYsAx7qouDyu5Do0xj72tJjhTIOdE9BDcjA/dgj0sJX009jZ18RGzAdAq4Sw43zADwLHoss1aybvlRl5EO2jIeDit5LkfxWz4EoPNOcjFNDo9aPid9ZP989tEzLBLon5uJBKK/Zssu62h7IyEQr+lIyUbUjv6jbUMvFzvzPwZ0ImvZQZYvDPXRW5O6EjiLN+gpUdrZLIqDCUGDvC/rqCy6Q==
Received: from CH5P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::11)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 08:15:41 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::1e) by CH5P221CA0020.outlook.office365.com
 (2603:10b6:610:1f2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Sun,
 16 Aug 2026 08:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 08:15:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 16 Aug
 2026 01:15:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 16 Aug 2026 01:15:31 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Sun, 16 Aug 2026 01:15:28 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH] net/mlx5: fix HWS sample action table leak on quit
Date: Sun, 16 Aug 2026 11:15:24 +0300
Message-ID: <20260816081525.166446-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 421a93cb-d8c3-49ad-3f4b-08defb6e8f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 5K8mbSP9ORzU1f5TdhHXJN51ucfItOmhA2xIsB9gJmiB217Gqtk8gO6CPbhyKNRd5318Jp8IHGWQPL6FF6CuawXRFZQWXOziVj4CMk6nHl/UjeJXSHrMMxIpzmaAgQgYe+MYaGpFb+9QZ52wwpTXZ3/0EZeC7JEUS/BE+T1kLmK28hnxAtymqqqoX7dnjX+JxkV/UO7+iYcb/ASZKTY6ZbBwcWf2cA8oFTVUY1I0HQI+DHcVd92QZDM8bjZR1OyND+sRMERFp+BYxqMImT8hXW2qWTYyk7RKPHIa9O9Q+EXwBWXnyNmUUXZMscxx/pRPl5ho8K3o3qqprAo9imc788hh1bBDUpPwfexuNTdy2IDmib/9+uBX5ilE1pyMaxYDS7LTn7Zef6gT/ShFoF+7YTXPn/dTEP0TD80zYg1h0aKNrjoriaWLI6cuI/ZBa05PCFtlelXLryYydZWZF1pyxrVQSL3oVtvbcbtfqUaqluuLE3VffmB1HWMoPirKuIUv9+YHSDVJyw+Rqz+bEEMNGYTOaTCh07LDEI2KOqukzoZ0SWRsVobIXqsvszSnwKYLCrsITU5cwik9pOivgoF55rOay0q1I+XpwWujJRg8EeHjNbff2kAICco8kCMT+EMRKdpck5bKwJOao0OHtnReXhgdogz1qkfhiAeQ9vmQquoM43vEZwykPvnyOocrjnTifdEiC/3Hden8MYLIg5J+dA==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QqHu2VHLI2X8DEDTteXyFdzXod2fktauYrvDcIV4F4YPloFq68I8HNFpVZLRdycfaTBzd/qBiHvo9d4D5p36mFiP3X1w4hkaup3Obko1BYAxTOWSb63zC3t10whLIBzFNBhOV4hCfsZh63WSpnNWGnEoDMjcqyOfUAMzwbNtGcjull0wwnsAEpuoMlfGkOm9cUQKvybgHRKreyRSsfsKtfwhPdToIRSxqH8l6/OqLNsGgzmG+kGUEBwmOqDVVKm0r2dhpp+UkbuI7HFMWRiv3nUB45HG1Zxg7Wgp9eZUYUr1pSNKoS/xqXc9iw+aw4uxNY76FigAisxogIK6B36gTLh4QN6wfYRulIYdwE+Fz9Am95m6iaa4AZtUB+LLKRt1r6L+ffQPMlbyKD7sUlNECWzBIXhgOl1/YkR+nG+Aca70aDQS1kDTI51XDP46UE//
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 08:15:40.2679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421a93cb-d8c3-49ad-3f4b-08defb6e8f68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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

Destroy the composite dest_array mirror action before releasing its
clone destinations. Releasing a JUMP clone can drop the last group
table reference while the dest_array still points at that table,
leaving the firmware flow table objects leaked on port close.

Fixes: 3564e928c759 ("net/mlx5: support HWS flow mirror action")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 1cffdcc54df..9abd1770a9b 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -14629,10 +14629,18 @@ mlx5_hw_mirror_destroy(struct rte_eth_dev *dev, struct mlx5_mirror *mirror)
 	uint32_t i;
 
 	mlx5_indirect_list_remove_entry(&mirror->indirect);
-	for (i = 0; i < mirror->clones_num; i++)
-		mlx5_mirror_destroy_clone(dev, &mirror->clone[i]);
+	/*
+	 * The mirror action is a composite dest_array that references each
+	 * clone destination (jump table or Rx queue). It must be destroyed
+	 * before the clones so the underlying destinations are no longer
+	 * referenced when they are released; otherwise releasing a clone can
+	 * drop the last reference to a group table and destroy it while the
+	 * dest_array still points at it, leaking the firmware flow table.
+	 */
 	if (mirror->mirror_action)
 		mlx5dr_action_destroy(mirror->mirror_action);
+	for (i = 0; i < mirror->clones_num; i++)
+		mlx5_mirror_destroy_clone(dev, &mirror->clone[i]);
 	mlx5_free(mirror);
 }
 
-- 
2.21.0

