Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA04606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nHEIuER6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9697A40296;
	Thu,  5 Nov 2026 08:37:35 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51]) by mails.dpdk.org (Postfix) with ESMTPS id 20B7840288
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:37:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOjZeb8N5OqqaVOUPEJalLzCyFsJ2ZRHuof9xYfwUb4zYXLRbeCV9XfHFZKNSxpPMv4uF6++f+5mclxuH6+0KptuWpZrZ2Ls/uyyAN/V/fwIgy66jMR3IHleTkDEz+ZeaB1p1Bjiol3MsuRs3phHUDChCM1ot24UmJl1zuIwUTtXWlzQxsDWnZ+meg4MicehF00nu5eRvxz0R5chZYZvLRvtWoLg0F6AaFmcOoXRqh2TgVlcsg+PyLLp2B0sAy3c+ccDEZRTal/wUPhL7c0Dc/MpVQ8spVC9Fl0nJgDByli+GoRlyQce28Uqq1P0zEMoNpFdRUgipsrxJJ8TzaGvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=t25T02K+lzYUN9YJYjxn7BGjx1uNc/X6ArGRc8rrs7UCoH/hawR3oM9BONrkRW8RVKrGl5yAj+O+mz4KG076uG7Qi8lNp6L1ej7cYujYbPoGYDdd/s3Dh2/wL0aQCdsKXa95WVoLH0sYNfUZkN4wwwhVW84sDWpPmBKUPx6qA9E5RF6KyjyxH1zs+xjhDmfK2yFCN704YFK7mf9pz5m6yEDkneEcteo3f6YzC9FkjEwKUVpN0jyCobAOXrCRQ9VEgQ7Y1hoyqZOWnxKsWJdQSm6rBOG1tXLbtJQEEBcsI3R/B/78o4tHaSCf/QsSLR/iZ8ezMOcP8PmODE1i4LC7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=nHEIuER6VOmJ/q/wjUltE7dEUYVo/9iXshnd5IuKxnvZfm1KXt0NNElND7DBWlI+2Xkd5OU94a2w/ZHqhiHp+21BC1y/hw4gTJnxr2F8l7EX6oGFBOPaL3t5tN367VWysRPtBeYY41ipMZ8X6GFxkzhC0XGysjNw5uM1rVnAhqkzixIVUr+MsNR/XvwnERz9ZIF1WGCZRCwBXaADeTgno8KzmM/863+AKAGScVpa97PNyAv2Ya5H9anEFphjbhdVSsqCRFIaBLOPJyTZ82odlPsUA1wkBjtQgSp2JNqG6GAoM91Sifcfqd9vqsedBixfziF9gkbokOHavYkJ4H/ajg==
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 5 Nov
 2026 07:37:26 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::24) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 07:37:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 07:37:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:07 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:05 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5/hws: add the DF bit for IPv4 header in NAT64
 action
Date: Thu, 5 Nov 2026 09:36:55 +0200
Message-ID: <20261105073656.20337-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028035017.3900338-1-bingz@nvidia.com>
References: <20261028035017.3900338-1-bingz@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: beebe6a0-25ea-4440-7ecf-08df3b0fa32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: yNhRiehmTvGwe2WVsTS8UXly0YayCF7MtWlul8/va9Xc9+QZRBbhDg/V5mPjSxy52pHcWeycJUOSQ7ir0rB7so0ebTIi/cXJmYcrVPwxhSauJRpP+fiVVcs2dGDve24txdRvSe05P1j7Pbi00lHhDbKd6do3mnIwBd76XJIk5g4r/HJLcRwP7/qF7eV24A9nJnRnl/hBUwRegPJ8qzIdFKQVX+8UnifJAA4PfG22QAZrmmPNj82HOUa8l8u0bW+feVKyybgN+OJWu8VRN9ppmWTSKG43TquyVcsrhAnJr/VKlu4clQNqkpNVerkEjLI4S1aR2Gluit/MulvwKDJO1R2X3jQlfzkKGyjAfZ0zlZuTSLXOZOSvxsRJw/fb2u3qwls64nJT7JBVZ2T+JZw2gbFik/XsviD1npEvszJEfDYPk+qvwn7hO8kCHSmELxz9WUyw4AVelM60UuDrKSW0jAcYzGgOfi3YhnB+aUEBxs8bIA59SzkgTfR/VV6HIlxsDXlF9YKN8CLIw5sixVlRp1JH9NWcnmT97mhhvSJqhyJ0msaucOBC1gQ0Zz6lBEaCDkwf5S7csceEfsGg3CHzSbwndE6aHaYODb22l+d5QXAJaekPaDFFwWn3OlEIJpyDvOgLn2AyayOCvr5O7Dv2UsOi6xM80ECdBUqlXdCHWqibwCgdlHy5sMJnpW8AJh/weSqjam7pAvdxoJRTmxhu3Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VeD6RyDjt2n68YdvVsYWSigYhio2Pvaa7Y4znav4n/9f566qYiQHz4juzZUcop9GmugkF6BdtNJ5j0di0fLjnM6K6tkpUjpZ8saoycxQNZdxSuGl3k2oc2V+0y+lKHXzSvIX0x5QiMGMMzDKSnNkLk+KThEXJLfhfPdRhPtlDm0x0F5KPpSRGvc4X0bJQ/siLA5XZxYh/zyDlvTEn7/RFycoH7WHDhxxeI89NY4j49qGZ1uO3qHftv7Wl6N2apVWGy7jCdmUEElF0iMVxP9g0cXPYPWvawHXhTJBcSyPQc+HcaC0z2BKj2epjGjDnqJpIMLhUIFcGYjw7/YAJSmZr3mcSq+Ae6Wjb1GNRKRB8su1L5gWyYqCc+i28Xq2mv1cv/HueVm3gr8DFMUCNHrU4hGrVfcU7Rj1wPF9xZh28+Bu5M+eeg/HiyWryVl7Muj+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:37:25.5876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beebe6a0-25ea-4440-7ecf-08df3b0fa32d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patch applied to next-net-mlx.

Thanks,
Raslan Darawsheh
