Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0576CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:38:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBB4B4065C;
	Tue, 23 Jun 2026 13:38:45 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24]) by mails.dpdk.org (Postfix) with ESMTP id BC6CB40677
 for <dev@dpdk.org>; Tue, 23 Jun 2026 13:38:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=angeJ5yGdIWwy1DEWpLIacCY8rnLmkM7TvmaoYztkWepd4CMCVSwf/9edqCGrr8QA6FRdB6zaflfpnRFmxADup5IOI4jo0hcfIHsSj21O67bQGJpW2tLFbPRTO2Ojltbf5zR6smFHMkqWgvahvNEOnEV9khO+ngikKmQSSe9Mr3DpZMRQWSDHrPtIPzyyhgrtNpGrlzGg6XyFMex6wDOighQ89lybQNu5H1HJSiOPS4/JpKBfyhSkN+ieWSeDGB6pUQ9o0r/dxSJgwSxPQ86S2SomOSkXXkiFDSsw5upz+OcwrnKo9n29jTU7WWE03+hB/7caEokZc6Fdj3K/ixFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGRYbcgtv+6bFNpN+WXP487Js9guTrwcrH+MYITSfM0=;
 b=Yu1nLcdKGhfuEC/xC5CvEeUAj/2b6vhO7RY/eUdueguvxgSewG8lrNDnFQooa1clzhVMaMlctf43HidK08IDc6b0zji0R0WYYrOPfpKNcbYUhR8kvW//86KJZkVGyuFVu6RD3Nn9gjZeiHS8KCs3LPfYLSlFY1Ktdf9Yvh6fbgt+LMNWiueJGD5xDEBwTZCo12PiQyOOuyPU0Y2rjn1aeJl6cAR5XEmd+BcAlmyqTbeGyd3hPUbpQ8Q8ReScauDP5QVBx5vTNXjP6XqvNxrzYfD6Sy66uI56ddrL82aFNGW0d+iJ/9ncCJX4pSAhzuxKLSUzu9yNR1l53L7Im1IzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGRYbcgtv+6bFNpN+WXP487Js9guTrwcrH+MYITSfM0=;
 b=sWXsqdKyCuwDaWh40VsgjCC+sV2GoVdomB3eAr1wls/eWypvK2X6jcMcNh2lWGMoIZnVC1gZe1r84axuNbEoYURDcQuOTEDWo9zMPAnVUHPpDbs3CAwrcnDh5jKqUcn2eduEBMj7HdGCmpuGCW6vmjMiWwqWE+ysQNWVFLqU/16CfzbvqcQJDviVO8JJpuxj3oLljGOe89JDS8PwPXbBWKykhdDB0xOuzdmYiciCQejwoUwZoEUJBQEWwULg1LbaVNKo1smnFJdbgh/7R/pL02QT2VM0/NZIBi4xZCzwGUrwuVd5KcQQVsuqYaH+G3yDdFghzJSMlDIgcOFymb82wQ==
Received: from BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::10)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:38:38 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::6f) by BL1P223CA0039.outlook.office365.com
 (2603:10b6:208:5b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 11:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:38:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:21 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 04:38:18 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 0/5] add versioned symbols for recently stabilized APIs
Date: Tue, 23 Jun 2026 13:37:46 +0200
Message-ID: <20260623113752.1100072-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: f076434b-4d98-4576-27f4-08ded11bf760
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|13003099007|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: kLspOCMwnUMnviZ5A13wIUgIXR0EuSYmrsbKYG5aBuuSVLZstKkaq96F4E4WKrLDI3vE0imaXJW4eNBveduHyto6bfsZ9SDCyxNx21QrK+thFNSgQ4Rlx5n796TP/4Q7xR7my/AUPZkNMed5d3Nkz3y3jr56pwYD759I6Y4ZlLpT2QGVmgCrxbqxx9ZxAsa/Mbfl16XXa0BtXTO8HbHVJ+VgPa6WLYO5YW4fszgZBgKG8cq8YossZ0KKs4SR6rUfXOzVWQfGhf92XByYygFcbI7Loxp4Wf9AkhDLSupQsjkymamIIyZR3uSiG5t6p0pJuk2uSWcpFSw9g1mUiHQ4wNPDt41y+4KCzeroBDp0bN21PzD2DYAL/4VMOPpPEZFYLThnCoP2rFeiBWITTxsGhmGqShXoUyJq6k/QXkcB0mVVdqI4u2tRjvhMwLfVjOhS7mVMJ3rmbeAxVBfSVnx+Zx007ikvmKJhIudupkx57IW6/c2JNdRBeVput0YNyU/q4ku/WghlNDUZe8is/oEYDAMTpvTiPQNR6XV+sX0/EU8FIQe8xNT7k0lyq+VWyLuoYcYTvZ3EsS2X94IT79OLUD+EPDDGtcqEx7gSx1TC3ZdHQWYzoP85GNGNmRCOIEWm2OgNwv2bhfkOdM3xUUDaI28LMN5/xnmXNjmL7Ky+9iXz7Q8KxaABz+4Wjzyic5vTb8THldjNDf/9PwfHpzf+Bw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(13003099007)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 74hynFKdeJ8PWrPBTYt81EiOJ0N0CfYq6qfq9cscsi8PZvNh+9CLMpVouos9t4lE7ZFg/OfD1xo9d2q5Iqt96+Q1JuqUuuYCofUBJ584dwJl+Xfq7Ip3EwAMlDea/dZ6zEROU6HEKsNjJnh23T1H4DuWaRgIY5gQ6sc0x6fOCgwSV0arQhfEQNZrJWscR1bbht5fHDF+wI8sswZHESzxUB5SKBY0Y2IsrMiMvOim6WRtWLhxh/xFb+75baLb1JEHcX9V+y/giuVF7KqteEUpVyx/5SMq0EwHLD2noZ7HbRsxMvOtEO0a7DA+F7x9KBYIU8YOa8G6m94uUqDjrLs/le84Nu/+YOG4L97Aggatk4ba0BVajOmPa7QBuxCVZOda+uLwTG5LkLhwk9LZEmBUdgQMAK0cvLe65ODG54nhRGhvFHv0D8We71KPJ1wg82bY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:38:37.5930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f076434b-4d98-4576-27f4-08ded11bf760
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
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
- Patch 4 - Introduce versioning macros for global variable symbols.
- Patch 5 - Version the function and variable symbols stabilized in
  https://git.dpdk.org/dpdk/commit/?id=4ee2f5c1cedf9ee7f39afa667f71b07f4004ba5c

Issue is still not fully fixed for stabilized global variables:
rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask.
Patch 4 and 5 address the bug for these global variables,
by providing a single storage for both EXPERIMENTAL and
DPDK_26 variable symbol versions.
This is achieved through symbol aliasing.
But this solution is limited only to executables compiled with clang.

clang and gcc have a different default behavior regarding relocations
of global variables exposed by shared libraries.

With clang, R_X86_64_GLOB_DAT relocations are generated for executables:

   $ readelf -sW build-26.07/lib/librte_ethdev.so | grep rte_flow_dynf_metadata_offs
       113: 00000000000ea4c0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@@DPDK_26
       116: 00000000000ea4c0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@EXPERIMENTAL
       970: 00000000000ea4c0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_impl
      1212: 00000000000ea4c0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_v26
      1325: 00000000000ea4c0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_exp
      1415: 00000000000ea4c0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@@DPDK_26
      1705: 00000000000ea4c0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@EXPERIMENTAL

    $ readelf -rW build-26.07/drivers/librte_net_mlx5.so | grep rte_flow_dynf_metadata_offs
    0000000003ed5f18  0000001600000006 R_X86_64_GLOB_DAT      0000000000000000 rte_flow_dynf_metadata_offs@DPDK_26 + 0

    $ readelf -rW build-25.11/app/dpdk-testpmd | grep rte_flow_dynf_metadata_offs
--> 000000000028ef70  0000011300000006 R_X86_64_GLOB_DAT      0000000000000000 rte_flow_dynf_metadata_offs@EXPERIMENTAL + 0

With gcc, R_X86_64_COPY relocations are generated:

    $ readelf -sW build-26.07/lib/librte_ethdev.so | grep rte_flow_dynf_metadata_offs
       113: 00000000000e74e0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@@DPDK_26
       116: 00000000000e74e0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@EXPERIMENTAL
      1471: 00000000000e74e0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_impl
      2134: 00000000000e74e0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_v26
      2247: 00000000000e74e0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_exp
      2337: 00000000000e74e0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@@DPDK_26
      2627: 00000000000e74e0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@EXPERIMENTAL

    $ readelf -rW build-26.07/drivers/librte_net_mlx5.so | grep rte_flow_dynf_metadata_offs
    00000000046dbef0  0000001600000006 R_X86_64_GLOB_DAT      0000000000000000 rte_flow_dynf_metadata_offs@DPDK_26 + 0

    $ readelf -rW build-25.11/app/dpdk-testpmd | grep rte_flow_dynf_metadata_offs
--> 000000000029b540  000001d200000005 R_X86_64_COPY          000000000029b540 rte_flow_dynf_metadata_offs@EXPERIMENTAL + 0

With copy relocations (testpmd linked through gcc) the following happens:

- When variable symbol (with EXPERIMENTAL version) gets resolved inside executable,
  global variable gets copied from read-only data to executable's BSS section.
  Executable will access this variable through BSS.
- When variable symbol (with DPDK_26 version) gets resolved inside a library,
  global variable is accessed indirectly through GOT.
  It is stored inside BSS section of the shared library.

So executable and libraries refer to different storage,
eventually leading to inconsistent runtime behavior.
Problems only appears when executable and library require
different versions of global variable symbol.
If testpmd from 26.07 is used with libraries from 26.07,
GOT entry for these variables will point to copied variable.

Without copy relocations (testpmd linked through clang) both
executable and libraries access the global variable indirectly through GOT.
Runtime behavior is consistent, regardless of the mix of variable symbol versions.

The only other solution I could find was to use dlsym() inside libraries
to dynamically resolve the location rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask,
but this solution sounds like an overkill.
Essentially this would require moving to getter/setter functions for these variables
inside the library.

I would appreciate any feedback or suggestions if anybody had encountered a similar issue before.

Dariusz Sosnowski (5):
  eal: fix macro for versioned experimental symbol
  drivers: support function versioning
  net/mlx5: fix stabilized function versions
  eal: support aliases for versioned variable symbols
  ethdev: fix promoted flow metadata symbols

 buildtools/gen-version-map.py        | 11 ++++++++++
 drivers/meson.build                  |  8 +++++++
 drivers/net/mlx5/meson.build         |  2 ++
 drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++++++++++-----
 drivers/net/mlx5/mlx5_flow.c         | 18 ++++++++++-----
 lib/eal/common/eal_export.h          | 24 +++++++++++++++++++-
 lib/ethdev/meson.build               |  2 ++
 lib/ethdev/rte_flow.c                | 33 ++++++++++++++++++----------
 8 files changed, 96 insertions(+), 24 deletions(-)

--
2.47.3

