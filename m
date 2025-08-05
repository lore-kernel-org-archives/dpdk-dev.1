Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D8AC87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 06:23:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0503A40A4B;
	Tue,  5 Aug 2025 08:23:21 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by mails.dpdk.org (Postfix) with ESMTP id CE434402E3;
 Tue,  5 Aug 2025 08:23:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aoe/7Qq2VTcpgv9krCgmOfl9Z8HSTWE0mLp1cyvV2oW+Crf7hQhwDq8YM14HrCDW9f3u4LupDsoB004ZXo/P1C1TTeyBQ3t9T/pOtuA4+y/FPJuiM8K6y5lBxZfxePfY/gE0LvXVxZDOnAkLK6vpYoInYfloxtiEXo/I+JS1Na/tddRF9M3XnyKa+y9+ZHBebId96whpkKypTIyHuz1eBYwZuqaup0Kxk3Nca8oWgjv3d5bmplJR3UjiEhSiv1M5T4kSsrtmcvNPIvStYnxfDDkg9oxSorS3G6h+y4YH4ITDluUJvjLJjTQwDvXwqzQKoywlOfcVYj26Z1KDTnMYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ahh+S8FBFrloF/xXeRxjsdNonBfweKBCmN/wFk3ix0=;
 b=fYMka4Mxp/loxqL6ClwpNvR9uAYwstvkaomnYF3U2nuwajhxG/CQ6qSm75Ws5LFlTSFENKQ4O5IRDGARP0Yp4fMLD6j+VqXeJP5P8FgwMdMjTxuEIBU2MY/E2lxbSnEMAtw8gLREyz6t1duONxbGZ7pPWyR/3ydHE+YCQxAy319KxPe250OL+RVPPnWs9Dlm64T+R0b+egfbWGMzxJSdcZebwkhEHpucrYsL1bOsTrOp/Ltlkt298Oxd3CGVpMiXv1GcVSf7T8vWTvO3MpiHaXmy9f7shtWcoRVb+O+JPXQbpsEHQGvE/TRutdF47/Av9yhy1fwBG1TBBQxQSNr7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ahh+S8FBFrloF/xXeRxjsdNonBfweKBCmN/wFk3ix0=;
 b=f5SGijDyX9LRrE8pzmEXjzjJ4u5Zxh6C5G+FDjkKCTwJhxlTqWjcRQTmjRrC4nufatHteyj8JREdWNAjC1k/oK4LSo9YI4UN4TTaEkCZXY68Pq5cGD3VJxBJ/9FDcC9CaCU/lYNTboXenYsdZXS9Tx83OculsqS4Y/WdYKZnscpxEjjjlmanYt5pVHMFDTORUhESxbFdNIT6nLpZj5sgJChoRsXUVL1+pI7ty0XJroebLKQ8Gt0RkQd2gCet70g3dxjcYt8tSqV2pYJgFlZ02I/E6IaLM6l7pSfvw4mM7ZhOCW3nqfLWftUGV+hBtHl3EgtlZYcD1f0eRHtHxLashw==
Received: from BN9PR03CA0779.namprd03.prod.outlook.com (2603:10b6:408:13a::34)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 06:23:14 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:13a:cafe::4b) by BN9PR03CA0779.outlook.office365.com
 (2603:10b6:408:13a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 06:23:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 06:23:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 23:22:57 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 4 Aug
 2025 23:22:47 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 4 Aug 2025 23:22:44 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <bingz@nvidia.com>, Shani Peretz
 <shperetz@nvidia.com>, <wathsala.vithanage@arm.com>, <stable@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>, Dhruv Tripathi
 <dhruv.tripathi@arm.com>
Subject: [PATCH] config/arm: support crypto in cortex-a78ae mcpu
Date: Tue, 5 Aug 2025 09:22:33 +0300
Message-ID: <20250805062233.222260-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 944f24a8-e100-4b0d-345c-08ddd3e88f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mtu3FS09rvNo1kMblxh7w3+iSRDmX6NY32J7EBNec0aAhFe6K7PVKG9LUNXu?=
 =?us-ascii?Q?ZirxFkVxo4pmpbimeT+IMCK0pZhXg+LLw0LOsaFZctHJ+QA/5y081Ydmq9j7?=
 =?us-ascii?Q?LDzO0pCODL/yi0ZyUNO9x0XpD1e3DMdaoSKDoTzAccW2hK1TxDsn9L+QB22f?=
 =?us-ascii?Q?CPNPSBP8kv1KzeSOR4PMTwv++TGyb7/43YBtyaSVGS7LW9m1CWmPzPQTIcBT?=
 =?us-ascii?Q?1j24hPDZwg5KIX7jSS8S4DRSycBNsj18OnejO3K+gPC95WqHcfPu4Byejn1E?=
 =?us-ascii?Q?xnQz0mRqISnBM2GS7Fmv1oBVbBB2mp0NmDqvReAi7XVlAX+L4m1ev1YJxNZ1?=
 =?us-ascii?Q?H5VoMg7n1CEloe+ekay6RIwiPO9UP0/cfRYwGo+P+tf54nqyhvJFrG0LAJ96?=
 =?us-ascii?Q?HlsfIaO3qAmfxt1sl23G6j8h4zu8AcRbzRjg8N+df7TDFSfUKI0UUcvsYt67?=
 =?us-ascii?Q?SZ6PCKWN+IFwV3dEoSTXzUrej1kO5TlJinhAQq2Vg+RnMQbbCstY+UWsT4gW?=
 =?us-ascii?Q?Rb6VOXW2z9Yp3YZFwe2y67I5bby3efTmGv+Qdp3wjxsYMVdNiuklnH/XD3fV?=
 =?us-ascii?Q?08ukrnxe+VfNxTMarGShREzh6qZYqPPXZ/vj7C2WdcEi8yJpohda5jPtIvCp?=
 =?us-ascii?Q?sWANMhsDOUC3ZN0r3noHPhpuP8sNIZhxxoeVdQSeHNtht9SJeDRx1CEcPC5c?=
 =?us-ascii?Q?SiO3NWJiqLXv64aMIpT1+EHFN2GoWHcSAjC3hUUois/S0dDjv2xxr6aIhDtn?=
 =?us-ascii?Q?Tt91knAHdykz968zgBZNTiBLI4EKOQ/usVEfOXt7Nw4QFhhqGQY6my6vrhQP?=
 =?us-ascii?Q?vjAQjedZ6teC2PqhhmC0Z76gxlZ507syK+eMq1YIDoRVwjHR09jpir9GzFV+?=
 =?us-ascii?Q?mNUDVFMtMP51D8PVciXzfXOC/gIb5rIMxlDFAjO9++O/T3mw9dUNJUB/MDAR?=
 =?us-ascii?Q?tOrFFIelcX6m/hlG0hVY4CrZU1j79flfuUiRhTrVA96teTAVP0XF2/cSuPho?=
 =?us-ascii?Q?dIrSy0FhflMx45a+EQT1R/hcyG7aro8jrYwBBm3xCOsYRPoZpN3kngFjKSDp?=
 =?us-ascii?Q?shMCxE34corf1VCu3yO0dci1ZSxk2vWC3808w1wuget+igLLhT3eRP5V13By?=
 =?us-ascii?Q?Fg4Ji8+P9J2LpplDcHkxRIgLdNS0ZOTDyV68aK5SmBtMkRqlGX/mtU6ZOtfS?=
 =?us-ascii?Q?0LvbdGJ2W6WL2/HDodkjecwfUoAVuMeSTRG9ehXWm/Eh0ppWdnBUMkql5fsk?=
 =?us-ascii?Q?dz8PI6jOy7ctZofXu+M1kuSqIWqNb7Q4y6Z+38SGB0CcjPwvkdAICWzZ3eLL?=
 =?us-ascii?Q?wNkEszOfq7quZRxThhskGzD/KU7dbLNFcpuuC1p//SjSfofWIfQPUKjLeEAw?=
 =?us-ascii?Q?Vx6YL/jKfpLLtlimIHb58sHT7XXqVfPp7hwIhgrHKs4oEVhfKWfnob6bHJSP?=
 =?us-ascii?Q?l7oHuHRhDaXekCyqGd3pOcWSD4QeKlBLJAIgXNJgCVNte5cMBMClOUcB4koB?=
 =?us-ascii?Q?K9Xrl30DdanJ+Dk8GJSFcR0EgDrTLfpPaNNO?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 06:23:14.4586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 944f24a8-e100-4b0d-345c-08ddd3e88f4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944
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

ARM cortex-a78ae configuration (part number 0xd42) is being built
without the necessary crypto extensions. This results in infinite
loops in the crypto performance tests applications because the
hardware crypto features are not properly enabled.
This fix enables the crypto extension in the mcpu definition.

Fixes: c02c01dbf907 ("config/arm: prefer strict use of -mcpu if supported")
Cc: wathsala.vithanage@arm.com
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
---
 config/arm/meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 35b7553e74..82661b7cfe 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -84,8 +84,7 @@ part_number_config_arm = {
         ]
     },
     '0xd42': {
-        'march': 'armv8.4-a',
-        'mcpu' : 'cortex-a78ae',
+        'mcpu' : 'mcpu_cortex-a78ae',
         'flags': [
             ['RTE_MAX_LCORE', 16],
             ['RTE_MAX_NUMA_NODES', 1]
@@ -689,6 +688,10 @@ mcpu_defs = {
         'march': 'armv8-a',
         'march_extensions': ['simd'],
     },
+    'mcpu_cortex-a78ae': {
+        'march': 'armv8.4-a',
+        'march_extensions': ['crypto']
+    }
 }
 
 '''
-- 
2.34.1

