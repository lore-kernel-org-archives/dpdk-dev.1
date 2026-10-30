Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE1606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CocWQ9Yh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ED8940BA5;
	Fri, 30 Oct 2026 18:29:39 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by mails.dpdk.org (Postfix) with ESMTPS id DF67F40BA5
 for <dev@dpdk.org>; Fri, 30 Oct 2026 18:29:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhKmhK9ie6bw/KcWQpAHEYjPjDLPqTYTm0CJE/SGbi5Y4jXjA0jZPbOIjILpu5q2FtMyQ3/18Wir90wKJAJGRb5wStx+zXn4KjIl3d6UzhGD+vINbLauvzGMt004+6QmclM9f1Lmd6ZyI/AtxC5ASuFWBCbPpbRx0znH2va7LkGrjXPY+jwjvzve9OXJR+D8SnUyPscTYv9JBE1CvbnfK6p0uDZ39nWzhLoDn4z/iUweWdvO6fgmecyUS2d2Zza2ox0YuTaX7dERQVqoiacIo+LbymP/iiV8VUbJMP3XCiTULgJaNUq/ojiPumtBGNu2TEkl6Bk4N3LwYQS+D5/mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07jglxYkfQu4RaWqAfkjA6g414qXgkMzYPd5oz24gQ0=;
 b=ONdoKugtgYqmfowrwqEyhTiDWB3B9LEAyFLr5M/H/Mr8pTtf4IxJsVIj5i1OlBlXHi1JmPcrWTaVP52ela7od4ENHQ6yEQdMlhgdzypKliiLVrfQ1vDUBkQihfNXv3jEM/eQ14dmXVByLHFvhJmq7VQw3GGZ//nMTXW/jjFO0+bqUKTfWVNRCYp/AePh0cmLKB+8nqc+t6NgV1iAs54sPA+eSlIwBYqIuHHCq0tfp3f05gyQevEzIoiqcmnCvKBlDZTZR7cyasuNIJjRlDgeIBVsrK2z7xDiHJIVmoG/5BEYUz/QKSQd8B+j9BlucsDz3N7SOfF/avWFSIADNm7d9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07jglxYkfQu4RaWqAfkjA6g414qXgkMzYPd5oz24gQ0=;
 b=CocWQ9Yh007vl72rwtHXZ40ZvxVBFXfohKUufO7FMY0CVUbjh4dJzTa+g5ELA6kLfKn0VQ0sV3at4beHDwyOU3ixQLwIGpthUc7AfH8/SAOw4YJbRxxLPXSaPwB86puyYAzToZKAr6VDFtZrMrwqOikFXPsTAqPdBpx2LEncT+qhe02ckrhztetMg8RtMXLJpJ5xiciyoYl9tqfvOzng8wd3tfq7gxFMvsuB/yXiaWZ3SpWhU9oOP2NKOHMYVEGDlNXciwKKwLXCg0swDncXUtHaHniSqvWLNA+HMm9VErm31sRqhNnRtt9VwS3BR/5Jt6HTysZeglIkCnWRe+GMcQ==
Received: from BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:29:19 +0000
Received: from BN3PEPF00022BCE.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::55) by BLAPR03CA0090.outlook.office365.com
 (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 30
 Oct 2026 17:29:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BCE.mail.protection.outlook.com (10.167.248.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 17:29:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:59 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:28:57 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/2] net/mlx5: improvements to link status handling
Date: Fri, 30 Oct 2026 18:28:41 +0100
Message-ID: <20261030172843.2304296-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026160400.1290443-1-dsosnowski@nvidia.com>
References: <20261026160400.1290443-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCE:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c97e74f-0e10-4cb3-1dc8-08df36ab5473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: G5QcK32Z+/f8JEcvy4C/n3jmO06SdLKzfN47QDUPdoCRi5YmgEROQeKm0oE1o2WZGUtWylbIOWvLKFnmSF5fPQZOcpm2SHNiGbX6X3SX502K7g/DUwBlzlkFrKDx9optlTGARgu26m7jgRuoUnHZYsBgA8E6gPk8m/FDjSJORGZN1ZpC4y8WAHC9AnTnt7gw1D3zIcolu5VQjv3XfwOaqK7xiRw0kaPhiP/zOVuju7zfeAJoOW0AefErxSfPSe371+M1FnwMHnDVPsgI+37CAIReBgG5I1iDIVi6tTKJsEU4LSiXHanYVPCV4qPJZxEicmVRjXJzahYXqIvQjmOvqUDosP0sGncFqxRyrko4Hi+XMoZbeqINBAjxIeL+DjZIoJRGO7CK1+OWzkgmKE2jxwZMmWaDmDvtuDykkNtZF1+N+YEjjww0t61VNMOpvGjsE7jKHd//QrpE9MSMHlB11/Tx4zIPscdvC52GPLbSmjTSj7g3248A6EtRjXJuW+4yyYzKAN2GY9Bgd7t3mHdtUMV6NFPHRHfp65vpHsV9ILhYpvPrW75fFii1R3VbaCslOr3JEWU2azVOAUDv8wtffDkCsZTYbxU2dy1bE8d08B44ZR7unaE89qrfiXNWtqWgPTKlHNpZ1HJ2u4mQ+EYlHLp+Q069MLQUwreqViDzA2r1qzW7WilNi2T8l9V0+1Mh6nVVegteZx0C/jmHL0C70w==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7AOkWr/wKCAeR0T9eNyGl4M+ZJJN45HwJfEKBNmSr5LLZCSxWOO69bNiprKXZKg1MN3Fax0/+BOYt19QcXuzz7u7nZfue6j5Gdlld1h43C7iO4oID72M011ArlOqi5iVAm1lnGTykEDGHpz01dF+B21wgcRPgo1LAUTlWUBCGH9Cb7DvKSTBQV8EsznU6VPo6788GM87XTqyRN/WbES8vFoIZgerdlH4UU12xb8KFt+pqUU830d105kNr25JHQV3Vk4Bo8JjosQhEfk6cLir1OL7dkiD91pUCrHHhpmAAkgbfm8+CT03pPFbPnHMWwuvPu8EZp3mS656zWmFXJZz44aOBbAc1dDgg3iwogs+ZTWXGHZE/1eacVMn9edEKqKE1/PxeVR8yp8yuBt8Uam0NQ5YTP95ySoaQAI8qTzutHMO01o6xetwB3WNeUaLnOtQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:29:19.2369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c97e74f-0e10-4cb3-1dc8-08df36ab5473
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series is a result of splitting patch:
https://patches.dpdk.org/project/dpdk/patch/20261026160400.1290443-1-dsosnowski@nvidia.com/

Patch 1 - Fix for mlx5 link update function to query current link carrier status,
bypassing the delay introduced by linkwatch in Linux kernel.

Patch 2 - Move to link status polling, in place of relying on netlink events
which can be delayed by linkwatch for up to 1s.

Dariusz Sosnowski (2):
  net/mlx5: fix link status query
  net/mlx5: move to polling for LSC interrupts

 .mailmap                                 |   1 +
 drivers/common/mlx5/linux/mlx5_nl.c      |  29 ---
 drivers/common/mlx5/linux/mlx5_nl.h      |   2 -
 drivers/net/mlx5/linux/meson.build       |   1 +
 drivers/net/mlx5/linux/mlx5_ethdev_os.c  | 147 ++++--------
 drivers/net/mlx5/linux/mlx5_lsc_intr.c   | 294 +++++++++++++++++++++++
 drivers/net/mlx5/linux/mlx5_os.c         |  23 --
 drivers/net/mlx5/mlx5.c                  |   7 -
 drivers/net/mlx5/mlx5.h                  |   4 +-
 drivers/net/mlx5/mlx5_lsc_intr.h         |  13 +
 drivers/net/mlx5/mlx5_trigger.c          |  20 +-
 drivers/net/mlx5/windows/meson.build     |   1 +
 drivers/net/mlx5/windows/mlx5_lsc_intr.c |  20 ++
 13 files changed, 385 insertions(+), 177 deletions(-)
 create mode 100644 drivers/net/mlx5/linux/mlx5_lsc_intr.c
 create mode 100644 drivers/net/mlx5/mlx5_lsc_intr.h
 create mode 100644 drivers/net/mlx5/windows/mlx5_lsc_intr.c

--
2.43.0

