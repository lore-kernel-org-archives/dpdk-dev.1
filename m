Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E93BE8B381
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 23:04:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 869AD4060A;
	Wed,  4 Feb 2026 00:04:27 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012064.outbound.protection.outlook.com
 [40.107.200.64]) by mails.dpdk.org (Postfix) with ESMTP id 712AF40275
 for <dev@dpdk.org>; Wed,  4 Feb 2026 00:04:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJpczU9sfDv9tGtN88i27CtP5fyLkFj1nMsE4AeCDUouje9OhhfAumZXgmfn3/d4c/E4VpOuLyrEdIvKWwk8tRg5iRVLhTIqYeQoTkhddvhSo49kirDcL+9AC6wPRUg+qcSrE0EHEWwOEP0QcN6GQH2gQ3vpTvFd5fmVMK2QPsyAGCFWAZapUTVKyzT+Iak5qhX31OeIred4dFgFKBEZS8fJVFX9hUn6FlFPjbr6RWfW4hx4k7WeKxV4rrzEHJukrsekVal6vUsvAY+pSDcbBn97gCa59ZA9LYBBfxwXo9LC8zIcM5tu3gBKXsawCSo1lLnVMVSJIxKbI+4J0kU4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM8tMEjZSd10/St6uDeh7DPVQ1WI5Ipz5cDNCFqFgAE=;
 b=jzYxh70gO642kE5X46vjVK7pw+KBrTa2AeXn/8Li7lCaLUxxn9SbJJHEgmkzZ1+SVL57FCw/SSB0lERPcHkj6wycpU+8ID2yOf8crfSN8SwDKkpa4F1ENcx8tNQZ2Obm3ID1su30X0GYGLUXe3BKjuYqXazecVdOkJbmCLCad2ANV+HqxkSGmfRMvx38hKUTdUptc+cJooOq0wDfiROjw4hGYmtzeZBnVpbe3tpFc0cj7+ffGzGoZemX7e1IjpyP+wBLcj9+s0uqNk9QlCFMCID0Z6FBtjlehW6J1EKxCBnpl1GuuO/O1nJLmFpfeFx8t9opUNqS/jXZu/HKVjj9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM8tMEjZSd10/St6uDeh7DPVQ1WI5Ipz5cDNCFqFgAE=;
 b=J1P7UhD1NA9Mge0C5Q+Ma2u3csUv9DPPSi8Ix+dj9wW542/peE2agj+tIn0vxR4gMcYZi41yxG/58qkIJkJmHo6yPeQRo7rriJUaeI66/Xt6CpsitrdeCTttX0mFGvC4QJAXgELZtlXEjYiQ9BOP43NlgFzo2Fvy9KeDQftMOITWZciKnGOVXn4D5rjHTDw/b+wDfN3O2N1TpyQb3MEDhwFUI0n9tHeSuSlmQWGDI05pb5sDDecdD2py22ptuVNwzDjOoFWyRyAfjctac2LgYIeE7WQNGrmeb0VPuk80YgnqIe+KikKhxVGt3RpDAQbUYr6gjGE+r1Jo+Nwiz2mnHA==
Received: from MN2PR05CA0039.namprd05.prod.outlook.com (2603:10b6:208:236::8)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 23:04:19 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::e8) by MN2PR05CA0039.outlook.office365.com
 (2603:10b6:208:236::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 23:04:05 +0000
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
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 23:04:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 15:03:57 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 15:03:56 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>
Subject: [PATCH v3 0/2] support dmabuf
Date: Tue, 3 Feb 2026 23:02:38 +0000
Message-ID: <20260203230338.1066297-1-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203222836.2862414-1-cburdick@nvidia.com>
References: <20260203222836.2862414-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 527ba55d-0f5b-4e8e-53ae-08de63788fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r9f03dDLMoqK3XjCh5d9GwTEXI5LVkfl1fYtQJ9n0lzAxEODuet9eutcudTi?=
 =?us-ascii?Q?rJEpf9Ucj9WrlA4zbvuTZInpMEG+zIz4KNmHdipjHKglXda95qw9ttML8G8Z?=
 =?us-ascii?Q?53MZj101uVTZKjz3+DzzQcD8eDEDV7Xe78UnZL6LwmKrl3rNnd9OQbyGdVq3?=
 =?us-ascii?Q?qr2iUvhWfnXbYWAc9pt/1Uugyis848BXp5fRu1PuKiN42DYuHeAhC8fbvCn8?=
 =?us-ascii?Q?ZRG3MNV+B56EnAA7oPM3XZtHpp0xsECjxJGosjWyTP3FN81K+5G9g4YkyyIf?=
 =?us-ascii?Q?NnEDrch/ceBuTGQX7nX0KE4Gn6s2e79TVz7jPsgOLPqsQikr50QG8lhFS/LY?=
 =?us-ascii?Q?p3wFINHVHwqdYIkLSMs6ZzctfJ1mrBjLkjAPh0fuS3iIYFDyjRgxLdtrOJVB?=
 =?us-ascii?Q?L3dik2kJ1yAm8j9Rwsza5LDYye+bXROWsBjrh1EzYQghUl92XBqcBBRZoggg?=
 =?us-ascii?Q?kUk4sFjwF6fSmNxAVM2DLMZYx3RVvYvbGvy2boVbcpvFcpGnPz0WoMOD17fJ?=
 =?us-ascii?Q?tG4nghcFfHe414bg0PoBhU2rlhXTFdFmv3S7kffUW5AGdyOukyaBxoT53c4N?=
 =?us-ascii?Q?G5/T8VM+hykRd+uISQu1uZQ/SiKLK3T7Iap1Su0/oEQvF1pxVABqH6mXevlg?=
 =?us-ascii?Q?wEtbLLh4Spk5lLjWFllLeioBTIY/ScK+pAG4Uj7IYvOo8jK7mQIRA/FUk5CJ?=
 =?us-ascii?Q?k1Q1PbVjIWMvaz2U8dFtVFUWWkaavus8Jd8RN2wsQHtt/leAHH6pjNLxUZYw?=
 =?us-ascii?Q?N8IUP9cgWt6mYFmd3CqKj4gLs1IlL1CZHgOl0HZANhfXjxoJKeWIo9fq+/xS?=
 =?us-ascii?Q?Q+MebRdKHXkJMpJG08PW5T4jeGtJ1yPJlodT5mbrgPuZYCpRF+XRHGs7jZkH?=
 =?us-ascii?Q?rP80Hn1nXghwgz5r7un3PRpHVFnkl7NXBB4nOtxrmzGofU+/1LwW+WEcoPUx?=
 =?us-ascii?Q?vbccpFlobxWBz8/vpRiVYkvJy6r4NxEQPVMhDgTWu+AOvWFseCNXCI1mrzIO?=
 =?us-ascii?Q?rrXayDN1v27UaM2FJO3qs4uiT1Jsr5PtFM8hA4Bpoi4UAlPvvWDkriR8AEzC?=
 =?us-ascii?Q?5OlZiDWvAIvkAbVoZvnVaFAuVayHnI5gmOweScrCYkQ3StZ0SdtUxHnBPOEG?=
 =?us-ascii?Q?x649EdFlvXWW/6/swYr7NLqKp24p7N1QJ8clFN79tpa0WzUDm/ZR7QwEeGsY?=
 =?us-ascii?Q?7EltiM+CVPU+13L4FwOEywBkNnRthPc8V45nQXea2bQ9rjf5z2zO5y/4tN0F?=
 =?us-ascii?Q?opfSn7PItBKXkCTpF09W/QeJFYCSKAUQ4a8rAZoYtkOYsq3jVygPOTfzu5cr?=
 =?us-ascii?Q?oJJUezwkPuEEyPWfesaXi1SeABwXE1X4K/AfHsjzsksQRFPEhLl2TSV/gslQ?=
 =?us-ascii?Q?k7OaMFQE7iD09wOKgRe9dUEL7uVyRKIQf2i246hZjZy4chtB+FVqsz3m9iHM?=
 =?us-ascii?Q?e1LEeH3HfWxI1QkMzY5mWpkhmVw2sIgvG7mxAjeo1Ymrxu5q1/quDxtyi9tz?=
 =?us-ascii?Q?25UUJXR7Hbjf5KDX/+0vGkFjOhRgMbi48WLIDVpINeVMDcUe2DhdZD1k3HKI?=
 =?us-ascii?Q?MER/R0Dils3jnuXRRHU102tEWlQsURtKmKBFaMjH74vQYGJrB1skOliDCpHu?=
 =?us-ascii?Q?ywFDC1Qo1h/m1ydYHKhYFYWyQFSGrbY7Aft4JpwGAVwSPHHCL6lZiJujqblr?=
 =?us-ascii?Q?n4rJZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8M0I/rsqxRUUi1bMgD43gIrbqjm8NHSnUbbKrxEuEFVHgPTzN0vp5BuzanQK2/Z6bO64hl7PfaOxKK00qhu/ZNtnDBd15AiCETG9f9zig7GqP/EW5wZ6hwPfo7pNCDrCmkC0HxcvNle1/eubkz7MyBu8+CUnGCINTll4lS8sTZN0udrv4p652UK/Eh5RBB1v3qXen3AXwPknGvQ7z7c5Uf90XpWRPNOoFgthrT5D0D07g38cAmEAxvZylcwyN7RCP1FMcDFoRiLqvKnpYolYFX4BdlgwauMya0ISSP5V1Awh7SZiaUvoH+AVD7c9+0NS6gL7MFTk2pE8TeHidCjWQIwNbTtua+EyDuywD3dJ6X4MECWsp7L/p044Yz+8pADAmbk5X6CmZgEeKjgrExa3Gp8NsQrZpnKZCiegQ+ldm84soCrnwE3cVVh5PoqXoQrk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 23:04:18.8916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527ba55d-0f5b-4e8e-53ae-08de63788fab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
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

Fixes since v2:
* Fixed missing EXPERIMENTAL macro on new symbols
* Fixed style issue

Add support for kernel dmabuf feature and integrate it in the mlx5 driver. 
This feature is needed to support GPUDirect on newer kernels.

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

