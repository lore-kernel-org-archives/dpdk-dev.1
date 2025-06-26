Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9340C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:33:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4AF84025D;
	Thu, 26 Jun 2025 15:33:46 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by mails.dpdk.org (Postfix) with ESMTP id A922540156;
 Thu, 26 Jun 2025 15:33:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBbHxxXU3hmA0/Iwy3YpY0Mg7E2vR4soi6KpgsbzY3ip+NaE8ihW5waP7GoqJBeCyvzqvcuxJr8kLt4j0X2qHdHmh+EdYYpMpo0CM1OtP8nvyJCSANwoFlX9flAEwXCa0uNe/7OVqnkszTD3a7rZUXZvoX32zzUM52M1MG/nzEs+cKyVy/Yiy6Xe0B1hs1Erbw1owPc22V0HP/K3b9N0TFAs0kYRH9KUCgxaLG6ZoPf9cTrs5E3xZPQZP1touLYJD1gvRMlgioXSC3a6iBuIIDF7uOzEDWrAlZggZkz/KapqNQp7rS0WbI02wCqqR+QJJ/J4E13zVzlNy0KvtfTYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmE8i6BrSofWMZQB6r3hmuRVVBfC+FIIbTSdyfT+/dY=;
 b=WwZiGmdnCgo8YcH8LhjX3xEeyMBlGtgeO4T6F3UCu3pnu+ITqWkxF9KBN7jFnbvT0uMpRnLizVl2yvJafp/OfwEPKIY9JTByvjqT9Hsm2EzSwkvxNl0YuYMp4bGwsG0/M4tzdEGTBIZbIHg3CEj5h+dwTm7UHy8qY0NKDrGIb+SObCFX4bydwGWYzmr3TtCeVPvkmxpg7J+qSjRtDSg7F0UNCFqWce+cMfQCC4QLPLPPrj7Cdho9gyIEh8uVRcM8nv/eM0kwWhU+nSNke4v0q1z2FAwV5qVou+XcZFtGDM9kOB3gp22uiNGwIkouFcCy7tVveQ+AulcQyquDaJJ6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=uetpeshawar.edu.pk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmE8i6BrSofWMZQB6r3hmuRVVBfC+FIIbTSdyfT+/dY=;
 b=QOMIKkH0WsjIXxLQIWiqO3LJ+leFkoGUt0wM3aSGk4mcPclpNTVk6tfOpQaQAQZzxUcOsVDRZQM73yDqD6gIoWZS+xnOox/u+ipzzWFRPAdnM1JYRXgFZ8dqn/j0NeYZYq4NL4F5EF9/aEJ3hDbAIA6CKM8rjeWqvLxz8JXGsx51GTjSXanOrvKWpmRXpFHFOE0idPXn2PWf/gWk/Cr166bcYCS0R/AMWpxzVObulP8CSRgYkBygscSzPZ6mOILQ26MSrSRs0GTCLXo6ZRzY1s8/Lc/uh/yDpUQc1VM9gAFCYVe4S3UihJg6deV5jZOeaYzUvE6VzL9ujpcgXrXY4Q==
Received: from CY5P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::11) by
 PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 13:33:40 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::8f) by CY5P221CA0006.outlook.office365.com
 (2603:10b6:930:b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 13:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 13:33:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 06:33:18 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 06:33:18 -0700
Date: Thu, 26 Jun 2025 15:32:51 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>,
 <viacheslavo@nvidia.com>, <bingz@nvidia.com>, <orika@nvidia.com>,
 <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: fix segfault on indirect action age query
 with conntrack
Message-ID: <20250626133251.cfa7hd5tbclo3xjo@ds-vm-debian.local>
References: <20250626130702.3921887-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250626130702.3921887-1-14pwcse1224@uetpeshawar.edu.pk>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: bf278794-ee61-4f4a-7f11-08ddb4b60f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?21exm3UYM9zGh5iWmYE1sLaQZuvMbBqm5ePt9CW4fpPzQBHAeDU4FGCfBs1E?=
 =?us-ascii?Q?caZi524e1MxEM2OBDGVLi02R08NG1A3ZTlgc41HpkKknpmZr+wx6ijIgpULj?=
 =?us-ascii?Q?uC+sB9NdC85AWWxz05WV8hp7foNPZMd7cDBB7SWSv66NdTp+YJCOlGLck7OZ?=
 =?us-ascii?Q?nBQCckUjSH6kuEVzZi+44Rgmv257dN7W7iVCoOvGtRDPZUm3b5HPNeHKB0aV?=
 =?us-ascii?Q?ZGagXcnVTxXGIyP5z2K7WPeXVbfJHyK1SZDjACwGLxHuHbFYbh1xjZsj3OYY?=
 =?us-ascii?Q?a0Do7lwei07JybObxy5gZinuE99r8T9kNCg7INocuZlq7X2/+XsgaML4Eh30?=
 =?us-ascii?Q?T3tU9YkVD67usXoG5qmuCYH09kumCU73+jyowXr1NP95iVe//wFhLAMv8hmX?=
 =?us-ascii?Q?RyYi9NrB7dj7/Rrt++TZaguAqdFrpCVol/y3d/xsfZUEeeZ2CHoLRaik9ZjG?=
 =?us-ascii?Q?hFdEH1ZFDkAQJg0UdcITbi0r27UOzdYFhvcQYPMeOW5ly0MNRorg/jBcEbJo?=
 =?us-ascii?Q?xIbIR50MT65AJ5FLknn4iVAHsAsU9PRbXepoYFUPX/+FP9wnkVxyBtvZyPjx?=
 =?us-ascii?Q?WAoiekz3X7jnlhlyYHYzKLom2wLxRXdUq9BK6knPrj6ztS9j6mzUAutIToaz?=
 =?us-ascii?Q?BlYvbMLQFohSIKUYA2cxi9EiIabNsLyYPNr8SjLTEzl9gvcLR7lVf7JCoAZY?=
 =?us-ascii?Q?ygtk6oXhdfrbJWUdi06Gl1bq6LmDPw4QCSPO4rmLsZLEee3AiNekeRpC2JH7?=
 =?us-ascii?Q?rq3L0crvzYlc+NFG7+xCbeTtJcOgRWXEee4VugAC0mKghtucBXYheBgHtau1?=
 =?us-ascii?Q?UazKxDpMVSdU0zK/YxEWCio40aW1ZOEKXt34KZkSn9xkRt7tiqXMHtDezw2X?=
 =?us-ascii?Q?6KC2Q7iTqVq/Q3oSpfmnKVP5wsx3RyruK34hRurxsTu8HH5fwwdcCTWZQTjo?=
 =?us-ascii?Q?ikF75samC0PfcyYcI5wfgbJ4LKZ2Vf9Z7N855MnGbGhqPgKbQWh4BOr7Zuek?=
 =?us-ascii?Q?+G4jFQ6jb8Mrx5sA2eaH7ckdl1QmDwVNm/gwHk2h5yGarlbPvPPUnjaTKY+p?=
 =?us-ascii?Q?+PT0tAzhZ3RdhFmBbz6jzMcqm6lK74KKl1oBeQi9zvwyKgqnJ7tY/xD61DqO?=
 =?us-ascii?Q?/j8H5+hCR9ANeCy78LTi88jHU6SpiT7OV4MUFOdki+see6N866J/Bv1lg57I?=
 =?us-ascii?Q?0RIJl3GvfGppbq6clGMlUkpKRbozG1N80K3TFXBapOKWzyDw0qNk6sTVQEL1?=
 =?us-ascii?Q?EPgc5U8Lci2aDwE/P+F8o/GcqDkTswiQ0s8/JnxR2IKc3YSOxAOgljlyhwmm?=
 =?us-ascii?Q?KKENQeuFtjWB6lZp+18b9cSiO8fl4bT4jyge4Iz0Dtafe7k9BnmcT8zBJfWx?=
 =?us-ascii?Q?opAf9xpqmi6IXoG1nmowWwA67Y0QZN9GYhwkeht5R0u2u/yMn0oSh9bTbyfr?=
 =?us-ascii?Q?WpKX68C1Lbts6dP6l9OFOUQr1m7M1JTw5XRqEntM2Ved/naJzChzFVeQ3cJU?=
 =?us-ascii?Q?lnT6ozoRnYlrIknufNuFdT1AmvxtixRTYzdvvzjvRnnV0Yr2Td3Rmg19LQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:33:39.2917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf278794-ee61-4f4a-7f11-08ddb4b60f7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
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

Thank you very much for changes and detailed descriptions.
It helped a lot during review.

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

On Thu, Jun 26, 2025 at 09:07:02AM -0400, Khadem Ullah wrote:
> v2:
>  - Added missing check for AGE + CT conflict in flow_dv_query().
>  - Removed unnecessary null check from flow_aso_age_get_by_idx().
>  - Added Fixes tag for LTS tracking.
>  - Ensured .mailmap and Signed-off-by addresses match.

In case of any future contribution would you be able to put the changes
between versions in notes section of the patch?
You can find the details here: https://doc.dpdk.org/guides/contributing/patches.html#creating-patches

Also, in the future would you be able to send patches to all relevant
maintainers? We have a script, ./devtools/get-maintainer.sh,
which extracts the info from MAINTAINERS file.
You can find more info here: https://doc.dpdk.org/guides/contributing/patches.html#sending-patches

> 
> This patch fixes a segmentation fault that occurs when querying the
> AGE action of a flow rule that uses indirect connection tracking (CT).
> 
> Background:
> AGE and CT indices share a union in the mlx5 flow struct. When using CT
> without age, the age index is invalid. Querying AGE in this case leads
> to a crash due to reading an invalid pointer.
> 
> Fix:
> Add a check in `flow_dv_query()` to prevent AGE queries on indirect CT
> actions. This is the correct fix rather than null-checking the pool.
> 
> Steps to reproduce:
>  1. Create an indirect CT action:
>     flow indirect_action 0 create ingress action conntrack / end
> 
>  2. Create a root rule with jump:
>     flow create 0 ingress pattern eth / ipv4 / tcp / end actions jump group 3 / end
> 
>  3. Create a group 3 rule using the indirect action:
>     flow create 0 group 3 ingress pattern eth / ipv4 / tcp / end actions indirect 0 / jump group 5 / end
> 
>  4. Create a group 5 rule matching CT state:
>     flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 / end actions queue index 5 / end
> 
>  5. Querying the first rule causes segfault:
>     flow query 0 1 age
> 
> Fixes: 2d084f69aa26 ("net/mlx5: add translation of connection tracking action")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
