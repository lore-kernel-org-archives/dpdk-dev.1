Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1949EC36008
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 08:18:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46F47402D2;
	Mon, 24 Mar 2025 09:18:47 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by mails.dpdk.org (Postfix) with ESMTP id 8BCC940151
 for <dev@dpdk.org>; Mon, 24 Mar 2025 09:18:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLf8Ba6zeAOYKBf4Unls6y+M0PPs9eA1QEhV1RrRMVfyEljjO5YlRDVwRJS9Yuvu6a2zXGCxJXw0fb4SqqQacGTitqSoanvuuaIIdLBvVvRrQ9V5UQjaGGvCuld2FUXgDXsX6WvNMuEIeNavRZC5GOVQE4ggd3nsdXNhWfwQd6Sg44OmHbXAmnnjuyjhrfHJXvDjs3gM2kFpD6YRAUawgPImhoKZuhwFZCtrgMxcm3mpprnfZUhLrgJvbXZSJrJM/YShBt1tqeMi7fhPmqKR0szsGrLL9iD1Z0iF3j2skB4alMJjvAlsEpMKauX8cGeTF/KWxWoREVGHaEUG1WffyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAW9l5xcxR6CRmXRdxSqG8iKmQ3tZbV/Sz04DRFXeWw=;
 b=gUm2B42BZTkc6LpHW2Sbv7AkY74rBYJ7Jj6piSfKbaADO6GQ2y92bJZUtb8C9Y+iJUp5oNiIyowuvMPDDJJ1VLnNQBibHrp+GdFzM3Z8Z7/9TM5lwqCscrT1BV9uZkamo8sjBoAVxyNRjN/d6fBD/obMS9aNk1SSxOt63uwxQ9Y4iWSb+m/sid5IwoY5Yo20AAuWCkyR/OVOBgzaq1bgc1RsaJJe7iBRJPgXL8ykhsijD+CNJOESjzgQH9c+BnbeWcr4fMl/9GUjKl01+Qq/St2h8fw+KxOLZjt4Km1SRRastZ8J96fJtIUQ2c+LipLx2FIn1TaeSzBDx1DHoLAxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAW9l5xcxR6CRmXRdxSqG8iKmQ3tZbV/Sz04DRFXeWw=;
 b=joMOscngBo/x+8k2PUvgiC8edIVigTmcqvWwlP7gFgLZlTmHVNp6yP5xQwBIaoNZsgujadYXK76G9RD8zczHnaQNweuNbMz8OAQaHBQ97dHI++uJAJBpO4zm9NQw48/XiUqMbZ22Gq7wnhSDT/UYILZ0Djr8pn5ty1qtr/5AakXfd8KhS8ugQd6EfT3/kKXIrLDEDAr01qLvlZ12znmmxcGr0dfncoXnXss8cc2WO9Mp/SXVJTA7PXg/2adQ8IlVZ3yhvI9RM/FDOikEv7xjcPc47SvDJGxph6mA0h7cKVF3JbkgYyyktVBEX06c3GjNXiH57X3O+QwWACI8/BuypQ==
Received: from SN6PR05CA0024.namprd05.prod.outlook.com (2603:10b6:805:de::37)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:18:43 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::63) by SN6PR05CA0024.outlook.office365.com
 (2603:10b6:805:de::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.38 via Frontend Transport; Mon,
 24 Mar 2025 08:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 08:18:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 01:18:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 01:18:29 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 01:18:28 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH 0/2] add debug capabilities to ipool
Date: Mon, 24 Mar 2025 10:18:22 +0200
Message-ID: <20250324081825.231395-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f58d51-9bcd-4dd9-029a-08dd6aac7da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kxhopl/zos3WmxYgdRBv3ScH/na9A6b/9knECKKXpajuqDvzq82LccDfh/mL?=
 =?us-ascii?Q?g7Qx9ndP/3rKca8w7Tc8Hc++2Q3EySiZ6YLi0SzVrNTdgXy2g/iabMkJ/2sQ?=
 =?us-ascii?Q?UvSlh+cRM7Bn/AoR9KBQoFpRpU/O6sdge8YiTFkcVWD6Y6YNTPrPJ+KL389k?=
 =?us-ascii?Q?gdSvG86Sgm7/E1LG682TGNTmu7AUrH1yUosMf95Eb0Q5nPtl9daeb9nrfsdj?=
 =?us-ascii?Q?2FgcbrqPrjqwht9+2QKOVhwfNjfF+4frWh6khH4WWmYTJQVjAVBnu58oUW9H?=
 =?us-ascii?Q?yYTvB5ydTyLmD9AsT01k+4V9C5Dlduae2eJ6fhGvblWMNgwMZJYudl1T+6Ml?=
 =?us-ascii?Q?HQRC1s4mSBx1pxY5y5H6TnOpf+Bk2UUH6HMotpBR61WfU2PSCdF4qFvOZv84?=
 =?us-ascii?Q?7lTCoFNpuCQXqqz4V1aMIcwqyHLV+IAsoq1HgShqUqjxuFzmW2r5hDPF78Jn?=
 =?us-ascii?Q?CDNFM9mgJR73lvAEApKRrqJPjdtVsYGzb0kdxd/5a81otVwqQSFxicnddNtF?=
 =?us-ascii?Q?AWYXUiHj1diab99boBtWzWLgJ1NtH/ZvL+UehjkFUuftaZx8sli9rhQKah3R?=
 =?us-ascii?Q?d5KwFkhncat0Gm3Nvvh7NvPB+BmFijRPSe/OR03INEBgf2Hyn1DBnjOBXExq?=
 =?us-ascii?Q?AGROpcy8ayjgAb6BGx8j4euTuUXZA6qjXn93BY9+YJoO2di2aACs9VCoy/n4?=
 =?us-ascii?Q?JRzHFnfNNkTDv8tlqt8a65LAFD5otrbqkpuXpfmbxoEPHIGgKNLoNuaXfV9f?=
 =?us-ascii?Q?mojEEImqoUJtrBYTRCOtj0rhU0y/+khCwn+iEFYg3ivW1DpFftkXaE6yadkF?=
 =?us-ascii?Q?wo9RJqxXt9E34GcBbVQLU9TV8Y2JvYEc2Qp4RHOzuooSF6xIaWvhRF3e9AR6?=
 =?us-ascii?Q?iIBLKISKoyvCbwxwSMmuBUHMxx+BEWpMzqSAO/L1TuLe5HOxwBL9fM6aovZK?=
 =?us-ascii?Q?H7geuoY64ACfmfknlqn3QIP4bfFXoi6/IDUfI3Zd1mgqZFq4Y9H+/Xa4VcaZ?=
 =?us-ascii?Q?OSbkGrOhH2X0Psbh2o5ZO6PZN7WSm+xM0ynp3dCJInI+wj8pxWC47HMSejRE?=
 =?us-ascii?Q?q8WUC8TmQK/UjSM1ism02Q+iamieA7OrjSUTrnKkSu5BzvzMgwxjuDuGihmq?=
 =?us-ascii?Q?xFpM66oHlX76oaWE1xMlZymCAsmKmqji/JLsApKWhDqBOiqymK9f+73fNrVr?=
 =?us-ascii?Q?+GAJfbm/y6yiRq/oycTjxm8kHoFPRWdKOVRRoL9fIbA/mTW7OAIRIzcwmgEw?=
 =?us-ascii?Q?zVLcv3E3x/KVGpqt80dNeRF7S9nq/ugZqRk1CWrEbV+GgSW4jo56O/q7kiu/?=
 =?us-ascii?Q?9ykioAvyUMi1zoj4W+dB/2pfjmocaGHX8N++y7MRF/QuC5LadkCCZKmXGlsV?=
 =?us-ascii?Q?egwu2ZChBuMx5Jsn/Vw0y8CBPbHZhDRCO8Ek/imu4SyTvkSosy4Z/qxyEOKa?=
 =?us-ascii?Q?qHiYXvkPkdHbGEFx47jUPKuU+qzhAkRJHdun9KPS4tUsMiBLoawFzg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:18:42.9997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f58d51-9bcd-4dd9-029a-08dd6aac7da8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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

Enhanced ipool debugging: Added new log component and verbosity levels for operations. 
Introduced a bitmap in debug mode to track allocations/deallocations, preventing doubles in per-core cache mode.

Shani Peretz (2):
  net/mlx5: add ipool debug capabilities
  net/mlx5: added a bitmap that tracks ipool allocs and frees

 drivers/net/mlx5/mlx5_utils.c | 151 +++++++++++++++++++++++++++++++++-
 drivers/net/mlx5/mlx5_utils.h |  21 +++++
 2 files changed, 171 insertions(+), 1 deletion(-)

-- 
2.34.1

