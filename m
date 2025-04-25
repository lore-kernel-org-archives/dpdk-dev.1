Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44B9C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 19:41:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8472E40616;
	Fri, 25 Apr 2025 21:41:49 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by mails.dpdk.org (Postfix) with ESMTP id 3FCE040652;
 Fri, 25 Apr 2025 21:41:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNv91KhTivHaVXlRiFL3XZ923LLc9Y1GX/uGCiE+P9uLZ69q6n/v+MsXEVq4aes/p1phdWOQu1xseRPLywHSsO6KbeLLDwKnGy279cPSlikZ3Kf2SeEesVVvJy+kt/5alSrwNvUimn0yUwxNt1RPmZDgJitOSijh68vaLaxRWTHpzxBdn+u8benECdCHEuQWMEGXiZDMmvzuNyxqpBlQqfGljerXJ6jiChC6sNFyWeYpIR7w3MdvWqlpBGbqk4nqZktBowJCFuKNPI7g/O+t3TJeNfFyeBbDDoEgDrxy5OevGX1R0VQX9EBni/6KtK+jJvGxZeaE10G/EbP47I1zhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrGKEuNqBkhZwQxS5aRn2HfLec795Kufv9AX9QJ7pA8=;
 b=PsOupKdv1gC5mW/fbTHYh6FicH6J+3DG7r9TyrN3kHXoXwuxYfqFMyvDr9aAaqcqKaFoopI4491AOZy7z9ojk0B08FGCG2ddxhg9vsRAOqZ/2tfIvy9UnpsfYcO9/ELKGjCIx//Bs7dRQm33eYpfXxFa9lH9hTqQON9fYOpKGNiOpHzeztkwM6SA+TQ7pcFyzdMlUGManfnbwxWjolKPVm200xp5F8wymNHvJPS/YCo0cTTFzO73uI0GLmqLe6lCN5QGrPr1SZjeIaeNHZ9lAAgjMPgEghXG4nBfy4bP/P/nloNJe+2Tyk8HIgrKfRqD7Ae9x6RqSAmlb7g640q5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrGKEuNqBkhZwQxS5aRn2HfLec795Kufv9AX9QJ7pA8=;
 b=Pf0G8XWaiQijcSrg6Rcvg9xpciRRRtfcvvnnuHHGe1MCaqQfeP0b7U1W0vUOsU8LhxOWqWjrpsn/irkl8eqt2xh29kLpmhwKOyO0oTJEAANuA/T3p7AbhgkgkfoAv19CBy3IraiE6kZoLaWDYEYDijYYsfk+3p7afF7DzryI/N8mQCL6sYQYz/gzrXyGLXm5hmwGq5r2Qm4aoYttjjK8QuUB+qQE2FZ/RMNQ8MqD6n2F64/+ipBsr6mgMQ8iEZaAjSBA1fcPSnye54JZMi2CmpP9U8dF0Fih0kTKeDPJ1WFZ7o68Hc/qSzz99sAUDmhnkzSDX5stC2mVn7t8kdIR/Q==
Received: from MW3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:303:2b::6)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 19:41:43 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::d8) by MW3PR05CA0001.outlook.office365.com
 (2603:10b6:303:2b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Fri,
 25 Apr 2025 19:41:43 +0000
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
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 19:41:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 12:41:28 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 12:41:26 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 1/2] net/mlx5: fix counter pool init error propagation
Date: Fri, 25 Apr 2025 21:41:04 +0200
Message-ID: <20250425194105.39401-2-dsosnowski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9b26b1-a87f-4c05-7059-08dd843134f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lC2+aVU28c6UUeFS9m306xJv096nGZUCxSruLC5xLqQ3zD95TOCz/08I/Ol9?=
 =?us-ascii?Q?BYLxmn9OgWwjXbCzhPgu4+W/gOLE9IbQe/TMBj3guQh8jb3o+xHJ0rHfXhIZ?=
 =?us-ascii?Q?cNJ2lJz7tVVAfhe3qM6xBZhKzZAxfozxvEHT01BRSF3/g/eG80HJSueVpMLs?=
 =?us-ascii?Q?aErlir446v6nB6AIAIVMFQy2xyfE9kqtKqFhFYOEu2HZuW6hfItjq3r7aVqj?=
 =?us-ascii?Q?QMXMxe707Qx9VTj6Ri2XtdCvYMTpWktHRvens0HtsdX2a+bjwtjm+0XV4Xf7?=
 =?us-ascii?Q?jGsl4RVbinETNEQUSCnqR0Tmsd06+4Q0xQ5AuvOC4K+HPwwTV0pj6xqXYJRE?=
 =?us-ascii?Q?fT+TJKLWaXftb7Mx69eUNjuTk+872yV7IInQyphT8jz8yufoJO/ha8zM8RYk?=
 =?us-ascii?Q?C7RVCBdbjoUdZjxY7/KZchJtIMsqhngOvCfdTq8dloRxrGeRRdiFI5wmgW9r?=
 =?us-ascii?Q?OGCiit5OJWij6x0UmKmgGMucEhwEXIuHz9YBFEb/lNPY4XrgqRxOnrQNk+t3?=
 =?us-ascii?Q?LFzISUBtP3BS4uVOTRehy12L8PQhpgQuYeg7mFZWdv36PA8Jd1Oo8pN95fnS?=
 =?us-ascii?Q?D98gy/ejKj1fgz5pMvGKgLjKE8guKc/48gglBF9XO8GFzaMFhTdrgLWA/RDz?=
 =?us-ascii?Q?EQSac7Er8ihDtoNG1mAZSvDJtFew4sYFPBcKIm534uc1KoCx8wuAKTzN3xiV?=
 =?us-ascii?Q?jCdthHIWHAGFLSG8qMqoHf+DTSof8X7svP4mClbpCTYA4H7ies/ONSVoOEJ+?=
 =?us-ascii?Q?2avT0QWVT7PQ0E1htr4xyOky4p5e4GQqOrnotCaESBU6sHAmhvpNY7bYGdgo?=
 =?us-ascii?Q?6aTD6GnAHQeVQ3e5/5PhZUkxxB/JCAdUoy/97cn64x7WA2mYfJAmmuitbvMG?=
 =?us-ascii?Q?223ZOgYpa/wAZuobTRMvkM0sG4lIuatQiuYHD6TtF4KE7I15jyZpYSqzLmq3?=
 =?us-ascii?Q?rrafGI8t8+wMIC/3Zze7dUtxrYs8oXChTchflD7xs5WOdFd8gBV1mRkyMpGv?=
 =?us-ascii?Q?I5WXzcLBF4mxCB3hevOBqcRyDFvCePWOUf/RGXYSXX34VGHOm0jcJ4iZHYfO?=
 =?us-ascii?Q?Eokwd6PKKYwOYiZEHoVv2RW1bmupct5bZ2cT0u698owcRVZVx6ZRSL2I9aVS?=
 =?us-ascii?Q?8BzEpsQleojutphrr2t1hAGL4JY3V5wWoATSA5iMISigYigTJ8dMNxdDuM3S?=
 =?us-ascii?Q?lBF7QgRL4CXs4cj/Q7Naiz1tNraLFSLrWC2jDhmD7lgJUteX/Bj146DKe5HG?=
 =?us-ascii?Q?E4b0QbPyrObHui/zkag8Pkt2nndUxqbPTSZaLixmQSljilsujWEuPHUorFh8?=
 =?us-ascii?Q?bHTVgNo1V7cstpiwrlhioAyYO7l6HwrCuF1KTOr2jjepU+lvCwVD404zFWVm?=
 =?us-ascii?Q?stTzlpokUkt977BWBn6UDxSZCLBbxqaf0HKPGnweQxV9PadrEng8o4S0xSjQ?=
 =?us-ascii?Q?vXK3S5fTgJsf7wAAwE+/ggKPnBRQNzADP83oRBYHf40cV+23ysrJOSfE49PK?=
 =?us-ascii?Q?58c+SnnbfxCV5fNEkLcMH961d3KorzodfHIj?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 19:41:43.1952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9b26b1-a87f-4c05-7059-08dd843134f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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

In case of an error in mlx5_hws_cnt_pool_create(),
value stored in ret is used as "error code".
There are however a few cases inside this function,
when this variable is not set, leading to failed
assertions (e.g., when requested number of counters is bigger
than maximum supported).

This patch addresses these cases, by propagating the rte_errno
set by failing functions.

Fixes: e1c83d295dd9 ("net/mlx5: support ASO actions with non-template flow")
Cc: mkashani@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_hws_cnt.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_hws_cnt.c b/drivers/net/mlx5/mlx5_hws_cnt.c
index 7b5e7310af..fd12bcd7ec 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.c
+++ b/drivers/net/mlx5/mlx5_hws_cnt.c
@@ -704,8 +704,11 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 	size_t sz;
 
 	mp_name = mlx5_malloc(MLX5_MEM_ZERO, RTE_MEMZONE_NAMESIZE, 0, SOCKET_ID_ANY);
-	if (mp_name == NULL)
+	if (mp_name == NULL) {
+		ret = rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					 "failed to allocate counter pool name prefix");
 		goto error;
+	}
 	snprintf(mp_name, RTE_MEMZONE_NAMESIZE, "MLX5_HWS_CNT_P_%x", dev->data->port_id);
 	pcfg.name = mp_name;
 	pcfg.request_num = nb_counters;
@@ -713,8 +716,10 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 	if (chost) {
 		pcfg.host_cpool = chost;
 		cpool = mlx5_hws_cnt_pool_init(priv->sh, &pcfg, &cparam, error);
-		if (cpool == NULL)
+		if (cpool == NULL) {
+			ret = -rte_errno;
 			goto error;
+		}
 		ret = mlx5_hws_cnt_pool_action_create(priv, cpool);
 		if (ret != 0) {
 			rte_flow_error_set(error, -ret,
@@ -736,15 +741,19 @@ mlx5_hws_cnt_pool_create(struct rte_eth_dev *dev,
 	cparam.threshold = HWS_CNT_CACHE_THRESHOLD_DEFAULT;
 	cparam.size = HWS_CNT_CACHE_SZ_DEFAULT;
 	cpool = mlx5_hws_cnt_pool_init(priv->sh, &pcfg, &cparam, error);
-	if (cpool == NULL)
+	if (cpool == NULL) {
+		ret = -rte_errno;
 		goto error;
+	}
 	ret = mlx5_hws_cnt_pool_dcs_alloc(priv->sh, cpool, error);
 	if (ret != 0)
 		goto error;
 	sz = RTE_ALIGN_CEIL(mlx5_hws_cnt_pool_get_size(cpool), 4);
 	cpool->raw_mng = mlx5_hws_cnt_raw_data_alloc(priv->sh, sz, error);
-	if (cpool->raw_mng == NULL)
+	if (cpool->raw_mng == NULL) {
+		ret = -rte_errno;
 		goto error;
+	}
 	__hws_cnt_id_load(cpool);
 	/*
 	 * Bump query gen right after pool create so the
-- 
2.39.5

