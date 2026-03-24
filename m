Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE567D58CC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:37:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFFD8402BE;
	Tue, 24 Mar 2026 13:37:51 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
 by mails.dpdk.org (Postfix) with ESMTP id 2A98C4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 13:37:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohkSCJPvSIhqEIIv2xWfq5g9zZqgHjPVwayMEZsya4HEgwfSJYlpZQYnvrEKKGNOUQfNFYZGUmlL6vGjSF2gJYcgJKzuIhCxWc1Y+rIKn5pPtvaA19pgeP5IqBnMqzK7tw0RYlRZNfCbDXuI5NTYEBhzZXQkVbk0jDWVSQ4skb/5fRKQWjMICbSg7OF2S6jpMH4Y4pgDM/XWcfYh9c93WGxifLMS9o8ARZvhC0CWfoOlGExl3lUVTyYDhLqktP5CT316NZy1sxTc98rODEcrLXMj9u7pRLhcEsF4UOJGBJx5mlEARp6wrYecezxG01GY+/Kdj7e+awOrlKUO+qECjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofxqNSnwOuedvt7fRZlV8R2scGY/9b3D8PGU6j16wqw=;
 b=LDJLtxjbldwYvh3GgIKkNluP5W0Vu5i9PGvxRLt1huU/Fd8Su1IYyQ6nq0QaEaNV/WFhdjvLQYHxew6+X343hcUixBLKpqAfZlbfTj+DcR4ruY+uvQr0XBiEI+2V0xXArCOQSWi/6ddI9Z0ygj/qqu9fhW5RFK252BAwL4+oqAlTsGOjIKe4v5eXlAPE/piZsg4MiIYPNG2trfO5qjwoN4D89A2dDnOOazvbPnkU7JNGrXurIX/Ltkezqp8r56WgZwlkwnAixDGTW7yENNUbFYsQ9SYjoWDbSOHGcHJMcjBzqXOuee54rdozyrb9/BwlDg91ufHLrQxuKfVzZEGOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofxqNSnwOuedvt7fRZlV8R2scGY/9b3D8PGU6j16wqw=;
 b=azWz8vlyJqExGmcZfvaefWQgzjH8ubNErxyCsRUcyjsibGQcU9MqZkgIcnjbAzuNoUIyJq7m5D/BTf+UkVlqCtcCQM1T79xpD/RFIq0tcix/5gQP7TxULHTycrg0U1z3ICDKfNeml8QKHf6b9yD4gvVBkejiSCaQvdPgDr6xKIoRHG2dkb8AiTK1fBwg39W7zBMQAnKsr9BjWsJplYOwO5JTjL9sopL8Phwh0f85JDHvJcqOy9mGQkvqm4+qnrV1cYtUlhNQ+8QuXWUDw+2TQg7+iPeUpuK/B2Qkv/awPHMCY7G3rvD1Ks41WnJBSr6fdRpRCBAO5cvMe3N5oMBoBQ==
Received: from BN9PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:fb::16)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:37:46 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::76) by BN9PR03CA0041.outlook.office365.com
 (2603:10b6:408:fb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:37:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:37:30 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:37:28 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH 0/2] app/testpmd: assign share group dynamically
Date: Tue, 24 Mar 2026 13:37:07 +0100
Message-ID: <20260324123709.3471-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1625f03f-cd28-48af-d17b-08de89a226aa
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: aPOeeTRwN2l8RKhrfe8Gm3GOVxdLLljbWXE8LV+qQvajuvDkFBiLiFxPe1HSqLgRvEKfXQu3YBbhl9CsiBwPE4wUaAuWN6j83BAJCBLKlxVPY6uYEyyeDVCF/it0n77waDGKtkUWjxzHJ2ac+ASe9LkBB901y4z/vPQhcLARlPAT+UH6VCpvTJJnnIrafNOq6cnYc9XubqA+UXl3qyrqZ2BpiQyHvik3CGdNkY7H18+RmYHvptNXjCAV0YLuIseMaWQF6XnJZ8YixyHew9Dwnq31lRCOKESYyJMeell4U+/L8q7PnCey+Vk+uWkrcH222UpIy7CCuYzY0cA0oI6HV3BkG1OI2LiopVRihw56/U/tysVJZ9Tm/ao2QqkAjzRcYH/sPdEzEgV4QpzSTtJEFTdxd9SvMUdH8kejbDFzD80wr/KPkSqU6WI3C5jKP5jBTD66b3JL8R0lzBDeoccNFW7efr1EuDaE6i4JfqzytxQn95L5IhjngzLgY2aCyyCZdgOWStET+PvKT7ttx43d65/fFt75e4nM+zY72vWhIHfaFW3ESfZlS6Y/N0LDPJUJFhTbG7RYNMlCb13DgiVhvWcHDCzcnZIAuYhQzDR34QhwxZVDbHL3nRpwMr7Qo6MUvNn+/gZNbOHhodPURK/EF/9/aXoO8yJrEQyerZ5jHumsHSXE2vwT8/v9KqoFTmMarRgU5DLvIQeuIuTbpfSzF3bxgSEEihYDikIHijkmvy1S9uVffJ96KsC02IDMvEWATH+otfsVJ535Pc6BM3ryjw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pK7ZXxPbstxoQOirpdslYVa3yDoh6flYjFPYSSLaXTderO1lqW75IBjeSrNJTREGYgiS/SU7Q+Yuw9voo+CvFMrZfhw5FWENnXlLUlHAL7Dmh45Fp9KY4CqOAq6b3Mi560ApQtcY5+W3kULb3mzhiDFEhqGNcEPkZUtggtbZWaJQiqaJcOgRNT+YKXu/wAg3SsnbCTGrMNd1JtJg9KsJqnP8NJwsWDBl1Yo7DtMEIuKXtw2UqBMJtAln17wa8enw46FOBoa+bGdRRTKM7HLUB8G43Yj7LX9msJggZf/CBRAS2DqraRRC6JKHlZezbAhBnpsbXxRZnMSJX44Mk+R6tMvVKBttbGJGrNy1sXLVOVm110UFKcFrVLtNpOCzXtG1t8DOAgf6Sj29rl8vrt22Dj4eMmyu1pOWysbvdFYFOdkK1e77N4WqZbHeZHqwidOY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:37:45.7780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1625f03f-cd28-48af-d17b-08de89a226aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

Our internal regression tests have flagged issues with shared Rx queues.
Specifically, issues with domain mismatches:

	Invalid shared rxq config: switch domain mismatch ports 0 and 3

These started appearing after commit [1] which added checks
for globally unique share group indexes.
This could be worked around with --rxq-share=N option,
but it does not allow proper testing of all use cases [2].

This patchset addresses that by changing behavior of --rxq-share parameter.
Instead of relying on user to select proper parameter value,
testpmd will dynamically assign globally unique share group index
to each unique switch and Rx domain.

[1]: 8ebba91086f4 ("app/testpmd: fail on shared Rx queue switch mismatch")
[2]: https://inbox.dpdk.org/dev/yotjxacqrodttraqrr3r6ftut4cty66g6cjnr5ughswtatapgh@gqqkftskp3qq/

Dariusz Sosnowski (2):
  app/testpmd: assign share group dynamically
  app/testpmd: revert switch domain mismatch check

 app/test-pmd/parameters.c             | 12 +---
 app/test-pmd/testpmd.c                | 88 ++++++++++++++-------------
 app/test-pmd/testpmd.h                |  2 +-
 doc/guides/testpmd_app_ug/run_app.rst | 10 +--
 4 files changed, 54 insertions(+), 58 deletions(-)

--
2.47.3

