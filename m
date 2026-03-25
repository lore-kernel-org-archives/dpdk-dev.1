Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1978F109C04D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:04:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E504A41104;
	Wed, 25 Mar 2026 19:03:55 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010003.outbound.protection.outlook.com
 [52.101.193.3]) by mails.dpdk.org (Postfix) with ESMTP id 5A52E410F9
 for <dev@dpdk.org>; Wed, 25 Mar 2026 19:03:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1EA9z1jpMYuEneGJZXATSfCthSxEAG6KZagNziaPEEU/b9TQg7STLv3Uml2vNw6HJmIkRWSldq6ergxgfO0hv1Rm76bBoR7A5oTmJoPgR9+7ZCFVR4LaxaiaGvCBknDSDMhQoRdiKU/rKuaZQZdQXF/epaLmpqZpJ7+uuq3kHdJTqokpBU6PbHaJYfS0C6GkxWMM90CcHEccgx03NCSizxrErpoHfZmwrfDW5xz0KvAj0xF0hNelIKvWELOb4z5brVuJu8vCtk2Gb6LsiOC5whCI8nAcBoSmqfiQAmL8beOrXbRD3RgW5cqcaEWZNNmcfOd8StiEtBSw2Pi5TSklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJdMlleAPcTf1S7egvZUgUk5idnqfR5xQO4wDKrmqQQ=;
 b=UoPoebxuZyaTqUHLW98c6Q9G2Vo4wOB+M19HiSJpHg695/l9AoExBlqppy8zF3VGNDpQD5sB1bLlJNnxlLWLEV5l4jxpc/s+XSK7sglwdf/f+XhBFXy4vStInAauxxKe+kUjc8pOFZbVpG2d7m1X1A6SK6DN19DyUjVmJ8PGEe8zXZZBKD1XZbRPeuXcCje3bej2uCo2xt417D4QHGkileK3IYUVhECEF/WlYkFHIwmMozQyRGFVS/cOsNQ/Yjv1oKqH7tYSzNkHBO0YsnT74NlTq03JfboWmhmXJryK6FZ/oL3OiZc/Jfu1RrhlkWxnbA9wdkwyFmofyubYueRqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJdMlleAPcTf1S7egvZUgUk5idnqfR5xQO4wDKrmqQQ=;
 b=kfpYwChTgfet+TiYezfx0uL70ztahsDbyUg2w3tbjBoEfb/C2ODVVykjhtGqfElCTGDQc96o1RuE6Qjp4HphapyIiwuIdCA2UjnxVRRwWZb2KK7c2uwn1aL+TOI3cDf6YQMD/r3FfyNcpas0Mu0dD1Ztuzf3kqBnXIUXzKVKmTFqvVwVxq/pC/0LLjyw+VFWwgaPJjlTrndlILKKlKUAuU5qqjSwzjYikDYXd4aoFEEUpdxI8HecMHIacTCBBtsQDsC3Lzm0AYQBm9uBfZB27VLKzZmh49PmvSpXz8/KNj6KTJJaebPkxFUqNj4f7Eoi7guAkGlCs7Lb80mseT/4WQ==
Received: from BY3PR10CA0017.namprd10.prod.outlook.com (2603:10b6:a03:255::22)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 18:03:48 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::b3) by BY3PR10CA0017.outlook.office365.com
 (2603:10b6:a03:255::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 18:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 18:03:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 11:03:27 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 11:03:24 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH v3 0/2] app/testpmd: assign share group dynamically
Date: Wed, 25 Mar 2026 19:02:52 +0100
Message-ID: <20260325180255.57489-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324165657.23945-1-dsosnowski@nvidia.com>
References: <20260324165657.23945-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: edea8c25-b2f2-48b2-4b4f-08de8a98dc13
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: vnjHVsIOv3KG/vWI+BU+0Q22l4puvQF4U65ZdXtQuRaCd8Lo/VBQoj8i4dlo8W6YU6da+Kd576xSniOsdmZYviprEbHfir4Bg44uKPZTJyYT1Jrm5C8/eU462LDvM381L0VRa1Uwiz3/Fvi1z3SXERCLuiay0CwuG6W4+oCAUw2FrNg1acQ9CXN9H1zS7WxcvcEQMnyEzinNYE3zcpK7mMvAsE3Z3MREZMD1ys74mIujLSyWwGHg21KIA2iGAEh4da2dgtQ9VvTMaWR5H65bZRHqeRNcQLN7KUtLMkG9XJoa5DvfbLohtrkpcL6DO5AilkLh0CG4bXPZKjyuz8p0QB+zeAZeBBRshMfBuD44zfryKjLJzrWKqNtxM2lMMkyBdy65nGEOV7fHhhETVm69+izZ0ZHsp/zOyNx5c78Oz4Lsyf69t3zIvgs8ilvS7QbuzE6XuoaLnnxGRQ7DcQX6TrMfOLGvUNO6WdEDyAFwM1OTPgPeq1qiO3COL0KJOeI31tYJJl5aCXvTxe4TrJdapysPZ7/zWa5V9vnzjUuetVmviruoqMA3YhoYWdeZiEpwdNrOooKcgCLqmi+Mq3/EunoXbrCF0brTPqRARaEo9DQnTzsIGXlQFCdbh0I76MxBZ6t+1CgBrSi7F7wKYcKRkxqWVoDmW8kcCMYSExIpS2dJKCnbBm498pLzlOhSE0ZFixjOnGjg2CQRxh9FDUSlUfvdcVlp1VaraOA1zReIcDYeYpeiQI3aCNPa1eFcTEOPlCc2RxYUz4lgba1I9UqUOg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rHQGTIaeR/2nXq3+7PX7A5beHkQ2hSUCZX2gEVL3Vuy5mN6qv9kURjL0JH5iKjTmdSCTgKSK1R9ZHrV6U3HZyEj3I9NfbG2Xpddky8Kr0yj5alfuP4TNi9x5ixTWsoEk5qSvis59PY7mVgjrm95hih56Dvj2WlDEBSXB1lrujhRaw2lGqTRbssudHKldi1VJfz9Ft3jUNAJbwFDKq+KxSwMbk7R5TjIxLEaFwav917jFrozxMAgfSALSHA4+Fqvb+8OdmiQhYmf3rOaP1+77X9z0EFcNXXK+WuY/rb5Dl8goqVfRhaXI46QX08PTFF0/rkhzpCH3uRG5ZulRDDsyRG+dNDvwDoc6UB94vW/YzFBXsvvoBexlksoVy3jhLKRfAqYTMKm1Y5v5v1t/iHi5NleRvFrg90A9mmqlQOnLT5qIENgnZLDoBC61IT1Jn/0i
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 18:03:46.3746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edea8c25-b2f2-48b2-4b4f-08de8a98dc13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937
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

v3:
- Use short circuit return in assign_share_group().
- Replace assert in assign_share_group() with error checking.
- Do not require optional argument with --rxq-share option.
- Fix typo in docs: update -> updates

v2:
- Add releasing share groups when ports are closed.
- Add static to share_group_slots array definition.
- Remove double empty line in revert commit.

Dariusz Sosnowski (2):
  app/testpmd: assign share group dynamically
  app/testpmd: revert switch domain mismatch check

 app/test-pmd/parameters.c             |  14 +--
 app/test-pmd/testpmd.c                | 124 +++++++++++++++++---------
 app/test-pmd/testpmd.h                |   2 +-
 doc/guides/testpmd_app_ug/run_app.rst |  10 +--
 4 files changed, 89 insertions(+), 61 deletions(-)

--
2.47.3

