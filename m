Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80FCE9D404
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:52:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07F83402F2;
	Wed,  4 Feb 2026 16:52:53 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46]) by mails.dpdk.org (Postfix) with ESMTP id 78641402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 16:52:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhriH6MgtzuQ6IgBwr4Wod27hZX58KaqUpwWqLY78u+KyHQOCo1DausKzbeJHxk4ePoZMXRT7Ts02KKk6ORynRf7B0S5JbuPyOTjakfgp08kt35NaFC7uOwgpFks/nIsgk/uRrzPFqAxbQ1JlxW+5ASDJioST6SwdfPYkAobc80LfxtqGSNAhSbt06bvZKM9jNpWWOa2FDSLtxYnFBe8zUV0WAzBFiszaKWbwxbq8pOLL3c2sSh1oFcPIFeEBxtxjH+rTg42si1Yp0/yRWZwxxxgNVfC7hS7EKWgkk0nrLXTmvvWR2E2ioZOC5HQc72AMyfrLUw4DefbvoFZEHG8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmqA2d4SArX1868rvpAAT0dEgUxj2n6/aIa4iH4cjBA=;
 b=ffJMAqfkwSVDIcg0Nm+vG8TYvTek+vikZbIrj4mLFU39ZZ2aWzSjE1rsV+Xme4xcTrwktTGgY5ItgO8oyRShel4uKS7e8Y72pQlIYKsJ6FwdaWLFASg+7I21Vpz/KV5bujtVDnjrj4UCVx1aFFTDtYxu68jheMRVUZwQpAe91qZnWWXCjC5Z9ddVTrfoHNWf7bqSPjASuFW1IVEBpQO1iBJYtrhG5UP+82mpqN3FxnmupC+nWs7aQQ1HgUXHDGFDX09HAJKVPUBB4jUzsgkWBkRR7mTwGPnCn8ZNsoXlsggLIbAdKpqO7F0nv8Qx6UlA/ysdEjcsAmZg2LT98+Rsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmqA2d4SArX1868rvpAAT0dEgUxj2n6/aIa4iH4cjBA=;
 b=c91oOm1YBAsUbesRIL8VTrFBdccLQume+bsDYF1gM3RTsDRvB53gL37YaiTxpEoXkE7/yvn6xd0kLnSxTj/c+eqeXuMy260sO88H3b+R13UcoJwiV2AYxQ01RDHvWFwRkR23QY7ZjOI03Gmw5l4t4G9nG5sik54O+KDMcYPYwlgU4QSadDD74xxHe8FPr9IpJQfMeXGA23V0JuObl2nBQ7SdXNDPIqtuQq5kTYA6ef+bXoUru3hOKjHCXHqcauwCtSpIFhc6t2FExNletVGNRBm9phUtH/eZvWks8PELquCXKbe0NIKhfNag9k1Zvs54/sh8N7fbBbvoONq+muFBRQ==
Received: from BN9PR03CA0356.namprd03.prod.outlook.com (2603:10b6:408:f6::31)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 15:52:44 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::59) by BN9PR03CA0356.outlook.office365.com
 (2603:10b6:408:f6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 15:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 15:52:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 07:52:22 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 07:52:22 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>
Subject: [PATCH v4 0/2] support dmabuf
Date: Wed, 4 Feb 2026 15:50:07 +0000
Message-ID: <20260204155206.2345189-1-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203230338.1066297-1-cburdick@nvidia.com>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf64e25-6657-46e5-2e9e-08de64056f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iSIXtTjAbndhwQBPKEsaxmMfFoqDXgEZ6V9FhrkMmU9iG66ixMEM8lnVdYgU?=
 =?us-ascii?Q?bki/M/w37yju4D1lOqg1MJuvQpQS0Fg/XuwD8tihiFFXM83+u7o4zuOPGOxI?=
 =?us-ascii?Q?CL62UCEYNEzDipPWIqYkc6YF7kox+wCjzxuSHq+ksQBnsEafa4KpeDhUq2pO?=
 =?us-ascii?Q?SyNIyloHfRgDpANF/1UHuBOk0jB9qlock17Ar/BThiebZAgXsLeBzj6PCeMU?=
 =?us-ascii?Q?5TdYY61sH5Pk/3nePW0cyrx0xvVvTwZU42pqSEOTx2eNpeYdDoKz0MiiZoec?=
 =?us-ascii?Q?puGeVC9gVpg8EKlRqfrYVsuTDeSGqNj0uYN4qCzqtsvbD1kd0m4676ny8afh?=
 =?us-ascii?Q?Xkc/i2KVSMCJc1TTjArU/ASOy2mHcJWBwJ9fC1AI3hOXfA6uR6rjlDk+4v/W?=
 =?us-ascii?Q?B6JK48Br4qZrpTZU7C1FUgcmrAfWcgqSKZV/X7xFOXTLOJlBgAajUIQ0vL7T?=
 =?us-ascii?Q?Cq4JVRIpOKdAg1hgT556R3eEBWhNiRzIU3EBICbsgKOX6GHx2DH7GfYmd8mD?=
 =?us-ascii?Q?P58gaAU8ck/j8teLZbvtyS5LettgbGDJv0FJpcJMBsAYDyNIgwTvNp+7rTNx?=
 =?us-ascii?Q?tOvDsz4wDCJ33aayw+uRCQFV7AfDKR3RptOIFVjMOpoDhpOFYPsZL5dj0rKT?=
 =?us-ascii?Q?AUCowFK3r8Ahv7STQUj5snv11YPR35ijqRaTGFxvfcA7yDjQCE96pj/U9269?=
 =?us-ascii?Q?1MCFvWMJOl80x06nsnlzWwBkXshVqZlU6vQIvGfGCRi0Q5VmzjQs8QecPL4g?=
 =?us-ascii?Q?o5ZoSGmFnClNhr07yKBvVCE6ySujgOXT0POfHszPtPXnvV4XgSmS4skctXuy?=
 =?us-ascii?Q?XobnNu+2Vc4bOmCvZskVxyQ4hQ+P5MOfmcoaNHKbNZiDcbMob6ArRk0Xrru1?=
 =?us-ascii?Q?A0V6BcC2OMb3ZrEO7D1kaJcu4uvjge8AzGTX+DExD8o6NR/3V2GlhoH3+WKG?=
 =?us-ascii?Q?k/1iw2+5QqBJTnTXdORd71w2J6QgpXr2ou5nPSmy1hw88D6ICbSgwpt/Xco6?=
 =?us-ascii?Q?urzMYuxQlSqpJJq/cmd3E4fR7LcdJ/gMLvkCy+2EyivzmQMVUJatOV7O12Ot?=
 =?us-ascii?Q?Yep+GhvFnU2oLBUXHRC7FttUGEoUxY5IaMBq7wDXZ+NT1HZ+9ONxZkYIOSVD?=
 =?us-ascii?Q?5fwAirEnqOCZH+oDpNiHDyZiVd2mlqq8IFxNuRvj6AkbkyCdefO8bvyel7RZ?=
 =?us-ascii?Q?cJLCR63WIm03ibdYe/mLK8KffZ0tP8l6tGJgJSo7w0m6uB/lL8IcvE/QXCfl?=
 =?us-ascii?Q?UChUMTrmxu87PRO/m1bKjwprjH49YYppG7rqU3yc7HPIMj417p3k/jWdnYfy?=
 =?us-ascii?Q?eLcRN6KJFVEGa1pLpJEz67IU2bFwmPugBpYPHCRa919+LZ9d4ovG6TDvJ27k?=
 =?us-ascii?Q?/uFu6y2s4wjEC2jJ7x3jvVuOCXzvCM+CrCaavuNfynNSuaqK7lcdb7mgOIsm?=
 =?us-ascii?Q?bqFPibbDp5/jT3z/n24InwSRCme7GuDBb1uS+t131LRiOEb44WW6/2AzVOkf?=
 =?us-ascii?Q?NlEQSnGJzLty3XrFaeoJG86d+cCzwKlNsO1U41Gxm3FQAIcdAt8KeXbfYZH2?=
 =?us-ascii?Q?Ig73mAzap0HmLhWUBt41kOGDMSnv6Hx5CwWYdRvi00zXurheUpw2wYtAQvKi?=
 =?us-ascii?Q?VZsLbJE95L+O56IpU5qfiJQrWhj5K+9//KYrE3ULA4915qPMWX4eEQ0PzA9e?=
 =?us-ascii?Q?Qbcq1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4mTWUvzRxoQRiAs76OBluK4MchzZ/ByZxnd/7D921x+G7jRbK3LrHraIEJLuL+XCMMy+xuY0Y1VCMiEhVrQXyv6eV5U2lOLLUmoDJm8h2n35mwzVFpZtFKQm5MVsjVLO3WamAz2JxJG+uuhiqfNYlbakkysNWW1JlhV2NGXrETLXK+2X/QDgzDvzaw+ytR2UDn43dCxjXKxhlgoxCZx8zsE8WnUwHz/p28FO6JdH92dPVPRUk/sT5qTr/ukHZVCauNj6Zef7TyAH/EMClPk9MBk3zkPM3aNZvbb1UIDER8LPfQXkGJC3u0id0mGRKZ5sFXE5s/dOqZwICPlmYqsn1VkgikYYc8a3QR7OCcs6bjEG15LDI9I0xJ3L8E/nNV4CHNJhT0KhAwRfbjqIU+2SalQJgVgxFAjN7haehSzDW2E7FHpSeLo4bPGeObhZLfrz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:52:44.1105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf64e25-6657-46e5-2e9e-08de64056f98
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493
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

Fixes since v3:
* Fixed version in RTE_EXPORT_EXPERIMENTAL_SYMBOL

Add support for kernel dmabuf feature and integrate it in the mlx5 driver.
This feature is needed to support GPUDirect on newer kernels.

I apologize for all the patches. Still trying to learn how to submit these.

Cliff Burdick (2):
  eal: support dmabuf
  common/mlx5: support dmabuf

 .mailmap                                      |   1 +
 doc/guides/rel_notes/release_26_03.rst        |   6 +
 drivers/common/mlx5/linux/meson.build         |   2 +
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 ++++-
 drivers/common/mlx5/linux/mlx5_glue.c         |  19 ++
 drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
 drivers/common/mlx5/mlx5_common.c             |  42 ++++-
 drivers/common/mlx5/mlx5_common_mr.c          | 113 +++++++++++-
 drivers/common/mlx5/mlx5_common_mr.h          |  17 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
 drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
 lib/eal/common/eal_common_memory.c            | 165 +++++++++++++++++-
 lib/eal/common/eal_memalloc.h                 |  21 +++
 lib/eal/common/malloc_heap.c                  |  27 +++
 lib/eal/common/malloc_heap.h                  |   5 +
 lib/eal/include/rte_memory.h                  | 145 +++++++++++++++
 17 files changed, 612 insertions(+), 14 deletions(-)

-- 
2.52.0

