Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58887C88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 08:36:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 315F340269;
	Fri, 11 Sep 2026 10:36:30 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by mails.dpdk.org (Postfix) with ESMTP id 4EB0E40264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 10:36:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNliQpCmkrorZJRlNVySSfxJYmDYwyK7pWLe+ouhBx+YDFvbQEVBI1Nl5niJgzPNEDmyoAOB/fJgrlfPAWUeg+/+Oor0p7b9V6um+wTXExR13wHlLJgIr3RaAPvdFElShD62UsFjPVhn92B1FoY9MVMPpxHu7J9SO+ZA9cr0xCCH6Fm+hXy3aKb0T3O/f3BxKcL44RHL/p3NFOtswRb3S/tCYAIRANVtcH3XEjpWeN67mFRNqUm1aU3Ho61bhFm2Rz6ciaKSJK4/Tr02oFG9rmUNkYSxG+187j+9wbBSa674C5a4VV1pRPb2mZrRAT2nmM7PcuCbN2nAcSO3bdzZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDsUvjrzzxVFW6kzx1asqmFNSCvRvlwPe8ZeUDgKflY=;
 b=JTZZMtZZxXKIu7jxr4IWdP2CWGVsUkD7SBve/2UOXBGNIvMcQsZ2bu4j1Ic78UYiTir25/MzmF5GydMS4Q4yqnYuLpLMuROLsC1PjdvKn5upzIv+2nnKpogS89OVe+MkhDP0b0zq5fbcJJDbyw0/jce8Q0qetjlB0rRpjX3k6vkouHrktC7CWijhXC8ps/aJ2wo8PKBpgjDnIKeuQWksIa6a5pEmRQhgfCFw9R+iMO+tqGjg2O4J9nmEa9MWHeEmbIImDfCApo0rzIfkKc8a6hVNuWYF4SRFvseZHU5bOS+/TS4BhYKaSmsAL6Tor2sKu6kKceK1gmf1FBHW+yFZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDsUvjrzzxVFW6kzx1asqmFNSCvRvlwPe8ZeUDgKflY=;
 b=ek2RjvxsMGnJE9L4HWLyiWiVWOvUMhYJfOYk7KzHe0tS+EvGGx9OxIrTeqiLBH1UP050qLovGszgylGqu/I3xNNnKs+j5BFc3TqixxQvzRFD+5pBOxc+tw7AfIOpbNssORlsW99zZNnmU7iTEJSIr8tuXVHJ0N6O/TE5Yd9+CmxaE1Ng0ZUNQhPbVJvrxjS/yQls1RsF+Dy/qBm1GLXFKOF9JFJm+z3+ITqm0Yx7kgqWFaMk2U8mS0Zw4qMZGItZS7jLhzYiGSDnHa9RClFvyLou75ZcVNfNE3tYA/RgBsqRFWvAEIY69lyz/vMyG1CAVLsJzO4SYGvc0ytxlOOcyA==
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 08:36:24 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::23) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:36:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.0 via Frontend Transport; Fri, 11 Sep 2026 08:36:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:36:00 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:35:59 -0700
Date: Fri, 11 Sep 2026 10:35:52 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <cfontain@redhat.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH v6 1/5] net/mlx5: remove MAC addresses flush helper on
 Linux
Message-ID: <tjx2o3nd7n675uac5jzvutnehj5tdk2nfisbkrb5xq5p2ypgfx@cmkcskchl23z>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260908092743.3439825-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908092743.3439825-1-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6d8444-4600-4bfe-20b7-08df0fdfc385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VFhDFHw1MnwowpIevKBFk1VvimR3udPmcIrO+kZHqFUTE2MNXWTlJb1Fyy8C7N2LESgwXuf6zCemURUW94JiM/fT4sfhES/qyVMhCswuW83KoHTavKjUmxYxglcK7Ahie5nnPBzqYgnCz131XIFLs2Z/yxmoi00jxtZhMYMab5NDZcRQtGDQSMBUjuDXJpR4wgQIWX6492VmmrywUvhVvZpioRXVIcu3RUVrMESQEkw7gJxIv6a3ZgQ3CKjz4Z/JVNVU6Med9Tpb7FE0RbuJ3ZEXhmuV6VfozmdvV5XVTLxPWl/KvwlCbse6M2FA+NxE7YWThKVvll9wtofDGr5Ut+9RTBE2o/iAg6h5zMI2JvfuNioBpMGNmbmCafCqEgZW9wycKrPKE9sQ1zKgEruYBQuSkg/8tyA4LJXF9pAHJnmodXripihcz6yFm5/IrZ5Z0IEX4kX2A5DoSXE867jLDM0pRQCnVMQTUoYzLrpF5+UVUjGk6BYdx3skdukgPsZiFDvbsBc9CSwxxuf8tT7sdF6jhkvFcbb62zZIPOFEJquF6TjZlGAPxlZLSTrSgjS9J/xtIJHxZghkgWPCb3tR/PhR9XYQ13bWahOr8AbpHmILmD4UALDCHVKH2uyqnZMq+FefNM18fZpMBJAwQU22FAuscIg+naVAv2+OaDho/iK3ejt507l0WkiVB97QUKwSrh+voWuhCG/qcHt/v0Ke+Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KC15lAZkBWhVDlNJLlBLBoWfKKwTGjVY0C/5InvtKUs/ttVWXEdQSKXGGtkyJ6/DzyCLNqlnz8GOV5eNE5mEHyU8oCozrJYqZYET6V46uKovb/4d57CtjzhrhyAWB/f7vHqos3/LiQxbCKJC7TWWtrdogIkdTaZjZ6sZeWGLALjbubHaZbYCZpuUK3A+uttBVskDAbyeHKWuibpDpFaJf/Nq6RrT28h7BH0rjtbY00LEo3Gouqq52n0WSr3M4+5+44tEpDFTqnx5/fgvTmcTBGPWhKjhu+yJ9op0YluKZqM5na8UrfJ2AuYX2RQTHm3mftnx/J0oQDpppheUqgNuQ4lW0M495D+j65LijfyJrbdwXhxvSEngn5YuAkU0yZqSBF8GO71Hkr++BB4HTDb1ORbOOzaBXct0Slgsc7ccXW9E7EmonGaxJffEPNkD91Rj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:36:24.0527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6d8444-4600-4bfe-20b7-08df0fdfc385
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
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

On Tue, Sep 08, 2026 at 11:27:39AM +0200, David Marchand wrote:
> This helper is exposing internals of net/mlx5 for no good reason.
> All this code does is calling the remove helper.
> Walk through the list in Linux implementation like the Windows
> implementation.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
