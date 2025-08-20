Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDA3CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 09:52:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B8A8402DD;
	Wed, 20 Aug 2025 11:52:30 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by mails.dpdk.org (Postfix) with ESMTP id 00EF640292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:52:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJsdRv0sgMhhJiqywrd4cUvagB8wXaXoykaaI3Jo2qSUuc6pdJUj+hm1NbAgnuTZ0bzGzxbKa67k4zbqoRujaYJD0MHnZoGhF2nJGPN7j/zbiKX1cq52nMEwKXX/ajEQC0TVAIto75hK8+wdv0j6lgz7NOZkZ8pR+a49s6i6eTSlcludGZPdzJPP0J+hvNCiJ/Wr3f0Rn/s/T9IFKO2BgyRFT07zsH+VS4HzPsLw//sqlNqNpgBFTy3oD5FXy4Rf7ry8xI2T0DHm+wWzCUNNL9OrDvfGi9P/YHYfBsZHUokNaZMXuUqZLdW9I/HgEyQBqIlSo6zU/61NyOnDP/ndaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFvOOZmTck7CU9C9xezaXjqG/+uQklBecfyghLNrdqg=;
 b=SkMPpwt6KF6c+M6pRukygbfKppWfE5wPd0RF40M+pw4Gvwt/0bpJJVd4cCKF0CRi2whgT90jcE9saaceSADAuK4QAG/2eEeq9205F0MOCKKeQ2Z7ETBsKpuIHJuLAAS4xgABoSNyITn1D7goMX/UU6so7ldSA0TMEKhmHb53mFUVE1waoY3ECvestSGs+m63sJVSK/s4R+00JlDImdupHR6yrG4zyn7DArj3p6A44DWESa1u+qbi+wHv0jkOCSR8M1yi+CFjF0fJ5EA2KaDpf+2KKcH/isZpx7EK7XIpB3084iiOoTUYSKeKVXzIEzZGxgHx6iaMvd6/E3K85VY8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFvOOZmTck7CU9C9xezaXjqG/+uQklBecfyghLNrdqg=;
 b=X/Cl1EjQn1x+ql+8ucvd4Cjjwmqn6csrBF0Yul8iTUa22VMeL4XkrgIHFzpITwU9Q5DNUqXLxODGBwbL5BqibFioqXVVurInfMX0k/j3AV1RbASWPm/3PBicxZcNDSV5z21jEPHVetXQ/6BEqfxh5QiurFEoec2S3Ybo2Ak3mxxcmkoLUIvBoxuugAPgiafGEa6SLfGn5uxl/103nmVgy8Hsv5j0YihssCQJUcrekKQ2f1A/uEu6fEN9OUPbGGiqh/ut3rrkiZ67yiq5U+FFnpRvdxRzEXAWy3eJGWrXztSNr8FH4zsl8mEpFEqRIyRfVDrBbO81v4Rommtv1Zm52w==
Received: from BN0PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:143::25)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 09:52:25 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::ef) by BN0PR10CA0007.outlook.office365.com
 (2603:10b6:408:143::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 09:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 09:52:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 02:52:04 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 02:52:03 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] devtools: ignore new warnings on reported-by tag
Date: Wed, 20 Aug 2025 11:50:50 +0200
Message-ID: <20250820095050.1090859-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 829565b3-8579-4288-62fa-08dddfcf4416
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yG58Y5iwOsVYmcPMVcvico8zcmjifse8B3PM6a0VsKNsAldHuAEfEgYLhD1B?=
 =?us-ascii?Q?WKzJepMcv7uczbqDH6h/XYc4Ou2IgDpPqPdZc3zHmR/urNTHfTt/zf9o2pvW?=
 =?us-ascii?Q?nvaAFv9lDnWvKAptvzvA+7lwMscUxVA5C65XP4NWDZYSZJI+IggcHSZ6A5dK?=
 =?us-ascii?Q?3khvf/iUUzMbm4FXyPczHK1Y5kVWJEcr/biIa4t9LsSMoK5tziDiFMxAry6K?=
 =?us-ascii?Q?nQZX7NZPM/VwjEQFjZZ6B6gJKf55xM8H/7te5kOqCsDHl7ED72f1bX6jkOe9?=
 =?us-ascii?Q?MzQMb+KLp4h5OHWiV9MaleBTvIUWeC6fGRHaGMq7dcaf8hwmx+HVn0RGoFdk?=
 =?us-ascii?Q?PvZO87gsge4Wjp81Iyw56aEOEyrlKj4/yM6lgF5RBtsxbWw9ohC6SDrxHyg7?=
 =?us-ascii?Q?6ncDcRC1RaFN+8ovX6D/pGaKk8RFFik4NEusizwJPmomXfxa1X2oYYQurRa+?=
 =?us-ascii?Q?CHBThonglhGzmEmDTvEUBC/Y/QdflVaO0h0/9v1Nav1cwTWXKKTHCD3yyYHJ?=
 =?us-ascii?Q?zi9NtSo8/uubelclI3sXxjS/HLulCfl6CqHznXfgGifoNnywSkYGvZ9KWZc+?=
 =?us-ascii?Q?3yIIhmt1wIyQD/sgmIabse/6Ay9o43bv6fva7hRbjXZSWthwTXCHhDz1G/iK?=
 =?us-ascii?Q?BxuF4fNA75SUEW/LpyD73lyPsSlGZIUylWJfKGJodPezwGCP2K+8ylsBzkIi?=
 =?us-ascii?Q?zIBqSRUIDeuZpbkOCb+XPRYW8np6d2WDF6VnAC11a8Off2kqHwhlRzft890S?=
 =?us-ascii?Q?ahXa7acdMP78yaPWhLnpjjiXfXIFYdNqUwILo+wemPDJ19KP6pjiMUv1qhTT?=
 =?us-ascii?Q?npR9LVRaXT7uzReMQHp/lXiMs+vUo8Ucel9tzX2GsaazyMQavx6/WOENc00p?=
 =?us-ascii?Q?zAofaKqRmAY4vSH1xjtWsNd1hIRx5RUi7z/EbSX5uJ0kLw2jUJKjm7gXHID4?=
 =?us-ascii?Q?WKuuQVmraG5qaI8MHzz3m28BAKf1aEQ1szA/lE+UjXUfuwiVEa5KFufi4dCs?=
 =?us-ascii?Q?ottfQZUzZb7qHRQyanZ1tMbteR4rg5XdCu7FrFs1lAKCGxd1bGfsNwd3dLIz?=
 =?us-ascii?Q?pkbwe1Q0HuuVGKX5QkZrkX9IpwRgppPXQ8616V6vWcwQUFnPJloLpOPuVy+5?=
 =?us-ascii?Q?koXwgdjeuDTXuDf52gvPo7kPjntKlHPoYIClAOmEB3u0Uoxee+ZIeOZQVST7?=
 =?us-ascii?Q?x761ySm13ul3HIv5PcieHlMxoyWkKZuiGSW5CVRZvzBTZq3yHx6lhE4Ezks0?=
 =?us-ascii?Q?J/aCuBxBeT0dQ3vpEv5jNtS18gnD+lzcoYIUwhSAspq1pQibrpu9piw8euVo?=
 =?us-ascii?Q?VIgXVPw5yiatSh+9met+JB+CqtNHgrK/bf2xTAdPl2rK9G+GhZE4V3wqtweC?=
 =?us-ascii?Q?qKtUgyTU1geCB3a0qLOYE4Fhe0eK+TNIRw/a9hYCg2WEZHqqaPvld8ioqj11?=
 =?us-ascii?Q?qkn+34Fssw0gaJEhiH8mFYC/eMy9nBbu2N4j+BtdL3UesEGXpg1t7YzualA5?=
 =?us-ascii?Q?diUWaQ8iCh+qGhlzw+CpFKGc2tF1nkytxDrMRvX0ktFzKb5Nn56rP2pT1w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 09:52:24.7790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 829565b3-8579-4288-62fa-08dddfcf4416
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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

There were 2 changes introduced in checkpatch.pl script [1][2]
which verify if Reported-by tag is followed by Link or Closes tag.
Example of the warning output:

    WARNING:BAD_REPORTED_BY_LINK:
      Reported-by: should be immediately followed by Closes:
      with a URL to the report

Original purpose is to link the patch to the mailing list discussion
and/or a bug report.

Since in DPDK these tags are not used, these warnings are false
positives and can be ignored in devtools/checkpatches.sh.

[1]: https://github.com/torvalds/linux/commit/d7f1d71e5ef630ab9e15b5821d297a9e1a5fa1da
[2]: https://github.com/torvalds/linux/commit/44c31888098a590b8ec5ba37009e5a983f7c4b46

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 devtools/checkpatches.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 35037aa8f1..8c5b5d1380 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -33,7 +33,7 @@ VOLATILE,PREFER_PACKED,PREFER_ALIGNED,PREFER_PRINTF,STRLCPY,\
 PREFER_KERNEL_TYPES,PREFER_FALLTHROUGH,BIT_MACRO,CONST_STRUCT,\
 SPLIT_STRING,LONG_LINE_STRING,C99_COMMENT_TOLERANCE,\
 LINE_SPACING,PARENTHESIS_ALIGNMENT,NETWORKING_BLOCK_COMMENT_STYLE,\
-NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL"
+NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL,BAD_REPORTED_BY_LINK"
 options="$options $DPDK_CHECKPATCH_OPTIONS"
 
 print_usage () {
-- 
2.39.5

