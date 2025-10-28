Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1782CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 09:27:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2458440262;
	Tue, 28 Oct 2025 10:27:53 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7]) by mails.dpdk.org (Postfix) with ESMTP id 9FD8E4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 10:27:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVJ34xRAaODjsYOpStL+Q9yyngyl9Io4CLJpFpPXAa4rDpCi9+iTWozNkgKwC10BqTnD+cmJY8232k9uWV12lPbGYbeJ3Mq1Mb4zApJaxv4gK/heCS+KEu1C063wPHYycyn8czFKN0b2aG+jQQfly4kFY1PZyz3qdv/qdTqz+OQHnl5OKkBIf2tHkTHnCx83Z+1JEMINRyCBFwbTN7/2XCobc9Yy5GA/On3jYKXDcn2C2sRnBqWG+78shsOaRe3BIebYDE7mzBX7daAC1HDoPIktEwVJoTKjApWFKXb0kQsLgLMOGwC+nnMGIe7k43YAKsdWML2jT3x6dkdw7TAkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDfVuS5L46GEdJ/skVMKzNe8jEFLwuApRdt/VZgRwfk=;
 b=JBh448sZ/AQNpx29G8UKsWRZGtkvU3V0USTWaD9dqekUNf07fRn2E4V5SeZ4BHqwcSoaeio1z+rg7pYanok3O5sdc7gisf79rQ8J+51RYnGls1bD8pqJkzC36du2EXIV+yLm5vGXEDgWmqTcNz7oYRIXFwaNZWsNdMuby0bJeOXRLxNMoqJkaqlBXnG0xc4O9sXloAiFHXNytmtjarsjOJgWZ2Lyg5vz3vEReHCOEYw2ove974zvNjQt5iPJHYczxrPj8a5xZo1qeEYNUt8u+DVhicDZcKV0tAdmiX+A/WDnfcmc8sIoiBjXE+HhytDHIY8PeNBMrjl38pWDPJciUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDfVuS5L46GEdJ/skVMKzNe8jEFLwuApRdt/VZgRwfk=;
 b=hBicLDIK6rBqngDlf71aeY9kya275FP/1ecpFczV2ldCbWV27vTgKWLYYSpP4iy2iAY5vzRyRq+IMavlwS9ivBb/oncbG9dOyTC7QTrVABlWPEIa9pLFtGAd72XVjTQezL/Fz9V6I45M+yHspIUSdtwA3E8WaNPeLkHWpUln7QcoXVbW+Ctj4nRdibUGJ8yxXcLBAnJMC+gGzb5i7Z15Uks2zmzrytnPS4XuY9uAkJVBXfexUNr8rl/sU2uxzw/mWK7rMVpi/Twa7nPwlgMXqTdV+EHN8k+H3ngQZxXfEdsRch0cJdBqaqp2D9L8ynqUadSLvFHkY7U+gUZBzVZQSg==
Received: from BN9PR03CA0619.namprd03.prod.outlook.com (2603:10b6:408:106::24)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 09:27:45 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::39) by BN9PR03CA0619.outlook.office365.com
 (2603:10b6:408:106::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Tue,
 28 Oct 2025 09:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 09:27:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 28 Oct
 2025 02:27:29 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 02:27:26 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: remove counter alignment
Date: Tue, 28 Oct 2025 11:26:11 +0200
Message-ID: <20251028092611.1755141-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b94bee-9e02-47ab-c108-08de16044073
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hsIa8fuJWp61Hv4t3OXT5A6IbkKo/TZdKdIxTW7yDIR/9sX01rvgAWOsBuWG?=
 =?us-ascii?Q?FV4SAjSJDZ7g4yC2iGUdPZ+Pas+6UvR2tI9F6hbPHIyW2BagOS/qYtj6azOD?=
 =?us-ascii?Q?sMMYkack6mAfERAFjewWMDkl5E4OpF4iX9xD/D8FHfr8EmOJup+H29PJHrmK?=
 =?us-ascii?Q?P36T4kG26NzJz5QiUYBHCA6gdmB60QDyEOfQ2SQUM1+oOn6w9fmHN/GITcnW?=
 =?us-ascii?Q?q8T2ThI97WVBwIaVlC2Atwo6p0SB3mwsLcnZl9PxFM1Jd3tOcXQCha6FkrFZ?=
 =?us-ascii?Q?Eycu8BwqIgaCO2AuEjrK0h5UShs5jm01ySumOX3FMKfD0Vmi+Zl9DOqbqxrA?=
 =?us-ascii?Q?fQkjNtLxVfzY99fIZ1cDQu1tMtbZ8QmlD/MtEw4ve6ATLBCy5qxCgvOE9n0v?=
 =?us-ascii?Q?ELVwkQiPLDv6/Exm80n9YEICxL0SRAh2etyzZX35JvXvYhop8fwbGw8VrA75?=
 =?us-ascii?Q?KNli6KYsN31vY5Shl7jKd3fhTe1H0iyKm6p+kjtCKFeUQTpJx63unfnFG0Qv?=
 =?us-ascii?Q?TxHAerC5hNAGNtA69UfEcLJJTdo+sOI9ETVtFA5GmZ2xUFnkgnuOIL1pNKRg?=
 =?us-ascii?Q?fh0mIVOFxplFksjVbwtPsTrD/GVdtNeMOp9fXGYLyWbWx4ft/hP0XQQCoZj2?=
 =?us-ascii?Q?qzt6wPlLi4ZOw0qqL8rFeEV1UiQ8kKyZJ7Ba3/BDzHR5A5I4k/l7spf8WUPO?=
 =?us-ascii?Q?XIpbkSP8xllsHix+ma5K4FzZ7c5SAwI/qaAxTFUcJZ0/IAkfGv8WLDXaxva9?=
 =?us-ascii?Q?mDDO0qhzTPg7FDbjo40q7HfPitb5amBY0W5Y6aZ1c9TdqXGMDJibDUrGy1QS?=
 =?us-ascii?Q?aQYV3tCqwxfBv5nGoaZFhVtbb6LlG8Hr9Dwmw+a5LZCM9Saft4r4dhAmm9pw?=
 =?us-ascii?Q?R4RY6AVa/TKSvIQtunae8Fh9ti+YN7FZAZXJSX3rhhVV+jLcygzGcKoXM/0n?=
 =?us-ascii?Q?kLOk2NW2k1vRjXaUqJht/O72ZP3alBx4C+EvuWzl88trJ9AmcLnRWpap9HWo?=
 =?us-ascii?Q?x4p9QR0zeMcqtOpVVSJnz7I8YZIRtKcl5ffGZzAq8XkrY9PoVcl2ORCblqCO?=
 =?us-ascii?Q?+swtPzPfM22rN/nNFPU9Wl5w7lx9rJL32fx1AuiisUAu8rCUcud3ORPQwFM3?=
 =?us-ascii?Q?zr6NN/+0BwBkrsjCePaS7WH0hiSG1j6ovk8DDbBlek/0Rp1dXCJZSkLZK3Fn?=
 =?us-ascii?Q?BRuOsBlf4ACasiB33LeehwWqlTKr/5RTq4g9C0dFi0bBg1d5xjv2JvLIx5Xi?=
 =?us-ascii?Q?lA5lVMrO4qQuFiKCIAQgx2TmGFHVUsUy2TZ3UvM29qaT+/xNgv1v1690iQLz?=
 =?us-ascii?Q?QDF4AxYe1wkEDERXKjv7Gsy4DWWcj3TlkYbuEmD79jrgN9yOEMs8I3tZiBij?=
 =?us-ascii?Q?tlAhBcLoal/JXC6iB9+16yTZxor65S8og6OPabUlQ18q9QZwSpA1ev7rTknW?=
 =?us-ascii?Q?3VsM3b+DnQ4W8h6ZvZdzYbXpGmMRRu/srONUqF2+5C3DA8Ojuj/3r8fHAP64?=
 =?us-ascii?Q?GJUZLwct9bqUWJBw6+udWASkV3wuGHNH5uvV8qL/dZwiDN8mP3lolPj9BA3m?=
 =?us-ascii?Q?u1KX9ff32zB8eUcuNg4=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:27:44.8291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b94bee-9e02-47ab-c108-08de16044073
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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

The memory footprint was increased due to the alignment.

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
---
 drivers/net/mlx5/mlx5_hws_cnt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_hws_cnt.h b/drivers/net/mlx5/mlx5_hws_cnt.h
index f5b7e8f643..d19a7bf37e 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.h
+++ b/drivers/net/mlx5/mlx5_hws_cnt.h
@@ -43,7 +43,7 @@ struct mlx5_hws_cnt_dcs_mng {
 };
 
 union mlx5_hws_cnt_state {
-	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint32_t)data;
+	RTE_ATOMIC(uint32_t)data;
 	struct {
 		uint32_t in_used:1;
 		/* Indicator whether this counter in used or in pool. */
@@ -64,7 +64,7 @@ struct mlx5_hws_cnt {
 	struct flow_counter_stats reset;
 	union mlx5_hws_cnt_state cnt_state;
 	/* This struct is only meaningful when user own this counter. */
-	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint32_t)query_gen_when_free;
+	RTE_ATOMIC(uint32_t)query_gen_when_free;
 	/*
 	 * When PMD own this counter (user put back counter to PMD
 	 * counter pool, i.e), this field recorded value of counter
-- 
2.27.0

