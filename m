Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F61CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 14:00:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CC85402CC;
	Wed, 20 Aug 2025 16:00:03 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by mails.dpdk.org (Postfix) with ESMTP id 22BF24027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 16:00:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnKvONs0mUGu2/kLxKmExMwfNjyJX5cLsJtt2lqjDGi7IgMrhDlwmk6ZYE97Mmm3WPpTZZMs1ufEUQKyBrcpjvYsxQtWLK40KRshrZHN6T9c4zfMw37u0+Apuj170vsDNdyer0VzQu/rYt66mVZ63pPnMHw7SzDftJJr6bfFRMGrje6Uv5/SA/D207s/eVvZ9VtTQCjeYHIuhmWSrPzrYxCviBEuGMnavPpBc5NeIf/HtMfFGjcRv2sX1Q1WdYog1KbOxGHUQWmYQmexIb4zRCrpLFEdrfnMUTvSoLg/rmYJEuC35g5x0G6Svkeobq+UetKxCw1MrbAA3zXfCICsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d02m0LTD1nk9JXDANSIRTU+64hqYzXDvYQAq5jKvpSM=;
 b=j/e+o4TYP9PhxrU4xmaXuoa0vXZGr/FwReiIGLLe09OYXyoOROJhUJxs873ZitNbCCILODtObqI1MfkkhEb71TsIl6aPNpsmvBSDKjd3ah7VILsaTuXJfmEDnBMUa5r4xEJ93yH3lb+8/FiLra3cgvEjj78l+KEmLnqtBk523z6e+waoV4K1/R2pQV0G1rc0bzOri6HRlnzB82eWVFf23cA9bnvvpMTIjC/jsMQLMjXoD9sTu1zP5qFM86eMklW+utFPmb2ckEmSzP2daeBrfSUzY97YXrnc/mkh2v9BlMpEzAyUAp6CXiy6sZkMMMZSWXSwzHwnbA9vKpvoc8YJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d02m0LTD1nk9JXDANSIRTU+64hqYzXDvYQAq5jKvpSM=;
 b=YZ6fxMNCzNxtnyiR/a7HfKVV2XDnXDPpDoP80pssT8+UK4FOjUsrEwC/2BkYIFgd3NhVC2rCFeyY5D0KOhuJt/bInYTJlLZ5wvM5qSN9wkf5QQfPgAVdvAX39GaFBQQvhEaWZFnCKufzAWSq+6kPgeBg6vk5yr5nee/yQ/ZBZQS56YxatPEzMsVOUpEZyV86phhODWHqce5FDKC1mIMwUarermWqHgA6g9KFW3tciVkfIMV0Xnsx+It4r2I2MVVXKu5QUwFr0zXPrGffJ72zBj5kNUhTWtK8g61M02pwYguVRPq2xtx95/amRMRbEIDvZfyEsCUvT5/Nr86adxOPeQ==
Received: from DM6PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:333::18)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:59:52 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::47) by DM6PR03CA0085.outlook.office365.com
 (2603:10b6:5:333::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 13:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:59:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:59:34 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:59:33 -0700
Date: Wed, 20 Aug 2025 15:58:30 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] devtools: ignore new warnings on reported-by tag
Message-ID: <20250820135830.pn3fi3p6rq7xlnyz@ds-vm-debian.local>
References: <20250820095050.1090859-1-dsosnowski@nvidia.com>
 <2450283.yKrmzQ4Hd0@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2450283.yKrmzQ4Hd0@thomas>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 389ce559-3f4d-44d2-5344-08dddff1d54a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eZaWEdTlV2yq/pqTn8uAqkDXc9ANWSycTW0ZUvjclNGb6ID4Lue/1XR5kTGx?=
 =?us-ascii?Q?NtBS2Keu7tu3vU54hpVtAKd7ApG9PcVNJ7AgljAuLenNiJ9NXkQbycnOhe4R?=
 =?us-ascii?Q?D/X58gxbx/lOzrKjyhWn4Zpf6k/AfYeuw6oHtn/ZgjpDU9bN7Rdig2QS92nC?=
 =?us-ascii?Q?7GDn0NKPQR94T8JeGFXCGrp4cOV8AvVn+Whyuj65htASQC2XpgCx3TtuZ+ou?=
 =?us-ascii?Q?BhGO58IBBiIOv8o30Xuff/v1wR868YdB7TDr17+6/vPAKLuPk/6xHg3Xdzi/?=
 =?us-ascii?Q?7Bcx0ncjwKwLsCT2OuG80As/bq/qMtGHx3+gT+W/Zci6ro/B2TgdOT9XSTJf?=
 =?us-ascii?Q?Jhs7ypWgWVxkQH9mkO75wumtjqvV4+Zsl4TV8F8RukTvWfZ6a1DjV6K6OU//?=
 =?us-ascii?Q?/eRJPluB0IRToCQWwWfgoCMP4Rzx0xU9Qdi1l7IXxtXMwNRo1b+A0NnB3Qnn?=
 =?us-ascii?Q?cnlczuYSzdixg4xoCQffYUYNEY49rnwiU4nAlJHM5MqCjdJ8vWtZqBlIpSAi?=
 =?us-ascii?Q?PXQX/D/otVHyrRQPk7isancsJ8nNjGrGkeE9zBZagomiy4q6+qD/bjMJFTMw?=
 =?us-ascii?Q?KSary7PBZxzhsFNxj28p1GXJwzlCQbreQaFfpxLMmU9r/MfmZ1dCzwfW5b6k?=
 =?us-ascii?Q?3QIsThaFoirUlIpBTzfNKYjrjHypdn/oeelt3EDN4ba9tCIkT+3B9WzhfqRO?=
 =?us-ascii?Q?fKy2ODCFD3HVyXHAObi3kudxYMspXwoYM8r0JmWlutjbQLjQTg1uVh2dgM3l?=
 =?us-ascii?Q?Td1Hh6Xdo5zbwQJLv5GRhUec80sheaQG6OII2gbPCwJRnpBiLLkvzqIyWX4T?=
 =?us-ascii?Q?NQKkrZOrU0OnsBQXZtvubC2E93LYnmgxMJjxHyg/nXchR0xgfYc9uPxLnMMu?=
 =?us-ascii?Q?b6hnjtF7xmkJutqX7J/Ws3lCOxywz90m3gymh0LsGYgRwfldP4rXFZSq5/eu?=
 =?us-ascii?Q?e4r1vESmj+jM0wsXw8MR+RPchXM3o2ZBe7j1eFbhMWfx5DYjn2FQngfsqFjn?=
 =?us-ascii?Q?cpY+M4WE0ZW3eI3QhwGQHaL9VTpzVw9ZalzffDl0Cw90Zo/FzT9jDkBbXRs7?=
 =?us-ascii?Q?5bdWMUHnErvTitsHHVBUxlyU3UtbjE0N01MfMAR8ZYUVJGY0NHmLS0YvnGEk?=
 =?us-ascii?Q?4zsAYekp/x5FQLQiwY5Ie6h23AhNDAtuUMt179Frty4rsPwsTJB6FOn9lKys?=
 =?us-ascii?Q?gOVgvYvj3TqC5YeXK6njQhwEakEL33syEZc00DG45o0M4DqkkHYDwTo2IiCv?=
 =?us-ascii?Q?AKbV6QLIVzc/NdAPjxK61cmn3aZltb6OG+gHTjPC+G1e3ArYvoYDmHqEJUdh?=
 =?us-ascii?Q?n5kCyYjFh6Id0iWFinXkv+TBsEc3H3CzMvOTr4//2Y4B4YeyZgvVLIFQNpbn?=
 =?us-ascii?Q?SjFA+NlwYuF/3Qwhb1xo2hoaFwGoPGMyvhlDVlIEhk6mL3WB/BQVdJ4w8eR1?=
 =?us-ascii?Q?dxjBoK2MAmJqnSDObd24vOa3bs0tnPviwRJYMcR5W/ewzVh113W3KmSJZFeL?=
 =?us-ascii?Q?w2ZLxbmnmjz29q/yZmnxdQHMRAXiimV4ZJYm?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:59:51.3500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 389ce559-3f4d-44d2-5344-08dddff1d54a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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

On Wed, Aug 20, 2025 at 03:33:00PM +0200, Thomas Monjalon wrote:
> 20/08/2025 11:50, Dariusz Sosnowski:
> > There were 2 changes introduced in checkpatch.pl script [1][2]
> > which verify if Reported-by tag is followed by Link or Closes tag.
> > Example of the warning output:
> > 
> >     WARNING:BAD_REPORTED_BY_LINK:
> >       Reported-by: should be immediately followed by Closes:
> >       with a URL to the report
> > 
> > Original purpose is to link the patch to the mailing list discussion
> > and/or a bug report.
> > 
> > Since in DPDK these tags are not used, these warnings are false
> > positives and can be ignored in devtools/checkpatches.sh.
> 
> We use "Reported-by", it gives credit to people doing this precious work.
> But we don't mandate a link for this credit.

Sorry, maybe my commit message was misleading.
I was referring to Link and Closes tags in that last sentence.

The new check in checkpatch.pl will warn if there is no Link or Closes
tag assuming Reported-by is present.
It does not warn on Reported-by itself.

> /* snip */
