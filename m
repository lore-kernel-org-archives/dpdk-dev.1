Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF3CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 12:51:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39181402D5;
	Tue, 23 Jun 2026 14:51:18 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by mails.dpdk.org (Postfix) with ESMTP id 5364A402B5;
 Tue, 23 Jun 2026 14:51:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYgXtt9skd0teOq3ZdE+CcrcJsLPjRVYBxkP8lPAbvwukLHDnFYIB8HIoKLB0mCZvDMuQU0+qcHMNqGxmkzCVor1SgHG+8tJ7C4KcXzIpX5DET2gj7ZmVzLZjm1XEm8L1RueTWvb9l+HY8qKFjJA3wzHJFwhbDbOOVLJbvsmJHHTbtLa0eZ06HyOHd7mh5ECZ7m42jyMcfNHoahgqxpMAY2z6ZH78ba27icrAKnRDl5haJmF5/nxIUI//z9rCPFVxz70z5vxCI0xX1F+NGqBMNfh5mwRcXfYAvZmkt6BGQJp2jHV0z0tITAslz5dRdDmjFPeRAHnOoVl0hQltodOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpLh8GSMgUuQwf9uICEcS4UYzFCRGbU0IZYuvRuoN2w=;
 b=bp5peg712cORzTeA+1GrsaDjJDXC4Y3vvARHVzGJi1fWJ5aI8H6MXvpl8UgWcmFVKaTSnn2pXl9CdjBE4NxATcFKZc71MDQ5lUCOHqbJb6z9U0oeNj0UZjbl6c2FT25pL+t2ArAHYJNX/UsPn9rxwXBv0DIcQbeZzZLaUnEVXQGGJHdbm9XwPXjlV29IetAh5SBx9Wa8slhQCDCxF0jfE05+Gjh8zvppFwCVLRvAcjL4Caq3CsXmT/LQMLFRKNos6kkgNtLDeNhzUUnHhdieKiBL5tUXpVAtAihFpnw/VM1CG53SY57XXTPhtjqx5Nv4y3JIiSJoiimHRCc9ECw1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpLh8GSMgUuQwf9uICEcS4UYzFCRGbU0IZYuvRuoN2w=;
 b=nlsXAn2DAYj8qDOT99P+mP38c0FRDlS5FikWzbUbySyJXL9227GyP7M++3oOk1fnd1cU1RxXsZwUrRtngC9gZuvBIBZRa+JFbcz1W64C2GVka3ZPXxDH+8pdecAdwT0JJPtXmhg3qy5eYHzWoZRZDY7m8pzfXXZLytsTUNQXnAb8pwfM9ys6aKauTtSLAVyezGnoFEAPzHItgtKfvOntl3oiOx9/lvvhX7uY88P//rBTz0AGb64ulcfj3RzVkVVs5h12/NvYC37B/8KRXT8N53rJe3v268xIIcDGNsqq1ZGFVmMEPCZVlMd061nqJF3dJ7HhKaN5LXXOzzhKrNlnSQ==
Received: from BL1PR13CA0271.namprd13.prod.outlook.com (2603:10b6:208:2bc::6)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:51:10 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::ad) by BL1PR13CA0271.outlook.office365.com
 (2603:10b6:208:2bc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 12:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:51:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 05:50:44 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 05:50:43 -0700
Date: Tue, 23 Jun 2026 14:50:26 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
CC: Thomas Monjalon <thomas@monjalon.net>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Alexander Kozyrev <akozyrev@nvidia.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix double free in vectorized Rx recovery
Message-ID: <osk57cbcyyplgiwsl66alodxd5pddcwswzeit2c4jbtyyicree@tqbiksug3wnt>
References: <20260617134301.798213-1-tsyrulnikov.borys@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260617134301.798213-1-tsyrulnikov.borys@gmail.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4c48b1-f2f7-4609-13b7-08ded1261984
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: FhJTMKI5ihMJGvoIId7LbWdmsfrpJw0QtQ6s8gzcMJtEg8qyV1um5T/YY7I3qx2ut4dQZMoLJKJ2HsLe3WSu01cG0NholCilcFY6e6wq+7+YK7pLND56Gm8+f/oC7cCu92KSGkjOK3nOVF/zkOcOY+/e+I+xesj2zCtGnluHw14Nfp56Vtf6CmmUZqU0psb3uakGE7IYUATx/DiCrICBx7c1NAXXjSPyr8gsrMksVnY6tGqeK+sF7hQa8yU9oMVvBEbiYL0Wo0JiBuoTfWsNXIQ/UNSERl0FH+YtR+0zxUsATzTs0wv5v/UU/QL+7q4yesbjoMhcFuFQbmyZXnrHsg6GrxEeKKU+9b8dg/ryQshHCqARIqv5yGFps8TC7H+H76Zoeg1uvV/hYRUrbwkd23+pogbn0OFaz7vyR3nehWbAxiZQKFZQXwhLNHr5LLbtqvizBbrihwrV8Ph5B3m59sTrr5SHsy8V7Inp87CrH7FfGGc/9S2IrYErinQNe6BVc8EaX4kVKAxH9pI+3xvhtTza3aBP7In3Wzov0CTeO6nCWACmobC+Xr5TI/YCPWgH9gdQKjgPfztbbPENpqDez2v8oPTtObgBs3h4ENJdCEn5XHnxFHItsBqnunvikuTVjgwA2ndhsP6Qy5RP66lbyRDZyBCzq2xMUr8UjOPX4+87wv/yB/JvA0vRvqb+qT562qN1moHxKLB9zXsmFZd3rw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aPsn8F24liRZWDJ6vkn9CkRYdKf5vs2L7rHlFSwg8OduxOrpQjT6GkfMkcKQ6sSXV760xxqle+7rmPRPyA9gTO4OzE6B68F6fuC+xR+HfyKK12asEXlOVk2d9cs+GGN8G2l8RAILRSllYsodiwwywdw9JqFmY8tHkr2C/Qe30Tm8RVn4mvM2sAnAmhgIFs9o22sjRgrpIHbP3V0aLvPKKz94yMSfLiQXDhz9lmycl/UVIvM2uJLgv5z8R/s/ZnN5sCjiPmEAkY28nuPHVnEF7ZTBmj5U4Sxbq6e47012JnIQvSa6/2OIrIDSh+uVv2jrfXt9yym6EXy6rJBwAATQxsm7x50HRmB4AVvzy9xrVkywy+odzNn3h0kbdfYbw13Lrejod78ZtQIODkt71CiPpJa2xxrRBtkGaU173r2CyNh6u3YE5+p90I2u06y8e67A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:51:09.8429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4c48b1-f2f7-4609-13b7-08ded1261984
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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

On Wed, Jun 17, 2026 at 04:43:01PM +0300, Borys Tsyrulnikov wrote:
> During Rx queue error recovery, the vectorized path in
> mlx5_rx_err_handle() reallocates an mbuf for every queue element. When
> rte_mbuf_raw_alloc() fails (for example, the mempool is exhausted), the
> rollback loop frees the mbufs allocated so far, but masks the element
> ring index with "& elts_n" instead of "& (elts_n - 1)".
> 
> elts_n is a power-of-two element count, so "x & elts_n" isolates a
> single bit and can only evaluate to 0 or elts_n, regardless of the loop
> counter. The rollback therefore never frees the mbufs just allocated in
> this pass (they are leaked); instead it repeatedly frees elts[0], a live
> mbuf still posted to the NIC (use-after-free / double free), and
> elts[elts_n], the fake_mbuf padding entry used by the vector datapath.
> 
> Mask with the existing e_mask (elts_n - 1), as already done in the
> matching forward allocation loop just above.
> 
> Fixes: 0f20acbf5eda ("net/mlx5: implement vectorized MPRQ burst")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
