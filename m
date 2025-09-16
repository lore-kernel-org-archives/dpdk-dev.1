Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B95CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 15:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B35F4064E;
	Tue, 16 Sep 2025 17:12:40 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4DB3D402E3
 for <dev@dpdk.org>; Tue, 16 Sep 2025 17:12:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn27vENZniTL3TaH5UT3qbVCYLgmhnmJo84APSaI8vfpox/jlKEJykwOpSNLRokPL+AP8Oyjqr3FAjUAfJ+YYbC3erSWXy9shEAgVTg4dz7ks/JIDCN5v5wnmInQcs2V2Z9sbeuH12Kbzkwke1LtJQta6sooTM109U04IW7iaIzJyz9+ttROMvJMI3uKXApCRs8ayKoSw/vq8NAm+T1KZemcIzHbuVGXx/l0LlPeYxFo5JC6kJy5NGqwoc+nt2tzCZ9lHZ2TKtT9Hx2+3IX3EEegfd6nUnYu2x80y6BPfcWgOzK4vDbJirWkzk0KtAW7kuTuLFdJJH55KmI5kkYkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA3LSHdFHBfphofmWqq0VTrGknr1mq6YV2C5p62PnxU=;
 b=ng6zWeK3eDomCewZpAx2ZqvTJesS30XFToyJ8V+KSMHMHVmOQHUZC7vn720ZjaPi8PiLG1JbPh62rQOVUoxplwRy5Jn9/dkoDMvWnPi9/um6CDJa8nJvQ2vbKMWGhqJzikf6L0P42RUiw1J9cjtbg7zvX/or9vSw9wiFHSi6E4E8bst+OmxRgAdAJH/2BU5+eLs2+rYvUTJsUFKCANoNCZ+Vn+SjlooC+QbvF7+zoTEAIFdIjM2lmzH3NLmczZdg0XcOMz7//Lmssl3mp98aSHoGCDTd0hVEVwco5RNV6K75rzwCEQ5osY2FisRNgN9EV3vgiJYKaTpMKNIR/1kWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA3LSHdFHBfphofmWqq0VTrGknr1mq6YV2C5p62PnxU=;
 b=hYHd+cHl0d/3/bWd4A7QPaf95iXfBvdCTb3KDbJWT59czSzYP7pjjeKDn7KfGjXGe4qH3tbSPH/VP55QiKbfxZ3HnEXL9hvxoxLJfYqYhw17AOxgQtY7nd4bEZpWaGaSpqt+vVG7weuQ0fl8M6KgJ0njjMqlas7IYqKaKvEunFji1SJzmcY+T3H4iFPWWbW3juZvVLhqqWlnEI5bv067+enO2y5+3Z/E5/wVLvUj0SOoaiBQyENAF/PAOR6as8j0DDID/zInxyX4VgtMitb7PPS2GhmsleAu3tBcPN/WMHgvQ0JZulvYVhARLmZHJipLKxe6qP4QvzeT5zNMddRGnw==
Received: from CH0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:610:119::29)
 by CH8PR12MB9815.namprd12.prod.outlook.com (2603:10b6:610:277::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 15:12:35 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::c6) by CH0PR03CA0386.outlook.office365.com
 (2603:10b6:610:119::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 15:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 15:12:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 08:12:18 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 08:12:14 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <mb@smartsharesystems.com>, <stephen@networkplumber.org>,
 <bruce.richardson@intel.com>, <ajit.khaparde@broadcom.com>,
 <jerinj@marvell.com>, <konstantin.v.ananyev@yandex.ru>,
 <david.marchand@redhat.com>, <maxime.coquelin@redhat.com>,
 <gakhil@marvell.com>, <viacheslavo@nvidia.com>, <thomas@monjalon.net>, "Shani
 Peretz" <shperetz@nvidia.com>
Subject: [PATCH v2 0/4] add mbuf debug capabilities
Date: Tue, 16 Sep 2025 18:12:03 +0300
Message-ID: <20250916151207.556618-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616072910.113042-1-shperetz@nvidia.com>
References: <20250616072910.113042-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CH8PR12MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b19e71-5052-4f6a-2315-08ddf5337795
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wpplOUrQBDp1wGLUbHaex34vxDsFonaF98rtwJjR1aGntv8ZKMBIi6pxgPJO?=
 =?us-ascii?Q?jOahclbyRUuAX5XZc9c04lAkccM48bp8J+ORFjbw1Ja7Mee8X+IriMssSLxi?=
 =?us-ascii?Q?k8WXynWY39mLgG50aIQFd+6BzqSYsejMdxZI+SWiCxj1uhobOFdWPZ2uX0sx?=
 =?us-ascii?Q?X5nFRPFdq3oy3Osh1F3ic+OsvvgHAWtYp+Nyfk1T7Inqph8ECGXpfTO/8wdz?=
 =?us-ascii?Q?g4LdqGEoxfstAcET8AuQGtCTDm9vmgZCw62oJHAawxUUmMQ7F+In98FC+9v2?=
 =?us-ascii?Q?+tIjfoMvaga7zZ4PA35NetJ4JSuTKtXxtubFIBAzJWbz2xjpSTeuWYrpEUny?=
 =?us-ascii?Q?Nwy3m9iZ1E2PUtDGK0GJ1ggoYcpZaZb3O4XDxKu5zVpxW9IEOhbIpgHrzCIX?=
 =?us-ascii?Q?HBqpN3ZfX2uNKqN3+LK2GBRsZKCMyFsW5cOyH3bIPTO4gEFo4YqlgqYp5kjC?=
 =?us-ascii?Q?F56aQ3Qw57zN5ZTMFPM+nsPuQ1OBpABkudIp1e9nVb0y2LtNqxt7jAGjO6xv?=
 =?us-ascii?Q?m0IhMt/aPYdC6n/Pi6UPY59vrOV4EsVh2zKkA4Rqoth9Rq+82XDMFDLpPUVm?=
 =?us-ascii?Q?KOPoUXonySvLvPkC7T4QpfFClL3nuScvyDDalr+SSo7HAlEe8dEu3uMhubh8?=
 =?us-ascii?Q?IFS+e53ws0rl3m6rKYd4cI13xHCPmLzAv5gfJKcKbqeBJwrz+zsJv2Xp1JnZ?=
 =?us-ascii?Q?8/2lYcYkCoq0EwNauL6HCMs+FAyd2MM174WNPjCmpvw37ZGNjNzLAzptzhQS?=
 =?us-ascii?Q?Sh3SMsobvEP42NEh5j99mllitu+WZzWuhvhkVmRLb3nJKTwWSqChtvjF6bsD?=
 =?us-ascii?Q?iEpSa360J6rM+H15ydUz3r84qgNzihZfiIQOP2fM8Mfn9mwvV34LEPonDOAI?=
 =?us-ascii?Q?EcHIZtYsc1x2Eayib0NxKPqv1O5Px/27CMoB7w8rDa69l+zHBRkfsvkC+C2W?=
 =?us-ascii?Q?9cE5jnUD0c8pIZ5BnAiiEIntIwwxLk75yUzrmg0x9zk0RelDyQotzBZg41WW?=
 =?us-ascii?Q?mfu2so3m5KT2XwFoZH2BnzMeYLyVMU1OpDIeLj6PBa67tJw7i9wrTLSX68gF?=
 =?us-ascii?Q?CwFRivp38kFM43V5dJz/COQW2J5PgsNNfsHrMfceKInS0y07iQctxwRYn4oo?=
 =?us-ascii?Q?4VBqcHd/DnN5ILSSMerRPqtuJr+jCapmbVQOW8J3O3wjoFuerxlO1Q/uoOQA?=
 =?us-ascii?Q?JjZu+OKseUr2TdQXul4ycpWWRdh6a0M1QrnCc+PwkuEuBCV62sAZnlrbeAN/?=
 =?us-ascii?Q?aMi1lzQ3ignL/XcGSBI9tIlXpsfYcfrIjYF0VYuPhcTwFGoUcMg4Sn5KQ1zA?=
 =?us-ascii?Q?nfsue1FB5OaD85edxMX9rPvU6yoO0Jbgc2+qD85S+WvBJZNsBtNIzrnjjJBU?=
 =?us-ascii?Q?J0o9NhRTRfMNP+4eSZan6k8dptEc85mP3PPw+E7/Syv1L4pK644plkxD+0YG?=
 =?us-ascii?Q?rQwzCEaL9FAtEahzUdqnagT+augZoZM9MrktiVHBSud5m+HT1lVLbbrMOf8S?=
 =?us-ascii?Q?r6aOTcRLwzd7YyfjHL1KUgRmBZytD0jP1AfG?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:12:35.3401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b19e71-5052-4f6a-2315-08ddf5337795
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9815
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

v2:
narrow scope to mbuf only - move the history tracking data to the rte_mbuf structure.
use a dynamic mbuf field to store the tracking bitmap.
remove the compilation flag.

v1:
This feature is designed to monitor the lifecycle of mempool objects
as they move between the application and the PMD.

It will allow us to track the operations and transitions of each mempool
object throughout the system, helping in debugging and understanding objects flow.

The implementation include several key components:
1. Added a bitmap to mempool's header (rte_mempool_objhdr)
   that represent the operations history.
2. Added functions that allow marking operations on an
   mempool objects.
3. Dumps the history to a file or the console
   (rte_mempool_objects_dump).
4. Added python script that can parse, analyze the data and
   present it in an human readable format.
5. Added compilation flag to enable the feature.


Shani Peretz (4):
  mbuf: record mbuf operations history
  net/mlx5: mark an operation in mbuf's history
  app/testpmd: add testpmd command to dump mbuf history
  usertool: add a script to parse mbuf history dump

 app/test-pmd/cmdline.c                |  60 ++++++++-
 config/meson.build                    |   1 +
 drivers/net/mlx5/mlx5_rx.c            |  25 ++++
 drivers/net/mlx5/mlx5_rx.h            |   6 +
 drivers/net/mlx5/mlx5_rxq.c           |  15 ++-
 drivers/net/mlx5/mlx5_rxtx_vec.c      |  16 +++
 drivers/net/mlx5/mlx5_tx.h            |  21 +++
 drivers/net/mlx5/mlx5_txq.c           |   3 +
 lib/ethdev/rte_ethdev.h               |  15 +++
 lib/mbuf/meson.build                  |   2 +
 lib/mbuf/rte_mbuf.c                   |  10 +-
 lib/mbuf/rte_mbuf.h                   |  23 +++-
 lib/mbuf/rte_mbuf_dyn.h               |   7 +
 lib/mbuf/rte_mbuf_history.c           | 181 ++++++++++++++++++++++++++
 lib/mbuf/rte_mbuf_history.h           | 154 ++++++++++++++++++++++
 meson_options.txt                     |   2 +
 usertools/dpdk-mbuf_history_parser.py | 173 ++++++++++++++++++++++++
 17 files changed, 708 insertions(+), 6 deletions(-)
 create mode 100644 lib/mbuf/rte_mbuf_history.c
 create mode 100644 lib/mbuf/rte_mbuf_history.h
 create mode 100755 usertools/dpdk-mbuf_history_parser.py

-- 
2.34.1

