Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0462EA795E
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 09:51:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78B904029A;
	Fri,  6 Feb 2026 10:51:34 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by mails.dpdk.org (Postfix) with ESMTP id 59FA440293;
 Fri,  6 Feb 2026 10:51:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afht0muCBHvpHwLsVRP/op+qNI1iPlftaiveNh6qybvcucnk14fKlmqrjk0nZYMGEIno/nADLd90PluNDaXGnXte2NQhuuAa51+cUD1Lopp5B5kHYoulUNUij4ts81I1GNXQQy4eAp+bLhyBscdztr5TnTgFv1pdLxiLGYFu21XTbHPtP8mRZWN+ILmdeKAeqfaD2ZgGUtq6fX+5xSTW1TsOi863qrGQPM7KXkWEvbu65FMTHdEPi49Fe7q2MK9+LcwRMwbXtbo0JCURXNd8/H+Oepqie6186K6Oi+h7gqj8mV9GTFKC2Nnrawr1Tmp7BQdZPwoUZqpcdLswaTtZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW5gnhKfWwe3bacrtljjiCQ1XOu9UXdBIkFGBtY1wZs=;
 b=DX0j26tnT8cUSVUlLf8JrMmTmLGY24tpXLQWysgofzYjx2CBIHy2brFatjAwJTRXbLS8cegPMge6O0b9j4+z2PqJEU9SKCzCpMndTVWgXhzXjpA3ZtEWKPByEu9SvumZbURe/S6HaroQMopqZ0s4DlkGNmybILvoeqWp0wDFj/Po1fLXR+ftzRarEvkisMekqy+MeNDpTXCXmk+WfMPBoYOHSASpk8ttlrJQAobw5wPSLg7MVAsxVRDumMsjATEBOGaZf29MGIcsqcjklRj6A121TBbgFSAYmISb+yBQ9WCgBYNerbYKVuiZ3w3kSPRjAvwyIo9VPLHyLIL9NYBaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW5gnhKfWwe3bacrtljjiCQ1XOu9UXdBIkFGBtY1wZs=;
 b=CZPrnU6Fmz1b+to9Y8qvRMeYAZ+AYgb8cRgboVm/UP5nUgIFUhd5ldaJLv2LF+IulObCDraRddK2FDnZon1hBqD3oyyt2UXNfs2VED72Y9ejOK0sFn6OAyZ7uw2tei8VG2UMd7rQXHq4DRkriqkrI3R+Z126+5wmNoVoydAmq9hyb02W+5gHpwNh7h8RDYW+bihWSIOhtsoNyp8pduI8lCVCkfuzwqDDwaEJ7nN9CD3IMjEzRElUOP+mYLo/B/6GeNLKzFtAeLODRwMw38tE1+iOOc/vHmmD93qAqGLKl/4EpkTldWV8fbrVESxyVCe0+n2cXuQmVwpCHHVOlTlhQw==
Received: from SJ0PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:33f::22)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 09:51:28 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1b) by SJ0PR05CA0047.outlook.office365.com
 (2603:10b6:a03:33f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 09:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 09:51:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 01:51:09 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 01:51:08 -0800
Date: Fri, 6 Feb 2026 10:51:05 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>, Alex Vesker
 <valex@nvidia.com>
Subject: Re: [PATCH v6 6/6] net/mlx5: fix LTO stringop-overflow warning
Message-ID: <o4qbphiblyc6uwgg5cf3brwlb6g2325f455tjhj6r7npcxneba@cjoeetv4aghk>
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
 <20260205175750.653353-7-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260205175750.653353-7-stephen@networkplumber.org>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 406ccece-decc-496d-4004-08de65654c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PPMNbD25N3KBejpTPv5p1sxRtvnuoSR3McWefsPuZaxIo78SvkSIgDqMiOfa?=
 =?us-ascii?Q?RfPwTKLuYncfHFM1/cY8Ih2xowE9rWl934+dUSpM70IPF+EPzrHi8TztEiXZ?=
 =?us-ascii?Q?bDfxAJx5F23LwpEf3FwtPgCQ0MVMhAALb/wRSY56tRqr/CASqc5DYiRUwZT7?=
 =?us-ascii?Q?g5F6LDNdtMPr5OyIY9hVs1n+gTp4BHPCeekI4z8beAaOJeUROZegucXllmi8?=
 =?us-ascii?Q?8BMBnkHVLoM9Vfq3GfQ4OlAFHF1g0FXBIiW+w4TCneGmoMHUaiWGJS4wl2Xb?=
 =?us-ascii?Q?/52tFqPQOEr6RKJK6FMfmT+CH8gwdPSn2qqL0sWntcRswD+XNHAuJLpOuVbF?=
 =?us-ascii?Q?lR7Oequ4MIClBAf1A8dt9fIoAVYZ/F8cpvyo14Bp5A19GzTPD6tUBFKhBhON?=
 =?us-ascii?Q?egXN2hJJHqcIIXSQO/Z90xMlGMogmDEF7i+S97FOQJRBbn7ElgK4rL/KuhY4?=
 =?us-ascii?Q?tu2hs0FQA18/hhhcWzX6Y32nUgzl7gbxWJHovoI+wlUyKczE3v0Fr75S/2na?=
 =?us-ascii?Q?g/dGdMqvxPalhN1lJzqGGj33jR94d+zWPu+Q9WkQJeIfnhElZbj74BvZOOK3?=
 =?us-ascii?Q?YfUFYg5usf8BslAW237oPqrmXL6kv2HYVy3NXtKQKobxJZJ7JbxeP/+7esA7?=
 =?us-ascii?Q?iZFsMlI7u7R29mSp0MHYpyDynOHT04dZ6AWHG4vvsByY07DFJ3xlnXFJ/hIT?=
 =?us-ascii?Q?qIoiAclgw6bjxmURPSahUvLRKuqawWXSaVKtyMipl1JSbIio1rTB3K6tAbHG?=
 =?us-ascii?Q?755lt/fzawpWHK7E9brr9PCQ9871kAzQjnfAOZlKa1WJX8A93blEjG71uXoS?=
 =?us-ascii?Q?vuwTqZtIYHKd0m4ZTaONkpU26ZIC62uCAFwUBy3W4xch/3QPXLxjDyEG6DrE?=
 =?us-ascii?Q?2prMUK3YCWpi8E7gPYS5Mqtp51JDFdWkD+Dspl8jt4mr6Wyrll1BCXrT8CD6?=
 =?us-ascii?Q?r7ZseIj5C2thTk31F2JY9rWOdskrRy0lstpeENeIFYrxST7r3e520Mz6ytUL?=
 =?us-ascii?Q?4+w2HjwNtRyOjEj7yY6VE8cwW1MEx4I1tBvS6tawLziEIYfr8hc+y0vQUZmv?=
 =?us-ascii?Q?BtDG8seXEd9RHOeIA7yPICZy+EjyLH1AHBfgnw6ABONtD3UHTYCP8s2X6Dt8?=
 =?us-ascii?Q?WSKxmxrGHwG6NwXKtBcTH60e0wSfIX0eb7z5fEwam0A3RzkEMnkWcQU4WTkx?=
 =?us-ascii?Q?7CMmPg+JeetclTHrusFkiCXVEymzc6U3tmVOEX2XfN/z/aoRUNXbPVvc1Wd+?=
 =?us-ascii?Q?gTH0vU1VdS7HoUAbFBPEDVxKNg/bllTZiUjr38miJxxqjtz5JodCLJO4RfTQ?=
 =?us-ascii?Q?OolNSq0RQqC1ARgfnQTZhYblJ3iz1wZp0Bc8UmlWLNju8xJGpTz6W1egSCIT?=
 =?us-ascii?Q?mkK2A/UK5rK8JI2TDz9VcpTR4Vp01cHHPEmXOZGfxNrgYouC9ejTXOv8ncLt?=
 =?us-ascii?Q?zYfy9ZX9/cYf0dDq/MnsI3itS6z0kLNgxgIeG9N/PBY5SYDcaRy2h341rNpN?=
 =?us-ascii?Q?lyr/OT4sCPhLMDzXFynH7/zE6UyKF0xHDFgKKU7kcZtOaTPrNXMGnXxs8qJL?=
 =?us-ascii?Q?pm9sHf+kD192TyN8KpVhXyV5AIJBpLFmpCmOldP3v31oluKzR+ztdPa7MjFt?=
 =?us-ascii?Q?EJMJPRa1pytve+H+RZfxs/9PaQSadxctfjoGxhwFEKmlEIJCOyxYwwNiQyU3?=
 =?us-ascii?Q?OrriBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jtlxccqPug75asYAHVItOtvLSJJI2y34Dkz6nbBvK84obkqz8k8J8HcCMlBkuMtE2+EnivWYJdAwSBVX+nsiqYRw9mVQu5tcH8hxnZpjkEShXgyA2lkMAjwIZQjFzd5IPdMeOVKmMqpKe+PArYn8IolPHKRfBYX2aO4q0DZN4SC+7WWesz0tbDIfnJOeNFGHa+yJeE2uIhzLKza/rEH74dhQEDSktxbKqU/+T5SPmrLz2gBjPt5wnvm80GrWBjilShReZYtFp+O0RClBam4Cs4u5UZ/WavmhiYDmLyvtn4QMRTTdc5X0C1dy12p4cJDLXNQz/dRXzvwLn57BCVf1U2+HadrTd2Dr0dyZHlHJNXZIbxKJ7QqjtitemSe9rQCD8rfPe09xXMI/cGO3sR+InbpvmqOlhEg7FEcQF7CeDswf4MDjl2fLwxmwEsyhPTMG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 09:51:27.8675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 406ccece-decc-496d-4004-08de65654c50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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

On Thu, Feb 05, 2026 at 09:55:58AM -0800, Stephen Hemminger wrote:
> When LTO inlines mlx5dr_action_prepare_decap_l3_data() into
> its callers, GCC sees the 64-byte stack buffer 'mh_data' but
> cannot prove num_of_actions is bounded, producing a false
> -Wstringop-overflow warning.
> 
> Add __rte_assume(num_of_actions <= DECAP_L3_NUM_ACTIONS_W_VLAN)
> so GCC can verify the loop stays within buffer bounds.
> 
> Bugzilla ID: 1710
> Fixes: f8c8a6d8440d ("net/mlx5/hws: add action object")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
