Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F2AC88E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 08:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2697640269;
	Fri, 11 Sep 2026 10:38:49 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65]) by mails.dpdk.org (Postfix) with ESMTP id DA18D40264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 10:38:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xoe4Ah/QVQIo0tlPmUalGkaY/EjR51m7MdIhoFZRFTXfD/uq3cbkB7dnBZuUs7DpuHKuaWf/sysPFSoFjnX609uBsEDgyejM4twcvwm9YHHvxta6yzjYxbyrMgFE4oWNl5om2cGDRpZ6R0veeBb8TXwypbIf2zEdCpEBJMSX8kTfFm+L3T6MVXZtbSzcm7SW9CqoU0hHVQLyqtGQhH2V5mVCiDSF5ex2n1ymyHWDmDkwNmkspu4gONLqbxZQ2Tf+U74e96WJynZtRVCj44fTf6V0/UfhqQyVXptbWqETsgz9MBDpqQgBRsJdW1IWDe90kK+21WwexYcT4ZxD7q3qyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41nNOGkz+IoMzX0Oi43jH+wGjRUOMsDUFSdKKWnBCAg=;
 b=n4KEJzNjgslzEZgMHcrJ4lkoS8OMlxGsoe+GnrF6utJE5Qeqtpc+isLhlu93Hz0WsvoEY3FfUhcJ5M00y0L0g3+fZx0UTjTyBu003lnUenjU4G9FkNCsCld34mnqcZ2tDDrMCQJyTzbCQ/efbTfn9Sa/99l8zXMhp3RMbzHyW0RWfBE5GVj4Ep/VuRi0gOvNOHap2QJpvfX1I90SF54PNmCbcII7MRQohXIFqwN7HumE+Hjb9ZLBz4KdHbnhfLbqKIiOmE6PBhFtfRrCjm6K9xICrVQztrQmD+2Si6Ic/DWiSS71lA0ANN65d73Dex73qa1kQXkUrnnvX3X7xSngpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41nNOGkz+IoMzX0Oi43jH+wGjRUOMsDUFSdKKWnBCAg=;
 b=RLA+lG7LPthRY4Q30qvaasmEJ31joq1Ei9towCuB3pXhGrH8OCWwJfAwqz+0dj03mSUTSSs9FTtbI8HKFbHFP8f4jhX8zK1lThlTwbMigjiLBRitSkQh8JevV/f6ZB+XG6PTgJmW5LSODRsQEBsoUiZSt2X/bSr/IGZyE8igNO/Rh7pSKh/ScAeBrT9u7E2v5UgwYwLisrXg6G8j+cDn1HAMPQVVA4qcQVwVDDfpWn5tCmfK+gMWIw3/N2IkWimtf4mP6CrC+WsztcbjWpm76fA3SqCzewK3V/j/0heJk3QIQu3nE2C/y2FU57dnukSdVgaOswF360F1i8dtqThq0w==
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by DS6PR12MB646826.namprd12.prod.outlook.com (2603:10b6:8:4b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:38:42 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::5c) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:38:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.0 via Frontend Transport; Fri, 11 Sep 2026 08:38:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:38:23 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:38:22 -0700
Date: Fri, 11 Sep 2026 10:38:20 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <cfontain@redhat.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH v6 3/5] net/mlx5: pass maximum number of unicast MAC to
 common code
Message-ID: <m7qg6ae5hpqqzuf4hbnfwdxbr7j7h6hx2kb4jvoes6w72p3qh3@e4tfss553bp2>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260908092743.3439825-1-david.marchand@redhat.com>
 <20260908092743.3439825-3-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908092743.3439825-3-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS6PR12MB646826:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b32bf8-23b2-421e-2d41-08df0fe0161f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: z5wDCS/2vHeEOBSVmxESDisCW3ddvdSrAVnl8wIUsixxdnqeRXUiIepvyfPzEmZuR66Yp3oGUjtTQ+gZ7MrZioOpWa28+AHUVJTLD/xe9mrxYQPXvqc3WXDzocdSw/Oc2qh73RcfVNdx+6dTgdj98i8aov/hcBMgE2fl2AXNgDlD/7HvHcLNMVxQT4AYueCWZy8hJdWX+toiqvzdUol1VWA5NucC3d1D/QOJcZPcqsY6VYM/aU65lNkf5JI8wmiPBBXtcfHvLYkLjz58oXhGO8b106t9yU0vqukKKbmtAbt6cEs4zQBYufiBUnpHds1aPmzKkINRycZfqCP8+jwt9InxDgP69zMCae8eW5butStf1YpUxNcGBYvh0IK/8ySG585hym9+7Fk4CJjTmW60q1ImyfIeV4ABPS3eXF67dfTpSZXxapowrnTyN1KV3PmDY2BpEpiKWetBPKHFjSgXu6X8fu7mkDwzHxH7gWr4UfB1Slv/SqqIKj25vQo7kiH+zlk5CZLuan5jQMOH+uVfp0Uayg55E09hdQNWqHG1RB+u/W2qZVVuGQ3N/uEJNTK1cAXATrAwPn0l8y+JKGF+obE6OdgbDRasoCZPULZgsvGoYiuAx/27k9VN7Fn20xIGzseG+ZQ0ja0hltnq4ARHipmIFQQ3Xv3kXCxW7iCClJfWjKx4rOi1SUmiHntRau0uggzCNCk1iYySp/3GRxKjsw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XIxnLVjsjZ4+vFsfEOvyFfnfOp6n3dGUrez/W5D4AlBGs73h4eIrLi3UsSo7alMpYXT2OCXuRpcxWBrwawD6cjZPoCcAQseG7dlUeC64FLbkSNBiF9elK6DIwxvYBaTxrptIY3z0LY24TaKsYjH239wLlMyRmjHV2z325Px1hEaHkz0GH+SKAglEoGOcjBQZDe8vPQGL2ZJ4mg5Jguv4pbAggcBkl+hn0c0j/OegCvGJhS0RxufuPmeHTtiFKDfhCVGh7w4Ora/9FUauu5Fi55NzEc9TqlA2nYsh7nQLUHRMVdn6x85RMFrGN6JB64sNfo0mPKom4pH/RmhPf8EZsx0j2TRt/LqMAN0XsR5j30kWNr3mNPooixUPrHoE5lk5trEEeogYX99FbOBoqGUaz+tGDxU3BN9hbw8A6gTpODEJvWu3tJ5ax7PMnamSKdB5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:38:42.6165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b32bf8-23b2-421e-2d41-08df0fe0161f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB646826
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

On Tue, Sep 08, 2026 at 11:27:41AM +0200, David Marchand wrote:
> Isolate how the MAC addresses array is walked through in the common code
> by passing the max index at which a unicast MAC address is stored in
> dev->data->mac_addrs[].
> 
> With this change, only net/mlx5 knows about the max number of
> unicast/multicast MAC addresses.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
