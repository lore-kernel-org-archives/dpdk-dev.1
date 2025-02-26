Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD5CC19F2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 16:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17C574029F;
	Wed, 26 Feb 2025 17:05:17 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by mails.dpdk.org (Postfix) with ESMTP id 99DB04026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 17:05:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoJEa6SiC3CPe+l82SCLaM8Pi6UeNI+jRFJZHn5lJZeOq5LSMYmB4XMTO7WlonrvuH9EKsSGJ31YwCaUSIxvgZeRImyzf8loDQRSNP9/586jwnjqEjLdlp0YjWMi4kRCPDv2CgsDNtFClUVG9XxzZX/zKZdi7gfUH7HsIIEehEMPK2E8BwQuYSTdxogzBhpsUh6T/6bzJwBeRGSpZdrRuNOPsDv6xjNFhZaxUwwPFv5L7/kHC6rDU46JxsguznezWj09Egv0jCMmHqk7spDnBkDtMRsMyyfRnp0N0Vw99Sp5e5mMJGvygEJENoZGreK09XfDDeVmE0WM9Y40Rq69QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP3BBhktdkqfTj5owbb+26K2t6BknX1PxtbcPTualCU=;
 b=OhrEhN+n+WDum4wfoY0IMrfn60+ghkHi06dTCquUMQTRHTPuMv3fjbMHmNd+ZAPe/yl5isp6rxBwAcauGlxqI6CSsMievr9aVFm1gXSmmkmULrrdopvp53npuQBAmApw2rzRgMFkmhu5Shgd6htjjqFl2qIJA5vtQrxGgF7A+czqMF8dg8KG6PmOSrzeUbcPkFMK1yPDg1YvcrWe6WiboSlqgBpmhSZ+875SU5VAWFycZdNtnFaPwyazN/z6m3sU/E/gvdLge43myyPt8SzOhait1n9kjGJZf1ciSUfSw3YF2jP0EGsvgD1m4tTP7eobDdL7WFKMNloArlnNlGog5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP3BBhktdkqfTj5owbb+26K2t6BknX1PxtbcPTualCU=;
 b=SN8MWM/gocMl777YIdPLP88DPiaYxPNvAh5l90PF5InIJwkSNITflHaXAiPUh7+LKT/YE7QU7zwE29HgWtQTnRGjJYxRHHN1bew7AV7XZS/3GMmT2hnwbgC3NZ+N0z/fsX5TVDqIwcK0xp852eo3suPD/sm5mFjzeFjPbj3WXrhM/uqcRRS5e6GJh4G9VZ8IyyXUxANFEmsu0nDgcy31SMaaq8qT4K4sVUdTsbLas2ondw4qN+fiHyPNL+M+rFA8sd36i3e4U0I3R25/MeGu8h93B2MIvClpm0hzU+GDkkf3e4XJRcRHfgOAXacZNB2WZ8SAWj50NNFnKbMVIIruPw==
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by CH2PR12MB9518.namprd12.prod.outlook.com (2603:10b6:610:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 16:05:08 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::55) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 16:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 16:05:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 08:04:49 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 08:04:47 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v3 0/3] net/mlx5: support jump FDB Rx
Date: Wed, 26 Feb 2025 17:04:22 +0100
Message-ID: <20250226160425.78147-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140119.2142352-1-suanmingm@nvidia.com>
References: <20250226140119.2142352-1-suanmingm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH2PR12MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: 722abab4-0bb2-4df2-fdfc-08dd567f56fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QSDsd/9AbXrfY6IdiSGn0tkAXE5zKIqgQnY1yegOCSwzBQcMT+pPSHzKSSVh?=
 =?us-ascii?Q?/8fDzNA6DF99Oe7tP+nU8CAFhAH2aX+FPcsvq7I35PIGchmtdSZxzPA/fDZe?=
 =?us-ascii?Q?qB6loK2ECUlzV+rO+nCUgjNXesjWIjJW9Jha8fJJWyPXfSQRaydicY+e5EhS?=
 =?us-ascii?Q?gtwMa3R5zgJgSsOQBo0wDZjmtKcuykdKxk4xmXt/vFnPZyXJn5lk11zKEG7C?=
 =?us-ascii?Q?wbizBgrUN9q3bEVrYX6w3oDzx8XTNhLO6nE/DP1C5w7yujUCCfe68VDv0j7C?=
 =?us-ascii?Q?t5EbaRFg4NbZtghPNYg8J8tZ4NUOpMyU8zodHGIcCvV5VbObr08sb77OTAdm?=
 =?us-ascii?Q?Py/3cXv8+eh6PtIUAws8tvV8HsCJ3GXFQVMSBuzKx8S1v76d5jymCoQKxXr5?=
 =?us-ascii?Q?OUZ54FKYNiR4+Kp5J6kQ/etXu+aP6ol8/JK5Xk/SbKu7Nm8Mm/w0Kx5pYs1e?=
 =?us-ascii?Q?aqunnNmAetScAizox2L/YO7C42oxd7NvC/jyDG9fMEPU42TxcMTMUYgrEtBw?=
 =?us-ascii?Q?3X5QbZjM8N1khB9C4gY+Jx+gxDTAHpobHB4cWfoOPMub5jfPcI+OwvmrBpml?=
 =?us-ascii?Q?9Kz/iBirj3F+zxBERxJT7bLSWfrC5BLOtyz4RX7zK6ECw0hvEdm3lDgCjGh5?=
 =?us-ascii?Q?kFXQ6Hk6VCErUEhIhPdAFQN15T8C9Ls5s0u5YZ/Erj5Xt8ejwmF5nggDG2TA?=
 =?us-ascii?Q?1GGsaiwbomcRXh6ec9oGQqeD25ZdVyyeq+2Nk6SifOi54TQBgeGrz/1aGtm/?=
 =?us-ascii?Q?5Gy70ybPN99T8U5zUV27L44jrd5p7gV/CmGMyiQrTEyqLQ6DMHlikp+kIPTL?=
 =?us-ascii?Q?jphOO84OOn4mPXunhe/1scZ/m3e5lWfyBhRZxVw7oBVmEmB9nd7dlcXCgYJq?=
 =?us-ascii?Q?hoMoTIOV3O4h9HiqSYv3jEyF6iCxqLsOEAEb/8q5iu46xh+Z3OO4KaLa3brL?=
 =?us-ascii?Q?NWa6SycXT5rJVs1cyJOcUg3OfHJ8JVH0z+CAJMNwgweh7twhv5BJUWPIM1Vt?=
 =?us-ascii?Q?D4ATMDHjpoQhcqiDTrcC41Qwjxo4DKzdnWI/t8oSlkA/l+bMlDz+8Jr12NqJ?=
 =?us-ascii?Q?G4438eyc8AR9EGOjqleNEP1Bw1D61Sj0tmNycZPBTDogqO3xzZVPLw8orD6t?=
 =?us-ascii?Q?YnlLx86gziwEQ3SCbVPK1CWe7LIk1lcvBAFQ7cA6jnZSYYJWrOKQ9y18P9Hx?=
 =?us-ascii?Q?awnyGwkF9yxzs9N7uo1yG3BGuSSm2E2/pcOxFNDbvZdjWzIkmYdh8sJyJTpY?=
 =?us-ascii?Q?8AG6IGPqbsLjK+yHXLdJ1WWWcY/cAgzrOmJJL4dI/BJs/Qz7j21AKs4v172t?=
 =?us-ascii?Q?lftDt85lgKiNi4njdtGtTAOC1voXpBWtGUultANBrX3ipeqJMHifEDNG4zM2?=
 =?us-ascii?Q?LhXsK/W5F1yGhCGeDiPCIH/z/Z/ARkV2e9j92K6pLaLoQaJcWFcr3la7hvnk?=
 =?us-ascii?Q?NlR+10S9194DGpuqzeIjr8Ko/oPwpZHT1t6Pu1QB/PGjA31bC/QO5ddB7/1H?=
 =?us-ascii?Q?nOKuVGiqPay1gXc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:05:07.5418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722abab4-0bb2-4df2-fdfc-08dd567f56fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9518
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

Before FW introduced the JUMP_FDB_RX action feature, jump from
FDB Tx to Rx is not allowed. JUMP_FDB_RX feature introduces
the internal loopback for Tx case and allow the REG C0 C1 B be
preserved as well.

This series adds the jump from FDB Tx to FDB Rx support and allows
RSS action in FDB domain rule when jump FDB Rx is supported.

v3:
- Rebased on v2 of mlx5 Unified FDB patches (series 34723)

Suanming Mou (3):
  net/mlx5/hws: support jump FDB Rx
  net/mlx5: add jump FDB Rx flag
  net/mlx5: allow FDB RSS

 doc/guides/nics/mlx5.rst              |  4 ++++
 drivers/common/mlx5/mlx5_devx_cmds.c  |  8 +++++++
 drivers/common/mlx5/mlx5_devx_cmds.h  |  1 +
 drivers/common/mlx5/mlx5_prm.h        |  9 +++++++-
 drivers/net/mlx5/hws/mlx5dr_action.c  | 26 +++++++++++++++++-----
 drivers/net/mlx5/hws/mlx5dr_action.h  |  4 ++++
 drivers/net/mlx5/hws/mlx5dr_cmd.c     |  9 ++++++++
 drivers/net/mlx5/hws/mlx5dr_cmd.h     |  2 ++
 drivers/net/mlx5/hws/mlx5dr_context.c | 17 ++++++++++++++
 drivers/net/mlx5/hws/mlx5dr_context.h |  2 ++
 drivers/net/mlx5/linux/mlx5_os.c      |  9 ++++++--
 drivers/net/mlx5/mlx5.h               |  1 +
 drivers/net/mlx5/mlx5_flow.c          |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c       | 32 ++++++++++++++-------------
 drivers/net/mlx5/mlx5_flow_hw.c       | 28 ++++++++++++++++++-----
 15 files changed, 125 insertions(+), 31 deletions(-)

--
2.39.5

