Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0A7CF45BB
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 18:19:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D8C340431;
	Mon, 12 Jan 2026 19:19:04 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by mails.dpdk.org (Postfix) with ESMTP id CBE7940041;
 Mon, 12 Jan 2026 19:19:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKLZEMg99Z5tAYP08krK+cCLhJzCE/gmEMgnZ5FshO+twtJDTI16cWkfElnu3ZRB1z9R6Mb0U3EM5OPB08gT/QUgded3Ijj5F8ySCI2k2gzP+IVjyEgmVgj1iYY8FUCLW6jSlUIvWjzBhNX6EVpjGpGP8HCeDslwCvAc/eIpJ4NuMY85i0xzR7VKZ1zKz6GY6ObHvG2vUwbfEHOZP94J6xNHaU1yHWriDsDKmDVrlCmS6G2KkCbIKf6xcV1KvDkONJBXtl/I+kVQO6+u7v8ybLZSHsoBgrJnNqhvv/6EGxLw67o53WqNIKoCBYw15NYV6sc/LADFZDCyEMD2hhnrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qw1a+aBPPlanbZOknzT+oS6tb7yambXVnPfpFCAEN90=;
 b=uhy3sH4X76GSv/2eu8j4WcCp2/eeGbPHRmwCJo3em7ISFYbew9hFVI2w3HsRYeEPSWdlvC8egwehLni4cdvruKTTqE22l2++YUe5Rzv+7ygHXqqSj6uIVZ4JQLXDjOl+shdYZNGLXjopR7lNEq8x7YwQHCKZhJ/RdNPu7DJV+mOdyrUGyHzT+kPaXVq+dsdaqG3HJNQ6wh0mHLe/iQMOuDqDnBozdDs2PivxxRCYYMrc4i5+oVbd/rnbOu5coNl0CnxKVefiIUsJw6PwQwSlxFbuVt3GfK1NqIoEVupUfmbHsVUD5b3sme3jU2EMeSUTk+grk1OjZrCdPNSZ3PAfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qw1a+aBPPlanbZOknzT+oS6tb7yambXVnPfpFCAEN90=;
 b=OpaNYembxbiyshgKqyPb99bOb2Wuw565sBoNtB5eZGLESv65W+zAJMpsMJbmVPsJmRHkPU8982CD9DTXPhvmoraYC+uq3sysl98aTAAKIQEDDHnqEoRHmUxGWp6+mKcXhuQfpC0K4BfKjnSvZ7qxMDOUa7R9UnF8ZFMxDd/H+A/04qDwqOxNdVH8hh4W0amh8AmBKYANwYUCH6riNcFaFinzgWke8CpCo4OxhIm6uBioqvW/qSwOTnPWjZlFw2EqrzhokyN43wqN+Qvbq93UF8XhzFvGv/JQ+DeL+5/eAmIqCqjkQY460ip7Z+DIOYOKbOKOid4Rh5g3dPs76c248Q==
Received: from CH2PR18CA0001.namprd18.prod.outlook.com (2603:10b6:610:4f::11)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:18:58 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::18) by CH2PR18CA0001.outlook.office365.com
 (2603:10b6:610:4f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 18:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 18:18:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 10:18:39 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 10:18:39 -0800
Date: Mon, 12 Jan 2026 19:18:36 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, Gregory Etelson
 <getelson@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH 3/4] net/mlx5: fix internal HWS pattern template creation
Message-ID: <q6q7ibgbz2atpcxjob3qfmoz7bosd4fzvoywu3grefqys5uhwm@k36iimqzuqky>
References: <20260112092439.14843-1-mkashani@nvidia.com>
 <20260112092439.14843-4-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260112092439.14843-4-mkashani@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: 0209d807-3648-497e-3d5d-08de52070d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g2/8KL+55cnHFw7hlREAuh2DvqGkUesXxi628oJvJGwTgkeY7YVh4e7H3qBv?=
 =?us-ascii?Q?6QFTAWZVKFDO+zmLWqN8+tyjsb9RoOx9Xcll7nGvuPywK/zHeYE4tgI+vPXM?=
 =?us-ascii?Q?lZ7ynT5jL4SlzstuMQCO3DQsTlGIAqon9KFKOAX6OZsaYRnSNAg3Jt864gcE?=
 =?us-ascii?Q?9v/hEmTjUs5hYUng+ec4Rj9nWcZ8tKRZgsR9hbkSn2j5nhOzS/+V3vygMQwW?=
 =?us-ascii?Q?a6KG6nBSD0F/VUnrIQps/sW6Im2ZzsfvIplQxlB5DaMUUZHq7jXsMK5yuclP?=
 =?us-ascii?Q?kDG0L6Q0jEdH/tNtyXOyPIvND1zRU2SxCE8WSVfgjig35x9Qs7tCRNkdaT6g?=
 =?us-ascii?Q?3fL0U06Fp6ao6aMoU81lR6svGj/U1CLETNf2Sx6f4vVnkwx2SodDOvdKOR9/?=
 =?us-ascii?Q?OLZsUhMYc408d21+i4t4Zdef+sJzGE7rRcwGDH1y2nyPagwSqnEiof/6W06p?=
 =?us-ascii?Q?+g+x3SY/gOllx93+SeHEn/9ycggcJZT+ckRhKwXtprp6/0+VoZ+xWboqqne/?=
 =?us-ascii?Q?hfWaulqoetbGD/ZnNPbjvxF1t9WeobCpIERgxfOD1tBtH1+1Xkm7T1eo7Wha?=
 =?us-ascii?Q?e9n/SJJYRhx6wv67rQ0T/7u3jOUNU/sH14RlsFOQpsMHSEOvvxAxJ+ABE3fW?=
 =?us-ascii?Q?84Ngf0oGG3oJ6Vz5kCRYwOI1of5otnVdghYf0mngM8XmNM8vSR66YDe9QiEE?=
 =?us-ascii?Q?g1NHprTdZBEY8ejnCCF74eaPZ2HXsO5DUb3FfhwJLI/1OaPAzzHpH5Fkr5IH?=
 =?us-ascii?Q?UIz5QLwT9QwvhYzy60SZdH5XbnualjOObbYJkgIKbyXGbmMvyGqGeW0A1mv3?=
 =?us-ascii?Q?2M0yvw+NUFh4pE+NovxL/G/O9Fb4Pjm6/dg0bqQ1a47TM9B4en7e+DdTR1qf?=
 =?us-ascii?Q?H56T9nBALEDbizevEfYYVDeK4Xs0P3F/OkHiNk+hnSj3IUQXp1vsqmL7/qdq?=
 =?us-ascii?Q?WS84RcFNzHwpRLL9Agx4BONQ+J8yKdJJFUfVKSdM04RRyxeIdeGQPp8Hlwag?=
 =?us-ascii?Q?ntQzhiWaL/LlXfz60HEKAYNrcYbg1Qy78q3Bc753LjG1noPkTHhlLhKCjBaF?=
 =?us-ascii?Q?kXZi87SJonHy9hYVLTb13fzZIHGQlzdXs1ibhHG6aqEyW5wpoVdyb8bOp5xJ?=
 =?us-ascii?Q?2hDvWacbXxM1emlrsBtv1pk1OtBdb+UJNADdv8Fm7DccnfV2qdKCuFzLVWGa?=
 =?us-ascii?Q?3j4eQge3uJQewaeSCWPa1HByMlF7UvUF3FyJn6BHquhcIT0XOVKBVmbKnXiK?=
 =?us-ascii?Q?SNqWa9fGgCZ8nO99SMlDiY1nBcLARaOvRwPnCaigdfhYmpFMlj2Bjrf4pCb6?=
 =?us-ascii?Q?tO5qrCu9UvPL7BdqyvxTDaFDn1B9nrpDIOrTxGDeF5LEOE4GnNC7pGkKYYQT?=
 =?us-ascii?Q?/nn97+l+WFRduLxUNFQOrKHHHkrcAus95LEB2tqtQSNQPXHAOC3XopczT87H?=
 =?us-ascii?Q?OXZLkuuT3IXPlxLY8CDJ20P379Vu7zWVV4vHwrx7ip7r4DnKj/+mzsBVwztf?=
 =?us-ascii?Q?rNFc90wetZofEEwJXpE4n/by6tyvsFB6U23T03ZII8pUZFeuBkSNZE/6Pdq1?=
 =?us-ascii?Q?un4TkY4KKMcOAIcJrJM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:18:57.6244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0209d807-3648-497e-3d5d-08de52070d7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802
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

On Mon, Jan 12, 2026 at 11:24:37AM +0200, Maayan Kashani wrote:
> HWS pattern template creation tries to build a table with
> the tested items after basic verifications to check
> if the pattern is valid.
> 
> Time consumed in that table creation can be critical for applications
> that require fast PMD initialization.
> 
> The patch separates pattern templates to internal and external.
> Internal templates are created by the PMD and are considered safe and
> can skip some validations.
> Pattern templates provided by applications will be fully validated.
> 
> Fixes: a190f25e6a93 ("net/mlx5: improve pattern template validation")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
