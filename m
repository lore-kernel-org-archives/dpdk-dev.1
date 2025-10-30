Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0ACCCF9F1
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 10:41:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C27614027A;
	Thu, 30 Oct 2025 11:41:33 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by mails.dpdk.org (Postfix) with ESMTP id 7241A4026F;
 Thu, 30 Oct 2025 11:41:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtG+gCE9DkuyPy3wzDvyuhDku85pamGXMqgT8Uyefmhi1Po3UywCivgi58ubDb9ZHcl0u0o0mx6OAjsH+vMwMgCSqm+1LHiYiApjKe9iKsGZ9M1SP5o3nddANLX9pOA2gbEcfQxHn3yAgJjUjP/Nsm02e3ZbgTE8HGUb2PW0OnQFELHTxmzv+5SBXULyILgz04egmQ1QOrOMmzvRWtZFFbeBkf7tB7UY5B5jvyIPW1BD9c/RJXesPbxIlvrsbG5jNr0axKiBu4QJ8hjEPKfRTd9jGKiPyAIiKvOmORqqQoCEwnbxZxMG9tp3O4iBN+B40c7wNGeW6lQpxHLvPsIhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rADvALSbDsvhsu/1nTII303PCx0K38WM1Fyz7MCXMsU=;
 b=dX26KfrCdQe74pgfOeeqTSAWeLEQOrd+JFBp374/1Np7vY40NAmj/0EFSvJJFwJlwzJoYnrTX2TDSKzZ+lT2q137mg8QreN5QN6aWCFoC3J5BSH9j+lQzHUmfGsA/AmKVLKF5L2UfNkifvL3t8izjYrmUZxndu4uc/rpDGGkZ1S42xMszf7Air90ncacLAGxiODbL8iXK66mv2EypDcUCGhxV3QWPVQYNyl8jTHFKpDa64A/1xu5u8h2Rs1+F3jLjrvRbQ6LZXLABwFoK4VWh7uuP7TgJFiSO1me9hLBanjBztuMS5OfYRvVOB8KzbOPyBb7oK4D4uyPeP3uEMBc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=syseleven.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rADvALSbDsvhsu/1nTII303PCx0K38WM1Fyz7MCXMsU=;
 b=mqF8PM9GtdEo290npkimUYhwurmtZCowoTNTudjSvxuXmjbq9bnCyq22F6vtf2U6XeXmUuuAlHEOf94z2186N7WUG0xuBGmKwkVOivI9cz4cvBLwRQRDHsa8IUu+jmcUTMMgYKKAMGIft13sGRMYmVcNadbaATaDMhC6xpCiuhsr4uW2SLPGHkTaSf+Dk9ZpVNtBEZnZWkAb5Kqmu6yEbLOZW6zt45lCci+nsxE56Yw1eJ9GkchAudvdj8Qr2jCF8faHiZmeeBE0A+emwFgMHHSkn001KfW7Wb5NH7JgzGi0DtaugQgr3fYqUIPWUNAeDT0ymYaRbklaA8NhaiLnQw==
Received: from CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::28)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 30 Oct
 2025 10:41:27 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::35) by CH0P221CA0047.outlook.office365.com
 (2603:10b6:610:11d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Thu,
 30 Oct 2025 10:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 10:41:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 03:41:14 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:41:12 -0700
Date: Thu, 30 Oct 2025 11:40:09 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: <a.schollmeyer@syseleven.de>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, <dev@dpdk.org>, Michael Rossberg
 <michael.rossberg@tu-ilmenau.de>, Erez Ferber <erezf@nvidia.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/mlx5: store rxq MTU at allocation time
Message-ID: <20251030104009.cx74wmofh6ljsukv@ds-vm-debian.local>
References: <20251028100144.36284-1-a.schollmeyer@syseleven.de>
 <20251030091313.55152-1-a.schollmeyer@syseleven.de>
 <20251030102155.m2uk2us7vzgh3k7h@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030102155.m2uk2us7vzgh3k7h@ds-vm-debian.local>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea9ebb0-a350-467b-2839-08de17a0e0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ycm8Nkk+zx21J02JKkz0qnzGbdXDn3WQdwBeurc+l1mLbYzVnbsjOc71jwPC?=
 =?us-ascii?Q?LYzS86FVK5YhDl81Ksf1Bh7I78Fx7EUPCur41dBcHbSEuqHRr0/F/4WuIsFG?=
 =?us-ascii?Q?MJHji3WwolkI+ABQ0e15QmEqEp1wl3zAB2yyKnj5CtkU0vx+rfUJKgOeaJcM?=
 =?us-ascii?Q?rdFWjbWjjvhqFdIsY3MEppa4fk0xIJUbAmRnpo8+dmU8VVnKIfSWgAeAbv6D?=
 =?us-ascii?Q?ng1IFTL0S4nIzMdk5Pixqdnu9kJtcse4+GDac04BnJH1evPOKQZQS67Lo7pD?=
 =?us-ascii?Q?Wo9iG+8YsMm8oC1eq9NcxQqWS2kuWus/RCb7QpeC2M0XIIZq57R1J3Z0PKs+?=
 =?us-ascii?Q?r9Zi0e93Dpuzwd8hTErRpvQgxKIMKLSiwzCelB6B/jQ9D8gHWfe8yOybKTNq?=
 =?us-ascii?Q?yi+FIrqxUamOlv4Zpv87hIAfPldSD+FcCG0vlRx6ke5s4ewJqx2bkdEzLopQ?=
 =?us-ascii?Q?4reMf3wsYpW81ldVzO6f+b3f/Oa7xGXd9vd+EyFr3oSZ86SKvkxwpUaOx68t?=
 =?us-ascii?Q?1mohs+nnBWljHrnqUC5ItbuSj/HK/X+LHQqY1k53g2v9/b6lZ56SXEuV0cfC?=
 =?us-ascii?Q?Qi1qhc5WXpypGO2W/7fsbOtmPpv16X2Yn5ZcBSpF01Q1xGbCfyqJYshqy9g8?=
 =?us-ascii?Q?ECBfiaTYeu2ZGULqkKfsNXDEkV47ZUezq28f5+D04TEIMxkNO3IPHVXlJ3AD?=
 =?us-ascii?Q?Qc2GjcMaaLzFnG4ndBvzKDrzIGZpKab0uML9zWfvJ8nstyPPUm+YyKCKJYIG?=
 =?us-ascii?Q?eIc4txWsWYqrCC+IQjTIcJLN5SYdR4SG0t6OJoueAOLv/dEkqJOFU9ZQ6SRQ?=
 =?us-ascii?Q?DTpdUrFLltHFYwQ4UIpzpcUZSEWP0hIMw3ijD8ekIi7JV3Fep/499ym32rwI?=
 =?us-ascii?Q?7uSSUCbb9mh9kD0LxnPcBRY+CcFbR9Ll8lT/BFqixlcRI55tOLp25WMgsnem?=
 =?us-ascii?Q?w4cjtWYQZNDGlf54OBqtc9MaOe4dHeVEqRUvsofpEhep3JiNQBa5FUXYNocU?=
 =?us-ascii?Q?g+l+pJ2e7wcydKSqAtjLpRTv0lDTNqKjFAAnZKJSMpbcQC33oJdl8koM99h7?=
 =?us-ascii?Q?pmj4ESK/beSd279L+sH6J1w2mJCd7dCdWqylbOZzJwwdEyhIz6j1RDPoK02N?=
 =?us-ascii?Q?vPTcln4QMLZ+wYvFYBFmle52qM6VtD6YVsZUkXcJXfNpf9ZQH4SoSap5ETU0?=
 =?us-ascii?Q?vl64xByD/O7vKu/jco3v9THIXEcYFstaatCdOSRU5psxafSAHH6dspb2ws5j?=
 =?us-ascii?Q?cLLzNGU4XFVBCxkIN9bbTCuryLdzRe09pYgMEmNuO8pefa0s5WWJJNPLIEDI?=
 =?us-ascii?Q?0ciskVxCz70SxX0fY1yOh7yhjFpOPrfplkH1xvcuURvE8RloqvZxl0EiIg8N?=
 =?us-ascii?Q?XGoKp1tH6Re6KIjNbzM00e0n1/MW4p0XgJuE2CxZtHmu22U4tXacPxPLMX4L?=
 =?us-ascii?Q?6vEoUNC5oBg3+HnlfVsi1PBSRnMZFj6/5Srl44+l8sdSp7XgRJ97oNudThiX?=
 =?us-ascii?Q?aHh85LqPa14a3xNfDJ547ucm5lIhVddqys7KI8+Xn9pzCOcDzn9RshClYOvI?=
 =?us-ascii?Q?ZFBgwmpy77D2cYXQ9OA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:41:26.2409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea9ebb0-a350-467b-2839-08de17a0e0a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
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

On Thu, Oct 30, 2025 at 11:21:55AM +0100, Dariusz Sosnowski wrote:
> Hi,
> 
> Thank you very much for applying the changes from last review.
> 
> On Thu, Oct 30, 2025 at 10:13:13AM +0100, a.schollmeyer@syseleven.de wrote:
> > From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> > 
> > For shared Rx queues, equal MTU for all ports sharing queues is enforced
> > using mlx5_shared_rxq_match() to make sure, the memory allocated in the
> > Rx buffer is large enough. The check uses the MTU as reported by the
> > ports' private dev_data structs, which contain the MTU currently set for
> > the device. In case one port's MTU is altered after Rx queues are
> > allocated and then a second port joins the shared Rx queue with the old,
> > yet correct MTU, the check fails despite the fact that the Rx buffer
> > size is correct for both ports.
> > 
> > This patch adds a new entry to the Rx queue control structure that
> > captures the MTU at the time the Rx buffer was allocated, since this is
> > the relevant information that needs to be checked when a port joins a
> > shared Rx queue.
> > 
> > Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> 
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

One other thing, unrelated to the patch content.

Could you please change the state of previous versions of this patch
to "Superseded" in Patchwork?
This would be very helpful since it reduces the amount of patches to track.

This requires creating the account on Patchwork - https://patches.dpdk.org/

Best regards,
Dariusz Sosnowski
