Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE03C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 19:42:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5556040666;
	Fri, 25 Apr 2025 21:41:52 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by mails.dpdk.org (Postfix) with ESMTP id 9273440657;
 Fri, 25 Apr 2025 21:41:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCf+7BbLZqBOxyHO5CjwK1XsIt8Zzl/EZO7psoNJDIKH8Tn9rHjyM2sxbrE3DsmDjq40M10/OHu9RijKD/23xkBei+Zya01xxtHRlqnR5oFNetDix19EPI1vSIZCa2oIU087txSqZWqErt58jcgnzQ3PRbpZSgPCJmlkhhJelJ+xP9JxgO/cUgPzXWUI07fzQMcJZxh5gRFH2nH+jnQJcfFHz9UZgBn/s+YRwQJN3J/V9A2xlmxkaABDnJkFhK04k6VrkUx9r+F/3zbiX7jTcL/cVgRoZ6nkl3TkytEXP3FaCbbZipjss+6Q1WwK58cWbtK+8YBiX2feU8q5Macp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KPDBq+57eH3MyO+WG/wH9ep/FoSut7vGoaAhY7aOoY=;
 b=W+fw92Fnh/KDRlqswHfBGBu2pP/2NE4RZmv5ALUfTWBT0kWkHhCipkoqmUzPZroBE3tvMFXgrQVeHGXREMOFnNO8h9XhDaRXorv2TFNqaTOsWOEyDO1kV+2R5yqaNI3WdVnW8y1JZ4wIbXQnuQcGrNRFL0jcvpdctqSm6+QlZfiIi1h+vFuvUgNtntkt0VIUA/Vp2t+K7M69f2DeTh/m9J2LwKveNhxGKsg1iEON3bXiqRxX/bkFqx8XjrP171pgTjw3aRFh8ShcBNbU0+E7mTimpHBDzKTVN9NxKI/uiudm16zMZkhmVsLEErMJMQFPVFdqg/pa6JwNYfIHfPWNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KPDBq+57eH3MyO+WG/wH9ep/FoSut7vGoaAhY7aOoY=;
 b=Z2VUcBIJlrD9dY5MlN7oMXKtD9CxXMjDF3iiWirGgWCMfTrXleQfnhnQ0FyRkdPZsLvyOfX0aOAgQ6kSkamYWoQHy7Q5mZIUaJTlFtTV9vMTI+zexhSyCbFXD8h0Mmx8Rq5mgL9VxMdhJzLXDiKhjGHoZ+6ZqqXiZ2Cth55iA6gD1eb9qFuiCuvK7utGa3+CXc+KYx85CdJ79F7FMVd49N9cqfByNA/zuhEHLcNSBRuESFZChiQ4JR4zWTemqAiU1T8GkoyAnSXTYRyCiK1jYtCAlqMFOED+UA4TZO5UBFb4acrXTGOF8J3VmacrxfwlH5GZ+/xlPvMm8o1eaGMYwQ==
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 19:41:46 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::d8) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.23 via Frontend Transport; Fri,
 25 Apr 2025 19:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 19:41:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 12:41:30 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 12:41:28 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xiaoyu Min
 <jackmin@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 2/2] net/mlx5: fix counter service thread init
Date: Fri, 25 Apr 2025 21:41:05 +0200
Message-ID: <20250425194105.39401-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250425194105.39401-1-dsosnowski@nvidia.com>
References: <20250425194105.39401-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e930112-a85c-4ead-bd39-08dd843136e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jwtKkUAKyUFLTfsOH5RBA1/oOsgPFH7JlqbOZqlYxSOFtmjq5wiwmT61mBGY?=
 =?us-ascii?Q?muiug1zEvLsFDFElkpaMx9ueGCsSdy4ccxKh2JxzYim0hw7smP/4RtCDYflz?=
 =?us-ascii?Q?EE8aW75Z3GA0nm3v/i29jQ7tRf5DrKfgh6nP9sE6buDfJO7lQ8Tfp/O32vNO?=
 =?us-ascii?Q?RjFvmtNJsATxm8Xn/Pz8ZddriRUBZx1ZdDdTLoJIPxB8GXm4wFsnTBv7JiON?=
 =?us-ascii?Q?prg+JTh3oJDntoQorKZwxyqv02D/i0qvsrpb52pM3Wof6nV6SX+K6f5iTrqs?=
 =?us-ascii?Q?ioaXGPrO75FjhikJ7Ba5Q/VQ9C3AVSPC78wjTQFqnuttZpdXDEnbs4QHQj38?=
 =?us-ascii?Q?pzf6JzsS692MmnDqJQM4BQg4cwbXuNz2mUmhOVbYMkAG+aEuCeRTtAv4+XCH?=
 =?us-ascii?Q?6knIlq3cqNcuOyi3h78umm0qYOAbTXBYUkWIpfJOAvFpFYTH30fvq332MAJC?=
 =?us-ascii?Q?E9CHOJWjFGCF8tZ7L659zy0VM/4sBRPdb2A5SubrVNw5U9ql1E6fIMSoy8nC?=
 =?us-ascii?Q?Os0Mvfb2gJ74+EhNaYb5DlkEvU8/jvJRFqHyaqbkNGRJSG5INcbbpkZen+L3?=
 =?us-ascii?Q?eH+8qJinCBTNJNiTk1jYx0uzbZSXgIVnTS9uLGTv1rMYhtxzebmOTbdL9GuT?=
 =?us-ascii?Q?7E4HHbOXGMIPXoveOS3cLBGJbEapIoXoYjRUvDEtKehmjFQzhZN//o0QlL+T?=
 =?us-ascii?Q?Ae3pn7Knvm4KT3OJxTkwyEBRJfjztx//34+4PQq1jjIrbsLjs30TC1QIp1Mn?=
 =?us-ascii?Q?PNIk9JqgMtiQwPeRi/dPU29gcG5+1m3Ktx6BDeaG8Fqho5Gk0if+JdaYQQGA?=
 =?us-ascii?Q?59WsDMI49gs/au5QRuXQJVM4B+O/RkzapF1gk1PwUFc7J3UK+NqOlova0FVm?=
 =?us-ascii?Q?h6vSDyS7W8HF+roIsDBFFKLjCXPYg+WhSg/fkKo5h3+Kmda+3437aXbANxOH?=
 =?us-ascii?Q?SVsB82aYQwi579Przmf40usyU+Ah/2oklyVyvWT6uGQhZysDWFcrtanqa1dk?=
 =?us-ascii?Q?Nul73fYpXFciBU62kvYyvITdONB6SGgqPRiR1+05JgcYCfxwJ0hf2S/Z5wpu?=
 =?us-ascii?Q?9lrXQOhV0jOBfpSjSzd6tw9sbvWDwJZcs2iCp8FOg49f0noI/YdXZ2MgIdrl?=
 =?us-ascii?Q?bObNfLiyN3MJ6r/J+fT1c6DPZv+8H66T3XOq++r/E2d5WV4VVTe/YPUsA7qw?=
 =?us-ascii?Q?DVSfTY6tfHwjSpo6ZVpGEH2QJJfkCRy4QkyVvF+4otDF1wEmKUNCo7g3NnCz?=
 =?us-ascii?Q?/KnJcY1Yy7722yYKrovA5ePM7idHj9Aram93c+lehJK5b78Iv5qkk9RrDVBP?=
 =?us-ascii?Q?13JydhHJdocsG7OzoZ9Ey11SP8C+eXR+S67izyOcP9ydFMXDrGe2xVQsEVMb?=
 =?us-ascii?Q?ZUbEpLv81sdJc+hP15LWGgKwtTTicI/smeyuHo7Ygf3A4CsgIgP5q6O43Zwg?=
 =?us-ascii?Q?ghGscjOEs/QqqhL0+zRzdWCqORimrj1pi62TbN0r36Y/4hNpgknEZWO6+9KY?=
 =?us-ascii?Q?q4HH7ZemZQsluUrEcFGpaMHwirbivWTyWFmA?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 19:41:46.4140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e930112-a85c-4ead-bd39-08dd843136e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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

During counter pool initialization (mlx5_hws_cnt_pool_create()),
a background service thread is started by mlx5 PMD,
which refreshes counter values periodically.

During initialization it might happen that:

- background thread creation succeeds,
- pool creation fails (e.g. due to error in configuration
  provided by the user).

In this case, the procedure on error rollback will not clean up
counter service thread, because rollback assumes that
is there is no pool, then there is nothing to clean up.

This patch fixes that, by moving background thread creation
to the end of counter pool initialization.
This ensures proper order of resource release during rollback.
Also, this patch adds missing "goto error" in case of
failure to initialize the service thread.

Fixes: 4d368e1da3a4 ("net/mlx5: support flow counter action for HWS")
Cc: jackmin@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_hws_cnt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index fd12bcd7ec..5c7c0041aa 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -729,12 +729,6 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 		}
 		goto success;
 	}
-	/* init cnt service if not. */
-	if (priv->sh->cnt_svc == NULL) {
-		ret = mlx5_hws_cnt_svc_init(priv->sh, error);
-		if (ret)
-			goto error;
-	}
 	cparam.fetch_sz = HWS_CNT_CACHE_FETCH_DEFAULT;
 	cparam.preload_sz = HWS_CNT_CACHE_PRELOAD_DEFAULT;
 	cparam.q_num = nb_queue;
@@ -769,6 +763,12 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 				   NULL, "failed to allocate counter actions");
 		goto error;
 	}
+	/* init cnt service if not. */
+	if (priv->sh->cnt_svc == NULL) {
+		ret = mlx5_hws_cnt_svc_init(priv->sh, error);
+		if (ret)
+			goto error;
+	}
 	priv->sh->cnt_svc->refcnt++;
 	cpool->priv = priv;
 	rte_spinlock_lock(&priv->sh->cpool_lock);
-- 
2.39.5

