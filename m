Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006B5CDB481
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 13:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12AAE4025E;
	Wed, 24 Jun 2026 15:15:01 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by mails.dpdk.org (Postfix) with ESMTP id EB31E400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:14:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4XdJ84B/gTOPGFxc+vxthbxSk0nQAfdBM3b2RiPoK1mQBdDOT0vrCGDxe+YCbePxIpvTJRZ6EdxtUh6PvR27ODgKOHedMcioBP1oWF1Mr4USr7cGLyIhmXzasgoZAhxM/gzKZmHaVMNu5v+49lbUbMzNO3x/axSO4k4dti81FiNJA8cmXGcWEsiNRIFsd8U2+/KYB/0QOX0uft7ygGstp1fUlIwyM+NVC7M5UIX/JV/of9S8jxRrPglnxQxR2p8gdz8HvZLaLNWKRjGROkWxfKb4RuLbAT1nRmWOJuhPvCrLwxaNDk3wwu8ipnQQnvInermHZglRgOXMp5DBgrZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUfqjJd4RiE41u33oVd9Jx/GDd0mV5DjMR+lCjt/lTY=;
 b=kFWUAQbVogbd44qopL4/pSMu4Ta41Ju7NQ6PoMsg5vWBEf+ZBxZHLF2MWWAKX9VzSZou+dp60NxHXI2xfACJawD1EG/ozyE/nz1nSZsBNM/tkvIlmxIAXGkDWbSSMzgpoqVaXFhFExER14+U0kHSP06JsZthwPEzthRO6zN11TXXC2EQUtTvjDuTII6GcvrNCHDAsHUpAvIDxYiXDYXlTy1XAYLALDryKsdVHpCFw+aC+f/lp4xb3YvmOi3aNmbCQwxqNQtk8XX3xSmDyyy78LqMLpcy7jrgDswtbPrqbJQMGNMiq+UnoUNc0ItXw5tjlllZuEW72L2VzDZGXhp06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUfqjJd4RiE41u33oVd9Jx/GDd0mV5DjMR+lCjt/lTY=;
 b=uMObMnxK/T/uY6WEDCcxvUgnduamDjngoHgsWauZdnk1UmwBmrwM7x67MYnMtGD3aO5flrtzbo9n+ITfoetHAbSp0+KzfSEA+xEFw/2/skUx6BgJgKGWhPnFDww53/JdAaIdGhcJyOSQKndfc46xbeIdQljDo8QWJmN9c5wBxpTdF0UWKanJOKLj0fFP/i1ThDHJywVsnI3gfr3y1JNkrsonHgaXMXNf10M4NMefq9tL1fXJHsQCivdNdzqnPlHjldJsLXtVZrj6hQvVEqOBBUD+9Ap0Fgu9VzcSfH7hxJgJrSsHJREXLtODrPqvP25sP9nOfoXaB7eXpnP2ySdpvg==
Received: from BY3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:39a::20)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 13:14:49 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::a0) by BY3PR03CA0015.outlook.office365.com
 (2603:10b6:a03:39a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 13:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 13:14:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:33 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 24 Jun
 2026 06:14:30 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v2 0/4] add versioned symbols for recently stabilized APIs
Date: Wed, 24 Jun 2026 15:13:32 +0200
Message-ID: <20260624131337.1127323-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623113752.1100072-1-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: 1abc26e7-591a-43a4-8855-08ded1f291ff
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|13003099007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1mx7pR5TMzr2XJJqB3F5Fuf0DhkGGYlKgg/BEY5DA3Gv47q0VyHHCSSA0MFZXVB12eCTDlVirZmVDyqmGrdyx7FYR0L7svJtenGlic/tXtN1majyEM1g085wtpabmu/lga9ndjvPcR0OfRpaG8BhpygoeYJJv/2jrbo9ZZKIsOs/hmVL9sHG5I/CLjmSvn7hyr4l+GSHZ0FVGAEMj4DE48mn3dA//6q2xjk3M41ivmuo6KRUiEcPb8dK0VRhGHldWKheQ6ewXsxpJUFRPz6yhxwpD+Z9yDJPsjD/x5FlO+ootj05aFXiCUkwn2PYjPW2JsOGcXUSXkRz5nsud4UEaVGTnhWx6iY/+aVdRsDhtadI/YEeZ9jd0Syqgc5QMkNiQcCS39Fzk8WuGl5eoJCl939hDuxPMXMdAxZl34zCQp70OFVPN8erqSUHYQ9naAXffj+kme7TbAcJwDPVWwNSEbiN5KRXZ245prHcoNOCozua1pS58zR1BqmdwAAb/NPsBI5F1JJ3Mj7rkUzJZFRR6UE3yli2whLDNDDJ1cYQ1qWIfz1znOe6PIDICNKMyhZtFqBwT27fKCxfFk24StF22sDIv8crMKbzJO/eycLOImYWNYK4fcLhbg/pVHxHdQn4f4t5HK06Ct6h99jwpyJ/fDPKGA4yokC1N65+CTTx+ycHxi/8hGOmCwpzbwg44cCaorpXUOsyE+qvmwX8fvrK1w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(13003099007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L4eyk696+2ax0RGE/CpvQBE20deWMt/Qtfm/CWNeHwJHhEa6uMRnwtamX2tClgXSArXwBHkB6v2Tvv8FJbdkd/oOkEqqCuEIDAkf+hgJ7X9UdX6EHYU1B+2dd47gAubr01DlxIM7w45PS5SSInz6wqsLc01YH6NoLPe620zJ8JEiVNg3WPWDC5OAh0jDu75RFWC3t5VYkz7sWNvFA+ZJI9r//it5/rhxB9u7Qlg1QwIHWUZwpLoFIsWaEu5T/JfwGDL9rI3fqmlYTbWspbyIIoTApi1AVwPB8Z9A5VNmC4F/1GBMPwPFz1eqWQ/dcT9pADFkwW/nRiRl5iFmRldnITuP6AKN9iftPxCPxNf6u+xOemmtyIr0YHkVtiaiiKpNs7zwsS80ohkzzvaUAIMNIwQn5Lr6AkqfUA1u8mJvuVTDaPFFj+zNDltA+7FbMfaK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 13:14:49.4599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abc26e7-591a-43a4-8855-08ded1f291ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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

Main goal of this patchset is to address https://bugs.dpdk.org/show_bug.cgi?id=1957
but it also handles other recently stabilized symbols and has some minor fixes:

- Patch 1 - Fix RTE_VERSION_EXPERIMENTAL_SYMBOL macro on clang.
- Patch 2 - Allow function versioning inside drivers.
- Patch 3 - Version the function symbols stabilized in
  https://git.dpdk.org/dpdk/commit/?id=e8cab133645f5466ef75e511629add43b68a5027
- Patch 4 - Version the rte_flow_dynf_metadata_register() function stabilized in
  https://git.dpdk.org/dpdk/commit/?id=4ee2f5c1cedf9ee7f39afa667f71b07f4004ba5c
  Restore EXPERIMENTAL version on global variable symbols
  rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask.

v2:
- Drop patches introducing versioning macros for symbol aliases
  and their usage (patch 4 and 5 from v1)
- EXPERIMENTAL version on global variable symbols
  rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask,
  as discussed under v1.
- Change commit title prefix in patch (2) from "drivers" to "build".

v1: https://inbox.dpdk.org/dev/20260623113752.1100072-1-dsosnowski@nvidia.com/

Dariusz Sosnowski (4):
  eal: fix macro for versioned experimental symbol
  build: support function versioning for drivers
  net/mlx5: fix stabilized function versions
  ethdev: fix promoted flow metadata symbols

 drivers/meson.build                  |  8 ++++++++
 drivers/net/mlx5/meson.build         |  2 ++
 drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++++++++++++------
 drivers/net/mlx5/mlx5_flow.c         | 18 ++++++++++++------
 lib/eal/common/eal_export.h          |  2 +-
 lib/ethdev/meson.build               |  2 ++
 lib/ethdev/rte_flow.c                | 13 ++++++++-----
 7 files changed, 49 insertions(+), 18 deletions(-)

--
2.47.3

