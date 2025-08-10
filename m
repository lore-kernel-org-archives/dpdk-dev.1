Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757FC87FCF
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 Aug 2025 06:48:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B0724025D;
	Sun, 10 Aug 2025 08:48:02 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by mails.dpdk.org (Postfix) with ESMTP id 0E775400D5;
 Sun, 10 Aug 2025 08:48:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2rMmTwImsd4490oZ9/hnmHBA+TNgAZ2TOEl1e8LGQ1S973sQd7sQSXzoogc6Cg9h0yzgIegfx7ubH3z0Rx2rZxOLOYM9dr4trGbgNWEsB04MAtDgeuixdWTBeyPRpt039qGV+Vc1Zw4figHUisXZDsP6qzNxc6DfkwDMp98Nb5LL1Vg8TCC/C6lbWaLlmCQ8JRfpoNof0LNzME1V5GA7mlLc1P4EzrvX9HPijWSgUVkyBdZ5S7ADiKJMRa63UA/QQFxo73kQLYGN/PYEQ6JNTk5tK4dXf+TxA8OCUeqdd9kvkihPaJZI3Yw/iHG7z8e0aIr8ZzarY5Qp9Bm/+myMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDNd5sdPglXRT+CkXg2IaESXGSyyB8Pus8kRyecLx0I=;
 b=DYOlBMnlhA1vMV9E1kqIaE3GLjyNs8HnRDXXRNi+43vEZAsdmY8kilUUMcnwcIJ9lLVklZyCLXREIuGPufCz7mJjY4Qt6KL4k2u84trpPREGKzXbDGASX/c9gOcw/GP9mAlgb/z7m78fx475JdrT0wpVn8KT3FN+eqzGjuqxWXjQ+vk0C/q6K6XsKhqiMuM/UdlEcrNrd6zrZmN0SRpix+Qi5yYkJO5DRU1KqhTJu5UcgpdwvCzVgAIqO3mthC9zkCgCQT8F5jXakEdYI2Lj15UfPpZ2tGmL6g26IXSr54vWe67MAG9JPHl7oiIB4bJjgNpmLFmSc2JEfbwJe1i+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDNd5sdPglXRT+CkXg2IaESXGSyyB8Pus8kRyecLx0I=;
 b=htWJf9YiY/E9itvsp9IUBee87xKSuLN6DcXEQJCXTsr2cuk1JAFASWuET3Z1XnT1ZHEiCbQUVyzMme85MXId1QTCsx3TKprmXTUjrBfkcFBZNYkqvHMQzoRDBJ2ssUI84UvHfOq1hflwZXJJ9rhSjz3Gug0GnGvfzWXtHsL4A6kvo/3JOm4Qj79REO08nCUXjY6w60FDm412f3pCLpFuwtz7weqXwRXMJZjk1TrS5y4qD0sBVhjvRRPRgyXlqgjgFMo1AJXrYmwasFsr0RaTqmsQBgePCkQ87cQaZCoCff8WAs0Qufww5Ap/fXwcnWIQ+qNRUOHd9gzk4/iagO3d8A==
Received: from BYAPR11CA0042.namprd11.prod.outlook.com (2603:10b6:a03:80::19)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 06:47:56 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::58) by BYAPR11CA0042.outlook.office365.com
 (2603:10b6:a03:80::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Sun,
 10 Aug 2025 06:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 06:47:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 9 Aug
 2025 23:47:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 9 Aug
 2025 23:47:39 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sat, 9 Aug 2025 23:47:36 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
Subject: [PATCH] net/mlx5: fix panic for non template age rules flush
Date: Sun, 10 Aug 2025 09:47:31 +0300
Message-ID: <20250810064732.74932-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d40dd46-5358-4ea2-23c3-08ddd7d9d67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0x6aG2wNuPvZTO//sFdGVPonWZq17qTiSe6caaP+FisO4SK7LDNcc4Ca+JcI?=
 =?us-ascii?Q?dKhmNwHLoQbQe8za7k+rnxcn25RNH4s+nEF9alfPgmrjWSYd27umEtldcM+P?=
 =?us-ascii?Q?+bYDdO3cpHTLYIAFdlF16PRxS07dw8w3m8z0CmYw/D/vP+GcbWEjaUX04Cx5?=
 =?us-ascii?Q?dHQp72858R5Z1qQpZl9IiV26CscdNHRcYul68epSHGPUvulWYngPsGHP4cR9?=
 =?us-ascii?Q?PWIVM8Z0GQfgWHjBKlD/8DfRoBpY8xhwU3Sy40LoM0UpKbiug+oQrXpR5gcp?=
 =?us-ascii?Q?+UW7ftwfjvPqQyAGkNnd+93Y/uQ1O0BNUN14fz/VzcQFTXb4bLmiQRStpWH0?=
 =?us-ascii?Q?VbU/TJDRv/l87jPnVGl5EUJKMBzY0xZQdgBE8iHaWc13BHoXKeyuoPIzJEVp?=
 =?us-ascii?Q?h1VPc/jz9HKF0zlTxt65ReAtuy3vZXZmCMunOcuv5yQ9atI/wRrdy62j2CPU?=
 =?us-ascii?Q?obB8fPGn7L3zE+SkyLFn+kbCRqaN0ObOTDY5YTeaS1ORRmOfjGKhBzSfcFS7?=
 =?us-ascii?Q?rdDJs+nC5PsbFCN7vQGQJOsojLFY3fDivo/rrFV6byUIFSJG0msgK3LUq1QD?=
 =?us-ascii?Q?rFKSktcpkRI1xR+GHUNFq5vNFZw1RvyfrXmITIkeb713tBa+bw1+fhQ5gmPb?=
 =?us-ascii?Q?MhafvkFzso6PZyd8Br/ID/yH6pbk0P5FzcyvwbXDVEEKJB+zeQ2PBVu29Eyo?=
 =?us-ascii?Q?UGD6777ukAb9H23YfrQfKppj8WeKMDTskYOJtG2/gOIIuysHnnErPjwX3ud8?=
 =?us-ascii?Q?/TuThaPJLyrSrdqo34KO2+lLOWZUlS360/2ZJzQyStNPlXtWK9zxM/uR6FrT?=
 =?us-ascii?Q?xrmPdy2N01hK7mqEizsyYojqXNphOMl/2pkl+LzPk538E+7xWVqSVY+Zfo9/?=
 =?us-ascii?Q?QRHk9NkAl9vQy6UnH3eqWIT2SD7vjXgLO+tsJasah6whp9c/3WRKmqpZadZH?=
 =?us-ascii?Q?1zwZa0dantVekdEaH+pDbWkxWCoIOfQ0adCUcwVO46K+KS0DGv0l1mbMhDh8?=
 =?us-ascii?Q?Xzb1YY1469aB69fc6aKjqu06M7b0/V9fXPbVpA4xaZ22aTjb3JVs8txKnXnf?=
 =?us-ascii?Q?5CH3SyBT8Bidy+F4zFhCLpmFxwoAjXDq1Frqew6zvrTVXIjyM8bualHkrTBW?=
 =?us-ascii?Q?bpU2R0aLQ+cqXqDe2qR3h6b61IHAz0jwbXgZfF5iBswov11kheGCN2YstKAm?=
 =?us-ascii?Q?qT/o1HD8tB2xJu24hOS7CsX+5YW7o9rpqAb+C/RHRI+R/yLQi1ybgo65Bjh7?=
 =?us-ascii?Q?nIhCZLWodovIIHG0DEGS1RdZar1UjQmIMMDg1xjpKqbmPK0S0fy1xZcuDib+?=
 =?us-ascii?Q?We7eLBGiGcAVj/lkAMAgMSouOwOiLdJwtRovttRrZBrQHPGzWV8sOsafmKEY?=
 =?us-ascii?Q?aZBZen4F2wzX/Ezz7TmmsGrEmXjNyuBKzUTuWDHXaogCCYo+sFjwLgBcQsfx?=
 =?us-ascii?Q?VWACOxdiPK1DdRKw2WOG92tqg+Lv/k+2cJrRk8OB1XAI7R8/IYrNDPn5QKg9?=
 =?us-ascii?Q?5L8kAdKaGNG2DMAF6nr3vhZQcrLwCi2T5MRn?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 06:47:56.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d40dd46-5358-4ea2-23c3-08ddd7d9d67d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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

When a user creates a non-template rule with both age and counter actions,
both actions share the same counter.
If a flow flush occurs, the rule is destroyed and the counter is released.
However, the age sampling callback may still access the age/counter during
the free, leading to a panic on assertion in debug mode.

This creates a race condition: one thread samples the age while another
releases the age/counter info used by the age action.
The fix is to ignore this case where the age is
free and counter not freed yet,
or the counter was freed during the age check.

Fixes: 04a4de756e14 ("net/mlx5: support flow age action with HWS")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_hws_cnt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index fce7a7e815f..5c738f38caf 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -170,10 +170,13 @@ mlx5_hws_aging_check(struct mlx5_priv *priv, struct mlx5_hws_cnt_pool *cpool)
 			break;
 		case HWS_AGE_FREE:
 			/*
-			 * AGE parameter with state "FREE" couldn't be pointed
-			 * by any counter since counter is destroyed first.
-			 * Fall-through.
+			 * Since this check is async, we may reach a race condition
+			 * where the age and counter are used in the same rule,
+			 * using the same counter index,
+			 * age was freed first, and counter was not freed yet.
+			 * Aging check can be safely ignored in that case.
 			 */
+			continue;
 		default:
 			MLX5_ASSERT(0);
 			continue;
-- 
2.21.0

