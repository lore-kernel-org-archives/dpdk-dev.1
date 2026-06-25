Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4017FCDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:08:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C5BC40DDB;
	Thu, 25 Jun 2026 18:08:18 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by mails.dpdk.org (Postfix) with ESMTP id 8B5ED40B9D
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:08:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7rMfud6O8Kljyy4DkBqDgj1IpknC2/IQHiGKDfNSwONVzgzI3NrvAKETShqNPw1Kv+/NasO170ZY5pzkC8tOAMCkp+pk9j8mtf8NMuDijP2h6oqKcqmwQb2tNg+5L4fqXONAOcpqo6rV9FOKNanzp6bomxzRtNuZmyh9oTZHmDFMDDv5nksUvIK0eyzxghTKAEKs1aR+gExkytgHZHN2zqX4al2yaC0rgWtvdUKUSlXKTe7n6VPFyDuv686NQrueSX7jDiVcGD8SI3tGTolvn/5saQa+ATANxZRMJgR1cn815pWFv2bO8HMDzp+KunaQpafIg0IR6RMbs1T4Z6d8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBK9qkXpUCl4/il5g/W1S8a2qi5NzqwWERn7M1K4LI0=;
 b=b4fhPC4s8sHTDl3rZ69fl4I4zVDzwkHvHQGyyPbQm6NRM5Fc5Z2EJZVJJG07yWRWTY2ZbkNzVNguSpuiwLxIurKNr4EvwQ++NamDYGCD5Y4+91r4l8v99ezrnVfQQZ3RCkTNgzAHZYEJEdEw5E+xyZVdMyvXIyR3aMVFTrEHVNdSYflz0RDKrHWFR7b58ErN+2zl1gqXVcyD4Ku4Wdb60lnjfnYgcUVQUG3egN0OWnND9obWbgtGgX0568JY+WFpOVSUIhze6019DUHkJJb00cXyKLb7w6s4kj94tXf597BXZ8JDZKxmlxziNJGiVxW/6+FZj12Z+QwxkGrXfXADqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBK9qkXpUCl4/il5g/W1S8a2qi5NzqwWERn7M1K4LI0=;
 b=XBRY2m+eYIVMXKpH8g/ZE8fb9mGkTDWDS9rkI0W0YnF1Tre2HhNm/2kXIF8EdwfvBmwM4hkNnGemuRHUDgp2pmhjEtRE2Bu+YuI/+3ALla1XCUhGxfw8/RjKr5RDQzO3H69GbbQgOriLEebOb/5xB4H1IXn3DpWVu3SOhAtfxpboPU9PoIjRjX43G8vgmNtiNkLpgEOguZzeG2Mg+3wo77vmAuAKnGM3MBpJsrpvoqoyD4V/ZQZt4ZmRSZ7ZGU3071IqURNnCbHcR6S77EUkVXZRkl9PsVEVBUIr7vf+WU6yjAsjyyfzQcjtbryBF/91xr//qMs4o8NnxxxkFwgg9Q==
Received: from MW4PR04CA0134.namprd04.prod.outlook.com (2603:10b6:303:84::19)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:08:10 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::24) by MW4PR04CA0134.outlook.office365.com
 (2603:10b6:303:84::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 16:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:08:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:39 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 09:07:36 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Thomas Monjalon <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Yu Jiang <yux.jiang@intel.com>
Subject: [PATCH v4 0/4] add versioned symbols for recently stabilized APIs
Date: Thu, 25 Jun 2026 18:06:39 +0200
Message-ID: <20260625160645.1341914-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625133311.1299705-1-dsosnowski@nvidia.com>
References: <20260625133311.1299705-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aeb1d10-2a0e-4258-953f-08ded2d3f3ce
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: nAIFdzNyv2i85A3HbcCNxonWo6/u5EnQXzp4VWoWSEFMQNUsU4CJ4NW8VTGoSKR8eyt+VM772E9CNNCBH6oyLRye3b8ROD/5J6tgHbMkzjHMWBCFakQxWQfdMRn2hR0j8fhABzfUskYwnp4+9qWpCqAdYZbirKi//gBGs0ybEdNrYpqQEL2xYoO8pkkOkAfViBExH05zFVQXPIc1lruFnlB3/PfIAL6a4+6qhh7nw0iOvzCMqFEla/2KqBtiQdqWIzR7BHkhFwLbeSg9SLPRgIl2Q0W8F2eUQksKUwOhiN2c3MMtLMkPT8z1GofOFso7yUgCLxS41ZUwZnmVJTqSbZoUbxVjHnd9abbQYGhgWXpH1Xojb+iQncXcSs1O3OKDcu4GiKmOuWUOZzJaGohsx1Gf4OpaMeVhB4YZNMOTchuYDcNTVG0trLq4J3qMt3U99hE9kC1wWX9pY/n8IN3mTXDY4/crFwKuo9MLIsxOGxo4djGak+vCB0jgRddCGZ40Zk9LBjSdogTB5DFoxKrCRTMMYGONwEPPDXRFOP1fvIkfuJ+QC6Klsh6MAkHT8zI3rNy8O6YRIMohiiP0LBhQIam/RMURYGuzioZBbZfEaaOQ2tjXu4SkLD+nOXO4RAQUgoDeYcQpsn4xUkv9iD68Q3O03LNZf4JMUpbdjLy73e+kLThm579v05zdbEJxCKCAZrhMltBFYebbnXEVwzV9ag==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d08wP+J0PFByO9u3ErBBMGkjWy2pPgtN/0PXePGxbhWWEyDWIXhCFyVivOFVvJcs/k1H50F0SwD6bFbEPPeo7fj5K96fa0ILrCktTtr2c1liqk+DSdTRq3f+ngRct2qodUznFJrdL5Hw/tInXGzTMsXbGSunxHdw0XmIXS8kJghTZvzIKEq+y2FNSwWqU3TY16Oe1HE9c06rlEoi5N1cExTGs7YrBSFrLPTARnya6aYwVrOtYo6ueVCDfoaACd7LBErBW4yyVcZF7vGWadtCK/Hvbyk4hmiu+qu2fFkAhaHIvFfhRL8s1y1cnAh1VUhU26m8SVgB/xAoyJKAZNVnD64cZSRZZLic6YHb8RseR91i7s0iw4dVeuW7fs3YjftOSdfqDzHL9ioTzfoqv/4iz5f9qTUSPfC+9ySquJPIGM2ryRChUD2DQR/5i5SsfH2X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:08:10.2065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aeb1d10-2a0e-4258-953f-08ded2d3f3ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
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

v4:
- Fixed build with older meson versions.

v3:
- https://inbox.dpdk.org/dev/20260625133311.1299705-1-dsosnowski@nvidia.com/
- Added rebuilding of drivers with -DRTE_BUILD_SHARED_LIB
  whenever function versioning is enabled.

v2:
- https://inbox.dpdk.org/dev/20260624131337.1127323-1-dsosnowski@nvidia.com/
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

 drivers/meson.build                  | 21 ++++++++++++++++++++-
 drivers/net/mlx5/meson.build         |  2 ++
 drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++++++++++++------
 drivers/net/mlx5/mlx5_flow.c         | 18 ++++++++++++------
 lib/eal/common/eal_export.h          |  2 +-
 lib/ethdev/meson.build               |  2 ++
 lib/ethdev/rte_flow.c                | 13 ++++++++-----
 7 files changed, 61 insertions(+), 19 deletions(-)

--
2.47.3

