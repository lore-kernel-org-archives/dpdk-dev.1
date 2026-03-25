Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C22109C059
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 19:10:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 505CD406BC;
	Wed, 25 Mar 2026 20:09:59 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by mails.dpdk.org (Postfix) with ESMTP id A20EE402CE
 for <dev@dpdk.org>; Wed, 25 Mar 2026 20:09:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/5mf6hslWY66divL0NKbMGYjTgfsX3onG6TWR0c6v6TIvOdrbdPe/ilB0mLqyseSyOLPWKL6DIXnxea9M6gt5GoxqLWmpEL0ljRzIneoNAh+Nku+pzkQ56ugI+jRfmE8GciPecafShZ2MEJMwshqchS636/nAKiYqZFw+WGdWuLDzWr2kESPCa9pPFxqOh7QwRqipM4HtpieDTxolYKcEQ5vy20GcGm8c9VvhWzLPSiqbuaVqGuky9W3VrcsGFGAYKP/TspIpA+8vgUTle5xPQaZ1/KoW79zliwIxvZJd+SQ2zvwmVyy1BNzOAmfpfzsZFmv6dPKyX3berpm5vuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4j36bpOURAehH8U1j34Dl0YpKaFV4JGzvHTvZlT58g=;
 b=qNR3LQ0L53Zbnu3WV3MZpFS0DW5s8J9SsjCExnayKL6QNDUDjJjpQbeq6HHW8rcf1V6lTcwjsATKLGJ0ORushjTTSY7u4JA5DiBP6jQEeKDCE1DiUJdydAas2sMoRG2YKrEDqjZrsI8pIxJKE/bSAzLvChpqUYmA1YI5/hfMG9v4b+7hJqloI4FYcO+r9yIcWg69y0mUeuXV3ZLcKPQVk2tAlE+odOrrDN1siHuehDLfozOPHQVfnL8Gkg8+sWX+7RuaNUVRNyP8BBPrXIprPeTmrBp6o0t0eQmq+5pEe/DmFFQdngCZjLJ56JwyIgWrwC6cjT6bbNqwp+Bi7gXZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4j36bpOURAehH8U1j34Dl0YpKaFV4JGzvHTvZlT58g=;
 b=C/yRDK+vnPfyM/QDF/mM4IbrQyGc9/76YsOQxTxMwhnpZKbkhEi+l53MwBSVnK8EfZLOYDoKEcItce9K8brcdvyqK5TVXFbRoRPQP4ABiEYwu6c72Gf4G8kJAq/yWd7G5iwlogwZU+K119FvhMBM/FxTgsH/SlNCitIXYr0DqcdwiuBhb3uYG/CcLrqb502PGrZ38PJ9CPwkv78oATGol0sp0VIigdeGaJVwXW21cM+y4utsP2ysLL2DG4sSuOjYVV+zrEmcnIunvoZTAcxW2H02PuXWK6tx9Cs9EZfgpgxNwOxVAnp1ZvXQhHdghAcxPF4bMcrJwPxlMl5U210+sg==
Received: from DS7PR03CA0166.namprd03.prod.outlook.com (2603:10b6:5:3b2::21)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 19:09:51 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::40) by DS7PR03CA0166.outlook.office365.com
 (2603:10b6:5:3b2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:09:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:09:35 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:09:33 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH v4 0/2] app/testpmd: assign share group dynamically
Date: Wed, 25 Mar 2026 20:09:04 +0100
Message-ID: <20260325190906.68531-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325180255.57489-1-dsosnowski@nvidia.com>
References: <20260325180255.57489-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 43293c68-a090-4ae5-6f97-08de8aa2174e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2ikv/7alQBJr2x8NG20iQJOaVeoMGm+o4bAwCHV460mNVqR1hhyb0XknzUrQwiePbHdjd614ZZ/1pvsTeKkma+i/M/bDRIVeSAC8gjpcyLYqFcAgTHYCLQL4AYLFzM7dtFmFN2ZpEI6omrwSysNXWp3edpbBJchXEaMWDsDY8cTToEb6FfRBMPDKVBHsNGBY1Ja9RsTM0k8CSGTz+nfn3iaKlIEaAyzAA63QeJCbdRDIg/yfyaV/J+QSiMKQ68IBCvXJEGmtzhKogPPv4iSBMrM50vd68eElAsh0G7GR2QTyoWE4mPEyUIG72boGYEL2ep/ChMuNM2Qc/hnumjdLTTlPoL/l9p2k32fKU1HcYVRpvI6x9bZDIqZi6jcPh0eJUmyCgGWgEcZETFgEZHTLquo4zYo31GyIp2xfJLRgXBaS1UGf6gA60sbBFC7HmB3sA+cPuEFaUyR727ZCjWtLWzYV77qa832yIqAvZ0rmSuze+XqkDCe5LvVGrGUVt2F5PQhAeaFnmzLHL7jcVwvIks78MZb0jcaMg7SS6j2uxu6eapLhgiffTSdKItMHEVYO9AvY9b+i59J31TDn7SlF8NyegKe02AfinMqJZuuojxikqShS8gHv6it7QV01aXnDfze4BImaJiFAouvBldyzN9eBgo/I1YUEH50OWECCnJuFlZ7zvjrqDsjLggMMlbpGyPxC+9/YEKbtj8mT1nm5l3cOkrROrjQtKu8a4zC4iaYTN5v1V+/zNqrrGqIavGIvwcsUNSacirePMxEhJsWhMQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4wF9DfhnQFhRewge9M+eBVT7SZHNMYRxXImfRJkU651CmuIAmixtv2rjh+QiTivpCThe/3EYYVgt1T3lwvwMlCgZYbEyAQOZbeRefN3jvYJy/sMLSeI+U+X1YvjYxZi7SYgMpMMJfCIJpIK88hzbAyArNuCaCs1imTaepi8cKI9psmlagHIn3ZxFLzcrFLzVm78Dz1YQR57Sg+9tm5+61fi52mtXEZu5TnO3rArh86ZQwNxTqixA/40Ef8pVBQPlWQUyVoX6N7bvxdYaVfULXvNzb6O3ZBKcjapxiEJl7CB179imeCxi0BETtzyzfXyIKa6lFXUR2OwnQGZcSuYC5HFYIcYukqPs/nxkWha+AhUXy5M91emeWqpMPr8L6cOMUod3YtmFMgbhsh0COZAL2NjiSAAVNaMvZTwCHSSkVnFA7b5YEy4gQ2x6wb4HNgdt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:09:51.2051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43293c68-a090-4ae5-6f97-08de8aa2174e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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

v4:
- Use short circuit return try_release_share_group().

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
 app/test-pmd/testpmd.c                | 121 ++++++++++++++++----------
 app/test-pmd/testpmd.h                |   2 +-
 doc/guides/testpmd_app_ug/run_app.rst |  10 +--
 4 files changed, 86 insertions(+), 61 deletions(-)

--
2.47.3

